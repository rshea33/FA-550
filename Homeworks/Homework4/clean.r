
setwd("/Users/ryanshea/Desktop/FA 550/FA-550/Homeworks/Homework4")

df <- read.csv('sale.csv')

View(df)

colnames(df)

pitch_type_vector <- data.frame(df$plate_x * 12, df$plate_z * 12)
colnames(pitch_type_vector) <- c('Plate X', 'Plate Y')


write.csv(as.data.frame(table(pitch_type_vector))[86:89,], 'loc.csv')



write.csv(pitch_type_vector, 'loc.csv')
