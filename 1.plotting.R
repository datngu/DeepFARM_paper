setwd('/Users/datn/research/DL_paper_final')
require(data.table)
require(ggplot2)
library(dplyr)
library(tidyr)


df = fread('out_tables/model_performance.csv')
df = as.data.frame(df)
df$LR = as.character(df$LR)
df$LR[df$LR == "0.001"] = "1e-03"
df$LR = factor(df$LR, levels = c("1e-03", "5e-04", "1e-04", "5e-05"))



## AUROC
auroc = ggplot(df, aes(x = LR, y = auroc, fill = Method)) +
  geom_boxplot() +
  facet_wrap(~Spec) +
  theme_light() +
  labs(x = "Learning Rate",
       y = "AUROC") +
  scale_y_continuous(limits = c(0.5, 1)) +
  scale_fill_brewer(palette = "Set2")

# Compute the median values
median_table_auroc <- df %>%
  group_by(LR, Method, Spec) %>%
  summarize(Median_AUROC = median(auroc, na.rm = TRUE)) %>%
  arrange(LR, Spec, Method)

# Display the table
print(median_table_auroc)


wide_median_table_auroc <- median_table_auroc %>%
  pivot_wider(names_from = Method, values_from = Median_AUROC) %>% arrange(Spec)


# Optionally save the table to a CSV file
write.csv(wide_median_table_auroc, "out_tables_R1/Sup_Tab1_median_auroc.csv", row.names = FALSE)


pdf("out_figs_R1/Fig2.pdf", width = 8, height = 5.5)
auroc
dev.off()


## AUPR
aupr = ggplot(df, aes(x = LR, y = aupr, fill = Method)) +
  geom_boxplot() +
  facet_wrap(~Spec) +
  theme_light() +
  labs(x = "Learning Rate",
       y = "AUPR") +
  scale_y_continuous() +
  scale_fill_brewer(palette = "Set2")

# Compute the median values
median_table_aupr <- df %>%
  group_by(LR, Method, Spec) %>%
  summarize(Median_AUPR = median(aupr, na.rm = TRUE)) %>%
  arrange(LR, Spec, Method)

# Display the table
print(median_table_aupr)


wide_median_table_aupr <- median_table_aupr %>%
  pivot_wider(names_from = Method, values_from = Median_AUPR) %>% arrange(Spec)


# Optionally save the table to a CSV file
write.csv(wide_median_table_aupr, "out_tables_R1/Sup_Tab2_median_aupr.csv", row.names = FALSE)


### export figs

pdf("out_figs_R1/Sup_Fig1.pdf", width = 8, height = 5.5)
aupr
dev.off()

## Export best learning rates for DanQ
combine_tab = median_table_auroc
combine_tab$Median_AUPR = median_table_aupr$Median_AUPR

best_lr <- combine_tab %>% 
  filter(Method == "DanQ") %>%
  group_by(Spec) %>%
  filter(Median_AUROC == max(Median_AUROC)) %>%
  arrange(Spec)


write.csv(best_lr, "out_tables_R1/Sup_Tab3_best_LR_DanQ.csv", row.names = FALSE)



filter_dataframe <- function(df, LR, Method, Spec) {
  pick <- (df$LR == LR) & (df$Method == Method) & (df$Spec == Spec)
  return(df[pick, ])
}

df_best <- rbind(
  filter_dataframe(df, "5e-05", "DanQ", "Cattle"),
  filter_dataframe(df, "1e-04", "DanQ", "Chicken"),
  filter_dataframe(df, "5e-04", "DanQ", "Pig"),
  filter_dataframe(df, "5e-05", "DanQ", "Salmon")
)

### AUC by track types

f2 = ggplot(df_best, aes(y = Type, x = auroc, fill = Type)) +
  geom_violin(trim=FALSE) +
  geom_boxplot(width=0.2, fill="white")+
  facet_wrap(~Spec) +
  theme_light() +
  labs(x = "AUROC",
       y = "Data type") +
  scale_x_continuous(limits = c(0.5, 1)) +
  scale_fill_brewer(palette = "Set2") +
  theme(legend.position = "none")



pdf("out_figs_R1/Sup_Fig2.pdf", width = 8, height = 5.5)
f2
dev.off()



# ### AUPR by track types

# f3 = ggplot(df_best, aes(y = Type, x = aupr, fill = Type)) +
#   geom_violin(trim=FALSE) +
#   geom_boxplot(width=0.2, fill="white")+
#   facet_wrap(~Spec) +
#   theme_light() +
#   labs(x = "AUPR",
#        y = "Data type") +
#   scale_x_continuous() +
#   scale_fill_brewer(palette = "Set2") +
#   theme(legend.position = "none")



# pdf("out_figs_R1/Sup_Fig3.pdf", width = 8, height = 5.5)
# f3
# dev.off()


