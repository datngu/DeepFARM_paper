require(data.table)

data = read.table('out_tables/gs_selection.csv', header = T, sep = ',')
summary_data <- data %>%
  group_by(Dataset, Method) %>%
  summarize(Mean = mean(Score), SD = sd(Score), .groups = "drop")



summary_data$Dataset <- recode(summary_data$Dataset,
                                "All_SNPs" = "70k SNPs (full array)",
                                "Best_Score_Marker_per_250kb" = "Best 9073 SNPs (per 250kb bin)",
                                "Random_Affx_ID" = "9073 random SNPs in the array",
                                "Top_9073_SNPs_Across_All" = "Best 9073 SNPs (genome wide)")

summary_data$Dataset <- factor(summary_data$Dataset, 
                                levels = c("70k SNPs (full array)", 
                                            "Best 9073 SNPs (per 250kb bin)",
                                            "Best 9073 SNPs (genome wide)", 
                                            "9073 random SNPs in the array"
                                            ))

summary_data$Method <- recode(summary_data$Method,
                                "GCTA_Yang" = "GCTA - Yang",
                                "GCTB_Bayesian" = "GCTB - Bayesian")

# Plot the data
f1 = ggplot(summary_data, aes(x = Method, y = Mean, fill = Dataset)) +
    geom_bar(stat = "identity", position = "dodge") +
    geom_errorbar(aes(ymin = Mean - SD, ymax = Mean + SD), 
                  position = position_dodge(0.9), width = 0.25) +
    theme_light() +
    theme(axis.text.x = element_text(angle = 0, hjust = 1)) +
    labs(x = "Genomic prediction method",
        y = "Predictive correlation",
        fill = "SNP sets")


pdf("out_figs/Fig6.pdf", width = 8, height = 5)
f1
dev.off()
