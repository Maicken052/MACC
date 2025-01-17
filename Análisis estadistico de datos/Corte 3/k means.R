# Clustering en R
# K-means
if (!require('readxl')) install.packages('readxl')
if (!require('psych')) install.packages('psych')
if (!require('cluster')) install.packages('cluster')
if (!require('fpc')) install.packages('fpc')
if (!require('vcd')) install.packages('vcd')
if (!require('tidyverse')) install.packages('tidyverse')
if (!require('ggpubr')) install.packages('ggpubr')
if (!require('GGally')) install.packages('GGally')

# Ejemplo 3.3

# Lectura de los datos

cell <- read_excel("D:/Anama/OneDrive - Pontificia Universidad Javeriana/URosario/2024 - II - UR/An�lisis Estad�stico de Datos/Material de clase - en R/12. Agrupamiento/cellsegmentation.xlsx")

cell %>% glimpse()

#-------------------------------------------------------------------------------------
# An�lisis descriptivo
#-------------------------------------------------------------------------------------

## Revisi�n de las variables escalares
describe(cell[,6:10])

# C�lculo de CV's
CV <- function(var){(sd(var)/mean(var))*100}
apply(cell[,6:10],2, CV)

# boxplot para ver la posible presencia de at�picos

boxplot(cell[,6:10], 
        names=c("Minutos \npreferido", "Adicionales", "Valor equipo", 
                "Minutos \nno preferido", "Internet"), las=2, cex.axis=0.7, cex=0.5,
        main="Boxplots variables comportamentales")

# Con ggplot
# Creamos los histogramas
hist1 <- cell %>% ggplot(aes(x=minutos_preferido)) +
  geom_histogram() +
  ggtitle('Histograma \nminutos preferido') +
  labs(y = "", x = "Minutos preferido") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

hist2 <- cell %>% ggplot(aes(x=adicionales)) +
  geom_histogram() +
  ggtitle('Histograma \nconsumos adicionales') +
  labs(y = "", x = "Adicionales") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

hist3 <- cell %>% ggplot(aes(x=equipo_dolares)) +
  geom_histogram() +
  ggtitle('Histograma \nvalor mensual del equipo') +
  labs(y = "", x = "Valor equipo mensual (d�lares)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

hist4 <- cell %>% ggplot(aes(x=minutos_no_preferido)) +
  geom_histogram() +
  ggtitle('Histograma \nminutos no preferido') +
  labs(y = "", x = "Minutos no preferido") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

hist5 <- cell %>% ggplot(aes(x=internet_gigas)) +
  geom_histogram() +
  ggtitle('Histograma \nconsumo de internet') +
  labs(y = "", x = "Consumo internet (gigas)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hist1, hist2, hist3, hist4, hist5, nrow = 2, ncol = 3)


#-------------------------------------------------------------------------------------
# Preparaci�n de datos
#-------------------------------------------------------------------------------------

# variable de servicios adicionales 
cell <- cell %>% 
  mutate(servicios=fijo+largadistancia+internetcasa+numoculto)

# reducci�n de at�picos
# selecci�n de variables
cell3 <- cell %>% select(c(6:7,9:10))

# obtener el logaritmo de 1+x
cell4 <- apply(cell3,2,log1p)

# boxplot datos transformados
boxplot(cell4,
        names=c("Minutos \npreferido", "Adicionales", 
                "Minutos \nno preferido", "Internet"), las=2, cex.axis=0.7, cex=0.5,
        main="Boxplots variables transformadas")

# ensamble final
cellfin <- cell4 %>% 
  as_tibble() %>% 
  mutate(servicios = cell$servicios, 
         equipo_dolares = cell$equipo_dolares)

head(cellfin)

# estandarizar
cellfin_est <- cellfin %>% scale() %>% as_tibble()

boxplot(cellfin_est,
        names=c("Minutos \npreferido", "Adicionales", "Minutos \nno preferido", 
                "Internet", "Servicios", "Valor equipo"), las=2, cex.axis=0.7, cex=0.5,
        main="Boxplots variables transformadas\ny escaladas")

# revisar descriptivos
describe(cellfin_est)

# y los histogramas

histo1 <- cellfin_est %>% ggplot(aes(x=minutos_preferido)) +
  geom_histogram() +
  ggtitle('Histograma \nminutos preferido') +
  labs(y = "", x = "Minutos preferido") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

histo2 <- cellfin_est %>% ggplot(aes(x=adicionales)) +
  geom_histogram() +
  ggtitle('Histograma \nconsumos adicionales') +
  labs(y = "", x = "Adicionales") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

histo3 <- cellfin_est %>% ggplot(aes(x=minutos_no_preferido)) +
  geom_histogram() +
  ggtitle('Histograma \nminutos no preferido') +
  labs(y = "", x = "Minutos no preferido") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(histo1, histo2, histo3, nrow = 1, ncol = 3)


# Clustering

### Escoger el n�mero de cl�steres

#utilizo una semilla para replicar resultados
set.seed(0526)
#c�lculo la suma de cuadrados total
wss <- (nrow(cellfin_est)-1)*sum(apply(cellfin_est,2,var))

#c�lculo para cada soluci�n de clustering 
for (i in 2:15) wss[i] <- sum(kmeans(cellfin_est,
                                     centers=i, nstart=10)$withinss)
# Gr�fico de codo
# Con ggplot
sumas <- as.data.frame(cbind(wss, k = seq(1,15, by=1)))

sumas %>% ggplot(aes(x=k, y=wss)) +
  geom_point() + 
  geom_line() +
  labs(x = "N�mero de cl�steres", y = "Suma de cuadrados within") +
  ggtitle("Diagrama de codo") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))


# Otra forma de hacer el gr�fico de codo
if (!require('factoextra')) install.packages('factoextra')
if (!require('NbClust')) install.packages('NbClust')

# Elbow method
fviz_nbclust(cellfin_est, kmeans, method = "wss", k.max = 15) +
  # geom_vline(xintercept = 4, linetype = 2)+
  labs(title = "M�todo de codo")+
  xlab("N�mero de cl�steres (k)")+
  ylab("Suma total de cuadrados within")

## otras formas de ver el n�mero de cl�steres

# library("cluster")
# library("fpc")

# Evaluar usando el criterio ASW (average sillouethe width)
set.seed(2) #Para evitar aleatoriedad en los resultados
clustering.asw <- kmeansruns(cellfin_est,
                             krange=2:15,criterion="asw",
                             iter.max=100,runs= 100,critout=TRUE)
clustering.asw$bestk

#Visualmente

set.seed(2)
fviz_nbclust(cellfin_est, kmeans, method = "silhouette")+
  labs(title = "M�todo de la silueta")+
  xlab("N�mero de clusters (k)")+
  ylab("Altura promedio de la silueta (asw)")


### Ejecuci�n
# ejecuci�n de k-means
set.seed(45390)
cell_cluster <- kmeans(cellfin_est,
                       centers=5,nstart=10,iter.max=20)
#tama�o de grupos
cell_cluster$size
#numero de iteraciones
cell_cluster$iter
#centros de grupos
cell_cluster$centers

#Gr�fico de calor de centros
centrosg <- as.data.frame(cell_cluster$centers)
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

#------------------------------------------------------------------------------------
# Perfilamiento
#------------------------------------------------------------------------------------

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