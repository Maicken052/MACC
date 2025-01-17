if (!require('corrplot')) install.packages('corrplot')
if (!require('tidyverse')) install.packages('tidyverse')
if (!require('psych')) install.packages('psych')
if (!require('RColorBrewer')) install.packages('RColorBrewer')
if (!require('factoextra')) install.packages('factoextra')
if (!require('reshape2')) install.packages('reshape2')
if (!require('FactoMineR')) install.packages('FactoMineR')
if (!require('readxl')) install.packages('readxl')



# Ejercicio - Cartera ---------------------------------------------------
cartera <- read_delim("C:/Users/prestamour/Downloads/cartera.csv", 
                                 delim = ";", escape_double = FALSE, trim_ws = TRUE, locale = locale(decimal_mark = ","))
cartera %>% glimpse()

# Se quitan las variables categ�ricas
carteraz <- cartera %>% 
select(-c(tipoips, retrasos))

carteraz %>% glimpse()

#creo matriz de correlaciones
base <- cor(carteraz)
#ver la matriz redondeada a 4 decimales
round(base,4)

#gr�fico de correlaciones
corrplot(base, type="upper", tl.cex = 0.7,col=brewer.pal(n=8, name="PuOr"))
corrplot(base, method="number",tl.cex = 0.7,col=brewer.pal(n=8, name="PuOr"), type = "upper")
corrplot(base, method="square",tl.cex = 0.7,col=brewer.pal(n=8, name="PuOr"),addCoef.col = "black", 
         number.cex=0.7,type = "upper", diag = FALSE, order="FPC")


# Test de Bartlett (prueba de esfericidad)
# H0: no hay correlaci�n vs H1: s� hay correlaci�n
# Si p-value < 0.05 entonces hay correlaci�n significativa entre variables y se puede
# aplicar un ACP

Test.Bartlett <- cortest.bartlett(base,n=nrow(carteraz))
Test.Bartlett

# Test KMO
KMO(base)

## Aplicamos componentes principales y se estandarizan los datos
componentestotal <- prcomp(carteraz, center=TRUE, scale.=TRUE)
summary(componentestotal)

#Variabilidad explicada en t�rminos de cantidad de variables
lambdas <- as.data.frame(summary(componentestotal)[1])^2
lambdas

#Veamos la direcci�n de cada componente
print(componentestotal)

## Cu�ntos componentes se deben escoger - Gr�fico de sedimentaci�n
plot(componentestotal, type="l", main = "Gr�fico de sedimentaci�n", ylim=c(0,4))

# Gr�fico usando el paquete factoextra
fviz_eig(componentestotal, geom="line", choice="eigenvalue", ylim=c(0,3.5),
         main = "Gr�fico de sedimentaci�n - Valores propios",
         addlabels = TRUE, xlab = "N�mero de componentes", 
         ylab="Valores propios")

fviz_eig(componentestotal, geom="line", ylim=c(0,50),
         main = "Gr�fico de sedimentaci�n - Varianza explicada",
         addlabels = TRUE, xlab = "N�mero de componentes", 
         ylab="Porcentaje de varianza explicado")

#Pareto       
tabla <- tibble(k = c(1,2,3,4,5, 6, 7), var_acum = unlist(cumsum(lambdas/7*100)))

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


#C�rculo de correlaciones para la soluci�n factorial
#Primer plano factorial
fviz_pca_var(componentestotal, labelsize=3, repel=TRUE)+
  theme(axis.title = element_text(size = 7.5),
        axis.text = element_text(size = 7.5))+
  ggtitle("C�rculo de correlaciones")

#Segundo plano factorial
fviz_pca_var(componentestotal, axes=c(3,4),labelsize=3, repel=TRUE)+
  theme(axis.title = element_text(size = 7.5),
        axis.text = element_text(size = 7.5))+
  ggtitle("C�rculo de correlaciones")

#Contribuciones a los ejes factoriales
print((abs(componentestotal$rotation[,1])/sum(abs(componentestotal$rotation[,1]))))
fviz_contrib(componentestotal,choice="var", axes=1)
fviz_contrib(componentestotal,choice="var", axes=2)
fviz_contrib(componentestotal,choice="var", axes=3)

#Ver los valores de las contribuciones
#Paquete FactoMineR
# install.packages("FactoMineR")
# library(FactoMineR)
carteracomp <- PCA(carteraz, graph=FALSE) #ncp=5 por default
#por variable
a <- carteracomp$var$contrib
sort(a[,1], decreasing = TRUE)

#por individuo
carteracomp$ind$contrib

#Limitando el total de componentes
componentes <- prcomp(carteraz, center=TRUE, scale.=TRUE, rank.=2)
print(componentes)

#Gr�fico de cargas factoriales
cargasdf <- as.data.frame(componentes$rotation)
cargasdf$medicion <- rownames(cargasdf)
cargasheat <- reshape2::melt(cargasdf)
colnames(cargasheat) <- c("variable","componente","carga")
cargasheat %>% 
  ggplot(aes(x=componente,y=variable,fill=carga, 
             label=sprintf("%0.2f", round(carga, digits=2))))+
  geom_tile()+
  scale_fill_distiller(palette="RdBu")+
  geom_text()


#Rotaci�n de ejes para facilitar la interpretaci�n
componentes2 <- principal(carteraz,nfactors=2,rotate="varimax")
# rotaciones disponibles: "none", "varimax", "quartimax", "promax", 
# "oblimin", "simplimax", and "cluster"
componentes2$communality
componentes2$loadings

#Comunalidades: Cuando se explica de cada variable por medio de la solución factorial (en este caso,
#PC1 y PC2)

#las comunalidades se obtienen como la suma de los cuadrados
#de las respectivas cargas de la variable en la soluci�n factorial

sum(componentes2$loadings[1,]^2)

#Graficando de nuevo las cargas (esta vez rotadas)

componente1 <- componentes2$loadings[,1]
componente2 <- componentes2$loadings[,2]

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

#La rotación varimax sirve para ver de manera más clara las cargas factoriales
#de cada componente.


#Graficar puntos sobre planos factoriales
#guardo las puntuaciones factoriales
pc <- componentes$x
#uno las dos columnas a la base inicial
carterapc <- cbind(cartera,pc)
carterapc$retrasos <- as.factor(carterapc$retrasos)
#dos gr�ficos
plot(carterapc$PC1,carterapc$PC2)

ggplot(carterapc,aes(x=PC1,y=PC2,color=retrasos))+
  geom_point()+
  ggtitle("Puntuaciones factoriales")

## Soluci�n Rotada

#guardo las puntuaciones factoriales
pca <- componentes2$scores
#uno las dos columnas a la base inicial
carterapca <- cbind(cartera,pca)
carterapca <- carterapca %>% 
  mutate(retrasos = as.factor(retrasos))

# carterapca$retrasos<-as.factor(carterapca$retrasos)

carterapca %>% 
  ggplot(aes(x=RC1,y=RC2,color=retrasos))+
  geom_point()+
  ggtitle("Puntuaciones factoriales - soluci�n rotada")

