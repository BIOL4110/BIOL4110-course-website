# BIOL 4110 Group Project: Ecological Data Analysis


## Overview

In groups of five, you will pose an ecological question, find a real dataset that can answer it, and carry out a complete, reproducible analysis in R. You will share your work three times: a proposal presentation on October 22 (all sections, in lab time), a final presentation (in class time: section 1 Nov 26, section 2 Dec 1), and a final written report (all due Dec 11). All of these are done collectively in your group.

The project will be an exercise in doing ecological research with data someone else collected (a common form of ecological data science research). Much of the work is deciding what question is worth asking, whether the data can really answer it, and how to show the answer clearly.

By the end of the project, you should be able to:

1. Develop a focused ecological question and set it in the context of the published literature.
2. Turn that question into testable hypotheses, including competing hypotheses, with clear predictions ("If the hypothesis is supported, then we expect to see…").
3. Find, evaluate, clean and document an existing ecological dataset.
4. Choose and justify statistical methods that match your hypotheses and data structure, and check their assumptions.
5. Make your analysis fully reproducible with R scripts and a GitHub repository.
6. Produce clear, accurate, publication-quality figures.
7. Interpret results accurately, including limitations and alternative explanations, and present them both orally and in writing.
8. Work effectively as a research team.

## Working as a group

Each group has five members. Everyone shares the group's grade on each deliverable, and everyone is expected to contribute to the code, the writing and the presentations.

**Suggested roles.** Roles help you divide the work, but they are not walls or set in stone. Every member should write and commit code to the repository at some point. You may rotate roles between deliverables.

| Role | Main responsibilities |
| --- | --- |
| Data manager (1-2 people) | Downloads and documents the raw data, writes the data-cleaning script, maintains a data dictionary |
| Analysis lead  (1-2 people) | Leads the statistical models, checks assumptions, keeps analysis scripts tidy |
| Visualization lead (1-2 people) | Makes figures consistent and publication quality, prepares slides |
| Literature and writing lead (1-2 people) | Leads the literature review, reference list and editing of the report |

**Team agreement.** Within the first week, write a short team agreement (half a page) covering how you will communicate, when you will meet, how you will split the work, and what you will do if someone is not contributing. Save it in your repository as `team_agreement.md`.

**Individual accountability.** Your contributions are visible in three ways:

- **Peer evaluations**, done in class after the final presentation. You will rate each group member's contribution and give brief comments. These count toward your participation grade (20% of the course). They do not automatically change your project grade.
- **Git history.** Commits show who worked on the code. Commit under your own GitHub account.
- **Contribution statement.** The final report ends with a short statement describing what each member did.

If your group runs into problems, talk to Joey or the TAs early.

## Finding your data

You may use any publicly available ecological dataset. A starting list is in [Possible Sources of Data for Class Projects](https://docs.google.com/document/d/1HYU0wAj1xpkmN1RBFVeSJrC8fqoj5FyAjU5iMNnc8Zc/edit?usp=sharing), which covers general repositories (NEON, GBIF, EDI, LTER, BioTIME, iNaturalist), bird data (eBird, AVONET, bird banding), fish and metabolic data, freshwater systems, animal movement (Movebank), and more. You can also use data from somewhere else, such as a dataset archived with a published paper on Dryad or Figshare.

There is no minimum size, but your data must be rich enough for an interesting analysis. A good dataset usually has:

- **Enough replication** to test your hypotheses: many sites, years, species or individuals, not a handful.
- **Variation in the predictors you care about**, such as a gradient in temperature, habitat or time.
- **Documentation** (metadata) that explains how the data were collected, what each column means, and the units.
- **A manageable size.** It should load in R on a laptop. If it is huge, plan to subset it.

Combining datasets (for example, species occurrences with climate data, or traits with population trends) often leads to the most interesting questions. It also adds work, so plan for it.

**Start from the question, then check the data.** Before you commit, open the data in R and confirm that it contains the variables, sample sizes and coverage you need. Many projects fail because the data turn out to be too sparse for the question. Bring a quick look at your data (sample sizes, a first plot) to the proposal presentation.

## Reproducibility requirements

Someone who clones your repository should be able to run your scripts and get exactly the cleaned data, results and figures in your report. The instructor team will try to do this.

**Required:**

- [ ] All analysis is done in **R scripts** (`.R` files). Quarto or R Markdown is allowed but not required.
- [ ] One **GitHub repository** per group. Share it with the instructor team. Every member commits from their own account.
- [ ] A clear **folder structure** (see below) and an RStudio Project (`.Rproj`) file.
- [ ] **Relative file paths** only (for example, `here::here("data", "raw", "birds.csv")`). No `setwd()` and no paths like `C:/Users/...`.
- [ ] **Raw data are never edited by hand.** Every change (filtering, renaming, joining, fixing errors) happens in a script.
- [ ] Scripts are **numbered** in the order they run, and each one starts with a short comment saying what it does.
- [ ] Code is **commented** so a classmate can follow it.
- [ ] Package versions are recorded, either with `renv` or by saving `sessionInfo()` output to the repository.
- [ ] If you use random numbers (simulation, bootstrapping, train/test splits), set a seed with `set.seed()`.
- [ ] A **README.md** that explains the project, where the data came from (with citation and licence), how to get the raw data if it is too large for GitHub, which scripts to run in what order, and which packages are needed.
- [ ] A **data dictionary** describing each variable you use, with units.
- [ ] Regular commits with meaningful messages ("Add model of nest success vs. temperature", not "update"). One big commit the night before the deadline is not acceptable.

**Suggested folder structure:**

```
project-name/
├── README.md
├── team_agreement.md
├── project-name.Rproj
├── data/
│   ├── raw/            # original files, never edited
│   └── clean/          # written by scripts
├── scripts/
│   ├── 01_download_data.R
│   ├── 02_clean_data.R
│   ├── 03_explore.R
│   ├── 04_models.R
│   └── 05_figures.R
├── output/
│   ├── figures/
│   └── tables/
└── docs/               # data dictionary, notes, report drafts
```

**The reproducibility test.** Before you submit, have one group member who did not write the scripts clone the repository onto a fresh computer (or a new folder), run the scripts in order, and confirm that everything works and the figures match the report.

## Timeline and grading

The proposal presentation (5 minutes) is on Oct 22, 2026, and the final report and GitHub repository are due on Dec 11, 2026. Required deliverables are in bold. The other rows are suggested group milestones to keep you on track.

| Date | Milestone | Weight |
| --- | --- | --- |
| Week of Oct 5 | Groups formed, team agreement written, GitHub repository created and shared |  |
| Oct 5–20 | Pick question and dataset, download data, first look in R, literature search |  |
| Oct 22, 2026 | **Proposal presentation** (5 min + 2 min questions) | 15% |
| Late Oct | Cleaning script and data dictionary finished |  |
| Early Nov | Main models fitted and assumptions checked, draft figures |  |
| Mid Nov | Results finalized, report outline and draft figures shared within group |  |
| Nov 26 or Dec 1 | **Final presentation**, followed by peer evaluation | 20% |
| Dec 11 | **Final written report** and final GitHub repository (reproducibility test done) | 20% |

## Deliverable 1: Proposal presentation

On Oct 22, 2026, each group gives a **5-minute presentation followed by 2 minutes of questions**. The goal is to explain to the class why your question is worth asking and that your data can answer it. Talks that go over time lose marks, so rehearse with a timer.

**What to include** (about 5–7 slides):

1. **Title slide:** project title that describes the subject, group number, and members' names in alphabetical order by last name.
2. **Background and motivation:** the ecological context, what is already known, and the gap or uncertainty your project addresses. Cite 2–4 key papers.
3. **Research question:** one clearly stated main question.
4. **Hypotheses and predictions:** at least one hypothesis that names a biological mechanism, with a prediction in "if… then…" form. For a top grade, give two or more competing hypotheses that predict different patterns in the data.
5. **Data:** source and citation, what was measured, spatial and temporal coverage, unit of replication and sample size. Show that you have already opened the data in R, for example with a table of sample sizes or a first exploratory plot.
6. **Planned analysis:** which variables are your response and predictors, the statistical approach you plan to use and why it suits your data (for example, non-independence among sites or years), and what result would support each hypothesis.
7. **Anticipated results and work plan:** a sketch or mock-up of your main figure, and who will do what, by when.

All members should be ready to answer questions, and at least two members should speak.

**AI Declaration Statement.** With your slides, submit an AI Declaration Statement confirming that no generative AI was used for the presentation, and describing any permitted use for coding or learning (see the Artificial Intelligence Policy below). If you did not use them, say so.

### Proposal presentation rubric (/50)

| Category | What we look for | Points |
| --- | --- | --- |
| Presentation technique | Clear speech, eye contact, good pace, within 5 minutes | /5 |
| Quality of slides | Visually appealing, not too much text, readable figures with labelled axes, enough information on slides | /5 |
| Background, motivation and question | Enough background from the literature, compelling motivation, clearly stated research question | /10 |
| Hypotheses and predictions | Hypotheses name a mechanism; predictions are specific and testable with the data. Competing hypotheses earn top marks | /10 |
| Data and methods | Dataset clearly described (source, replication unit, sample size); exploration shows the project is feasible; analysis plan clearly matches the hypotheses | /10 |
| Anticipated results and work plan | Mock-up of main figure; what each outcome would mean; realistic timeline | /5 |
| Responses to audience questions | Coherent, thoughtful answers to questions and comments | /5 |
| **Total** |  | **/50** |

## Deliverable 2: Final presentation

In class time (section 1 on Nov 26, section 2 on Dec 1), each group gives a **10-minute presentation followed by 3 minutes of questions**. You now tell the full story: what you asked, what you did, what you found, and what it means. Talks that go over time lose marks.

**What to include:**

1. **Question and hypotheses**, briefly restated. Say clearly if they changed since the proposal, and why.
2. **Data and methods:** the dataset, key cleaning decisions (what you removed and why), the final sample size, and the statistical models. A simple diagram of your workflow or study design is helpful.
3. **Results:** your main findings, shown with 2–4 clear figures. Report effect sizes and uncertainty (for example, slopes with confidence intervals), not only p-values.
4. **Interpretation:** which hypotheses are supported, which are not, and how confident you are. Connect your results back to the literature.
5. **Limitations and next steps:** problems with the data or methods, alternative explanations, and what you would do with more time or data.
6. **Take-home message:** one slide with the one or two points you want the audience to remember.

Every group member must speak during the final presentation.

**AI Declaration Statement.** With your slides, submit an AI Declaration Statement confirming that no generative AI was used for the presentation, and describing any permitted use for the analysis code (see the Artificial Intelligence Policy below). If you did not use them, say so.

### Final presentation rubric (/50)

| Category | What we look for | Points |
| --- | --- | --- |
| Presentation technique | Clear speech, eye contact, good pace, smooth handoffs, within time | /5 |
| Quality of slides | Visually appealing, little text, consistent design, easy to follow | /5 |
| Background, question and hypotheses | Concise context; clear question; mechanistic hypotheses with predictions; changes since the proposal explained | /5 |
| Data and methods | Data source and cleaning decisions clearly explained; methods match hypotheses and data structure; assumptions considered | /10 |
| Results and visualizations | Figures are clear, accurate and readable from the back of the room; results described with effect sizes and uncertainty | /10 |
| Interpretation and critical thinking | Conclusions follow from results; competing explanations and limitations discussed; links to literature and broader significance | /10 |
| Responses to audience questions | Coherent, thoughtful answers; any member can respond | /5 |
| **Total** |  | **/50** |

## Deliverable 3: Final written report

The final report is written like a short scientific paper. Submit one report per group by Dec 11, together with the link to your final GitHub repository.

**Format:**

- Maximum **8 pages of text**, Times New Roman, 12 point, double spaced. Figures, tables, references and the appendix do not count toward the limit.
- 3–5 figures in the main text. Additional figures (for example, model diagnostics) go in an appendix.
- One consistent reference style throughout (for example, the style of *Ecology* or *Journal of Animal Ecology*).

**Sections:**

1. **Title page:** descriptive title, group number, members in alphabetical order by last name with student numbers, and the GitHub repository link.
2. **Abstract** (max 250 words): question, data, approach, main results, and why they matter.
3. **Introduction:** broader ecological context, a critical summary of relevant literature, the gap your study fills, your question, and your hypotheses with predictions. Ideally, give two or more competing or complementary hypotheses.
4. **Methods:** data source (with citation), what was measured and how, spatial and temporal scope, unit of replication and sample size, data cleaning decisions, statistical models (response, predictors, model type, random effects if any), how you checked assumptions, and the R version and main packages used.
5. **Results:** describe the patterns with effect sizes, uncertainty (confidence intervals or standard errors) and test statistics. Refer to every figure and table. Do not interpret here.
6. **Discussion:** what the results mean for each hypothesis, how they compare with earlier studies, alternative explanations, limitations of the data and methods, and the broader significance.
7. **References.**
8. **Contribution statement:** one or two sentences per member describing what they did.
9. **AI Declaration Statement:** confirm that no generative AI was used to write the report, and describe any permitted use for the code: which tools, and for what (see the Artificial Intelligence Policy below). If you did not use them, say so. This section is required.
10. **Appendix (optional):** model diagnostics, extra figures, additional tables.

### Final report rubric (/100)

We grade at three levels, as in all written work in this course. Meeting the basic expectations well earns a grade of about 60–70. Strong connection to the literature brings you to 70–80. Critical thinking, including competing hypotheses and an honest assessment of what the data can and cannot show, is needed for 80–100.

| Item for evaluation | Points |
| --- | --- |
| **Basic expectations** | **/70** |
| Identifiable, clear main question and problem statement: the ecological uncertainty and why it matters | /10 |
| Hypotheses with clear predictions ("if the hypothesis is supported, then we expect…") | /10 |
| Data: source, collection, replication unit and sample size clearly described; cleaning decisions justified | /10 |
| Statistical methods: clearly connected to the hypotheses, suited to the data structure, assumptions checked | /10 |
| Results: accurate, complete, and reported with effect sizes and uncertainty | /10 |
| Figures and tables: meet the visualization standards below, are referred to in the text, and have informative captions | /10 |
| Reproducibility: the repository runs from raw data to final figures; README, data dictionary and commit history meet the requirements | /10 |
| **Good: novelty and connection to the literature** | **/10** |
| Development of the broader ecological context for the research | /5 |
| Brief but thorough, critical interpretation of prior work, and comparison of your results with it | /5 |
| **Excellent: critical analysis** | **/20** |
| Two or more competing or complementary mechanistic hypotheses, logically developed and evaluated against the results | /10 |
| Limitations and alternative explanations discussed honestly; broader significance and implications stated in a compelling way | /10 |
| **Total** | **/100** |

Writing quality (clarity, grammar, spelling, consistent references, staying within the page limit) is considered in every category. Reports over the page limit lose marks.

## Visualization standards

Every figure in your presentations and report must be made in R by a script in your repository (for example, with `ggplot2`). Each figure should show one clear message.

- [ ] **Labelled axes with units**, for example "Mean July temperature (°C)", not `temp_jul`.
- [ ] **Readable text.** Make labels large enough to read on a slide from the back of the room, and when printed at report size.
- [ ] **An informative caption** in the report that says what is shown, the sample size, and what the error bars or bands represent (SE, 95% CI, etc.).
- [ ] **Show the data where possible**, such as raw points behind a fitted line or model estimates, rather than only bars of means.
- [ ] **Show uncertainty**, using confidence intervals, standard errors or prediction bands.
- [ ] **Colourblind-friendly colours** (for example, the `viridis` palettes), and never colour as the only way to tell groups apart.
- [ ] **A consistent style** across all figures: same theme, fonts and colour for the same group.
- [ ] **No chart clutter:** no 3D effects, no unnecessary gridlines or legends, and no pie charts for complex comparisons.
- [ ] **Saved at high resolution** with `ggsave()` (at least 300 dpi) to `output/figures/`.
- [ ] **Referred to in the text**, and figure and table titles describe the content ("Nest success declines with spring temperature", not "Results").

## Tips, integrity and getting help

**Tips:**

- Choose a question you can answer well, not one so broad you cannot finish. A focused question answered carefully earns more than an ambitious one answered loosely.
- Explore your data early. Plot it, count missing values and check sample sizes before you plan your models.
- Make your hypotheses predict *different* patterns. If every hypothesis predicts the same result, your data cannot tell them apart.
- Write the methods as you go, and keep a list of every decision you make about the data.
- Commit and push often, and pull before you start working to avoid merge conflicts.

**Academic integrity.** Cite every dataset, paper and package you use (`citation("packagename")` gives the reference for an R package). You may adapt code from tutorials or forums, but you must understand it, test it, and note the source in a comment. Use of generative AI is limited by the policy below. Every member is responsible for being able to explain any part of the project.

### Artificial Intelligence Policy

**Use of Generative AI.** Please note that plagiarism in this course includes submitting work copied from generative AI tools (such as ChatGPT, Gemini, or Claude).

**No use of generative AI is allowed in the writing or presentations for this project.** This includes the proposal and final presentations (slides, speaking notes, text on slides) and the final written report. All writing and presentation content must be your group's own work.

For the coding and learning parts of the project only, generative AI may be used for the following limited purposes:

- clarifying concepts covered in class
- acting as an "advanced search engine" (for example, looking up error codes)
- helping debug code that you have written yourself

Generative AI may not be used to produce text or code from scratch. Should we suspect that an assessment contains AI-generated writing or code, it will be flagged and provisionally given a grade of zero. The student will then need to meet with the instructor or a TA before a grade is assigned.

All use of generative AI must be disclosed. For each assessment, students will be required to submit an AI Declaration Statement describing how these tools were used.

**Getting help.** Bring questions about data, R or Git to class work periods. Contact the instructor team early if your group has problems working together.

## Course marks breakdown

The group project makes up 55% of your final course grade.

| Component | Weight |
| --- | --- |
| Class worksheets (5 in total) | 15% |
| Proposal presentation (group project) | 15% |
| Final research presentation (group project) | 20% |
| Final written research report (group project) | 20% |
| Participation (includes peer evaluations) | 20% |
| Self reflection | 10% |
| **Total** | **100%** |