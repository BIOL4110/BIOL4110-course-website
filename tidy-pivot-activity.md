# Reshaping Data with `pivot_longer()` and `pivot_wider()`

In-class activity — BIOL4110

---

## Setup

```r
library(tidyverse)
library(gapminder)
library(palmerpenguins)
```

---

## Quick review: the 3 rules of tidy data

1. Each **variable** is a column; each column is a variable.
2. Each **observation** is a row; each row is an observation.
3. Each **value** is a cell; each cell holds a single value.

Most real-world data violates at least one of these rules. The `tidyr` functions `pivot_longer()` and `pivot_wider()` are the main tools for fixing that.

---

## Example 1: `pivot_longer()` — Palmer Penguins

### The problem

The `penguins` dataset stores four measurements as separate columns: `bill_length_mm`, `bill_depth_mm`, `flipper_length_mm`, and `body_mass_g`. This breaks Rule 1 — "measurement type" is a variable hiding in column names.

```r
penguins |>
  select(species, island, bill_length_mm, bill_depth_mm,
         flipper_length_mm, body_mass_g) |>
  head(3)
```

| species | island    | bill_length_mm | bill_depth_mm | flipper_length_mm | body_mass_g |
|---------|-----------|---------------|---------------|-------------------|-------------|
| Adelie  | Torgersen | 39.1          | 18.7          | 181               | 3750        |
| Adelie  | Torgersen | 39.5          | 17.4          | 186               | 3800        |
| Adelie  | Torgersen | 40.3          | 18.0          | 195               | 3250        |

Each penguin takes 1 row but has 4 measurement values spread across columns. Try writing a `ggplot()` call that shows *all four measurements* at once — it isn't straightforward in this format.

### The transformation

`pivot_longer()` collapses multiple columns into two: one for the old column names and one for the values.

```r
penguins_long <- penguins |>
  drop_na() |>
  select(species, island,
         bill_length_mm, bill_depth_mm,
         flipper_length_mm, body_mass_g) |>
  pivot_longer(
    cols      = bill_length_mm:body_mass_g, # columns to collapse into rows
    names_to  = "measurement",              # new col: holds old column names
    values_to = "value"                     # new col: holds the numeric values
  )

penguins_long
```

Each penguin now occupies **4 rows** — one per measurement. The `measurement` column is a proper variable we can group by, filter, or facet.

### Why this helps

```r
# facet_wrap() requires measurement type to be a single column
penguins_long |>
  ggplot(aes(x = species, y = value, fill = species)) +
  geom_boxplot() +
  facet_wrap(~measurement, scales = "free_y") +
  labs(title = "All penguin measurements by species",
       x = NULL, y = NULL) +
  theme_minimal() +
  theme(legend.position = "none")
```

Long format unlocks the full family of grouped `ggplot2` operations — `facet_wrap(~measurement)` would be impossible on the original wide data.

### Key arguments for `pivot_longer()`

| Argument | What it does | Common values |
|---|---|---|
| `cols` | Which columns to pivot (collapse into rows) | `c(a, b)`, range `a:d`, `starts_with("x")`, `where(is.numeric)` |
| `names_to` | Name for the new column that holds the old column names | `"measurement"`, `"variable"` |
| `values_to` | Name for the new column that holds the values | `"value"`, `"count"` |
| `values_drop_na` | Drop rows where the pivoted value is `NA` | `TRUE` / `FALSE` (default) |
| `names_prefix` | Strip a common prefix from each new name value | `"Q"` turns `Q1`, `Q2` → `1`, `2` |

---

## Example 2: `pivot_wider()` — Gapminder

### The scenario

`gapminder` is already tidy — one row per country per year. Wide format is common in real-world spreadsheets (one column per year). This example creates wide format with `pivot_wider()`, shows why analysis becomes harder, then uses `pivot_longer()` to recover tidy structure.

### Start: tidy long format

```r
gap_subset <- gapminder |>
  filter(country %in% c("Canada", "Mexico", "United States"),
         year >= 2002) |>
  select(country, year, lifeExp)

gap_subset
```

| country       | year | lifeExp |
|---------------|------|---------|
| Canada        | 2002 | 79.77   |
| Canada        | 2007 | 80.65   |
| Mexico        | 2002 | 74.90   |
| Mexico        | 2007 | 76.19   |
| United States | 2002 | 77.31   |
| United States | 2007 | 78.24   |

Tidy! One row per country–year combination. Works directly with `ggplot(aes(x = year, y = lifeExp, colour = country))`.

### Making it wide with `pivot_wider()`

```r
gap_wide <- gap_subset |>
  pivot_wider(
    names_from  = year,     # column whose VALUES become new column names
    values_from = lifeExp   # column whose values fill those new columns
  )

gap_wide
```

| country       | 2002  | 2007  |
|---------------|-------|-------|
| Canada        | 79.77 | 80.65 |
| Mexico        | 74.90 | 76.19 |
| United States | 77.31 | 78.24 |

Compact and readable as a table — but `year` is now encoded in column names. Adding 2012 data requires adding a new column. Try `ggplot(aes(x = year, y = lifeExp))` on this — it won't work.

### Recovering tidy format with `pivot_longer()`

```r
gap_wide |>
  pivot_longer(
    cols            = -country,                 # pivot everything except 'country'
    names_to        = "year",                   # old column names become year values
    names_transform = list(year = as.integer),  # "2002" → 2002 (integer)
    values_to       = "lifeExp"
  )
```

> **Note:** `names_transform` is important here — year arrives as character strings (`"2002"`) and needs to be converted to integers for plotting and arithmetic.

### Key arguments for `pivot_wider()`

| Argument | What it does |
|---|---|
| `names_from` | Column whose *values* become the new column names |
| `values_from` | Column whose values fill the new columns |
| `names_prefix` | String prepended to each new column name — e.g. `"yr_"` → `yr_2002` |
| `values_fill` | Value used when a combination is missing (default: `NA`) |
| `values_fn` | Aggregation function if multiple values exist per cell — e.g. `mean` |

---

## Bonus: `pivot_wider()` for summary tables

A common pattern: summarise in long format (where `group_by()` + `summarise()` work naturally), then pivot wide for a clean, readable table.

```r
penguins |>
  drop_na() |>
  group_by(species, sex) |>
  summarise(mean_mass_g = round(mean(body_mass_g)), .groups = "drop") |>
  pivot_wider(
    names_from  = sex,
    values_from = mean_mass_g
  )
```

| species   | female | male |
|-----------|--------|------|
| Adelie    | 3369   | 4043 |
| Chinstrap | 3527   | 3939 |
| Gentoo    | 4680   | 5485 |

The analysis used tidy long format; `pivot_wider()` reformats only for display. This is the *right* use of wide format — presentation, not analysis.

---

## Your turn

**Exercise 1**

Use `pivot_longer()` on `penguins` to gather only the two bill measurements (`bill_length_mm` and `bill_depth_mm`). How many rows does the result have? What happens if you skip `drop_na()` first?

> *Hint:* try `cols = starts_with("bill")`.

```r
# your code here
```

---

**Exercise 2**

Filter `gapminder` to the year 2007, then use `pivot_wider()` to make a table with one row per country and one column per continent showing `gdpPercap`. Why does almost every cell contain `NA`?

> *Hint:* think carefully about what goes in `names_from` vs `values_from`.

```r
# your code here
```

---

**Exercise 3**

Compute the mean life expectancy for each continent and year in `gapminder`. Pivot it wide so the years become columns. Which continent shows the largest gain in life expectancy from 1952 to 2007?

> *Hint:* `group_by(continent, year) |> summarise(mean_lifeExp = mean(lifeExp))` first, then `pivot_wider(names_from = year, values_from = mean_lifeExp)`.

```r
# your code here
```

---

**Exercise 4 (challenge)**

Starting from the Bonus example, add a `difference` column showing the difference in mean body mass between males and females. Then use `pivot_longer()` on `female`, `male`, and `difference` to make a faceted bar chart comparing them across species.

> *Hint:* `mutate(difference = male - female)` before pivoting back to long format.

```r
# your code here
```
