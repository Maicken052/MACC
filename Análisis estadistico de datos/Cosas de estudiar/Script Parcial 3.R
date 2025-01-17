if (!require('corrplot')) install.packages('corrplot')
if (!require('psych')) install.packages('psych')
if (!require('RColorBrewer')) install.packages('RColorBrewer')
if (!require('reshape2')) install.packages('reshape2')
if (!require('ggpubr')) install.packages('ggpubr')
if (!require('readr')) install.packages('readr')

if (!require('MVN')) install.packages('MVN')
if (!require('mvnormtest')) install.packages('mvnormtest')
if (!require('MVTests')) install.packages('MVTests')

if (!require('factoextra')) install.packages('factoextra') #PCA
if (!require('FactoMineR')) install.packages('FactoMineR') #PCA
if (!require('CCA')) install.packages('CCA') #Análisis canónico

if (!require('DescTools')) install.packages('DescTools')
if (!require('rstatix')) install.packages('rstatix')
if (!require('MASS')) install.packages('MASS') #lda y qda
if (!require('caret')) install.packages('caret')
if (!require('klaR')) install.packages('klaR')
if (!require('mlbench')) install.packages('mlbench')
if (!require('dendextend')) install.packages('dendextend')
if (!require('tidyverse')) install.packages('tidyverse')

if (!require('cluster')) install.packages('cluster')
if (!require('fpc')) install.packages('fpc')
if (!require('vcd')) install.packages('vcd')

#PCA----
#Eliminar variables categóricas

#creo matriz de correlaciones
correlation_matrix <- cor(dataset_num)

#gráficos de correlaciones
corrplot(correlation_matrix, type="upper", tl.cex = 0.7,col=brewer.pal(n=8, name="PuOr"))

corrplot(correlation_matrix, method="square",tl.cex = 0.7,col=brewer.pal(n=8, name="PuOr"),addCoef.col = "black", 
         number.cex=0.7,type = "upper", diag = FALSE, order="FPC")


# Test de Bartlett
# H0: no correlacion vs H1: si correlacion
cortest.bartlett(correlation_matrix,n=nrow(dataset))

# Test KMO
KMO(correlation_matrix)

#PCA con estandarización
PCA <- prcomp(dataset_num, center=TRUE, scale.=TRUE)
summary(PCA)

#Cargas factoriales de cada comp
print(PCA)

#Gráfico de valores propios (mayor que 1)
fviz_eig(PCA, geom="line", choice="eigenvalue", ylim=c(0,4),
         main = "Grafico de Valores propios",
         addlabels = TRUE, xlab = "Numero de componentes", 
         ylab="Valores propios")

#Grafico de elbow
fviz_eig(PCA, geom="line", ylim=c(0,50),
         main = "Grafico de elbow",
         addlabels = TRUE, xlab = "Numero de componentes", 
         ylab="Porcentaje de varianza explicado")

#Pareto (minima cantidad de componentes que explican el 80% de la variabilidad total)     
lambdas <- as.data.frame(summary(PCA)[1])^2
tabla <- tibble(k = c(1:ncol(dataset_num)), var_acum = unlist(cumsum(lambdas/ncol(dataset_num)*100)))

tabla %>% ggplot(aes(x= k, y = var_acum))+
  geom_line() + 
  geom_point() +
  geom_hline(yintercept = 80, color ="red") +
  geom_text(aes(label = after_stat(round(y,1))), 
            nudge_x = 0.25, nudge_y = 3.25)+
  ggtitle("Grafico de pareto")+
  xlab("# de componentes")+
  ylab("variabilidad acumulada")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Circulo de correlaciones
#Primer plano factorial (axes=c(3,4) cambia las componentes)
fviz_pca_var(PCA, labelsize=3, repel=TRUE)+
  theme(axis.title = element_text(size = 7.5),
        axis.text = element_text(size = 7.5))+
  ggtitle("Circulo de correlaciones")

#Contribuciones a los ejes factoriales (Para ver las var más importantes de cada comp)
fviz_contrib(PCA,choice="var", axes=1)
fviz_contrib(PCA,choice="var", axes=2)

#Ver los valores de las contribuciones
PCA2 <- PCA(dataset_num, ncp = 7, graph=FALSE)

#por componente
contrib_componentes <- PCA2$var$contrib
sort(contrib_componentes[,2], decreasing = TRUE)

#Rotación varimax para facilitar la interpretación
PCA_rotated <- principal(dataset_num, nfactors=2, rotate="varimax") #nfactors = num de comp

PCA_rotated$communality #Se puede ver que tan bien representada quedó cada variable en la sol factorial

#Grafico de las cargas rotadas (identificar variables más representativas de cada comp)
componente1 <- PCA_rotated$loadings[,1]
componente2 <- PCA_rotated$loadings[,2]

cargasdfr <- as.data.frame(cbind(componente1,componente2))
cargasdfr$medicion <- rownames(cargasdfr)
cargasheatr <- reshape2::melt(cargasdfr)
colnames(cargasheatr) <- c("variable","componente","carga")
cargasheatr %>% 
  ggplot(aes(x=componente,y=variable,fill=carga, 
             label=sprintf("%0.2f", round(carga, digits=2))))+
  geom_tile()+
  scale_fill_distiller(palette="RdBu")+
  geom_text()

#Graficar puntos sobre planos factoriales
PCA_dataset <- PCA_rotated$scores
dataset_with_PCA <- cbind(dataset,PCA_dataset)
dataset_with_PCA <- dataset_with_PCA %>% 
  mutate(category = as.factor(category))

dataset_with_PCA %>% 
  ggplot(aes(x=RC1,y=RC2,color=category))+
  geom_point()+
  ggtitle("Puntuaciones factoriales - solucion rotada")

#ACC----
#Número de filas y columnas
ncol(X)
ncol(Y)
nrow(X)
nrow(Y)

#Estandarizar
X <- scale(X)
Y <- scale(Y)

#Analisis canonico de correlaciones
ACC <- cc(X, Y)

#correlaciones canonicas (correlación fuerte en las primeras var can es bueno)
ACC$cor

#coeficientes variables canonicas en X (ver las var más importantes)
X_coef = ACC$xcoef 
sort(X_coef[,1])

#coeficientes variables canonicas en Y (ver las var más importantes)
Y_coef = ACC$ycoef 
sort(Y_coef[,1])

#Dataset con las variables canónicas (núm de columnas igual al menor de X y Y)
U = ACC$scores$xscores
V = ACC$scores$yscores

#Cambiar nombre a las columnas
U_names <- paste0("U", 1:ncol(U))
V_names <- paste0("V", 1:ncol(V))
colnames(U) = U_names
colnames(V) = V_names

#Gráfica del primer par de variables canónicas
plot(U[,1], V[,1])

#Verificación de supuestos
corrplot(cor(U, V)) #Diagonal en descenso y el resto 0
corrplot(cor(U)) #Diagonal en 1 y el resto 0
corrplot(cor(V)) #Diagonal en 1 y el resto 0

#variables canonicas vs las variables originales
plot(U[,1], X[,"x1"])
plot(U[,1], X[,"x2"])

#Análisis discriminante ----
#Baja prob de errores de clasificacion.
#Considerar probabilidades apriori de cada clase.
#El costo asociado por errores de clasificacion debe ser pequeño.

#Conteo de cada clase
dataset %>% count(class)

#Separación de cada clase
pi_1 <- dataset %>% 
  filter(class == 0) %>% 
  dplyr::select(-class)

pi_2 <- dataset %>% 
  filter(class == 1) %>% 
  dplyr::select(-class)

#Test de normalidad
mshapiro.test(t(pi_1))
mshapiro.test(t(pi_2))

mvn(data = pi_1,
    mvnTest = "mardia",
    multivariatePlot = "qq")

mvn(data = pi_2,
    mvnTest = "mardia",
    multivariatePlot = "qq")

# Analisis descriptivo
# identificar cuál variable posee mayor poder discriminante
names <- colnames(dataset)

#Boxplot
b1 <- dataset %>%
  ggboxplot(x = "class", y = names[1],
            color = names[length(names)], palette = "jco",
            width = 0.5) +
  labs(title = paste("Boxplot of", names[1], "by class")) +
  theme_minimal()

b2 <- dataset %>%
  ggboxplot(x = "class", y = names[2],
            color = names[length(names)], palette = "jco",
            width = 0.5) +
  labs(title = paste("Boxplot of", names[2], "by class")) +
  theme_minimal()

ggarrange(b1, b2, ncol = 2)

#Histograma
h1 <- dataset %>% 
  gghistogram(x = "x1", add = "mean",
              color = "class",
              fill = "class", palette = c("#00AFBB", "#E7B800")) +
  ggtitle("X1") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

h2 <- dataset %>% 
  gghistogram(x = "x2", add = "mean",
              color = "class",
              fill = "class", palette = c("#00AFBB", "#E7B800")) +
  ggtitle("X2") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(h1, h2, common.legend = TRUE, legend = "bottom", nrow = 1)

#Media y desviación
dataset %>% 
  group_by(class) %>% 
  summarise(media_x1 = mean(x1),
            media_x2 = mean(x2),
            desv_x2 = sd(x2),
            desv_x2 = sd(x2))

#Igualdad de varianzas
BoxM(bind_rows(pi_1, pi_2),
     group = dataset$class)

# LDA
modelo_lda <- lda(class ~., data = dataset)
modelo_lda

#Predicción sobre los datos
predicciones <- predict(modelo_lda)$class #dejar class en vez de población

#Datos reales
reales <- dataset$class

#matriz de confusión
confusion_matrix <- table(predicciones, reales)
FP <- confusion_matrix[1, 2]
FN <- confusion_matrix[2, 1]
total <- nrow(dataset) 

#APER
APER = (FP + FN)/total
APER

#Train - test
train_index <- createDataPartition(dataset$class,
                                   p = 0.8, 
                                   list = FALSE)

train <- dataset[train_index,]
test <- dataset[-train_index,]

#Cant de datos de cada clase en cada partición
prop.table(table(train$class))
prop.table(table(test$class))

#modelo en train
modelo_lda_train <- lda(class ~., data = train)
modelo_lda_train

#Predicción sobre los datos
predicciones <- predict(modelo_lda_train, test)$class #dejar class en vez de población

#Datos reales
reales <- test$class

#matriz de confusión
confusion_matrix <- table(predicciones, reales)
FP <- confusion_matrix[1, 2]
FN <- confusion_matrix[2, 1]
total <- nrow(test) 

#APER
APER = (FP + FN)/total
APER

#leave one out
modelo_lda_cv <- lda(class ~., CV = TRUE, data = dataset)
modelo_lda_cv

#Predicción sobre los datos
predicciones <- modelo_lda_cv$class #dejar class en vez de población

#Datos reales
reales <- dataset$class

#matriz de confusión
confusion_matrix <- table(reales, predicciones)
FP <- confusion_matrix[1, 2]
FN <- confusion_matrix[2, 1]
total <- nrow(dataset) 

#APER
APER = (FP + FN)/total
APER

#QDA
modelo_qda <- qda(class ~., data = dataset) 
modelo_qda

# Gr�fico del QDA
partimat(factor(class) ~ x1 + x2 + x3, data = dataset, method = "qda")

# Pronosticos
predict(modelo_qda)
predict(modelo_qda)$class

#Los APERS son iguales

#Regresión Logistica ----
options(scipen=999)

#Partición base de datos
set.seed(0214)

trainIndex <- dataset$class %>%
  createDataPartition(p = 0.8, list = FALSE)

train <- dataset[trainIndex,]
test <- dataset[-trainIndex,]

#Creación del modelo
reg_log <- glm(class~., data = train, family = binomial)
summary(reg_log)

#Coeficientes
coeficientes <- reg_log$coefficients

#odd_ratios
cambio_odd <- exp(coeficientes)
cambio_odd

#odd_base de la clase positiva
base <- table(dataset$class)
prop.table(base)

odd_base <- prop.table(base)[2]/prop.table(base)[1]
odd_base

#probabilidad final
odd_final <- odd_base*cambio_odd
prob_fin_1p <- odd_final/(1+odd_final)
prob_fin_1p

#Predicciones
probas <- reg_log %>%
  predict(test, type = "response")
probas

pred_class <- if_else(probas > 0.5, "pos", "neg")
pred_class

# APER
1 - mean(pred_class == Dia_test$diabetes)

# matriz de confusión
table(pred_class, test$class)

#Cooks distance
plot(reg_log, which = 4, id.n = 3)

#VIF (deben ser menores a 5)
car::vif(reg_log)

#Clustering jerárquico----

#Caracterizar los nombres de cada fila
dataset <- dataset %>% 
  remove_rownames %>% 
  column_to_rownames(var = "category")

#Estandarizar
dataset_est <- dataset %>% scale()

#Matriz de distancias
dataset_dist <- dist(dataset_est,
                       method="euclidean")

#Average (o single o complete)
dataset_clust <- hclust(dataset_dist, method = "average")
dataset_clust$height

#Dendograma
grafdend <- as.dendrogram(dataset_clust)
grafdend <- set(grafdend,"labels_cex",0.5)
plot(grafdend, main="Average") 

#Ver variables de influencia en cada cluster
heatmap(dataset_est,
        hclustfun = hclust, cexCol = 0.7, cexRow = 0.7) #siempre usa average

#cortar el dendograma a un nivel dado
dataset_grupos <- cutree(dataset_clust, k=4)

#Guardar el grupo
dataset_est_2 <- dataset_est %>% 
  as_tibble() %>% 
  mutate(grupo = dataset_grupos,
         grupo = as.factor(grupo))

#graficar
ggplot(aes(x=X1, y=X2,col=grupo), 
       data=dataset_est_2)+
  geom_point(size=3)+
  geom_text(label=rownames(dataset_est_2),
            size=3, col="black", nudge_y = -0.1)+
  labs(color="Grupo")+
  theme_minimal()

# Boxplot segmentado por cluster
dataset_est_2 %>% ggplot(aes(x=grupo, y=X6))+
  geom_boxplot()+
  ggtitle("")+
  labs(x="Grupo", y="")+
  theme_minimal()

# Resumen descriptivo por cluster
describeBy(dataset_est_2, dataset_est_2$grupo)

# correlacion  entre la distancia original y la del dendograma
# a mayor valor (>0.75), mejor es el clustering
cor(dataset_dist, cophenetic(dataset_clust)) 

#K-means ----

# Calculo de CV's
CV <- function(var){(sd(var)/mean(var))*100}
apply(cell[,6:10],2, CV)

#histogramas
hist1 <- dataset %>% ggplot(aes(x=var)) +
  geom_histogram() +
  ggtitle('Histograma \var') +
  labs(y = "", x = "var") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hist1, hist2, hist3, hist4, hist5, nrow = 2, ncol = 3)

#Estandarizar
dataset_est <- dataset %>% scale() %>% as_tibble()

#semilla random
set.seed(0526)
#c�lculo la suma de cuadrados total
wss <- (nrow(cellfin_est)-1)*sum(apply(cellfin_est,2,var))

# Elbow method
fviz_nbclust(dataset_est, kmeans, method = "wss", k.max = 15) +
  labs(title = "Metodo de codo")+
  xlab("Numero de clusteres (k)")+
  ylab("Suma total de cuadrados within")

#Silueta
set.seed(2) #Para evitar aleatoriedad en los resultados
clustering.asw <- kmeansruns(dataset_est,
                             krange=2:15,criterion="asw",
                             iter.max=100,runs= 100,critout=TRUE)
clustering.asw$bestk

fviz_nbclust(dataset_est, kmeans, method = "silhouette")+
  labs(title = "Metodo de la silueta")+
  xlab("Numero de clusters (k)")+
  ylab("Altura promedio de la silueta (asw)")

# ejecuci�n de k-means
set.seed(45390)
dataset_cluster <- kmeans(dataset_est,
                       centers=5,nstart=10,iter.max=20)

#tamaño de grupos
dataset_cluster$size
#numero de iteraciones
dataset_cluster$iter
#centros de grupos
dataset_cluster$centers

#Grafico de calor (ver variables)
centrosg <- as.data.frame(dataset_cluster$centers)
centrosg$grupo <- as.factor(rownames(centrosg))
centrosheat <- reshape2::melt(centrosg)
colnames(centrosheat) <- c("grupo","variable","centroide")
centrosheat %>% 
  ggplot(aes(x=grupo,y=variable,fill=centroide, label=sprintf("%0.2f", round(centroide, digits=2))))+
  geom_tile()+
  scale_fill_distiller(palette="RdBu")+
  geom_text()

# Gr�fico de perfiles de centros
grupos <- c(1,2,3,4,5)

centros <- as.data.frame(cbind(grupos, cell_cluster$centers))
centros$grupos <- as.factor(centros$grupos)
colnames(centros) <- c("Grupo", "Preferido", "Adicionales", "No preferido", "Internet", 
                       "Servicios", "Equipo")

ggparcoord(centros, columns = 2:7, groupColumn = 1, scale = "globalminmax")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle=90))+
  ggtitle("Gr�fico de centroides")+
  labs(y="")

#guardar el cluster de pertenencia
cell <- cell %>% 
  mutate(grupo = cell_cluster$cluster)

mosaic(~grupo + jubilado ,data=cell, 
       legend=TRUE, shade=TRUE)
mosaic(~grupo + genero ,data=cell, 
       legend=TRUE, shade=TRUE)
mosaic(~grupo + facturaelect ,data=cell, 
       legend=TRUE, shade=TRUE)
boxplot(log(ingreso_miles)~grupo, data=cell)
boxplot(Edad~grupo, data=cell)

#Descriptivos segmentados
cell %>% 
  group_by(grupo) %>% 
  summarise(ingreso_medio=mean(ingreso_miles),
            desv_ing = sd(ingreso_miles),
            edad_media = mean(Edad),
            desv_edad = sd(Edad))


# validar resultados- consistencia
kclusters <- clusterboot(cellfin_est, B=10, 
                         clustermethod=kmeansCBI, k=4, seed=5)
# la validaci�n del resultado. >0.75 o .85 muy bueno; <.6 malo
kclusters$bootmean