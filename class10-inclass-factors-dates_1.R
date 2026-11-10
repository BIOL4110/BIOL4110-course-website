#### BIOL4110 · Special objects in R: factors, dates & times
#### Live-coding script (instructor copy)
####
#### ~80 min total
####   Setup ............................................  2 min
####   Part 1  Factors with palmerpenguins ............... 36 min  (Your turn 1 & 2)
####   Part 2  Dates & times with nycflights13 ........... 38 min  (Your turn 3)
####   Wrap-up ..........................................  4 min
####
#### How to read this script
####   # SAY:  talking point to say out loud (no need to type it)
####   # ASK:  question for the class BEFORE you run the next line
####   YOUR TURN blocks: give students ~4 min, then live-code the solution
####   Lines marked ERROR ON PURPOSE are meant to fail. Run them anyway!


# Setup -------------------------------------------------------------------

library(tidyverse)        # includes forcats (factors) and ggplot2
library(lubridate)        # dates & times (also loaded by tidyverse >= 2.0)
library(palmerpenguins)
library(nycflights13)



# =========================================================================
# PART 1: FACTORS (palmerpenguins)
# =========================================================================

# SAY: A factor is how R stores a CATEGORICAL variable: a variable that can
#      only take a fixed, known set of values (the "levels").


# 1.1 What is a factor? (~8 min) ------------------------------------------

glimpse(penguins)
# ASK: Which columns are <fct>? What do they have in common?

class(penguins$species)
levels(penguins$species)
nlevels(penguins$species)

penguins %>%
  count(species)


# Under the hood: a factor is integers + a lookup table of labels
three_birds <- penguins$species[c(1, 160, 300)]
three_birds
typeof(three_birds)
as.integer(three_birds)
# ASK: Gentoo shows up 2nd here. Why is it stored as a 3?
# SAY: Levels default to ALPHABETICAL order. R prints the labels,
#      but stores the numbers.


# Making a factor yourself
# Field notes: how big did each penguin look?
size_obs <- c("medium", "small", "large", "small", "medium")
size_obs
class(size_obs)

factor(size_obs)
# ASK: Is "large, medium, small" a sensible order?

size_fct <- factor(size_obs, levels = c("small", "medium", "large"))
size_fct
levels(size_fct)
as.integer(size_fct)



# 1.2 Reordering levels for plots (~10 min, incl. Your turn 1) ------------

penguins %>%
  ggplot(aes(x = species)) +
  geom_bar()
# ASK: What order are the bars in? Is that useful?

# fct_infreq(): order by how often each level appears
penguins %>%
  mutate(species = fct_infreq(species)) %>%
  ggplot(aes(x = species)) +
  geom_bar()

# fct_rev(): flip whatever order you have
penguins %>%
  mutate(species = fct_rev(fct_infreq(species))) %>%
  ggplot(aes(x = species)) +
  geom_bar()


# fct_reorder(): order by a summary of ANOTHER variable
penguins %>%
  ggplot(aes(x = species, y = bill_length_mm)) +
  geom_boxplot()

penguins %>%
  filter(!is.na(bill_length_mm)) %>%
  mutate(species = fct_reorder(species, bill_length_mm, .fun = median)) %>%
  ggplot(aes(x = species, y = bill_length_mm)) +
  geom_boxplot()
# SAY: Read it as "reorder species by the median of bill_length_mm".
#      Chinstrap jumped past Gentoo. Add .desc = TRUE to flip it.
# SAY: We dropped NAs first so median() has nothing missing to choke on.


# fct_relevel(): move specific level(s) to the front, by hand
penguins %>%
  mutate(species = fct_relevel(species, "Gentoo")) %>%
  pull(species) %>%
  levels()
# SAY: Handy for putting a control/reference group first.
#      Models like lm() use the FIRST level as the baseline.


## ---- YOUR TURN 1 (~4 min) -------------------------------------------
## Make boxplots of body_mass_g for each island, with the islands
## ordered from lightest to heaviest median body mass.
## Bonus: put the heaviest island on the LEFT.
## ----------------------------------------------------------------------

penguins %>%
  filter(!is.na(body_mass_g)) %>%
  mutate(island = fct_reorder(island, body_mass_g, .fun = median)) %>%
  ggplot(aes(x = island, y = body_mass_g)) +
  geom_boxplot()

# Bonus
penguins %>%
  filter(!is.na(body_mass_g)) %>%
  mutate(island = fct_reorder(island, body_mass_g, .fun = median, .desc = TRUE)) %>%
  ggplot(aes(x = island, y = body_mass_g)) +
  geom_boxplot()



# 1.3 Changing the levels themselves (~12 min, incl. Your turn 2) ---------

# fct_recode(): rename levels.  Syntax is  "new" = "old"  (like rename())
penguins %>%
  mutate(species = fct_recode(species, "Adélie" = "Adelie")) %>%
  count(species)


# fct_collapse(): lump several levels into one
penguins %>%
  group_by(species) %>%
  summarise(mean_mass_g = mean(body_mass_g, na.rm = TRUE))
# SAY: Adelie and Chinstrap are about the same size; Gentoo is much bigger.

penguins %>%
  mutate(size_group = fct_collapse(species,
                                   "Adelie/Chinstrap" = c("Adelie", "Chinstrap"))) %>%
  count(size_group)


# Unused levels hang around after filter()
no_gentoo <- penguins %>%
  filter(species != "Gentoo")

no_gentoo %>% count(species)       # Gentoo is gone from the DATA...
levels(no_gentoo$species)          # ...but is still a LEVEL
nlevels(no_gentoo$species)

no_gentoo %>%
  ggplot(aes(x = species)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE)   # the "ghost" level shows up

# fct_drop(): get rid of levels with no data
no_gentoo <- no_gentoo %>%
  mutate(species = fct_drop(species))
levels(no_gentoo$species)

# Sometimes you WANT empty levels: fct_expand() adds levels with no data
penguins %>%
  mutate(species = fct_expand(species, "Emperor", "King")) %>%
  ggplot(aes(x = species)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE)
# SAY: Useful to show "we looked, and found zero".


# Missing values are NOT a level
penguins %>% count(sex)
levels(penguins$sex)
# ASK: count() shows 11 NAs. Where are they in levels()?


## ---- YOUR TURN 2 (~4 min) -------------------------------------------
## Using the sex column:
##   a) Recode the levels to "Female" and "Male".
##   b) Turn the NAs into a real level called "Unknown".
##      Hint: fct_na_value_to_level(sex, level = "Unknown")
##   c) Make a bar chart of sex with the bars in order of frequency.
## ----------------------------------------------------------------------

penguins %>%
  mutate(sex = fct_recode(sex, "Female" = "female", "Male" = "male"),
         sex = fct_na_value_to_level(sex, level = "Unknown"),
         sex = fct_infreq(sex)) %>%
  ggplot(aes(x = sex)) +
  geom_bar()
# SAY: Order matters: recode first, then add the Unknown level,
#      then reorder. Each line of mutate() works on the result of the last.



# 1.4 Factor gotchas (~6 min) ---------------------------------------------

# Gotcha 1: as.numeric() on a factor gives the CODES, not the values
yr_fct <- factor(penguins$year)
levels(yr_fct)

# ASK: What should the average year be?
mean(as.numeric(yr_fct))
unique(as.numeric(yr_fct))                  # 1 2 3 !!

# Fix: go through character first
mean(as.numeric(as.character(yr_fct)))
unique(as.numeric(as.character(yr_fct)))


# Gotcha 2: typos silently become NA with factor()
size_typo <- c("small", "Large", "medium", "large ")
factor(size_typo, levels = c("small", "medium", "large"))
# ASK: Why are two of these NA? Did R warn us?

# forcats::fct() is stricter and tells you what went wrong
fct(size_typo, levels = c("small", "medium", "large"))   # ERROR ON PURPOSE
# SAY: An error now is better than a silent NA later.



# =========================================================================
# PART 2: DATES & TIMES (lubridate + nycflights13)
# =========================================================================

# Warm-up (optional, ~2 min): everyone write today's date in Slack.
# Look at how many formats come back!
# ASK: Are there 365 days in every year? 24 hours in every day?


# 2.1 Making dates & date-times from text (~10 min) -----------------------

today()
now()
class(today())
class(now())

d_chr <- "Oct 1 2013"
class(d_chr)
d_chr + 1                          # ERROR ON PURPOSE: can't do math on text

# The ymd() family: name the function after the ORDER of the pieces
mdy("Oct 1 2013")
mdy("October 1st, 2013")
dmy("1/10/2013")
ymd("2013-10-01")
# SAY: All four are the same Date. lubridate figures out the separators
#      and month names; you only tell it the order.

d <- mdy("Oct 1 2013")
class(d)
d + 1                              # now math works (in days)

# ASK: What date is "01/10/2013"?
mdy("01/10/2013")
dmy("01/10/2013")
# SAY: Ambiguous! You must know how it was recorded.
#      Record dates as yyyy-mm-dd (ISO 8601) and future-you says thanks.


# Date-times: add _hm or _hms
ymd_hm("2013-10-01 09:00")
# ASK: What does UTC mean? Is that when the flight left?

sched <- ymd_hm("2013-10-01 09:00", tz = "America/New_York")
sched
# SAY: Time zones are named "Continent/City". Guelph is "America/Toronto".
#      OlsonNames() lists them all.

# with_tz(): same instant, shown on a different clock
with_tz(sched, "America/Vancouver")
with_tz(sched, "Antarctica/Palmer")    # where the penguins live!
sched == with_tz(sched, "Antarctica/Palmer")
# SAY: TRUE, because it's the same moment in time.

# force_tz(): same clock time, but in a different zone = a DIFFERENT instant
force_tz(sched, "Antarctica/Palmer")
sched == force_tz(sched, "Antarctica/Palmer")
# SAY: Use force_tz() only when the time zone was recorded wrong.



# 2.2 Building date-times from columns (~12 min, incl. Your turn 3) ------

flights_demo <- flights %>%
  select(year, month, day, hour, minute,
         sched_dep_time, dep_time, dep_delay, carrier, flight)

head(flights_demo)
# ASK: Where's the scheduled departure date-time? (Spread over 5 columns!)

# make_datetime(): glue numeric pieces into one date-time
flights_demo <- flights_demo %>%
  mutate(sched_dep_dt = make_datetime(year, month, day, hour, minute,
                                      tz = "America/New_York"))

flights_demo %>%
  select(year, month, day, hour, minute, sched_dep_dt) %>%
  head()
# SAY: make_datetime() defaults to UTC, so always give it a tz.


# The ACTUAL departure time is stored as one number: HHMM
flights_demo %>%
  select(sched_dep_time, dep_time) %>%
  head()
# ASK: What time is 517?

517 %/% 100      # integer division -> hours   (5)
517 %% 100       # remainder ("modulo") -> minutes (17)


## ---- YOUR TURN 3 (~4 min) -------------------------------------------
## Add a column dep_dt: the ACTUAL departure date-time of each flight,
## built from year, month, day and dep_time.
## Hint: make_datetime(year, month, day, ??? , ???, tz = "America/New_York")
## ----------------------------------------------------------------------

flights_demo <- flights_demo %>%
  mutate(dep_dt = make_datetime(year, month, day,
                                dep_time %/% 100, dep_time %% 100,
                                tz = "America/New_York"))

flights_demo %>%
  select(sched_dep_dt, dep_time, dep_dt) %>%
  head()
# SAY: Cancelled flights have dep_time = NA, so dep_dt is NA too. Good!



# 2.3 Date-time math (~14 min) --------------------------------------------

# One flight first: scheduled 9:00, left 9:15
sched  <- ymd_hm("2013-10-01 09:00", tz = "America/New_York")
actual <- ymd_hm("2013-10-01 09:15", tz = "America/New_York")

actual - sched
class(actual - sched)               # a "difftime"

# ASK: What happens if it leaves the next day instead?
ymd_hm("2013-10-02 11:00", tz = "America/New_York") - sched
# SAY: difftime picks its own units (mins? days?). Awkward in a column!

# Durations always count seconds
as.duration(actual - sched)
as.duration(actual - sched) / dminutes(1)   # -> plain number of minutes


# Now for every flight
flights_demo <- flights_demo %>%
  mutate(my_delay = as.duration(dep_dt - sched_dep_dt) / dminutes(1))

flights_demo %>%
  select(sched_dep_dt, dep_dt, dep_delay, my_delay) %>%
  head()

# ASK: Does our delay ALWAYS match the airline's dep_delay?
flights_demo %>%
  filter(my_delay != dep_delay) %>%
  select(sched_dep_dt, dep_time, dep_dt, dep_delay, my_delay)

flights_demo %>%
  filter(my_delay != dep_delay) %>%
  nrow()
# SAY: These flights left after midnight, but year/month/day is the
#      SCHEDULED date. So our dep_dt is a day too early.
#      Dates are hard; always check a new column against something you trust.

# How far off are we?
flights_demo %>%
  filter(my_delay != dep_delay) %>%
  count(off_by_hours = (dep_delay - my_delay) / 60)
# ASK: Most are off by 24 hours. Why are 4 flights off by only 23?

flights_demo %>%
  filter(dep_delay - my_delay == 23 * 60) %>%
  select(sched_dep_dt, dep_time, dep_delay, my_delay)
# SAY: All on March 10, 2013: the night the clocks sprang forward.
#      That "day" was only 23 hours long!


# Durations vs periods
before_dst <- ymd_hm("2013-03-09 13:00", tz = "America/New_York")

before_dst + ddays(1)    # duration: exactly 86,400 seconds later
before_dst + days(1)     # period: same clock time tomorrow
# SAY: Durations are a stopwatch (exact seconds).
#      Periods are a calendar (human units: "same time tomorrow").

# This clock time never existed in New York:
ymd_hm("2013-03-10 02:30", tz = "America/New_York")


# Fixing the overnight flights
# SAY: The earliest any flight left was 43 min early, so if dep_dt is more
#      than an hour BEFORE the scheduled time, it must have left the next day.
# ASK: Should we add ddays(1) or days(1)?
flights_demo <- flights_demo %>%
  mutate(overnight = dep_dt < sched_dep_dt - hours(1),
         dep_dt_fixed = if_else(overnight, dep_dt + days(1), dep_dt),
         my_delay_fixed = as.duration(dep_dt_fixed - sched_dep_dt) / dminutes(1))

flights_demo %>%
  filter(my_delay_fixed != dep_delay) %>%
  nrow()
# SAY: Zero mismatches. Swap in ddays(1) and the 4 DST flights break.

# If time: periods respect the calendar, sometimes awkwardly
ymd("2013-01-31") + months(1)       # there is no Feb 31!
ymd("2013-01-31") %m+% months(1)    # roll back to the last real day



# =========================================================================
# WRAP-UP (~4 min)
# =========================================================================

# Exit questions (true or false? ask first, then run):

# 1. This gives a factor with levels a to f.
c(factor(c("a", "b", "c")), factor(c("d", "e", "f")))
# SAY: TRUE in R >= 4.1. Older R gave the integer codes 1 2 3 1 2 3!
#      forcats::fct_c() is the safe choice either way.

# 2. This gives a Date (not a date-time).
c(ymd("2020-10-13"), ymd_hms("2020-10-13 09:30:00"))
# SAY: TRUE. c() follows the FIRST element, so the 9:30 time is dropped
#      silently. Swap the order and you get a date-time instead.

# Recap
#   Factors: levels(), factor(levels = ), fct_infreq(), fct_rev(),
#            fct_reorder(), fct_relevel(), fct_recode(), fct_collapse(),
#            fct_drop(), fct_expand(), fct_na_value_to_level()
#   Dates:   ymd() family, ymd_hm(tz = ), with_tz() vs force_tz(),
#            make_datetime(), %/% and %%, difftime vs as.duration(),
#            dminutes(), durations (ddays) vs periods (days)
