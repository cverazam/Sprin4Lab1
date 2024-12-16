---
title: "Análisis Exploratorio de Datos: mtcars"
author: "Tu Nombre"
output:
  html_document:
    theme: readable
    toc: true
    toc_depth: 2
---
  
# Introducción
El objetivo de este documento es realizar un análisis exploratorio de datos sobre el conjunto de datos `mtcars`, el cual contiene información sobre varias características de automóviles. Este análisis busca explorar la relación entre diferentes variables y visualizar las características clave a través de tablas y gráficos.

### Puntos clave del análisis:
1. Carga y visualización inicial de los datos.
2. Análisis descriptivo y visualización de relaciones entre variables.
3. Conclusiones sobre los patrones observados en los datos.

# Análisis de Datos

## Carga de Datos
El conjunto de datos `mtcars` es un dataset incorporado en R que contiene información sobre 32 automóviles. Cada fila representa un automóvil, y las columnas contienen diferentes características, como el número de cilindros, el rendimiento de combustible, la potencia, entre otras.

```{r}
# Cargar los datos
data(mtcars)
head(mtcars)  # Mostrar las primeras filas del dataset

library(knitr)
kable(head(mtcars, 10), caption = "Primeras 10 filas de mtcars")

library(DT)
datatable(mtcars, caption = "Tabla interactiva de mtcars")

library(ggplot2)
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(title = "Relación entre el peso y el rendimiento de combustible",
       x = "Peso (wt)",
       y = "Rendimiento de combustible (mpg)") +
  theme_minimal()
