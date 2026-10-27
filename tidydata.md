In-Class Activity · tidyverse

# Reshaping Data with pivot_longer & pivot_wider

Practice transforming between wide and long data formats using the gapminder and palmerpenguins datasets.

tidyverse gapminder palmerpenguins

## Setup — run this first

R

```r
library(tidyverse)
library(gapminder)
library(palmerpenguins)
```

## Quick Review: The 3 Rules of Tidy Data

1

Each variable is a column; each column is a variable

2

Each observation is a row; each row is an observation

3

Each value is a cell; each cell holds a single value

Example 1

## Palmer Penguins — wide → long

pivot_longer()

**The situation** The `penguins` dataset stores four measurements as separate columns: `bill_length_mm`, `bill_depth_mm`, `flipper_length_mm`, and `body_mass_g`. To compare all measurements side-by-side — or to use `facet_wrap(~measurement)` in ggplot2 — we need one column for the measurement name and one for its value.

Start: wide format (4 measurement columns)

R

```r
penguins |>
  select(species, island, bill_length_mm, bill_depth_mm,
         flipper_length_mm, body_mass_g) |>
  head(3)
```

| species | island | bill_length_mm | bill_depth_mm | flipper_length_mm | body_mass_g |
| --- | --- | --- | --- | --- | --- |
| Adelie | Torgersen | 39.1 | 18.7 | 181 | 3750 |
| Adelie | Torgersen | 39.5 | 17.4 | 186 | 3800 |
| Adelie | Torgersen | 40.3 | 18.0 | 195 | 3250 |

Each penguin takes 1 row, but its 4 measurements are spread across columns. This breaks Rule 1: "measurement type" is a variable hiding in column names.

↓ pivot_longer()

The transformation

R

```r
penguins_long <- penguins |>
  drop_na() |>
  select(species, island,
         bill_length_mm, bill_depth_mm,
         flipper_length_mm, body_mass_g) |>
  pivot_longer(
    cols      = bill_length_mm:body_mass_g, # columns to collapse into rows
    names_to  = "measurement",              # new column: holds old column names
    values_to = "value"                     # new column: holds the numeric values
  )

penguins_long
```

Result: tidy long format

| species | island | measurement | value |
| --- | --- | --- | --- |
| Adelie | Torgersen | bill_length_mm | 39.1 |
| Adelie | Torgersen | bill_depth_mm | 18.7 |
| Adelie | Torgersen | flipper_length_mm | 181 |
| Adelie | Torgersen | body_mass_g | 3750 |
| Adelie | Torgersen | bill_length_mm | 39.5 |
| … | … | … | … |

Each penguin now occupies 4 rows — one per measurement. The new `measurement` column is a proper variable we can group by, filter, or facet.

Why this helps — faceted boxplots in one call

R

```r
# facet_wrap() requires measurement to be a single column
penguins_long |>
  ggplot(aes(x = species, y = value, fill = species)) +
  geom_boxplot() +
  facet_wrap(~measurement, scales = "free_y") +
  labs(title = "All penguin measurements by species",
       x = NULL, y = NULL) +
  theme_minimal() +
  theme(legend.position = "none")
```

Try running `facet_wrap(~measurement)` on the original wide data — you can't. Long format unlocks a whole family of grouped ggplot2 operations.

Key arguments for pivot_longer()

| Argument | What it does | Common values |
| --- | --- | --- |
| cols | Which columns to pivot (collapse into rows) | `c(a, b, c)`, range `a:d`, `starts_with("x")`, `where(is.numeric)` |
| names_to | Name for the new column that holds the old column names | A string: `"measurement"`, `"variable"` |
| values_to | Name for the new column that holds the values | A string: `"value"`, `"count"` |
| values_drop_na | Drop rows where the pivoted value is *NA* | `TRUE` / `FALSE` (default) |
| names_prefix | Strip a common prefix from each new name value | `"Q"` turns `Q1`, `Q2` into `1`, `2` |

Example 2

## Gapminder — long → wide → long again

pivot_wider()

**The scenario** `gapminder` is already tidy — one row per country per year. Wide format is common in real-world spreadsheets (one column per year). This example creates wide format with `pivot_wider()`, shows why analysis becomes harder, then uses `pivot_longer()` to recover tidy structure.

Start: tidy long format

R

```r
gap_subset <- gapminder |>
  filter(country %in% c("Canada", "Mexico", "United States"),
         year >= 2002) |>
  select(country, year, lifeExp)

gap_subset
```

| country | year | lifeExp |
| --- | --- | --- |
| Canada | 2002 | 79.77 |
| Canada | 2007 | 80.65 |
| Mexico | 2002 | 74.90 |
| Mexico | 2007 | 76.19 |
| United States | 2002 | 77.31 |
| United States | 2007 | 78.24 |

Tidy! One row per country–year combination. Works directly with `ggplot(aes(x = year, y = lifeExp, colour = country))`.

↓ pivot_wider() — creates "messy" wide format

Spreading to wide format

R

```r
gap_wide <- gap_subset |>
  pivot_wider(
    names_from  = year,     # column whose VALUES become new column names
    values_from = lifeExp   # column whose values fill those new columns
  )

gap_wide
```

| country | 2002 | 2007 |
| --- | --- | --- |
| Canada | 79.77 | 80.65 |
| Mexico | 74.90 | 76.19 |
| United States | 77.31 | 78.24 |

Compact and readable as a table — but `year` is now encoded in column names. Adding 2012 data means adding a new column. Try `ggplot(aes(x = year, y = lifeExp))` on this — it won't work.

↓ pivot_longer() — restoring tidy format

Recovering tidy format

R

```r
gap_wide |>
  pivot_longer(
    cols            = -country,             # pivot every column except 'country'
    names_to        = "year",               # old column names become year values
    names_transform = list(year = as.integer), # "2002" → 2002 (integer)
    values_to       = "lifeExp"
  )
```

The `names_transform` argument is crucial here: year arrived as character strings (`"2002"`) and needs to be converted to integers for plotting and arithmetic.

Key arguments for pivot_wider()

| Argument | What it does |
| --- | --- |
| names_from | Column whose *values* become the new column names |
| values_from | Column whose values fill the new columns |
| names_prefix | String prepended to each new column name — e.g. `"yr_"` makes `yr_2002`, `yr_2007` |
| values_fill | Value used when a country–year combination is missing (default: `NA`) |
| values_fn | Aggregation function if multiple values exist per cell — e.g. `mean`, `sum` |

Bonus

## pivot_wider for presentation tables

summarise() + pivot_wider()

**A common pattern** Summarise in long format — where `group_by()` + `summarise()` work naturally — then pivot to wide format for a clean, human-readable comparison table.

R

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

| species | female | male |
| --- | --- | --- |
| Adelie | 3369 | 4043 |
| Chinstrap | 3527 | 3939 |
| Gentoo | 4680 | 5485 |

The analysis used tidy long format; `pivot_wider()` reformats only for display. This is the *right* use of wide format — presentation, not analysis.

## Your Turn

Work through these individually or with a partner. Raise your hand if you'd like a hint.

1. 1

   Use `pivot_longer()` on `penguins` to gather only the two bill measurements (`bill_length_mm` and `bill_depth_mm`). How many rows does the result have? What happens if you skip `drop_na()` first?

   Hint: use `cols = c(bill_length_mm, bill_depth_mm)`, or `cols = starts_with("bill")`.
2. 2

   Filter `gapminder` to the year 2007, then use `pivot_wider()` to make a table with one row per country and one column per continent showing `gdpPercap`. Why does almost every cell contain `NA`?

   Hint: `filter(year == 2007)`, then think carefully about what goes in `names_from` vs `values_from`.
3. 3

   Compute the mean life expectancy for each continent and year in `gapminder`. Pivot it wide so the years become columns. Which continent shows the largest gain in life expectancy from 1952 to 2007?

   Hint: `group_by(continent, year) |> summarise(mean_lifeExp = mean(lifeExp))` first, then `pivot_wider(names_from = year, values_from = mean_lifeExp)`.
4. 4

   Starting from the Bonus example, add a `difference` column showing the difference in mean body mass between males and females. Then use `pivot_longer()` on `female`, `male`, and `difference` to make a faceted bar chart comparing them across species.

   Hint: `mutate(difference = male - female)` before pivoting back. Use `cols = c(female, male, difference)` in `pivot_longer()`.

tidyverse 2.0 · tidyr::pivot_longer() · tidyr::pivot_wider()