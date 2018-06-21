---
title: ggplot
---

#### A truely classic theme with:
- black axis text;
- centered title/subtitle;
- no strip background;
```r
mytheme <- theme_classic(base_size = 12) + theme(
    axis.text = element_text(color = 'black'),
    strip.background = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5))
```
