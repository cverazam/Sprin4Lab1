# Paquetes necesarios
library(ggplot2)
library(cluster)
library(dendextend)
library(dplyr)

# 1. Carga de datos
dataset <- read.csv("Mall_Customers.csv")

# 2. Exploración de datos
head(dataset)
dim(dataset)
str(dataset)
summary(dataset)

# Renombrar columnas para facilitar el manejo
colnames(dataset) <- c("CustomerID", "Gender", "Age", "Annual_Income", "Spending_Score")

# 3. Limpieza de datos
# Codificar 'Gender' como variable numérica
dataset$Gender <- ifelse(dataset$Gender == "Male", 1, 0)

# Normalización de variables numéricas
dataset_scaled <- scale(dataset[, c("Annual_Income", "Spending_Score")])

# 4. Exploración de variables
ggplot(dataset, aes(x = Age)) + geom_histogram(bins = 20, fill = "blue", alpha = 0.6) + theme_minimal()
ggplot(dataset, aes(x = Annual_Income)) + geom_histogram(bins = 20, fill = "green", alpha = 0.6) + theme_minimal()

ggplot(dataset, aes(x = Gender, y = Spending_Score, fill = as.factor(Gender))) +
  geom_boxplot() + theme_minimal()

# 5. Entrenamiento de modelos de clustering
set.seed(123)

# Método del codo para determinar el número óptimo de clusters
wss <- sapply(2:10, function(k) {
  kmeans(dataset_scaled, centers = k, nstart = 25)$tot.withinss
})

plot(2:10, wss, type = "b", pch = 19, frame = FALSE,
     xlab = "Número de Clusters", ylab = "Suma de cuadrados dentro de los clusters")

# Aplicar K-Means con el número óptimo de clusters (ajustar manualmente según el gráfico)
kmeans_model <- kmeans(dataset_scaled, centers = 5, nstart = 25)
dataset$Cluster_KMeans <- kmeans_model$cluster

# Clustering jerárquico
distance_matrix <- dist(dataset_scaled, method = "euclidean")
hclust_model <- hclust(distance_matrix, method = "ward.D")

# Dendrograma
plot(as.dendrogram(hclust_model), main = "Dendrograma")

dataset$Cluster_Hierarchical <- cutree(hclust_model, k = 5)

# 6. Evaluación de los modelos
silhouette_kmeans <- silhouette(kmeans_model$cluster, dist(dataset_scaled))
avg_silhouette_kmeans <- mean(silhouette_kmeans[, 3])

silhouette_hierarchical <- silhouette(dataset$Cluster_Hierarchical, dist(dataset_scaled))
avg_silhouette_hierarchical <- mean(silhouette_hierarchical[, 3])

cat("Promedio de silueta K-Means:", avg_silhouette_kmeans, "\n")
cat("Promedio de silueta Jerárquico:", avg_silhouette_hierarchical, "\n")

# 7. Visualización de resultados
ggplot(dataset, aes(x = Annual_Income, y = Spending_Score, color = as.factor(Cluster_KMeans))) +
  geom_point(size = 3) +
  labs(title = "Clusters de K-Means", x = "Ingreso Anual", y = "Puntuación de Gasto") +
  theme_minimal()

ggplot(dataset, aes(x = Annual_Income, y = Spending_Score, color = as.factor(Cluster_Hierarchical))) +
  geom_point(size = 3) +
  labs(title = "Clusters Jerárquicos", x = "Ingreso Anual", y = "Puntuación de Gasto") +
  theme_minimal()

# 8. Análisis descriptivo de los clusters
aggregate(dataset[, c("Age", "Annual_Income", "Spending_Score")],
          by = list(Cluster_KMeans = dataset$Cluster_KMeans),
          FUN = mean)

