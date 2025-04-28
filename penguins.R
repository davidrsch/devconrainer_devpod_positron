# 1. Inspect the data structure
#    str() shows each column’s type, length, and example values—
#    crucial for spotting factors, numerics, and NAs before analysis.
str(penguins)

# 2. Summary statistics
#    summary() dispatches to methods per class:
#    for numerics it gives Min/Max/Median/Mean/Quartiles; for factors, counts.
#    This gives a rapid univariate overview to guide deeper plots or tests.
summary(penguins)

# 3. Histogram of flipper length
#    hist() bins the data, showing skewness or multimodality.
#    Choosing ~20 breaks balances detail vs. noise.
hist(
  penguins$flipper_len,
  breaks = 20,
  main = "Flipper Length Distribution",
  xlab = "Flipper length (mm)",
  ylab = "Count"
)

# 4. Boxplot of body mass by species
#    boxplot() compares medians, IQRs, and potential outliers for each species.
#    Great for group-wise spread and center comparisons.
boxplot(
  body_mass ~ species,
  data = penguins,
  main = "Body Mass by Penguin Species",
  xlab = "Species",
  ylab = "Body mass (g)"
)

# 5. Scatterplot of bill length vs. depth colored by species
#    plot() with `col=` uses integer factor codes to color points.
#    legend() maps colors back to species levels—key for identifying clusters.
with(penguins, {
  cols <- as.numeric(species)
  plot(
    bill_len,
    bill_dep,
    pch = 16,
    col = cols,
    xlab = "Bill length (mm)",
    ylab = "Bill depth (mm)",
    main = "Bill Dimensions by Species"
  )
  legend(
    "topright",
    legend = levels(species),
    col = seq_along(levels(species)),
    pch = 16
  )
})

# 6. Fit a simple linear model: bill depth ~ bill length
#    lm() estimates intercept and slope; summary() shows R² and p-values—
#    quantifies strength and significance of the linear relation.
fit <- lm(bill_dep ~ bill_len, data = penguins)
summary(fit)

# 7. Add regression line to the scatterplot
#    abline() draws the fitted line on existing plot—helps assess fit visually.
with(penguins, {
  plot(
    bill_len,
    bill_dep,
    pch = 16,
    xlab = "Bill length (mm)",
    ylab = "Bill depth (mm)",
    main = "Regression of Bill Depth on Length"
  )
  abline(fit) # overlay best-fit line
})
