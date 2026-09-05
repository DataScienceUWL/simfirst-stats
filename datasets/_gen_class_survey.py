#!/usr/bin/env python3
"""Generate the synthetic `class_survey.csv` tech-tutorial dataset.

PROVENANCE: This is a *synthetic, illustrative* dataset — not real student
records. It stands in for the planned first-day STAT 145 class survey and is
used by the Explore Unit Tech Tutorial so every tool (Jamovi / R / StatLens)
loads the same small, relatable file. Values are drawn from plausible
distributions with a fixed seed so the file is reproducible.

n = 50 students, seed = 145.
Columns:
  year         categorical  {First-year, Sophomore, Junior, Senior}
  housing      categorical  {On-campus, Off-campus}
  study_hours  numeric      weekly hours studying (right-skewed, a couple highs)
  sleep_hours  numeric      typical nightly sleep (roughly symmetric)
  commute_min  numeric      one-way commute in minutes (On-campus small)

Run:  python3 _gen_class_survey.py   ->  writes class_survey.csv
"""
import csv
import random

random.seed(145)
N = 50

YEARS = (["First-year"] * 18 + ["Sophomore"] * 14 + ["Junior"] * 10 + ["Senior"] * 8)
random.shuffle(YEARS)

rows = []
for i in range(N):
    year = YEARS[i]
    # First-years skew on-campus; upper years skew off-campus.
    p_on = {"First-year": 0.80, "Sophomore": 0.55, "Junior": 0.30, "Senior": 0.20}[year]
    housing = "On-campus" if random.random() < p_on else "Off-campus"

    # Weekly study hours: right-skewed, centered ~13, a few diligent outliers.
    study = random.gauss(13, 5)
    if random.random() < 0.06:          # occasional very high studier
        study += random.uniform(14, 24)
    study = max(1.0, round(study, 1))

    # Nightly sleep: roughly symmetric around 6.9, bounded.
    sleep = random.gauss(6.9, 1.0)
    sleep = round(min(9.0, max(4.5, sleep)), 1)

    # One-way commute: On-campus tiny; Off-campus larger and right-skewed.
    if housing == "On-campus":
        commute = max(1, round(random.gauss(6, 3)))
    else:
        commute = max(3, round(random.expovariate(1 / 18) + 6))
    commute = int(commute)

    rows.append([year, housing, study, sleep, commute])

with open("class_survey.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["year", "housing", "study_hours", "sleep_hours", "commute_min"])
    w.writerows(rows)

print(f"Wrote class_survey.csv ({N} rows)")
