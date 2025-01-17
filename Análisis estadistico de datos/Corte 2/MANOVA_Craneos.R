library(readr)
library(MVN)
library(tidyverse)
library(MVTests)
library(gridExtra)
library(ggpubr)
library(rstatix)
library(mvnormtest)

# Lectura de datos ----

Craneos_datos <- read_table("C:/Users/prestamour/Downloads/Craneos_datos.txt", 
                            col_types = cols(period = col_character()))
  
Craneos_datos %>% 
glimpse()
Craneos_datos %>% 
  count(period)

# Referencia: https://www.datanovia.com/en/lessons/one-way-manova-in-r/

# Visualización ----

Var1 <- Craneos_datos %>% 
  ggplot(aes(x = period, y = anch_max, fill = period))+
  geom_boxplot()+
  ggtitle("Anchura Máxima")+
  theme_minimal()

Var2 <- Craneos_datos %>% 
  ggplot(aes(x = period, y = alt, fill = period))+
  geom_boxplot()+
  ggtitle("Altura base")+
  theme_minimal()

Var3 <- Craneos_datos %>% 
  ggplot(aes(x = period, y = long, fill = period))+
  geom_boxplot()+
  ggtitle("Longitud base")+
  theme_minimal()

Var4 <- Craneos_datos %>% 
  ggplot(aes(x = period, y = alt_nas, fill = period))+
  geom_boxplot()+
  ggtitle("Altura nasal")+
  theme_minimal()

grid.arrange(Var1, Var2, Var3, Var4, ncol =2)

# Estadísticos descriptivos ----

Craneos_datos %>% 
  group_by(period) %>% 
  get_summary_stats(anch_max, alt, long, alt_nas,
                    type = "mean_sd") %>% 
  arrange(variable)
  
  
# Verificación de supuestos ----

# Tenemos un MANOVA balanceado pues n_i = 30 para i = 1, 2, 3.

# Identificaci�n de outliers
# Univariados

Craneos_datos %>% 
  group_by(period) %>% 
  identify_outliers(anch_max)

Craneos_datos %>% 
  group_by(period) %>% 
  identify_outliers(alt)

Craneos_datos %>% 
  group_by(period) %>% 
  identify_outliers(long)


Craneos_datos %>% 
  group_by(period) %>% 
  identify_outliers(alt_nas)
  
# No hay outliers univariados extremos
#En caso de haberlos, habría que analizarlos para ver si son errores (si lo son, eliminarlos)
#y si no lo son pueden dejarse, correr el MANOVA con ellos y sin ellos y comparar resultados

Craneos_datos %>% 
group_by(period) %>% 
mahalanobis_distance() %>% 
filter(is.outlier == TRUE)

# Tampoco hay outliers multivariados

# Normalidad
mshapiro.test(t(Craneos_datos %>% 
                  filter(period == 1) %>% 
                  select(-period)))

mshapiro.test(t(Craneos_datos %>% 
                  filter(period == 2) %>% 
                  select(-period)))

mshapiro.test(t(Craneos_datos %>% 
                  filter(period == 3) %>% 
                  select(-period)))


mvn(Craneos_datos %>% 
      filter(period == 1) %>% 
      select(-period),
    mvnTest = "mardia",
    multivariatePlot = "qq")

mvn(Craneos_datos %>% 
      filter(period == 2) %>% 
      select(-period),
    mvnTest = "mardia",
    multivariatePlot = "qq")

mvn(Craneos_datos %>% 
      filter(period == 3) %>% 
      select(-period),
    mvnTest = "mardia",
    multivariatePlot = "qq")

mvn(Craneos_datos %>% 
      filter(period == 1) %>% 
      select(-period),
    mvnTest = "hz") $multivariateNormality

mvn(Craneos_datos %>% 
      filter(period == 2) %>% 
      select(-period),
    mvnTest = "hz") $multivariateNormality

mvn(Craneos_datos %>% 
      filter(period == 3) %>% 
      select(-period),
    mvnTest = "hz") $multivariateNormality


# No es un rechazo de normalidad tan contundente. Al 1% son normales.


# Homogeneidad de varianzas

box_m(Craneos_datos[,1:4],
      Craneos_datos$period) #rstatix

# BoxMCraneos_datos# BoxM(Craneos_datos[,1:4],group = Craneos_datos$period) #MVTEsts

#Como p-value = 0.394 > 0.05 entonces con una significancia del 5% no se rechaza H0 
#y se concluye que se cumple el supuesto de homogeneidad de varianzas

#Si no lo tuvieramos, 

# MANOVA ----

modelo <- lm(cbind(anch_max, alt, long, alt_nas)~period, data = Craneos_datos)
Manova(modelo, test.statistic = "Wilks")

# Conclusión: Como p-value = 0.043 < 0.05 entonces RH0 del MANOVA y concluyo que 
#el efecto de los tratamientos no es nulo sobre las medias de las poblaciones; es decir, el 
#periodo de medición afecta al menos una de las medias de las 4 variables analizadas.

# Post-hoc comparisons ----
# Tukey_hsd (hace group 2 - group 1)

Craneos_datos %>% 
  pivot_longer(!period, names_to = "variable", values_to = "valores") %>% 
  group_by(variable) %>% 
  tukey_hsd(valores~period)

#Conclusión: Se concluye que los dos tratamientos que generan diferencia son el 
#1 y el 3, en las variables anch_max y long. Es decir, la anchura de el periodo 
#3 fue más grande que la del periodo 1, asimismo con la longitud base. Si se tuviera
#un tamaño de muestra más grande, podría ocurrir lo mismo entre los periodos 2 y 3
#en las mismas variables.

# t_test

pwc <- Craneos_datos %>% 
  pivot_longer(!period, names_to = "variables", values_to = "valores") %>% 
  group_by(variables) %>% 
  pairwise_t_test(valores~period, pool.sd = TRUE) %>% 
  add_xy_position()

pwc

# Reporte ----

pwc <- pwc %>% add_xy_position(x = "period")
test.label <- create_test_label(
  description = "MANOVA", statistic.text = quote(italic("F")),
  statistic = 2.05, p= "0.04358", parameter = "8,168",
  type = "expression", detailed = TRUE
)
ggboxplot(
  Craneos_datos, x = "period", y = c("anch_max", "alt", "long", "alt_nas"), 
  merge = TRUE, palette = "jco"
) + 
  stat_pvalue_manual(
    pwc, hide.ns = TRUE, tip.length = 0, 
    step.increase = 0.1, step.group.by = "variables",
    color = "variables"
  ) +
  labs(
    subtitle = test.label,
    caption = get_pwc_label(pwc, type = "expression")
  )

# Recursos adicionales (Two way MANOVA) ----

# https://kevintshoemaker.github.io/NRES-746/MANOVA.html
# https://ancamihai.site/2021/01/11/manova-analysis-in-r/
# 