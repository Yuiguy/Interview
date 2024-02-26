library("phyloseq")
library("ggplot2")
theme_set(theme_bw())


# Import data
data("soilrep")

# Create plot
plot_richness(soilrep, x="Treatment",color="warmed", shape="clipped", measures=c("Chao1", "Shannon"))+
theme(axis.title = element_text(size = 20),    # Change axis title font size
      axis.text = element_text(size = 18)) +   # Change axis text (tick labels) font size
  geom_point(size = 5)    # Change marks size
