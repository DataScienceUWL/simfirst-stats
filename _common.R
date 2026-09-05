# _common.R — Shared setup for all chapters
# Loaded by each chapter's first R code chunk via source("_common.R")
# Based on IMS _common.R, adapted for our textbook

set.seed(42)
options(digits = 3)

# Core packages (MASS loaded before openintro so openintro::mammals masks MASS::mammals)
suppressMessages(library(MASS))
suppressMessages(library(ggplot2))
suppressMessages(library(openintro))
suppressMessages(library(scales))
suppressMessages(library(usdata))

# Simulation-first inference
suppressMessages(library(infer))
suppressMessages(library(dplyr))
suppressMessages(library(tibble))
suppressMessages(library(tidyr))
suppressMessages(library(readr))
suppressMessages(library(forcats))
suppressMessages(library(lubridate))
suppressMessages(library(broom))

# Optional packages (load if available)
if (requireNamespace("nycflights13", quietly = TRUE)) suppressMessages(library(nycflights13))
if (requireNamespace("patchwork", quietly = TRUE)) suppressMessages(library(patchwork))
if (requireNamespace("gridExtra", quietly = TRUE)) suppressMessages(library(gridExtra))
if (requireNamespace("ggridges", quietly = TRUE)) suppressMessages(library(ggridges))

# IMSCOL palette from openintro — use these for consistency
# openintro::IMSCOL["blue","full"] = "#569BBD"
# openintro::IMSCOL["pink","full"] = "#D89A9E"
# openintro::IMSCOL["red","full"]  = "#F05133"
# openintro::IMSCOL["green","full"] = "#114B5F"
# openintro::IMSCOL["gray","full"]  = "#6C6C6C"

# Color constants — single source of truth, shared with chapters that
# source _colors.R directly (path is relative to the chapter dir).
source("../_colors.R")

# ggplot2 theme
theme_set(theme_minimal(base_size = 14))

# Default geom colors
update_geom_defaults("point", list(color = COL_BLUE, fill = COL_BLUE))
update_geom_defaults("bar", list(fill = COL_BLUE, color = "white"))
update_geom_defaults("col", list(fill = COL_BLUE, color = "white"))
update_geom_defaults("boxplot", list(color = COL_BLUE))
update_geom_defaults("density", list(color = COL_BLUE))
update_geom_defaults("line", list(color = COL_GRAY))
update_geom_defaults("smooth", list(color = COL_GRAY))

# knitr output width
if (knitr::is_html_output()) {
  knitr::opts_chunk$set(out.width = "70%")
}
