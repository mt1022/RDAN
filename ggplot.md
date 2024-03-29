---
title: ggplot
---

### To make the classic theme more classic:
- black axis text;
- centered title/subtitle;
- no strip background;

```r
theme_set(theme_classic(base_size = 12) + theme(
    axis.text = element_text(color = 'black'),
    strip.background = element_blank(),
    strip.text = element_text(size = 12),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)))
```

### boxplot with scatter plot overlay (example code)
```r
ggplot(plt, aes(x = sample, y = log2TE - log2TE.mock)) +
    geom_jitter(aes(color = grp, alpha = grp),
        position = position_jitterdodge(dodge.width = 0.85, jitter.width = 0.2)) +
    geom_boxplot(aes(color = grp), outlier.shape = NA, fill = '#00000000',
        width = 0.7, position = position_dodge(width = 0.85)) +
    geom_text(data = plt2, aes(y = 1, label = TE.label)) +
    scale_color_manual(values = c('grey', RColorBrewer::brewer.pal(4, 'Set1')[1])) +
    scale_alpha_discrete(range = c(0.1, 0.2)) +
    coord_cartesian(ylim = c(-1, 1)) + guides(alpha = FALSE) +
    labs(x = NULL, y = 'log2FC of TE', color = NULL) +
    mytheme
```

### How to plot fractions (0.23) as percentage (23%)
```r
+ scale_y_continuous(labels = scales::trans_format('identity', format = scales::percent_format()))
```

### Put multi-variable facet_wrap labels on one line
```r
facet_wrap(vars(var1, var2), labeller = label_wrap_gen(multi_line = FALSE))
```
The one line label will be shown in the plot as "var1, var2".
ref: https://stackoverflow.com/questions/37144861/ggplot2-put-multi-variable-facet-wrap-labels-on-one-line

### Remove space between bars and categorical axis in barplot
```{r}
# for horizontal bars
p + scale_x_continuous(expand = expansion(mult = c(0, 0.05)))

# for vertical bars
p + scale_y_continuous(expand = expansion(mult = c(0, 0.05)))
```
