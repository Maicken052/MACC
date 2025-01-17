#Clustering en R
if (!require('dendextend')) install.packages('dendextend')
library(psych)
library(tidyverse)

#Ejemplo 3.2
Servicios <- read_table("C:/Users/prestamour/Downloads/Servicios.DAT")

#Preparaci�n base de datos

Servicios <- Servicios %>% 
  remove_rownames %>% 
  column_to_rownames(var = "Compania")

#Estandarizamos porque tenemos magnitudes diferentes
Servicios_est <- Servicios %>% scale()

#Matriz de distancias
Servicios_dist <- dist(Servicios_est,
                       method="euclidean")

#Average
# Clustering
serv_clust <- hclust(Servicios_dist, method = "average")
serv_clust$height

# Dendograma
grafdend <- as.dendrogram(serv_clust)
grafdend <- set(grafdend,"labels_cex",0.5)
plot(grafdend, main="Average") 

#Single
# Clustering
serv_clust <- hclust(Servicios_dist, method = "single")
serv_clust$height

# Dendograma
grafdend <- as.dendrogram(serv_clust)
grafdend <- set(grafdend,"labels_cex",0.5)
plot(grafdend, main="single") 

## Ver variables de influencia
# mapa de calor
heatmap(Servicios_est,
        hclustfun = hclust, cexCol = 0.7, cexRow = 0.7)

# cortar el dendograma a un nivel dado y guardar el grupo de pertenencia
Servicios_grupos <- cutree(serv_clust, k=4)

Servicios_est_2 <- Servicios_est %>% 
  as_tibble() %>% 
  mutate(grupo = Servicios_grupos,
         grupo = as.factor(grupo)) 

# graficar
ggplot(aes(x=X1, y=X2,col=grupo), 
       data=Servicios_est_2)+
  geom_point(size=3)+
  geom_text(label=rownames(Servicios_est_2),
            size=3, col="black", nudge_y = -0.1)+
  labs(color="Grupo")+
  theme_minimal()

#-------------------------------------------------------------------------------------------------------------
# Exploratorio por cl�steres
#-------------------------------------------------------------------------------------------------------------

# Boxplot segmentado por cl�ster

Servicios_est_2 %>% ggplot(aes(x=grupo, y=X6))+
  geom_boxplot()+
  ggtitle("Sales")+
  labs(x="Grupo", y="Sales")+
  theme_minimal()

# Tarea: analizar las otras variables.

# Resumen descriptivo por cl�ster

describeBy(Servicios_est_2, Servicios_est_2$grupo)

#----------------------------------------------------------------------------------------
# Calidad del clustering
#----------------------------------------------------------------------------------------

# Distancia impl�cita en el dendograma
cophenetic(serv_clust) 
# correlaci�n entre la distancia original y la del dendograma
# a mayor valor (>0.75), mejor es el clustering
cor(Servicios_dist, cophenetic(serv_clust)) 



