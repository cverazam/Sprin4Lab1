# Cargar librerías necesarias
library(tseries)
library(ggplot2)
library(forecast)

# 1. Cargar el dataset
data("AirPassengers")

# Verificar la clase y resumen del dataset
class(AirPassengers)  # Debe ser 'ts' (serie temporal)
summary(AirPassengers) # Resumen estadístico
start(AirPassengers)   # Ver el inicio de la serie
end(AirPassengers)     # Ver el fin de la serie
frequency(AirPassengers) # Frecuencia: 12 (mensual)

# 2. Exploración inicial

# Graficar la serie temporal para observar la tendencia y patrones estacionales
plot(AirPassengers, main = "Número de pasajeros internacionales de aerolíneas (1949-1960)",
     xlab = "Año", ylab = "Número de pasajeros", col = "blue", lwd = 2)

# Estadísticas descriptivas
mean(AirPassengers)  # Media
sd(AirPassengers)    # Desviación estándar

# 3. Análisis de tendencia y estacionalidad

# Descomponer la serie temporal
decomposed_series <- decompose(AirPassengers)

# Visualizar los componentes: tendencia, estacionalidad y aleatorio
plot(decomposed_series)

# 4. Análisis de estacionariedad

# Graficar ACF y PACF
acf(AirPassengers, main = "ACF de AirPassengers")
pacf(AirPassengers, main = "PACF de AirPassengers")

# Aplicar la prueba ADF (Dickey-Fuller) para comprobar la estacionariedad
adf_test <- adf.test(AirPassengers)
print(adf_test)  # Verificar el p-value de la prueba

# Si la serie no es estacionaria, diferenciación simple
if(adf_test$p.value > 0.05) {
  AirPassengers_diff <- diff(AirPassengers)
  # Graficar la serie diferenciada
  plot(AirPassengers_diff, main = "Serie diferenciada", ylab = "Diferencia")
}

# 5. Detección de valores atípicos

# Visualizar posibles outliers utilizando un boxplot
boxplot(AirPassengers, main = "Boxplot de AirPassengers", col = "lightgreen")

# Resaltar valores atípicos
outliers <- which(AirPassengers > quantile(AirPassengers, 0.75) + 1.5 * IQR(AirPassengers) |
                  AirPassengers < quantile(AirPassengers, 0.25) - 1.5 * IQR(AirPassengers))

# 6. Interpretación de resultados

# Resumen de la descomposición de la serie temporal
cat("La serie temporal muestra una tendencia creciente a lo largo del tiempo. La estacionalidad es evidente
    con picos altos en ciertos meses cada año, lo que indica un patrón estacional. Los componentes aleatorios
    muestran pequeñas variaciones alrededor de la tendencia.")
  
# 7. Entrega

# Guardar el archivo como .Rmd o .R

