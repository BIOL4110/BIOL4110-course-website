# Model Fitting with Palmer Penguins

```r
library(tidyverse)
library(tidymodels)
library(palmerpenguins)
```

From today's activity, students are anticipated to be able to:

- fit a linear model in R using `lm()` with a real dataset.
- write a model formula using the `y ~ x` syntax.
- use `broom::tidy()`, `broom::glance()`, and `broom::augment()` to extract model information.
- generate predictions for new data using `augment()` and `predict()`.
- visualize a fitted model using `geom_smooth()`.

## Resources

- [Notes 09: The Model-Fitting Paradigm in R](./notes-a09.Rmd) — the lecture notes that accompany this activity.
- [broom vignette](https://cran.r-project.org/web/packages/broom/vignettes/broom.html)
- [palmerpenguins documentation](https://allisonhorst.github.io/palmerpenguins/)

---

## The Data: Palmer Penguins

The `palmerpenguins` package contains measurements for 344 penguins across three species (Adelie, Chinstrap, and Gentoo) collected from three islands in the Palmer Archipelago, Antarctica.

```r
glimpse(penguins)
```

We'll focus on the relationship between **flipper length** and **body mass** — two continuous variables where we might expect a meaningful linear relationship.

Start by visualizing the relationship:

```r
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(na.rm = TRUE) +
  labs(
    x = "Flipper length (mm)",
    y = "Body mass (g)",
    title = "Penguin flipper length vs. body mass"
  ) +
  theme_minimal()
```

Does the relationship look roughly linear? A linear model may be a reasonable choice here.

---

## Fitting a Linear Model

Recall the general model-fitting syntax in R:

```
method(formula, data, options)
```

We fit a linear regression of body mass (`body_mass_g`) on flipper length (`flipper_length_mm`) like this:

```r
penguin_lm <- lm(body_mass_g ~ flipper_length_mm, data = penguins)
penguin_lm
```

Printing the model shows only a digest of the object. The model object contains much more — we'll extract it using `broom`.

---

## Probing the Model with `broom`

### `tidy()`: component-level summaries

`tidy()` returns one row per model coefficient — here, the intercept and the slope for `flipper_length_mm`.

```r
tidy(penguin_lm)
```

- The **estimate** column gives the coefficient values.
- The **p.value** column tells you whether each coefficient is statistically distinguishable from zero.

> **Question:** Based on `tidy()`, how many grams heavier would you expect a penguin to be for each additional millimetre of flipper length?

### `glance()`: model-level summaries

`glance()` returns a single-row tibble summarizing the model as a whole.

```r
glance(penguin_lm)
```

> **Question:** What is the R² value? In plain language, what does it tell you about this model?

### `augment()`: predictions on existing data

`augment()` adds model predictions (`.fitted`) and residuals (`.resid`) as new columns alongside the original data.

```r
augment(penguin_lm) |>
  select(body_mass_g, flipper_length_mm, .fitted, .resid) |>
  print(n = 5)
```

You can plot the residuals to check model assumptions — ideally they should be randomly scattered around zero:

```r
augment(penguin_lm) |>
  ggplot(aes(x = .fitted, y = .resid)) +
  geom_point(na.rm = TRUE) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(x = "Fitted values", y = "Residuals") +
  theme_minimal()
```

### `augment()`: predictions on new data

To predict body mass for penguins with flipper lengths of 180, 200, and 220 mm:

```r
augment(penguin_lm, newdata = tibble(flipper_length_mm = c(180, 200, 220)))
```

Or equivalently, using base R's `predict()`:

```r
predict(penguin_lm, newdata = tibble(flipper_length_mm = c(180, 200, 220)))
```

---

## Visualizing the Model with `geom_smooth()`

You can overlay the fitted line directly on a scatterplot using `geom_smooth(method = "lm")`:

```r
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(na.rm = TRUE) +
  geom_smooth(method = "lm", se = TRUE, na.rm = TRUE) +
  labs(
    x = "Flipper length (mm)",
    y = "Body mass (g)"
  ) +
  theme_minimal()
```

Note that `geom_smooth()` draws the line visually, but the underlying model object isn't accessible for downstream use. That's why fitting with `lm()` and using `broom` is more flexible.

---

## Summary

1. `lm(y ~ x, data = df)` — fits a linear model; returns a model object.
2. `broom::tidy()` — coefficient-level summaries (estimates, p-values, standard errors) as a tibble.
3. `broom::glance()` — model-level summaries (R², AIC, p-value) as a one-row tibble.
4. `broom::augment()` — adds fitted values and residuals to your data; accepts `newdata` for predictions.
5. `predict()` — base R alternative for predictions; works even without `broom` support.
6. `geom_smooth(method = "lm")` — visualizes the fitted line, but doesn't give you the model object.

---

## Test Your Understanding

1. **TRUE or FALSE:** `glance()` returns one row per penguin because each penguin has a predicted body mass.
2. **TRUE or FALSE:** `tidy()` would return two rows for the model `lm(body_mass_g ~ flipper_length_mm, data = penguins)`.
3. **TRUE or FALSE:** You need to provide both `flipper_length_mm` and `body_mass_g` in the `newdata` tibble when using `augment()` to predict for new penguins.
4. **TRUE or FALSE:** `geom_smooth(method = "lm")` and fitting with `lm()` give you equivalent ways to extract the slope coefficient.

---

## Your Turn

### Exercise 1

Fit a linear model predicting **bill length** (`bill_length_mm`) from **bill depth** (`bill_depth_mm`) using the full `penguins` dataset.

```r
# Your code here
```

a. Use `tidy()` to find the slope. Interpret it in one sentence.
b. Use `glance()` to find R². Is this a strong model?
c. Predict bill length for penguins with bill depths of 14, 17, and 20 mm.

---

### Exercise 2

Filter the dataset to only **Gentoo** penguins, then fit a linear model predicting body mass from flipper length for that species alone.

```r
gentoo <- penguins |> filter(species == "Gentoo")

# Your code here
```

a. How does the slope compare to the model fitted on all species?
b. Plot the data with the fitted line using `geom_smooth()`.
c. Use `augment()` to find the penguin with the largest residual (in absolute value). What might explain such a large residual?

---

### Exercise 3 (stretch)

The plot below (which you should recreate) suggests that the flipper–body mass relationship may differ by species.

```r
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, colour = species)) +
  geom_point(na.rm = TRUE) +
  geom_smooth(method = "lm", se = FALSE, na.rm = TRUE) +
  labs(
    x = "Flipper length (mm)",
    y = "Body mass (g)",
    colour = "Species"
  ) +
  theme_minimal()
```

Fit separate models for each species and use `tidy()` to compare the slopes. Which species shows the steepest relationship between flipper length and body mass?

```r
# Hint: try filtering for each species separately, or explore purrr::map() 
# with a nested tibble if you've seen that approach.
```

---

### Attribution

Activity by [Bernhardt Lab](https://github.com/BernhardtLab), University of Guelph. Modelled after model-fitting notes by Vincenzo Coia. Palmer Penguins data from [Horst, Hill & Gorman (2020)](https://allisonhorst.github.io/palmerpenguins/).
