library(vegan)
library(dplyr)
renyi.test <- renyi(x=sim_tcr_treg$freq, scales=c(0, 1, 2, 8, Inf))
renyi.noisy <- renyi(x=sim_tcr_treg_noisy$freqs, scales=c(0, 1, 2, 8, Inf))
renyi.compared <- as.data.frame(rbind(renyi.test,renyi.noisy))
colnames(renyi.compared) <- c("amTregs","CD8","nTregs","Teff")

# superposed diversity of both sim datasets

plotgg0 <- ggplot(data=renyi.long(renyi.compared), aes(x=Scales, y=Diversity, group=Grouping)) +
  scale_x_discrete() +
  scale_y_continuous(sec.axis = dup_axis(name=NULL)) +
  geom_line(aes(colour=Grouping), size=2) +
  geom_point(aes(colour=Grouping, shape=Grouping), alpha=0.8, size=5) +
  BioR.theme +
  scale_colour_npg() +
  labs(x=expression(alpha), y="Diversity", colour="Community", shape="Community")

# percent of overlap (aa sequence colotypes) between the two datasets
overlap <- inner_join(sim_tcr_treg, sim_tcr_treg_noisy, by = "sequence_aa")
dim(overlap)[1]/dim(sim_tcr_treg)[1]*100

# compare top ten
top_treg <- top_n(sim_tcr_treg,10,freqs)
top_treg_noisy <- top_n(sim_tcr_treg_noisy,10,freqs)
top_overlap <- inner_join(top_treg, top_treg_noisy, by = "v_call")
dim(top_overlap)[1]/10*100
top_overlap <- inner_join(top_treg, top_treg_noisy, by = "j_call")
dim(top_overlap)[1]/10*100
