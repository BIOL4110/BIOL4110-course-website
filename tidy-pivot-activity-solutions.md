# Reshaping Data with `pivot_longer()` and `pivot_wider()`

Solutions — Bernhardt Lab

---

## Exercise 1

Use `pivot_longer()` on `penguins` to gather only the two bill measurements.

```r
penguins |>
  pivot_longer(
    cols      = starts_with("bill"),
    names_to  = "measurement",
    values_to = "value"
  )
```

**How many rows?**

- With `drop_na()` first: 333 penguins × 2 measurements = **666 rows**
- Without `drop_na()`: 344 rows × 2 = **688 rows**, including rows where bill values are `NA`

The `NA` rows are harmless for pivoting itself, but they'll cause warnings or missing bars in `ggplot2`. It's usually cleaner to drop them before pivoting.

---

## Exercise 2

Filter `gapminder` to 2007, then pivot wide with one column per continent.

```r
gapminder |>
  filter(year == 2007) |>
  pivot_wider(
    names_from  = continent,
    values_from = gdpPercap
  )
```

**Why almost every cell is `NA`**

Each country belongs to exactly one continent. For any given row (country), only one of the five continent columns can hold a value — the other four are `NA` because that country has no data for those continents.

This is a case where `pivot_wider()` produces a sparse, mostly-empty table. It reveals that the data isn't set up for this kind of reshape — `continent` is an attribute of a country, not a grouping variable whose values should become column headers. Exercise 3 shows a better use of `pivot_wider()`.

---

## Exercise 3

Compute mean life expectancy by continent and year, then pivot wide.

```r
gapminder |>
  group_by(continent, year) |>
  summarise(mean_lifeExp = mean(lifeExp), .groups = "drop") |>
  pivot_wider(
    names_from  = year,
    values_from = mean_lifeExp
  )
```

To identify the largest gain from 1952 to 2007:

```r
gapminder |>
  group_by(continent, year) |>
  summarise(mean_lifeExp = mean(lifeExp), .groups = "drop") |>
  pivot_wider(names_from = year, values_from = mean_lifeExp) |>
  mutate(gain = `2007` - `1952`) |>
  arrange(desc(gain))
```

**Asia** shows the largest gain (~37 years), followed by Africa (~21 years). Note the backticks around `2007` and `1952` — R requires them when column names start with a digit.

---

## Exercise 4 (challenge)

Starting from the Bonus example, add a `difference` column and pivot back to long for a faceted bar chart.

```r
penguins |>
  drop_na() |>
  group_by(species, sex) |>
  summarise(mean_mass_g = round(mean(body_mass_g)), .groups = "drop") |>
  pivot_wider(
    names_from  = sex,
    values_from = mean_mass_g
  ) |>
  mutate(difference = male - female) |>
  pivot_longer(
    cols      = c(female, male, difference),
    names_to  = "group",
    values_to = "mean_mass_g"
  ) |>
  ggplot(aes(x = species, y = mean_mass_g, fill = species)) +
  geom_col() +
  facet_wrap(~group) +
  labs(
    title = "Mean body mass by species and sex",
    x     = NULL,
    y     = "Mean body mass (g)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")
```

**Key ideas demonstrated here:**

- `pivot_wider()` was needed first so `mutate()` could subtract one column from another — you can't do `male - female` when sex lives in a single column.
- `pivot_longer()` then restored the shape needed for `facet_wrap()`.
- This wide → mutate → long pattern is common when you need to compute something *across* groups before visualising *within* groups.
