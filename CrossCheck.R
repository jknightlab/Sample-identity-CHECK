library(pheatmap)
library(data.table)
data <- as.data.frame(fread("~/test_LOD_Matrix_MAPQ255.txt", stringsAsFactors = F))

# 
row.names(data) <- data$READGROUP
data <- data[,-1]

# str(data) to check the if the valules are numerics 
# if yes, replace the characters/factors as numerics NOTE: replace the "," to "" to avoid generated incorrected NA values
data[] <- lapply(data, function(x) as.numeric(as.character(gsub(",","",x))))

# order the columns/rows by names
data <- data[, order(colnames(data))]
data <- data[order(rownames(data)), ]

# generate matrix and plot using pheatmap
data_matrix <- data.matrix(data)
data_matrix[data_matrix > 200] <- 200
data_matrix[data_matrix < -200] <- -200
#
pheatmap(data_matrix, col =colorRampPalette(brewer.pal(4, "PRGn"))(10),
         cluster_rows = F,cluster_cols = F)  #


sessionInfo()
