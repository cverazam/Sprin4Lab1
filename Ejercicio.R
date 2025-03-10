# Cargar librerías necesarias
library(tseries)
library(ggplot2)
library(forecast)

# 1. Carga del dataset
data("nottem")

# Inspeccionar la estructura del dataset
print(class(nottem))  # Verificar que es una serie temporal 'ts'
print(summary(nottem)) # Resumen estadístico
start(nottem)   # Ver inicio de la serie
end(nottem)     # Ver fin de la serie
frequency(nottem) # Frecuencia: 12 (mensual)

# Graficar la serie temporal
plot(nottem, main = "Temperaturas Mensuales en Nottingham (1920-1939)",
     xlab = "Año", ylab = "Temperatura", col = "blue")

# 2. Exploración y preparación de datos

# Descomponer la serie temporal para identificar componentes de tendencia, estacionalidad y aleatoriedad
decomposed_series <- decompose(nottem)

# Visualizar los componentes: tendencia, estacionalidad y aleatorio
plot(decomposed_series)

# 3. Análisis de estacionariedad

# Graficar ACF y PACF para observar la autocorrelación
acf(nottem, main = "ACF de las Temperaturas en Nottingham")
pacf(nottem, main = "PACF de las Temperaturas en Nottingham")

# Realizar la prueba de Dickey-Fuller para evaluar la estacionariedad
adf_test <- adf.test(nottem)
print(adf_test)  # Verificar el p-value de la prueba ADF

# 4. Transformación de la serie (si es necesario)

# Si la serie no es estacionaria, aplicar diferenciación
if(adf_test$p.value > 0.05) {
  nottem_diff <- diff(nottem)
  # Graficar la serie diferenciada
  plot(nottem_diff, main = "Serie Temporal Diferenciada", ylab = "Temperatura Diferenciada")
  
  # Verificar la estacionariedad nuevamente con la prueba ADF
  adf_test_diff <- adf.test(nottem_diff)
  print(adf_test_diff)  # Verificar el p-value de la prueba ADF para la serie diferenciada
}

# 5. Detección de valores atípicos

# Visualizar posibles valores atípicos utilizando un boxplot
boxplot(nottem, main = "Boxplot de Temperaturas en Nottingham", col = "lightgreen")

# Resaltar valores atípicos (si los hay)
outliers <- which(nottem > quantile(nottem, 0.75) + 1.5 * IQR(nottem) |
                  nottem < quantile(nottem, 0.25) - 1.5 * IQR(nottem))

cat("Valores atípicos identificados en las posiciones: ", outliers, "\n")

# 6. Interpretación de resultados

# Resumen de la descomposición y el análisis
cat("La serie temporal muestra una tendencia de temperaturas ascendentes a lo largo de los años.
     La estacionalidad está claramente presente, con un patrón anual de temperaturas más altas en verano y más bajas en invierno.
     Los valores atípicos son mínimos, pero algunos valores extremos pueden haber influido en ciertos puntos de la serie.")

# 7. Entrega

# Guardar el archivo como .Rmd o .R

