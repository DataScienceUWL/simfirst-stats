# Textbook Figures Status

Last updated: 2026-03-11

## Sources
- **IMS**: CC BY-SA 3.0 — images copied from `resources/reference_books/ims-source/images/`
- **OS**: CC BY-SA 3.0 — generated from R scripts in `resources/reference_books/os-source/`
- **Generated**: Created with R/ggplot2 using openintro data or fabricated data
- **Needs creation**: Not yet generated

## Blanket Attribution
The preface credits IMS and OpenIntro as source material under CC BY-SA 3.0.
Figures adapted from these sources do not need individual attribution.
Figures created from scratch are original to this textbook.

## Legend
- [x] = figure exists and is linked in chapter
- [~] = figure generated but not yet linked
- [ ] = needs to be generated
- [!] = needs manual/artistic creation (diagram, not a plot)

---

## Ch01: Introduction to Data
- [ ] `variables-tree.png` — Variable type taxonomy tree diagram [!]
- [ ] `county-multi-unit-homeownership.png` — Scatterplot, openintro::county
- [ ] `county-pop-income.png` — Scatterplot, openintro::county

## Ch02: Study Design
- [ ] `sampling-population.png` — Conceptual: population → sample [!]
- [ ] `sampling-bias.png` — Conceptual: biased sampling [!]
- [ ] `sampling-nonresponse.png` — Conceptual: non-response bias [!]
- [ ] `simple-random-sample.png` — Dots grid, random highlighted [!]
- [ ] `stratified-sample.png` — Dots in strata, samples from each [!]
- [ ] `cluster-sample.png` — Dots in clusters, whole clusters selected [!]
- [ ] `multistage-sample.png` — Dots in clusters, subsets selected [!]
- [x] `blocking.png` — Blocking diagram (copied from IMS)
- [x] `sun-causes-cancer.png` — Confounding diagram (copied from IMS)
- [x] `random-sample-vs-allocation.png` — Random sampling vs assignment (IMS)
- [ ] `scope-of-inference.png` — 2×2 table diagram [!]

## Ch03: Data Visualization
- [ ] `homeownership-barplot.png` — Bar plot
- [ ] `homeownership-pie-bar.png` — Pie vs bar comparison
- [ ] `interest-rate-dotplot.png` — Dot plot, openintro::loan50
- [ ] `interest-rate-histogram.png` — Histogram
- [ ] `interest-rate-density.png` — Density plot
- [ ] `skewness-shapes.png` — Three distribution shapes
- [ ] `modality-shapes.png` — Unimodal/bimodal/multimodal
- [ ] `interest-rate-dotplot-boxplot.png` — Dot plot + box plot
- [ ] `income-boxplots-by-gain.png` — Side-by-side box plots
- [x] `pie-3d.jpg` — 3D pie chart bad example (copied from IMS)
- [ ] `visualization-principles-color.png` — Color usage examples
- [ ] `visualization-principles-ordering.png` — Bar ordering examples

## Ch04: Describing Distributions
- [ ] `empirical-rule.png` — 68-95-99.7 bell curve

## Ch05: Relationships Between Variables
- [ ] `barplot-stacked-standardized-dodged.png` — Three bar plot types
- [ ] `mosaic-homeownership.png` — Mosaic plot
- [ ] `income-faceted-histograms.png` — Faceted histograms
- [ ] `income-ridge-plot.png` — Ridge/density plot
- [ ] `loan-amount-vs-income.png` — Scatterplot, openintro::loan50
- [ ] `income-vs-poverty.png` — Scatterplot with trend, openintro::county
- [ ] `income-boxplots-gain.png` — Side-by-side box plots (reuse ch03)

## Ch07: Randomization Tests
- [ ] `sex-rand-dotplot.png` — Null distribution dot plot (simulated)
- [ ] `opportunity-cost-null.png` — Null distribution histogram (simulated)

## Ch09: Sampling Distributions via Simulation
- [ ] `empirical-rule-ch09.png` — 68-95-99.7 rule (reuse ch04/ch10)

## Ch10: Normal Approximation
- [ ] `normal-two-curves.png` — N(0,1) and N(19,4) overlaid
- [ ] `empirical-rule-normal.png` — 68-95-99.7 shaded
- [ ] `normal-left-tail-z1.png` — Left tail Z=1
- [ ] `normal-right-tail-1630.png` — Right tail, N(1500,300)
- [ ] `normal-between-69-74.png` — Between region, N(70,3.3)

## Ch11: Confidence Intervals for Means
- [ ] `t-vs-normal.png` — t(5), t(15), N(0,1) overlaid

## Ch12: Hypothesis Tests for Means
- [ ] `t-two-sided-df99.png` — t-dist df=99, tails beyond |2.37|
- [ ] `t-two-sided-df67.png` — t-dist df=67, tails beyond |2.20|

## Ch13: Inference for Proportions
- [ ] `normal-right-tail-z059.png` — Standard normal, right of Z=0.59

## Ch14: Probability Rules
- [ ] `law-large-numbers.png` — Convergence line plot
- [ ] `die-events-diagram.png` — Events A,B,D on die outcomes [!]
- [ ] `venn-diamonds-facecards.png` — Venn diagram [!]
- [ ] `tree-midterm-final.png` — Probability tree [!]
- [ ] `tree-cancer-screening.png` — Probability tree [!]

## Ch15: Random Variables
- [ ] `two-dice-distribution.png` — Bar plot of dice sums
- [ ] `histogram-to-density.png` — Four panels, bins → smooth curve

## Ch16: Expected Value and Variance
- [ ] `expected-value-balance.png` — Balance/fulcrum diagram [!]

## Ch17: Binomial Distribution
- [ ] `binomial-normal-approx.png` — Four panels, Binom approaching normal

## Ch18: Normal Distribution
- [ ] `standard-normal-curve.png` — Clean N(0,1)
- [ ] `qq-plots-three.png` — Three QQ plots

## Ch19: Type II Error
- [ ] `type2-simulation.png` — Simulated test outcomes

## Ch20: Statistical Power
- [ ] `power-curve-sample-size.png` — Power vs n
- [ ] `power-curve-effect-size.png` — Power vs effect

## Ch22: Chi-Square Goodness of Fit
- [ ] `chisq-jury-null.png` — Simulated null distribution
- [ ] `chisq-distributions.png` — Chi-sq df=2,4,9 overlaid
- [ ] `chisq-pvalue-df3.png` — Chi-sq df=3, shaded right of 5.89

## Ch23: Chi-Square Independence
- [ ] `chisq-independence-null.png` — Simulated null distribution
- [ ] `chisq-pvalue-df2.png` — Chi-sq df=2, shaded right of 40.13

## Ch24: ANOVA
- [ ] `anova-variability-comparison.png` — Two sets of groups
- [ ] `mlb-obp-boxplots.png` — Box plots by position
- [ ] `exam-scores-boxplots.png` — Box plots by exam version
- [ ] `anova-rand-process.png` — Randomization process diagram [!]
- [ ] `anova-rand-null.png` — Null F-stat distribution
- [ ] `anova-rand-null-observed.png` — With observed F marked
- [ ] `f-distribution-pvalue.png` — F(2,426) shaded
- [ ] `anova-histograms-conditions.png` — Normality check histograms

## Ch25: Multiple Comparisons
- [ ] `multiple-comparisons-ci.png` — Pairwise CI plot

## Ch26: Correlation
- [ ] `possum-scatterplot.png` — Head vs total length
- [ ] `nonlinear-poor-fit.png` — Quadratic data with flat line
- [ ] `correlation-gallery.png` — Eight panels, r from -1 to 1
- [ ] `correlation-units.png` — Same data different units
- [ ] `correlation-nonlinear.png` — Strong nonlinear, weak r
- [ ] `crop-yield-scatterplots.png` — Six scatterplot pairs

## Ch27: Linear Regression
- [ ] `linear-relationships.png` — Three relationship types
- [ ] `possum-regression.png` — Scatterplot + line
- [ ] `possum-residuals.png` — Residual plot
- [ ] `permutation-regression.png` — Original vs permuted
- [ ] `permutation-slopes-null.png` — Null slope distribution
- [ ] `regression-diagnostics.png` — 2×4 diagnostic grid

## Ch28: Prediction and Model Fit
- [ ] `residual-patterns.png` — 2×3 scatterplot + residual grid
- [ ] `heteroscedasticity.png` — Fan-shaped residuals
- [ ] `leverage-influence.png` — Three leverage scenarios
- [ ] `confidence-prediction-bands.png` — CI and PI bands

---

## Figures needing manual/artistic creation [!]
These are conceptual diagrams that cannot be generated from data alone:
1. `variables-tree.png` — Can generate with R grid/base graphics
2. `sampling-population.png` — Dot diagrams
3. `sampling-bias.png`
4. `sampling-nonresponse.png`
5. `simple-random-sample.png`
6. `stratified-sample.png`
7. `cluster-sample.png`
8. `multistage-sample.png`
9. `scope-of-inference.png` — 2×2 table
10. `die-events-diagram.png`
11. `venn-diamonds-facecards.png`
12. `tree-midterm-final.png`
13. `tree-cancer-screening.png`
14. `expected-value-balance.png`
15. `anova-rand-process.png`

These 15 figures are included in the R generation agents but may need review/refinement.
