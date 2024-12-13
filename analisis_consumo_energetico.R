
# Función para leer el archivo de números
leer_numeros <- function(nombre_archivo) {
  # Verificar si el archivo existe
  if (!file.exists(nombre_archivo)) {
    stop("El archivo no existe.")
  }
  
  # Leer los números del archivo y convertirlos en un vector de enteros
  numeros <- as.integer(readLines(nombre_archivo))
  return(numeros)
}

# Función para calcular los estadísticos (media, mediana, desviación estándar)
calcular_estadisticos <- function(numeros) {
  media <- mean(numeros)
  mediana <- median(numeros)
  desviacion_estandar <- sd(numeros)
  
  # Verificar si hay alta variabilidad
  if (desviacion_estandar > 10) {
    print("Alta variabilidad en los datos (desviación estándar > 10).")
  }
  
  # Devolver los estadísticos en una lista
  return(list(media = media, mediana = mediana, desviacion_estandar = desviacion_estandar))
}

# Función para calcular el cuadrado de cada número usando sapply
calcular_cuadrados <- function(numeros) {
  cuadrados <- sapply(numeros, function(x) x^2)
  return(cuadrados)
}

# Función para escribir los resultados en el archivo de salida
guardar_resultados <- function(estados, cuadrados, nombre_archivo) {
  # Abrir el archivo para escribir los resultados
  archivo <- file(nombre_archivo, "w")
  
  # Escribir los estadísticos
  cat("Estadísticos:\n", file = archivo)
  cat("Media: ", estados$media, "\n", file = archivo)
  cat("Mediana: ", estados$mediana, "\n", file = archivo)
  cat("Desviación estándar: ", estados$desviacion_estandar, "\n", file = archivo)
  
  # Escribir la lista de cuadrados
  cat("\nCuadrados de los números:\n", file = archivo)
  cat(paste(cuadrados, collapse = ", "), "\n", file = archivo)
  
  # Cerrar el archivo
  close(archivo)
}

# Función principal para ejecutar el flujo
procesar_numeros <- function() {
  # Leer los números desde el archivo
  numeros <- leer_numeros("numeros.txt")
  
  # Calcular los estadísticos
  estadisticas <- calcular_estadisticos(numeros)
  
  # Calcular los cuadrados de los números
  cuadrados <- calcular_cuadrados(numeros)
  
  # Guardar los resultados en un archivo
  guardar_resultados(estadisticas, cuadrados, "resultados.txt")
}

# Ejecutar el script
procesar_numeros()
