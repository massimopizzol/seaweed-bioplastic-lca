library('ggplot2')
library('reshape2')
#library('Hmisc')

# Monte Carlo plot
mc = read.csv('../Results/mc_CC_fossil.csv', sep = ',')
head(mc)
names(mc)
dim(mc)

names(mc) <- c('X','BASE com','BASE inc',
               'CELL com','CELL inc', 
               'MANN com','MANN inc',
               'PLA5 com', 'PLA5 inc', 
               'PLA30 inc', 'PLA30 com', 
               'BASE nbu com', 'BASE nbu inc', 
               'CELL nbu inc', 'CELL nbu com', 
               'MANN nbu inc', 'MANN nbu com', 
               'PLA5 nbu inc', 'PLA5 nbu com',
               'PLA30 nbu com', 'PLA30 nbu inc')

summary(mc)


# New order of columns
myorder <- c('X','BASE com','BASE inc',
             'MANN com','MANN inc',
             'CELL com','CELL inc', 
             'PLA5 com', 'PLA5 inc',
             'PLA30 com', 'PLA30 inc', 
             'BASE nbu com', 'BASE nbu inc', 
             'MANN nbu com', 'MANN nbu inc', 
             'CELL nbu com', 'CELL nbu inc', 
             'PLA5 nbu com', 'PLA5 nbu inc',
             'PLA30 nbu com', 'PLA30 nbu inc')

mc <- mc[,myorder]
head(mc)
summary(mc)
plot(mc$'CELL inc',mc$'CELL com')
#remove outliers from plot

mc_sorted <- mc[order(mc[,c('PLA30 inc')]),]
mc_sorted <- mc_sorted[-c(1,2,999,1000),] 
tail(mc_sorted)
mc_sorted[c(996),]
# convert to long dataframe format (prepare for plotting)

mc_long <- melt(mc_sorted, id = c('X'))
mc_long <- mc_long[,-1]
mc_long$variable <- as.character(mc_long$variable)
mc_long <- mc_long[order(mc_long$variable),]
mc_long$variable <- factor(mc_long$variable)
head(mc_long)
tail(mc_long)
dim(mc_long)


mc_long$variable <- factor(mc_long$variable, levels = c('BASE com','BASE inc',
                                                        'MANN com','MANN inc',
                                                        'CELL com','CELL inc', 
                                                        'PLA5 com', 'PLA5 inc',
                                                        'PLA30 com', 'PLA30 inc', 
                                                        'BASE nbu com', 'BASE nbu inc', 
                                                        'MANN nbu com', 'MANN nbu inc', 
                                                        'CELL nbu com', 'CELL nbu inc', 
                                                        'PLA5 nbu com', 'PLA5 nbu inc',
                                                        'PLA30 nbu com', 'PLA30 nbu inc'))

mc_long$BU = ifelse(grepl('nbu', mc_long$variable, fixed = TRUE), 
                    "nbu", "bu")
mc_long$BU <- factor(mc_long$BU, levels = c('bu','nbu'))

summary(mc_long)



gmc <- ggplot(mc_long, aes(x = variable, y = value, color = BU)) + 
  geom_point()+
  #geom_jitter(color = "aquamarine4", width = 0.1, alpha = 0.15)+
  geom_jitter(width = 0.1, alpha = 0.15)+
  geom_boxplot(alpha = 0.01, outlier.shape = NA, color = 'black')+
  #stat_summary(fun.data = mean_sdl, geom = "errorbar", color = "darkblue")+
  stat_summary(fun=median, geom="point", size = 1, color = 'black')+
  #stat_summary(fun.y=median, geom="text", aes(label = round(..y.., 2)), vjust = -1, size = 3) +
  #stat_summary(fun.y=median, geom="point", shape = 6)+
  theme_minimal()+
  theme(text = element_text(size = 10),
        axis.text.x=element_text(angle = 90, vjust = 0.5),
        #axis.text.x=element_blank(),
        legend.position = "none",
        panel.grid = element_blank(),
        panel.background = element_rect(fill = "white"),
        plot.margin = margin(0.5,0.5,0.5,0.5, "cm"))


gmc  + ylab(expression(paste("kg CO"[2], "-eq / kg bioplastic"))) +  xlab("") + theme(
  plot.title = element_text(hjust = 0.5))+
  ggtitle("")+
  ylim(-5, 25) +#  setting a limit just for the figure
  scale_y_continuous(breaks = seq(-5, 25, len = 13), limits = c(-5,25))
  #scale_x_discrete(labels = parse(text = levels(mc_long$variable)))

# Analysis of differences.

mc_ <- mc[,-c(1,12:21)] # remove pandas index and nbu columns
names(mc_)
differences <- data.frame(matrix(NA, nrow = dim(mc_)[2], ncol = dim(mc_)[2]))

for (i in c(1:dim(mc_)[2])){
  print(i)
  for (j in c(1:dim(mc_)[2])){
  
    differences[i,j] <- sum(mc_[,i] - mc_[,j] > 0)/1000
  }}


names(differences) <- names(mc)[-c(1,12:21)]
rownames(differences) <- names(mc)[-c(1,12:21)]
differences
my_mat <- as.matrix(differences)
#heatmap(as.matrix(differences), Colv = NA, Rowv = NA, scale="column", Colv=FALSE)

#hclust_rows <- as.dendrogram(hclust(dist(my_mat)))  # Calculate hclust dendrograms
#hclust_cols <- as.dendrogram(hclust(dist(t(my_mat))))

heatmap(my_mat, Rowv = NA, Colv = NA)

write.csv(differences,"Differences_0609.csv")
