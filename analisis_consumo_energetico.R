# Crear el código en un archivo .R

code_r = """
# Paso 1: Crear vectores
energia <- c(rep("Renovable", 10), rep("No Renovable", 10))
consumo <- c(15, 20, NA, 30, 22, 18, NA, 25, 28, 16, 10, 14, 30, 20, 19, 21, 27, 22, 26, 15)
costo_kwh <- c(rep(0.15, 10), rep(0.20, 10))  # Ejemplo de costos

# Paso 2: Limpieza de datos
consumo_renovable <- consumo[energia == "Renovable"]
consumo_no_renovable <- consumo[energia == "No Renovable"]

# Reemplazar NA por la mediana
consumo_renovable[is.na(consumo_renovable)] <- median(consumo_renovable, na.rm = TRUE)
consumo_no_renovable[is.na(consumo_no_renovable)] <- median(consumo_no_renovable, na.rm = TRUE)

# Reintegrar los vectores limpiados al vector consumo
consumo[energia == "Renovable"] <- consumo_renovable
consumo[energia == "No Renovable"] <- consumo_no_renovable

# Paso 3: Crear dataframe
df_consumo <- data.frame(
  Energia = energia,
  Consumo = consumo,
  Costo_kWh = costo_kwh
)

# Paso 4: Calcular columnas adicionales
df_consumo$costo_total <- df_consumo$Consumo * df_consumo$Costo_kWh
df_consumo$ganancia <- df_consumo$costo_total * 1.1  # Aumento del 10%

# Calcular totales por tipo de energía
total_consumo_renovable <- sum(df_consumo$Consumo[df_consumo$Energia == "Renovable"])
total_consumo_no_renovable <- sum(df_consumo$Consumo[df_consumo$Energia == "No Renovable"])

total_costo_renovable <- sum(df_consumo$costo_total[df_consumo$Energia == "Renovable"])
total_costo_no_renovable <- sum(df_consumo$costo_total[df_consumo$Energia == "No Renovable"])

# Media de consumo por tipo de energía
media_consumo_renovable <- mean(df_consumo$Consumo[df_consumo$Energia == "Renovable"])
media_consumo_no_renovable <- mean(df_consumo$Consumo[df_consumo$Energia == "No Renovable"])

# Paso 5: Resumen de datos
df_consumo_ordenado <- df_consumo[order(df_consumo$costo_total, decreasing = TRUE), ]

# Top 3 mayores costos
top_3_costos <- head(df_consumo_ordenado, 3)

# Crear lista de resumen
resumen_energia <- list(
  Total_consumo_renovable = total_consumo_renovable,
  Total_consumo_no_renovable = total_consumo_no_renovable,
  Total_costo_renovable = total_costo_renovable,
  Total_costo_no_renovable = total_costo_no_renovable,
  Media_consumo_renovable = media_consumo_renovable,
  Media_consumo_no_renovable = media_consumo_no_renovable,
  Top_3_Costos = top_3_costos
)

# Mostrar resumen
print(resumen_energia)
"""

# Guardar el código en un archivo .R
file_path = '/mnt/data/analisis_consumo_energetico.R'
with open(file_path, 'w') as file:
    file.write(code_r)

file_path
