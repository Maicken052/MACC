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
if (!require('tidyverse')) install.packages('tidyverse')

if (!require('rrcov')) install.packages('rrcov')

data(hemophilia)
View(hemophilia)

#Conteo de cada clase
hemophilia %>% count(gr)

#Separación de cada clase
pi_1 <- hemophilia %>% 
  filter(gr == 'normal') %>% 
  dplyr::select(-gr)

pi_2 <- hemophilia %>% 
  filter(gr == 'carrier') %>% 
  dplyr::select(-gr)

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
names <- colnames(hemophilia)

#Boxplot
b1 <- hemophilia %>%
  ggboxplot(x = "gr", y = names[1],
            color = names[length(names)], palette = "jco",
            width = 0.5) +
  labs(title = paste("Boxplot of", names[1], "by gr")) +
  theme_minimal()

b2 <- hemophilia %>%
  ggboxplot(x = "gr", y = names[2],
            color = names[length(names)], palette = "jco",
            width = 0.5) +
  labs(title = paste("Boxplot of", names[2], "by gr")) +
  theme_minimal()

ggarrange(b1, b2, ncol = 2)

#Histograma
h1 <- hemophilia %>% 
  gghistogram(x = "AHFactivity", add = "mean",
              color = "gr",
              fill = "gr", palette = c("#00AFBB", "#E7B800")) +
  ggtitle("AHFactivity") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

h2 <- hemophilia %>% 
  gghistogram(x = "AHFantigen", add = "mean",
              color = "gr",
              fill = "gr", palette = c("#00AFBB", "#E7B800")) +
  ggtitle("AHFantigen") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(h1, h2, common.legend = TRUE, legend = "bottom", nrow = 1)

hemophilia %>% 
  ggplot(aes(x=AHFactivity, y=AHFantigen, color = gr)) + 
  geom_point()

#Media y desviación
hemophilia %>% 
  group_by(gr) %>% 
  summarise(media_x1 = mean(AHFactivity),
            media_x2 = mean(AHFantigen),
            desv_x1 = sd(AHFactivity),
            desv_x2 = sd(AHFantigen))

#Igualdad de varianzas
BoxM(bind_rows(pi_1, pi_2),
     group = hemophilia$gr)

#Las matrices de covarianza poblacionales son iguales bajo el BoxM, por tanto
#se usa LDA

# LDA
modelo_lda <- lda(gr ~., data = hemophilia)
modelo_lda

#Modelo Y:9.032787*AHFactivity - 8.006605*AHFantigen

#Predicción sobre los datos
predicciones <- predict(modelo_lda)$class #dejar class en vez de población

#Datos realcall#Datos reales
reales <- hemophilia$gr

#matriz de confusión
confusion_matrix <- table(predicciones, reales)
FP <- confusion_matrix[1, 2]
FN <- confusion_matrix[2, 1]
total <- nrow(hemophilia) 

#APER
APER = (FP + FN)/total
APER

#Train - test
train_index <- createDataPartition(hemophilia$gr,
                                   p = 0.8, 
                                   list = FALSE)

train <- hemophilia[train_index,]
test <- hemophilia[-train_index,]

#Cant de datos de cada clase en cada partición
prop.table(table(train$gr))
prop.table(table(test$gr))

#modelo en train
modelo_lda_train <- lda(gr ~., data = train)
modelo_lda_train

#Predicción sobre los datos
predicciones <- predict(modelo_lda_train, test)$class #dejar class en vez de población

#Datos reales
reales <- test$gr

#matriz de confusión
confusion_matrix <- table(predicciones, reales)
FP <- confusion_matrix[1, 2]
FN <- confusion_matrix[2, 1]
total <- nrow(test) 

#APER
APER = (FP + FN)/total
APER

#leave one out
modelo_lda_cv <- lda(gr ~., CV = TRUE, data = hemophilia)
modelo_lda_cv

#Predicción sobre los datos
predicciones <- modelo_lda_cv$class #dejar class en vez de población

#Datos reales
reales <- hemophilia$gr

#matriz de confusión
confusion_matrix <- table(reales, predicciones)
FP <- confusion_matrix[1, 2]
FN <- confusion_matrix[2, 1]
total <- nrow(hemophilia) 

#APER
APER = (FP + FN)/total
APER
#La tasa de error estimada con leave one out es de 14.6%

##
datos_nuevos <- matrix(c(
  -0.112, -0.279,
  -0.059, -0.068,
  0.064,  0.012,
  -0.043, -0.052,
  -0.050, -0.098,
  -0.094, -0.113,
  -0.123, -0.143,
  -0.011, -0.037,
  -0.210, -0.090,
  -0.126, -0.019
), nrow = 10, ncol = 2, byrow = TRUE)

colnames(datos_nuevos) = c("AHFactivity", "AHFantigen") 

#predecir datos nuevos
predict(modelo_lda, as.data.frame(datos_nuevos))

#
modelo_lda_prior <- lda(gr ~., data = hemophilia, prior = c(0.25,0.75))
modelo_lda_prior

predict(modelo_lda_prior, as.data.frame(datos_nuevos))