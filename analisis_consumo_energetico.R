# Cargar las librerías necesarias
if (!require(dplyr)) install.packages("dplyr")
if (!require(tidyr)) install.packages("tidyr")

library(dplyr)
library(tidyr)

# 1. Cargar el dataset mtcars y convertirlo en un dataframe
data(mtcars)
df <- as.data.frame(mtcars)

# 2. Selección de columnas y filtrado de filas
df_filtered <- df %>%
  select(mpg, cyl, hp, gear) %>%
  filter(cyl > 4)
print("Paso 2: Selección y filtrado de columnas")
print(df_filtered)

# 3. Ordenación y renombrado de columnas
df_sorted <- df_filtered %>%
  arrange(desc(hp)) %>%
  rename(consumo = mpg, potencia = hp)
print("Paso 3: Ordenación y renombrado de columnas")
print(df_sorted)

# 4. Creación de nuevas columnas y agregación de datos
df_with_efficiency <- df_sorted %>%
  mutate(eficiencia = consumo / potencia)

df_grouped <- df_with_efficiency %>%
  group_by(cyl) %>%
  summarise(consumo_medio = mean(consumo), potencia_maxima = max(potencia))
print("Paso 4: Nueva columna y agregación de datos")
print(df_with_efficiency)
print("Agrupación por cyl")
print(df_grouped)

# 5. Creación del segundo dataframe y unión de dataframes
df_transmision <- data.frame(
  gear = c(3, 4, 5),
  tipo_transmision = c("Manual", "Automática", "Semiautomática")
)

df_joined <- left_join(df_with_efficiency, df_transmision, by = "gear")
print("Paso 5: Unión de dataframes")
print(df_joined)

# 6. Transformación de formatos (pivot_longer y pivot_wider)
df_long <- df_joined %>%
  pivot_longer(cols = c(consumo, potencia, eficiencia), names_to = "medida", values_to = "valor")
print("Paso 6: Transformación a formato largo")
print(df_long)

# Identificar duplicados y manejar en formato ancho
df_long_grouped <- df_long %>%
  group_by(cyl, gear, tipo_transmision, medida) %>%
  summarise(valor = mean(valor, na.rm = TRUE))

df_wide <- df_long_grouped %>%
  pivot_wider(names_from = medida, values_from = valor)
print("Transformación de nuevo a formato ancho")
print(df_wide)

# Verificación final
print("Verificación final")
print(df_wide)
