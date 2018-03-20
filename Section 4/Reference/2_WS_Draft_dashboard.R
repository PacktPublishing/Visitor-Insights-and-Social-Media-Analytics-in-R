---
title: "Testing Flex Dashboard"
output: 
  flexdashboard::flex_dashboard:
    orientation: columns
    vertical_layout: fill
---

```{r setup, include=FALSE}
library(flexdashboard)
library(ggplot2)
```

Column {data-width=650}
-----------------------------------------------------------------------

### Chart 1

```{r}
qplot(Girth, Height, data = trees, main="Trees Data")

```

Column {data-width=350}
-----------------------------------------------------------------------

### Chart 2

```{r}
library(leaflet)
leaflet() %>%
    addTiles() %>%
    addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
```

### Chart 3

Here are some words

