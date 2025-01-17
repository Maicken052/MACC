#Estadística descriptiva multivariada
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("psych")) install.packages("psych")
if(!require("ggpubr")) install.packages("ggpubr")
if(!require("GGally")) install.packages("GGally")
if(!require("corrplot")) install.packages("corrplot")
if(!require("RColorBrewer")) install.packages("RColorBrewer")
if(!require("gmodels")) install.packages("gmodels")
if(!require("readr")) install.packages("readr")
if(!require("dplyr")) install.packages("dplyr")
if(!require("vcdExtra")) install.packages("vcdExtra")
if(!require("aplpack")) install.packages("aplpack")
if(!require("MASS")) install.packages("MASS")

#################Punto 1####################
#Leer los datos
PerdidaOsea <- read_delim("C:/Users/Daniel Fonseca/Downloads/PerdidaOsea.csv", 
                          delim = ";", escape_double = FALSE, trim_ws = TRUE)
PerdidaOsea %>%  glimpse()

#Arreglar datos
convertir_a_numeric <- function(df) {
  df[] <- lapply(df, function(col) {
    if (is.factor(col)) {
      col <- as.character(col)  # Convertir factor a character
    }
    if (is.character(col)) {
      # Reemplazar comas con puntos
      col <- gsub(",", ".", col)
      # Convertir a numérico
      as.numeric(col)
    } else {
      col  # Dejar otras columnas sin cambios
    }
  })
  return(df)
}

PerdidaOsea <- convertir_a_numeric(PerdidaOsea)
PerdidaOsea %>%  glimpse()

#Boxplot de cada variable
boxplot(PerdidaOsea$dradi, horizontal = TRUE)
boxplot(PerdidaOsea$radi, horizontal = TRUE)
boxplot(PerdidaOsea$dhum, horizontal = TRUE)
boxplot(PerdidaOsea$humero, horizontal = TRUE)
boxplot(PerdidaOsea$dcubito, horizontal = TRUE)
boxplot(PerdidaOsea$cubito, horizontal = TRUE)

#Vector de medias
medias <- colMeans(PerdidaOsea)
medias

#Matriz de covarianzas
mat_S <- cov(PerdidaOsea)
mat_S

#Matriz de correlaciones
mat_R <- cor(PerdidaOsea)
mat_R

det(mat_S) #Varianza generalizada
sum(diag(mat_S)) #Varianza total

#Distancia Mahalanobis
mahalanobis(PerdidaOsea, center = medias, cov = mat_S) 

#Distancia euclidiana
normalizar_z_score <- function(df) {
  df[] <- lapply(df, function(col) {
    if (is.numeric(col)) {
      (col - mean(col, na.rm = TRUE)) / sd(col, na.rm = TRUE)
    } else {
      col  # Dejar las columnas no numéricas sin cambios
    }
  })
  return(df)
}

# Aplicar la normalización
PerdidaOsea_normalizada <- normalizar_z_score(PerdidaOsea)

#Función de distancia
distancias_a_media <- apply(PerdidaOsea_normalizada, 1, function(fila) {
  sqrt(sum((fila - (medias-medias))^2))
})

# Ver las distancias
print(distancias_a_media)

#################Punto 2####################
#ver la base
view(crabs)

#Eliminar index
crabs$index <- NULL

#Solo datos numéricos
crabs_num <- crabs[sapply(crabs, is.numeric)]

# Aplicar la normalización
crabs_normalizada <- normalizar_z_score(crabs)
view(crabs_normalizada)

#Dividir según color
# Subconjunto de machos
blue_crabs <- subset(crabs, sp == "B")
blue_crabs_num <- blue_crabs[sapply(blue_crabs, is.numeric)]
blue_crabs_normalizada <- normalizar_z_score(blue_crabs_num)

# Subconjunto de hembras
orange_crabs <- subset(crabs, sp == "O")
orange_crabs_num <- orange_crabs[sapply(orange_crabs, is.numeric)]
orange_crabs_normalizada <- normalizar_z_score(orange_crabs_num)

#Medias 
medias_blue <- colMeans(blue_crabs_num)
medias_blue

medias_orange <- colMeans(orange_crabs_num)
medias_orange

#Matriz de covarianzas
mat_S <- cov(crabs[sapply(crabs, is.numeric)])
mat_S

#Distancia mahalanobis de los cangrejos azules al centroide naranja
dist_mahalanobis <- mahalanobis(blue_crabs_num, center = medias_orange, cov = mat_S) 

# Encontrar el valor mínimo 
min_dist_mahalanobis <- min(dist_mahalanobis)
print(min_dist_mahalanobis)

#Distancia mahalanobis de los cangrejos naranjas al centroide azul
dist_mahalanobis <- mahalanobis(orange_crabs_num, center = medias_blue, cov = mat_S) 

# Encontrar el valor mínimo 
min_dist_mahalanobis <- min(dist_mahalanobis)
print(min_dist_mahalanobis)

#Distancia euclidiana de los cangrejos azules al centroide naranja
distancias_a_media <- apply(blue_crabs_normalizada, 1, function(fila) {
  sqrt(sum((fila - (medias_blue-medias_blue))^2))
})

# Encontrar el valor mínimo 
min_dist_euclidiana <- min(distancias_a_media)
print(min_dist_euclidiana)

#Distancia euclidiana de los cangrejos naranjas al centroide azul
distancias_a_media <- apply(orange_crabs_normalizada, 1, function(fila) {
  sqrt(sum((fila - (medias_orange-medias_orange))^2))
})

# Encontrar el valor mínimo 
min_dist_euclidiana <- min(distancias_a_media)
print(min_dist_euclidiana)
