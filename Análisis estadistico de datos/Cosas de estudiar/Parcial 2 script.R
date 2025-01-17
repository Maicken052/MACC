if(!require("tidyverse")) install.packages("tidyverse")
if(!require("readxl")) install.packages("readxl")
if(!require("MVQuickGraphs")) install.packages("MVQuickGraphs")
if(!require("mvnormtest")) install.packages("mvnormtest")
if(!require("MVN")) install.packages("MVN")
if(!require("MASS")) install.packages("MASS")
if(!require("DescTools")) install.packages("DescTools")
if(!require("MVTests")) install.packages("MVTests")
if(!require("readr")) install.packages("readr")
if(!require("gridExtra")) install.packages("gridExtra")
if(!require("ggpubr")) install.packages("ggpubr")
if(!require("rstatix")) install.packages("rstatix")
if(!require("corrplot")) install.packages("corrplot")
if(!require("RColorBrewer")) install.packages("RColorBrewer")
if(!require("lmtest")) install.packages("lmtest")
if(!require("car")) install.packages("car")
if(!require("mclust")) install.packages("mclust")

#pruebas de medias----
#Definir una matriz (col)
X <- matrix(c(6,10,8,
              9,6,3),byrow=FALSE,ncol=2)

X_barra <- colMeans(X) #Media
S <- cov(X) #Covarianza
S_inv <- solve(S) #Inversa
p <- ncol(X)
n <- nrow(X)

#Prueba para la media
Tp <- n * t((X_barra - mu_0)) %*% S_inv %*% (X_barra - mu_0)
Tc <- (p * (n - 1) / (n - p)) * qf(1 - 0.05, p, n - p)

HotellingsT2Test(df, mu = c())

#Comb lineal de medias
#Caso de mu = 0_vector
CX_barra <- C_matriz %*% X_barra
CSCt <- C_matriz %*% S %*% t(C_matriz)
n <- nrow(X)
c_row <- nrow(C_matriz)

Tp <- n*t(CX_barra) %*% solve(CSCt) %*% CX_barra
Tc <- ((c_row)*(n-1))/(n-c_row)*qf(1-0.05, c_row, n-c_row)

HotellingsT2Test(as.matrix(df)%*%t(C_matriz),
                 mu = c())

#Medias pareadas
dif <- df %>%
  mutate(d1 = X1 - Y1, d2 = X2 - Y2) %>%
  select(c(d1, d2))

d_barra <- colMeans(dif)
S_d <- cov(dif)

Tp <- n*t(d_barra) %*% solve(S_d) %*% d_barra
Tc <-  (p*(n-1))/(n-p) *qf(1-0.05, p, n-p)

HotellingsT2Test(dif, mu = c(0,0))

#Comparación de medias independientes (n grande o normalidad)
#Varianzas iguales
X1_barra <- colMeans()
X2_barra <- colMeans()
s1 <- cov()
s2 <- cov()
n1 <- nrow()
n2 <- nrow()

#caso delta = 0_vector
S_p <- ((n1-1)*s1 + (n2-1)*s2)/(n1+n2-2)
Tp <- ((n1*n2)/( n1+n2))*t(X1_barra - X2_barra) %*% solve(S_p) %*% (X1_barra - X2_barra)
Tc <- ((n1+n2-2)*p)/(n1+n2-p-1)*qf(1-0.05, df1=p, df2=n1+n2-p-1)

#Varianzas diferentes
#n grande
#caso delta = 0_vector
chi_p <- t(X1_barra-X2_barra)%*%solve(1/n1*s1 + 1/n2*s2)%*%(X1_barra-X2_barra)
chi_c <- qchisq(0.95, 6)

HotellingsT2Test( billetes_falsos, billetes_genuinos, test = "chi")

#int_conf
lim_inf <- diag(6)%*%(X1_barra-X2_barra)-sqrt(chi_c)*sqrt(diag(diag(6)%*%(1/n1*s1 + 1/n2*s2)%*%diag(6)))
lim_sup <- diag(6)%*%(X1_barra-X2_barra)+sqrt(chi_c)*sqrt(diag(diag(6)%*%(1/n1*s1 + 1/n2*s2)%*%diag(6)))

Sim_CI <- bind_cols(colnames(X1), lim_inf, lim_sup) %>%
  rename(variable = "...1",
         lim_inf = "...2",
         lim_sup = "...3")

Sim_CI

#n pequeño (normalidad)
BoxM(bind_rows(X1, X2), #var dif o no
     group = c(rep(1, nrow(X1)),
               rep(2, nrow(X2))))

test <- TwoSamplesHT2(bind_rows(X1, X2),
                      group = c(rep(1, nrow(X1)),
                                rep(2, nrow(X2))),
                      Homogenity = FALSE)

summary(test)

#normalidad----
shapiro.test(df$variable)
mshapiro.test(t(df))
MVN::mvn(data = df, mvnTest = "mardia")$multivariateNormality
MVN::mvn(data = df, mvnTest = "hz")$multivariateNormality

#gráficos----
# qqplot multivariado
MVN::mvn(data = df,
         multivariatePlot = "qq")

# QQ's univariados
MVN::mvn(data = df,
         univariatePlot = "qqplot")

#Histogramas univariados
MVN::mvn(data = df,
         univariatePlot = "histogram")

#elipse
confidenceEllipse(X.mean = X_barra,
                  eig = eigen(S),
                  n = n,
                  p = p,
                  alpha = 0.05)

#Scatterplot
df %>%
  ggplot(aes(x=variable, y = variable_y))+
  geom_point()+
  ggtitle("Variable y vs Variable x")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Boxplot
heart_data %>%
  ggplot(aes(variable_y, y=0))+
  geom_boxplot(width = 0.25)+
  ylim(-0.5,0.5)+
  ggtitle("Boxplot variable y")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#manova----
#Homo, nor, indep ent fact

#significados
n <- n_1 + n_2 + n_3 #número de muestra total
g <- 3 #Cantidad de poblaciones
p <- 2 #Número de variables

#boxplot
Var4 <- df %>%
  ggplot(aes(x = period, y = alt_nas, fill = period))+
  ggtitle('Altura Nasal')+
  geom_boxplot()+
  theme_minimal()

grid.arrange(Var1, Var2, Var3, Var4, ncol =2) #en caso de que sean varios

df %>%
  group_by(var_y) %>%
  get_summary_stats(variable1, variable2, variable3, variable4,
                    type = "mean_sd") %>%
  arrange(variable)

#outliers
df %>%
  group_by(factor) %>%
  mahalanobis_distance() %>%
  filter(is.outlier == TRUE)

#norm
mvn(df %>%
      filter(factor == 1) %>%
      select(-factor),
    mvnTest = "mardia",
    multivariatePlot = "qq")

mvn(df %>%
      filter(factor == 2) %>%
      select(-factor),
    mvnTest = "mardia",
    multivariatePlot = "qq")

mvn(df %>%
      filter(factor == 3) %>%
      select(-factor),
    mvnTest = "mardia",
    multivariatePlot = "qq")

mvn(df %>%
      filter(factor == 1) %>%
      select(-factor),
    mvnTest = "hz") $multivariateNormality

mvn(df %>%
      filter(factor == 2) %>%
      select(-factor),
    mvnTest = "hz") $multivariateNormality

mvn(df %>%
      filter(factor == 3) %>%
      select(-factor),
    mvnTest = "hz") $multivariateNormality

#Homogeneidad de varianzas
box_m(df[,1:p],
      df$factor)

#si diseño balanceado, no se jode tanto a rechazo

# MANOVA ----
modelo <- lm(cbind(poner variables)~factor, data = df)
Manova(modelo, test.statistic = "Wilks")

# Post-hoc comparisons ----
# Tukey_hsd (hace group 2 - group 1)

df %>%
  pivot_longer(!factor, names_to = "variable", values_to = "valores") %>%
  group_by(variable) %>%
  tukey_hsd(valores~factor)

# t_test

pwc <- df %>%
  pivot_longer(!factor, names_to = "variables", values_to = "valores") %>%
  group_by(variables) %>%
  pairwise_t_test(valores~factor, pool.sd = TRUE) %>%
  add_xy_position()

pwc

# Reporte ----

pwc <- pwc %>% add_xy_position(x = "factor")
test.label <- create_test_label(
  description = "MANOVA", statistic.text = quote(italic("F")),
  statistic = 2.05, p= "0.04358", parameter = "8,168",
  type = "expression", detailed = TRUE
)
ggboxplot(
  df, x = "factor", y = c("anch_max", "alt", "long", "alt_nas"), #variables
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

#regresión
beta_g <- solve(t(Z) %*% Z) %*% t(Z) %*% y
y_est <- Z %*% beta_g
residuales <- y - y_est

#caso real
#matriz de correlación
mat_cor <- cor(df)
corrplot(mat_cor, method = "square", tl.cex = 0.7,
         col=brewer.pal(n=8, name="PuOr"),addCoef.col = "black",
         number.cex=0.7,type = "upper", diag = FALSE)


# Linealidad
heart_data %>% 
  ggplot(aes(x=variable, y = variable_y))+
  geom_point()+
  ggtitle("variable vs variable_y")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Histograma
df %>%
  ggplot(aes(variable_y))+
  geom_histogram(fill="white", col="black")+
  ggtitle("Histograma de Y")+
  ylab("")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

# Modelo RLM ----------
modelo <- lm(variable_y ~ varx1 + varx2, data = df)
boxcox(modelo) #?
summary(modelo)
fitted(modelo)
residuals(modelo)

AIC(modelo)
BIC(modelo)

#supuestos
residuos <- residuals(modelo)

hist(residuos)
boxplot(residuos)

par(mfrow = c(2,2))
plot(modelo)

# Normalidad
shapiro.test(residuos)

# No correlación
# H0: la correlación entre los errores es 0
dwtest(modelo)

# ln(y) = beta0 + beta1*z1+ ... + bkzk + e

#pred
nuevas <- tibble(biking = c(2.14, 8.37, 62.86), 
                 smoking = c(1.58, 26.49, 32.75))
nuevas

# Intervalo de confianza para la respuesta media
predict(modelo, newdata = nuevas, interval = "confidence") # al 95% (default)

# Intervalo de confianza para la respuesta

predict(modelo_heart, newdata = nuevas, interval = "prediction")

#multivariado
modelo_sobredosis <- lm(cbind(TOT, AMI) ~ GEN + AMT + PR + DIAP + QRS, 
                        data = Amitriptilina)

#comparar modelos
anova(modelo_sobredosis,
      modelo_sobredosis_2)

#varios----
#Cambiar el nombre de las variables.
Datos_sweet <-
  sweet_data %>%
  rename(tasa_sudor = '...1',
         sodio = `...2`,
         potasio = `...3`)

#transformación (log(x), ^0.25)
radia_trans <- radia_data %>%
  mutate(rad_closed_sq = close^0.25,
         rad_open_sq = open^0.25) %>%
  select(-c(close, open))

#filtro de datos en un df
billetes_falsos <- banknote %>%
  filter(Status == "counterfeit") %>%
  select_if(is.numeric)

#Convertir a dataframe
df <- as.data.frame(X)
colnames(df) <- c("Variable1", "Variable2")