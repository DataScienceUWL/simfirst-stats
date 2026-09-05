#!/usr/bin/env Rscript
# Generate figures for Chapters 10-18 of STAT 145 textbook
# Style: clean white backgrounds, IMSCOL blue/pink, 600x400 at 150 DPI

library(ggplot2)

# --- Style constants ---
IMSCOL_BLUE  <- "#569BBD"
IMSCOL_PINK  <- "#E97583"
IMSCOL_GRAY  <- "#888888"
W <- 600; H <- 400; DPI <- 150
OUT <- "/mnt/e/GDrive_baggett.jeff/Teaching/Classes_current/Stat145_Rebuild/textbook/images"

theme_clean <- theme_minimal(base_size = 11) +
  theme(
    panel.background = element_rect(fill = "white", color = NA),
    plot.background  = element_rect(fill = "white", color = NA),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#EBEBEB"),
    axis.line = element_line(color = "black", linewidth = 0.3),
    plot.title = element_text(face = "bold", size = 12)
  )

success <- character()
failure <- character()

wrap <- function(name, expr) {
  tryCatch({
    eval(expr)
    success <<- c(success, name)
    cat("OK:", name, "\n")
  }, error = function(e) {
    failure <<- c(failure, name)
    cat("FAIL:", name, "—", conditionMessage(e), "\n")
  })
}

# ============================================================
# CH10-1: Two normal curves N(0,1) and N(19,4)
# ============================================================
wrap("normal-two-curves.png", quote({
  x <- seq(-5, 35, length.out = 500)
  df <- data.frame(
    x = rep(x, 2),
    y = c(dnorm(x, 0, 1), dnorm(x, 19, 4)),
    dist = rep(c("N(0, 1)", "N(19, 4)"), each = 500)
  )
  p <- ggplot(df, aes(x, y, color = dist)) +
    geom_line(linewidth = 1) +
    scale_color_manual(values = c(IMSCOL_BLUE, IMSCOL_PINK)) +
    labs(x = "x", y = "Density", color = NULL,
         title = expression("Two normal curves: "*italic(N)(0,1)*" and "*italic(N)(19,4))) +
    theme_clean +
    theme(legend.position = c(0.85, 0.85))
  ggsave(file.path(OUT, "normal-two-curves.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH10-2: Empirical rule (68-95-99.7)
# ============================================================
wrap("empirical-rule-normal.png", quote({
  x <- seq(-4, 4, length.out = 500)
  base_df <- data.frame(x = x, y = dnorm(x))

  shade <- function(lo, hi, fill) {
    xs <- seq(lo, hi, length.out = 200)
    data.frame(x = c(lo, xs, hi), y = c(0, dnorm(xs), 0), fill = fill)
  }

  s3 <- shade(-3, 3, "99.7%")
  s2 <- shade(-2, 2, "95%")
  s1 <- shade(-1, 1, "68%")

  p <- ggplot() +
    geom_polygon(data = s3, aes(x, y), fill = "#D6E8F0", color = NA) +
    geom_polygon(data = s2, aes(x, y), fill = "#A1CCE0", color = NA) +
    geom_polygon(data = s1, aes(x, y), fill = IMSCOL_BLUE, alpha = 0.7, color = NA) +
    geom_line(data = base_df, aes(x, y), linewidth = 0.8) +
    annotate("text", x = 0, y = 0.15, label = "68%", fontface = "bold", size = 4, color = "white") +
    annotate("text", x = 0, y = 0.06, label = "95%", fontface = "bold", size = 3.5) +
    annotate("text", x = 0, y = 0.01, label = "99.7%", fontface = "bold", size = 3) +
    scale_x_continuous(breaks = -3:3, labels = c(expression(mu-3*sigma), expression(mu-2*sigma),
      expression(mu-sigma), expression(mu), expression(mu+sigma),
      expression(mu+2*sigma), expression(mu+3*sigma))) +
    labs(x = NULL, y = "Density", title = "The Empirical Rule (68-95-99.7)") +
    theme_clean
  ggsave(file.path(OUT, "empirical-rule-normal.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH10-3: Standard normal, left tail Z=1.00
# ============================================================
wrap("normal-left-tail-z1.png", quote({
  x <- seq(-3.5, 3.5, length.out = 500)
  base_df <- data.frame(x = x, y = dnorm(x))
  xs <- seq(-3.5, 1, length.out = 300)
  shade_df <- data.frame(x = c(-3.5, xs, 1), y = c(0, dnorm(xs), 0))

  p <- ggplot() +
    geom_polygon(data = shade_df, aes(x, y), fill = IMSCOL_BLUE, alpha = 0.6) +
    geom_line(data = base_df, aes(x, y), linewidth = 0.8) +
    geom_vline(xintercept = 1, linetype = "dashed", color = IMSCOL_PINK, linewidth = 0.6) +
    annotate("text", x = -0.5, y = 0.12, label = "Area = 0.8413", size = 4, fontface = "bold", color = "white") +
    annotate("text", x = 1, y = -0.015, label = "Z = 1.00", size = 3.5, color = IMSCOL_PINK) +
    labs(x = "Z", y = "Density", title = "Standard normal: area left of Z = 1.00") +
    theme_clean
  ggsave(file.path(OUT, "normal-left-tail-z1.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH10-4: Normal(1500,300), right tail of 1630
# ============================================================
wrap("normal-right-tail-1630.png", quote({
  mu <- 1500; sig <- 300
  x <- seq(mu - 3.5*sig, mu + 3.5*sig, length.out = 500)
  base_df <- data.frame(x = x, y = dnorm(x, mu, sig))
  xs <- seq(1630, mu + 3.5*sig, length.out = 300)
  shade_df <- data.frame(x = c(1630, xs, mu + 3.5*sig), y = c(0, dnorm(xs, mu, sig), 0))
  area <- round(1 - pnorm(1630, mu, sig), 4)

  p <- ggplot() +
    geom_polygon(data = shade_df, aes(x, y), fill = IMSCOL_PINK, alpha = 0.6) +
    geom_line(data = base_df, aes(x, y), linewidth = 0.8) +
    geom_vline(xintercept = 1630, linetype = "dashed", color = IMSCOL_PINK, linewidth = 0.6) +
    annotate("text", x = 1900, y = max(base_df$y)*0.4, label = paste0("Area = ", area),
             size = 4, fontface = "bold") +
    labs(x = "SAT Score", y = "Density",
         title = expression("N(1500, 300): area right of 1630")) +
    theme_clean
  ggsave(file.path(OUT, "normal-right-tail-1630.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH10-5: Normal(70,3.3), between 69 and 74
# ============================================================
wrap("normal-between-69-74.png", quote({
  mu <- 70; sig <- 3.3
  x <- seq(mu - 4*sig, mu + 4*sig, length.out = 500)
  base_df <- data.frame(x = x, y = dnorm(x, mu, sig))
  xs <- seq(69, 74, length.out = 300)
  shade_df <- data.frame(x = c(69, xs, 74), y = c(0, dnorm(xs, mu, sig), 0))
  area <- round(pnorm(74, mu, sig) - pnorm(69, mu, sig), 4)

  p <- ggplot() +
    geom_polygon(data = shade_df, aes(x, y), fill = IMSCOL_BLUE, alpha = 0.6) +
    geom_line(data = base_df, aes(x, y), linewidth = 0.8) +
    geom_vline(xintercept = c(69, 74), linetype = "dashed", color = IMSCOL_PINK, linewidth = 0.5) +
    annotate("text", x = 71.5, y = max(base_df$y)*0.4, label = paste0("Area = ", area),
             size = 4, fontface = "bold", color = "white") +
    labs(x = "Height (inches)", y = "Density",
         title = "N(70, 3.3): area between 69 and 74") +
    theme_clean
  ggsave(file.path(OUT, "normal-between-69-74.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH11: t vs normal
# ============================================================
wrap("t-vs-normal.png", quote({
  x <- seq(-4.5, 4.5, length.out = 500)
  df_data <- data.frame(
    x = rep(x, 3),
    y = c(dnorm(x), dt(x, 5), dt(x, 15)),
    dist = rep(c("N(0,1)", "t (df = 5)", "t (df = 15)"), each = 500)
  )
  df_data$dist <- factor(df_data$dist, levels = c("N(0,1)", "t (df = 15)", "t (df = 5)"))

  p <- ggplot(df_data, aes(x, y, color = dist, linetype = dist)) +
    geom_line(linewidth = 0.9) +
    scale_color_manual(values = c("black", IMSCOL_BLUE, IMSCOL_PINK)) +
    scale_linetype_manual(values = c("solid", "dashed", "dotted")) +
    labs(x = "t / z", y = "Density", color = NULL, linetype = NULL,
         title = "t-distributions vs. standard normal") +
    theme_clean +
    theme(legend.position = c(0.82, 0.82))
  ggsave(file.path(OUT, "t-vs-normal.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH12-1: t two-sided df=99, |2.37|
# ============================================================
wrap("t-two-sided-df99.png", quote({
  dft <- 99; cv <- 2.37
  x <- seq(-4, 4, length.out = 500)
  base_df <- data.frame(x = x, y = dt(x, dft))
  xl <- seq(-4, -cv, length.out = 200)
  xr <- seq(cv, 4, length.out = 200)
  left_df  <- data.frame(x = c(-4, xl, -cv), y = c(0, dt(xl, dft), 0))
  right_df <- data.frame(x = c(cv, xr, 4),   y = c(0, dt(xr, dft), 0))
  area <- round(2 * pt(-cv, dft), 4)

  p <- ggplot() +
    geom_polygon(data = left_df,  aes(x, y), fill = IMSCOL_PINK, alpha = 0.6) +
    geom_polygon(data = right_df, aes(x, y), fill = IMSCOL_PINK, alpha = 0.6) +
    geom_line(data = base_df, aes(x, y), linewidth = 0.8) +
    annotate("text", x = 0, y = max(base_df$y)*0.5,
             label = paste0("Two-tailed p = ", area), size = 4, fontface = "bold") +
    annotate("text", x = -cv, y = -0.012, label = paste0("-", cv), size = 3.5, color = IMSCOL_PINK) +
    annotate("text", x =  cv, y = -0.012, label = as.character(cv), size = 3.5, color = IMSCOL_PINK) +
    labs(x = "t", y = "Density", title = paste0("t-distribution (df = ", dft, "): two-tailed test")) +
    theme_clean
  ggsave(file.path(OUT, "t-two-sided-df99.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH12-2: t two-sided df=67, |2.20|
# ============================================================
wrap("t-two-sided-df67.png", quote({
  dft <- 67; cv <- 2.20
  x <- seq(-4, 4, length.out = 500)
  base_df <- data.frame(x = x, y = dt(x, dft))
  xl <- seq(-4, -cv, length.out = 200)
  xr <- seq(cv, 4, length.out = 200)
  left_df  <- data.frame(x = c(-4, xl, -cv), y = c(0, dt(xl, dft), 0))
  right_df <- data.frame(x = c(cv, xr, 4),   y = c(0, dt(xr, dft), 0))
  area <- round(2 * pt(-cv, dft), 4)

  p <- ggplot() +
    geom_polygon(data = left_df,  aes(x, y), fill = IMSCOL_PINK, alpha = 0.6) +
    geom_polygon(data = right_df, aes(x, y), fill = IMSCOL_PINK, alpha = 0.6) +
    geom_line(data = base_df, aes(x, y), linewidth = 0.8) +
    annotate("text", x = 0, y = max(base_df$y)*0.5,
             label = paste0("Two-tailed p = ", area), size = 4, fontface = "bold") +
    annotate("text", x = -cv, y = -0.012, label = paste0("-", cv), size = 3.5, color = IMSCOL_PINK) +
    annotate("text", x =  cv, y = -0.012, label = as.character(cv), size = 3.5, color = IMSCOL_PINK) +
    labs(x = "t", y = "Density", title = paste0("t-distribution (df = ", dft, "): two-tailed test")) +
    theme_clean
  ggsave(file.path(OUT, "t-two-sided-df67.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH13: Standard normal, right tail Z=0.59
# ============================================================
wrap("normal-right-tail-z059.png", quote({
  x <- seq(-3.5, 3.5, length.out = 500)
  base_df <- data.frame(x = x, y = dnorm(x))
  xs <- seq(0.59, 3.5, length.out = 300)
  shade_df <- data.frame(x = c(0.59, xs, 3.5), y = c(0, dnorm(xs), 0))
  area <- round(1 - pnorm(0.59), 4)

  p <- ggplot() +
    geom_polygon(data = shade_df, aes(x, y), fill = IMSCOL_PINK, alpha = 0.6) +
    geom_line(data = base_df, aes(x, y), linewidth = 0.8) +
    geom_vline(xintercept = 0.59, linetype = "dashed", color = IMSCOL_PINK, linewidth = 0.6) +
    annotate("text", x = 1.8, y = 0.10, label = paste0("Area = ", area),
             size = 4, fontface = "bold") +
    annotate("text", x = 0.59, y = -0.015, label = "Z = 0.59", size = 3.5, color = IMSCOL_PINK) +
    labs(x = "Z", y = "Density", title = "Standard normal: area right of Z = 0.59") +
    theme_clean
  ggsave(file.path(OUT, "normal-right-tail-z059.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH14-1: Law of Large Numbers (die rolls)
# ============================================================
wrap("law-large-numbers.png", quote({
  set.seed(42)
  n <- 10000
  rolls <- sample(1:6, n, replace = TRUE)
  prop_ones <- cumsum(rolls == 1) / (1:n)
  # Subsample for plotting efficiency
  idx <- unique(c(1:100, seq(101, n, by = 10)))
  df <- data.frame(roll = idx, proportion = prop_ones[idx])

  p <- ggplot(df, aes(roll, proportion)) +
    geom_line(color = IMSCOL_BLUE, linewidth = 0.5) +
    geom_hline(yintercept = 1/6, linetype = "dashed", color = IMSCOL_PINK, linewidth = 0.7) +
    annotate("text", x = 8000, y = 1/6 + 0.012, label = "1/6", color = IMSCOL_PINK,
             size = 4, fontface = "bold") +
    scale_x_log10(labels = scales::comma) +
    labs(x = "Number of rolls (log scale)", y = "Proportion of 1s",
         title = "Law of Large Numbers: rolling a fair die") +
    theme_clean
  ggsave(file.path(OUT, "law-large-numbers.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH14-2: Die events diagram (base R)
# ============================================================
wrap("die-events-diagram.png", quote({
  png(file.path(OUT, "die-events-diagram.png"), width = 600, height = 350, res = 150)
  par(mar = c(1, 1, 2, 1), bg = "white")
  plot(NULL, xlim = c(0, 7), ylim = c(0, 4.5), axes = FALSE, xlab = "", ylab = "",
       main = "Events on die outcomes {1, 2, 3, 4, 5, 6}")

  # Draw outcome boxes
  for (i in 1:6) {
    rect(i - 0.4, 0.3, i + 0.4, 1.0, col = "white", border = "gray30", lwd = 1.5)
    text(i, 0.65, i, cex = 1.2, font = 2)
  }

  # Event A = {1,2}
  rect(0.4, 0.15, 2.6, 1.15, border = IMSCOL_BLUE, lwd = 2.5, lty = 1)
  text(1.5, 1.5, expression(italic(A)*" = {1, 2}"), col = IMSCOL_BLUE, cex = 0.9, font = 2)

  # Event B = {4,6}
  # Draw rounded grouping
  segments(3.6, 0.15, 3.6, 1.15, col = IMSCOL_PINK, lwd = 2.5)
  segments(4.4, 0.15, 4.4, 1.15, col = IMSCOL_PINK, lwd = 2.5)
  segments(5.6, 0.15, 5.6, 1.15, col = IMSCOL_PINK, lwd = 2.5)
  segments(6.4, 0.15, 6.4, 1.15, col = IMSCOL_PINK, lwd = 2.5)
  segments(3.6, 1.15, 4.4, 1.15, col = IMSCOL_PINK, lwd = 2.5)
  segments(5.6, 1.15, 6.4, 1.15, col = IMSCOL_PINK, lwd = 2.5)
  segments(4.4, 1.15, 5.6, 1.15, col = IMSCOL_PINK, lwd = 2.5, lty = 3)
  segments(3.6, 0.15, 4.4, 0.15, col = IMSCOL_PINK, lwd = 2.5)
  segments(5.6, 0.15, 6.4, 0.15, col = IMSCOL_PINK, lwd = 2.5)
  segments(4.4, 0.15, 5.6, 0.15, col = IMSCOL_PINK, lwd = 2.5, lty = 3)
  text(5, 1.5, expression(italic(B)*" = {4, 6}"), col = IMSCOL_PINK, cex = 0.9, font = 2)

  # Event D = {2,3}
  rect(1.5, 2.0, 3.5, 2.7, border = "#2CA02C", lwd = 2.5)
  text(2.5, 2.35, expression(italic(D)*" = {2, 3}"), col = "#2CA02C", cex = 0.9, font = 2)
  arrows(2, 2.0, 2, 1.2, col = "#2CA02C", lwd = 1.5, length = 0.1)
  arrows(3, 2.0, 3, 1.2, col = "#2CA02C", lwd = 1.5, length = 0.1)

  text(3.5, 3.5, "Sample space S = {1, 2, 3, 4, 5, 6}", cex = 1.0, font = 3)
  dev.off()
}))

# ============================================================
# CH14-3: Venn diagram — Diamonds and Face cards (base R)
# ============================================================
wrap("venn-diamonds-facecards.png", quote({
  png(file.path(OUT, "venn-diamonds-facecards.png"), width = 600, height = 400, res = 150)
  par(mar = c(1, 1, 2.5, 1), bg = "white")
  plot(NULL, xlim = c(-3, 3), ylim = c(-2.5, 2.5), axes = FALSE, xlab = "", ylab = "",
       main = "Diamonds and Face Cards in a Standard Deck")

  # Draw two overlapping circles
  theta <- seq(0, 2*pi, length.out = 200)
  # Diamonds circle (left)
  cx1 <- -0.7; cy1 <- 0; r1 <- 1.5
  polygon(cx1 + r1*cos(theta), cy1 + r1*sin(theta), border = IMSCOL_BLUE, lwd = 2.5,
          col = adjustcolor(IMSCOL_BLUE, 0.1))
  # Face cards circle (right)
  cx2 <- 0.7; cy2 <- 0; r2 <- 1.5
  polygon(cx2 + r2*cos(theta), cy2 + r2*sin(theta), border = IMSCOL_PINK, lwd = 2.5,
          col = adjustcolor(IMSCOL_PINK, 0.1))

  # Labels
  text(-1.5, 1.8, "Diamonds", col = IMSCOL_BLUE, font = 2, cex = 1.0)
  text(1.5, 1.8, "Face Cards", col = IMSCOL_PINK, font = 2, cex = 1.0)

  # Counts
  text(-1.3, 0, "10", cex = 1.4, font = 2)         # Diamonds only (13-3)
  text(0, 0, "3", cex = 1.4, font = 2, col = "gray20") # Overlap
  text(1.3, 0, "9", cex = 1.4, font = 2)            # Face cards only (12-3)

  # Outside
  text(2.5, -2.0, "30", cex = 1.2, font = 2, col = IMSCOL_GRAY)
  text(2.5, -2.3, "neither", cex = 0.8, col = IMSCOL_GRAY)

  # Outer rectangle (sample space)
  rect(-2.8, -2.2, 2.8, 2.2, border = "gray40", lwd = 1.5)
  text(-2.5, 2.0, "S", font = 3, cex = 1.0)
  dev.off()
}))

# ============================================================
# CH14-4: Probability tree — midterm/final (base R)
# ============================================================
wrap("tree-midterm-final.png", quote({
  png(file.path(OUT, "tree-midterm-final.png"), width = 700, height = 450, res = 150)
  par(mar = c(0.5, 0.5, 2, 0.5), bg = "white")
  plot(NULL, xlim = c(0, 10), ylim = c(0, 7), axes = FALSE, xlab = "", ylab = "",
       main = "Probability Tree: Midterm and Final Grades")

  # Level 0: root
  x0 <- 1; y0 <- 3.5

  # Level 1: Midterm
  x1 <- 4
  y1_A <- 5.5   # A on midterm
  y1_O <- 1.5   # Other on midterm

  segments(x0, y0, x1, y1_A, lwd = 2, col = IMSCOL_BLUE)
  segments(x0, y0, x1, y1_O, lwd = 2, col = IMSCOL_GRAY)

  text(2.2, 5.0, "P(A) = 0.13", cex = 0.7, col = IMSCOL_BLUE)
  text(2.2, 2.0, "P(Other) = 0.87", cex = 0.7, col = IMSCOL_GRAY)

  text(x1, y1_A + 0.3, "A midterm", cex = 0.75, font = 2)
  text(x1, y1_O - 0.3, "Other", cex = 0.75, font = 2)

  # Level 2 from A midterm
  x2 <- 7
  y2_AA <- 6.5; y2_AO <- 4.5
  segments(x1, y1_A, x2, y2_AA, lwd = 1.5, col = IMSCOL_BLUE)
  segments(x1, y1_A, x2, y2_AO, lwd = 1.5, col = IMSCOL_GRAY)
  text(5.3, 6.3, "P(A|A) = 0.47", cex = 0.65, col = IMSCOL_BLUE)
  text(5.3, 4.7, "P(Other|A) = 0.53", cex = 0.65, col = IMSCOL_GRAY)
  text(x2, y2_AA + 0.3, "A final", cex = 0.7, font = 2)
  text(x2, y2_AO - 0.3, "Other final", cex = 0.7, font = 2)

  # Level 2 from Other midterm
  y2_OA <- 2.5; y2_OO <- 0.5
  segments(x1, y1_O, x2, y2_OA, lwd = 1.5, col = IMSCOL_BLUE)
  segments(x1, y1_O, x2, y2_OO, lwd = 1.5, col = IMSCOL_GRAY)
  text(5.3, 2.3, "P(A|Other) = 0.11", cex = 0.65, col = IMSCOL_BLUE)
  text(5.3, 0.7, "P(Other|Other) = 0.89", cex = 0.65, col = IMSCOL_GRAY)
  text(x2, y2_OA + 0.3, "A final", cex = 0.7, font = 2)
  text(x2, y2_OO - 0.3, "Other final", cex = 0.7, font = 2)

  # Joint probabilities
  x3 <- 9.3
  text(x3, y2_AA, "0.13 x 0.47 = 0.0611", cex = 0.6, font = 3)
  text(x3, y2_AO, "0.13 x 0.53 = 0.0689", cex = 0.6, font = 3)
  text(x3, y2_OA, "0.87 x 0.11 = 0.0957", cex = 0.6, font = 3)
  text(x3, y2_OO, "0.87 x 0.89 = 0.7743", cex = 0.6, font = 3)

  dev.off()
}))

# ============================================================
# CH14-5: Probability tree — cancer screening (base R)
# ============================================================
wrap("tree-cancer-screening.png", quote({
  png(file.path(OUT, "tree-cancer-screening.png"), width = 700, height = 450, res = 150)
  par(mar = c(0.5, 0.5, 2, 0.5), bg = "white")
  plot(NULL, xlim = c(0, 10), ylim = c(0, 7), axes = FALSE, xlab = "", ylab = "",
       main = "Probability Tree: Cancer Screening")

  x0 <- 1; y0 <- 3.5
  x1 <- 4; y1_C <- 5.5; y1_N <- 1.5

  # Level 1
  segments(x0, y0, x1, y1_C, lwd = 2, col = IMSCOL_PINK)
  segments(x0, y0, x1, y1_N, lwd = 2, col = IMSCOL_BLUE)
  text(2.2, 5.0, "P(Cancer) = 0.0035", cex = 0.7, col = IMSCOL_PINK)
  text(2.2, 2.0, "P(No cancer) = 0.9965", cex = 0.7, col = IMSCOL_BLUE)
  text(x1 + 0.3, y1_C + 0.3, "Cancer", cex = 0.75, font = 2, col = IMSCOL_PINK)
  text(x1 + 0.3, y1_N - 0.3, "No cancer", cex = 0.75, font = 2, col = IMSCOL_BLUE)

  x2 <- 7
  # From Cancer
  y2_CP <- 6.5; y2_CN <- 4.5
  segments(x1, y1_C, x2, y2_CP, lwd = 1.5, col = IMSCOL_PINK)
  segments(x1, y1_C, x2, y2_CN, lwd = 1.5, col = IMSCOL_GRAY)
  text(5.3, 6.3, "P(+|C) = 0.89", cex = 0.65, col = IMSCOL_PINK)
  text(5.3, 4.7, "P(-|C) = 0.11", cex = 0.65, col = IMSCOL_GRAY)
  text(x2, y2_CP + 0.3, "Positive", cex = 0.7, font = 2)
  text(x2, y2_CN - 0.3, "Negative", cex = 0.7, font = 2)

  # From No Cancer
  y2_NP <- 2.5; y2_NN <- 0.5
  segments(x1, y1_N, x2, y2_NP, lwd = 1.5, col = IMSCOL_PINK)
  segments(x1, y1_N, x2, y2_NN, lwd = 1.5, col = IMSCOL_BLUE)
  text(5.3, 2.3, "P(+|NC) = 0.07", cex = 0.65, col = IMSCOL_PINK)
  text(5.3, 0.7, "P(-|NC) = 0.93", cex = 0.65, col = IMSCOL_BLUE)
  text(x2, y2_NP + 0.3, "Positive", cex = 0.7, font = 2)
  text(x2, y2_NN - 0.3, "Negative", cex = 0.7, font = 2)

  # Joint
  x3 <- 9.3
  text(x3, y2_CP, "0.003115", cex = 0.6, font = 3)
  text(x3, y2_CN, "0.000385", cex = 0.6, font = 3)
  text(x3, y2_NP, "0.069755", cex = 0.6, font = 3)
  text(x3, y2_NN, "0.926745", cex = 0.6, font = 3)

  dev.off()
}))

# ============================================================
# CH15-1: Two dice sum distribution
# ============================================================
wrap("two-dice-distribution.png", quote({
  sums <- 2:12
  counts <- c(1,2,3,4,5,6,5,4,3,2,1)
  probs <- counts / 36
  df <- data.frame(sum = factor(sums), prob = probs)

  p <- ggplot(df, aes(sum, prob)) +
    geom_col(fill = IMSCOL_BLUE, width = 0.7) +
    geom_text(aes(label = paste0(counts, "/36")), vjust = -0.5, size = 2.5) +
    scale_y_continuous(limits = c(0, max(probs) * 1.15), labels = scales::number_format(accuracy = 0.001)) +
    labs(x = "Sum of two dice", y = "Probability",
         title = "Probability distribution for the sum of two fair dice") +
    theme_clean
  ggsave(file.path(OUT, "two-dice-distribution.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH15-2: Histogram to density (4 panels)
# ============================================================
wrap("histogram-to-density.png", quote({
  set.seed(123)
  dat <- rnorm(5000, 0, 1)
  bins_list <- c(5, 15, 50, 200)

  plots <- lapply(seq_along(bins_list), function(i) {
    b <- bins_list[i]
    ggplot(data.frame(x = dat), aes(x)) +
      geom_histogram(aes(y = after_stat(density)), bins = b,
                     fill = IMSCOL_BLUE, alpha = 0.5, color = "white", linewidth = 0.2) +
      stat_function(fun = dnorm, args = list(0, 1), color = IMSCOL_PINK, linewidth = 0.8) +
      labs(x = NULL, y = NULL, title = paste0(b, " bins")) +
      theme_clean +
      theme(plot.title = element_text(size = 10))
  })

  p <- gridExtra::arrangeGrob(grobs = plots, ncol = 2,
         top = grid::textGrob("From histogram to density curve",
                              gp = grid::gpar(fontface = "bold", fontsize = 12)))
  ggsave(file.path(OUT, "histogram-to-density.png"), p,
         width = 800/DPI, height = 600/DPI, dpi = DPI)
}))

# ============================================================
# CH16: Expected value balance point (base R)
# ============================================================
wrap("expected-value-balance.png", quote({
  png(file.path(OUT, "expected-value-balance.png"), width = 600, height = 350, res = 150)
  par(mar = c(2, 1, 2.5, 1), bg = "white")
  plot(NULL, xlim = c(-20, 200), ylim = c(-1, 5), axes = FALSE, xlab = "", ylab = "",
       main = "Expected value as a balance point")

  # Number line
  segments(-10, 0, 190, 0, lwd = 2)
  ticks <- c(0, 50, 100, 137, 150, 170)
  for (tk in ticks) {
    segments(tk, -0.15, tk, 0.15, lwd = 1.5)
    text(tk, -0.5, paste0("$", tk), cex = 0.7)
  }

  # Weights (values and probabilities)
  vals   <- c(0, 137, 170)
  probs  <- c(0.20, 0.55, 0.25)
  ev     <- sum(vals * probs)  # 117.85

  # Draw weights as boxes
  for (i in seq_along(vals)) {
    ht <- probs[i] * 8
    rect(vals[i] - 6, 0.2, vals[i] + 6, 0.2 + ht,
         col = adjustcolor(IMSCOL_BLUE, 0.7), border = IMSCOL_BLUE, lwd = 1.5)
    text(vals[i], 0.2 + ht + 0.4, paste0("P = ", probs[i]), cex = 0.7, font = 2)
  }

  # Fulcrum triangle
  fx <- ev
  polygon(c(fx - 5, fx + 5, fx), c(-0.2, -0.2, 0), col = IMSCOL_PINK, border = IMSCOL_PINK)
  text(fx, -0.75, expression(E(X) == "$117.85"), cex = 0.8, font = 2, col = IMSCOL_PINK)

  dev.off()
}))

# ============================================================
# CH17: Binomial-Normal approximation (4 panels)
# ============================================================
wrap("binomial-normal-approx.png", quote({
  ns <- c(10, 30, 100, 300)
  p_val <- 0.10

  plots <- lapply(ns, function(n) {
    x <- 0:n
    probs <- dbinom(x, n, p_val)
    mu <- n * p_val
    sig <- sqrt(n * p_val * (1 - p_val))
    # Only show range around mean
    xlim_lo <- max(0, floor(mu - 4*sig))
    xlim_hi <- min(n, ceiling(mu + 4*sig))
    idx <- x >= xlim_lo & x <= xlim_hi
    df <- data.frame(x = x[idx], prob = probs[idx])
    xc <- seq(xlim_lo, xlim_hi, length.out = 200)

    ggplot(df, aes(x, prob)) +
      geom_col(fill = IMSCOL_BLUE, alpha = 0.6, width = 0.8) +
      geom_line(data = data.frame(x = xc, y = dnorm(xc, mu, sig)),
                aes(x, y), color = IMSCOL_PINK, linewidth = 0.8) +
      labs(x = NULL, y = NULL, title = paste0("n = ", n, ", p = ", p_val)) +
      theme_clean +
      theme(plot.title = element_text(size = 10))
  })

  p <- gridExtra::arrangeGrob(grobs = plots, ncol = 2,
         top = grid::textGrob("Binomial distribution with normal approximation",
                              gp = grid::gpar(fontface = "bold", fontsize = 12)))
  ggsave(file.path(OUT, "binomial-normal-approx.png"), p,
         width = 800/DPI, height = 600/DPI, dpi = DPI)
}))

# ============================================================
# CH18-1: Standard normal curve
# ============================================================
wrap("standard-normal-curve.png", quote({
  x <- seq(-3.5, 3.5, length.out = 500)
  df <- data.frame(x = x, y = dnorm(x))
  xs <- seq(-3.5, 3.5, length.out = 500)
  shade_df <- data.frame(x = c(-3.5, xs, 3.5), y = c(0, dnorm(xs), 0))

  p <- ggplot() +
    geom_polygon(data = shade_df, aes(x, y), fill = adjustcolor(IMSCOL_BLUE, 0.3)) +
    geom_line(data = df, aes(x, y), linewidth = 0.9, color = IMSCOL_BLUE) +
    scale_x_continuous(breaks = -3:3) +
    labs(x = "Z", y = "Density", title = "The Standard Normal Distribution, N(0, 1)") +
    theme_clean
  ggsave(file.path(OUT, "standard-normal-curve.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH18-2: normal-two-parameters.png — same as ch10, just copy reference
# ============================================================
wrap("normal-two-parameters.png", quote({
  # Reuse the two-curves concept with slight title change
  x <- seq(-5, 35, length.out = 500)
  df <- data.frame(
    x = rep(x, 2),
    y = c(dnorm(x, 0, 1), dnorm(x, 19, 4)),
    dist = rep(c("N(0, 1)", "N(19, 4)"), each = 500)
  )
  p <- ggplot(df, aes(x, y, color = dist)) +
    geom_line(linewidth = 1) +
    scale_color_manual(values = c(IMSCOL_BLUE, IMSCOL_PINK)) +
    labs(x = "x", y = "Density", color = NULL,
         title = expression("Normal distributions differ by "*mu*" and "*sigma)) +
    theme_clean +
    theme(legend.position = c(0.85, 0.85))
  ggsave(file.path(OUT, "normal-two-parameters.png"), p, width = W/DPI, height = H/DPI, dpi = DPI)
}))

# ============================================================
# CH18-3: empirical-rule-ch18.png — copy of ch10 empirical rule
# ============================================================
wrap("empirical-rule-ch18.png", quote({
  file.copy(file.path(OUT, "empirical-rule-normal.png"),
            file.path(OUT, "empirical-rule-ch18.png"), overwrite = TRUE)
}))

# ============================================================
# CH18-4: QQ plots (3 panels)
# ============================================================
wrap("qq-plots-three.png", quote({
  set.seed(99)
  n <- 200
  dat_norm  <- rnorm(n)
  dat_skew  <- rexp(n, 1)
  dat_heavy <- rt(n, df = 3)

  make_qq <- function(d, label) {
    qq <- qqnorm(d, plot.it = FALSE)
    df <- data.frame(theoretical = qq$x, sample = qq$y)
    ggplot(df, aes(theoretical, sample)) +
      geom_point(color = IMSCOL_BLUE, size = 1, alpha = 0.6) +
      geom_abline(slope = sd(d), intercept = mean(d), color = IMSCOL_PINK, linewidth = 0.7) +
      labs(x = "Theoretical quantiles", y = "Sample quantiles", title = label) +
      theme_clean +
      theme(plot.title = element_text(size = 10))
  }

  p1 <- make_qq(dat_norm,  "(a) Normal data")
  p2 <- make_qq(dat_skew,  "(b) Right-skewed data")
  p3 <- make_qq(dat_heavy, "(c) Heavy-tailed data")

  p <- gridExtra::arrangeGrob(p1, p2, p3, ncol = 3,
         top = grid::textGrob("Normal QQ Plots",
                              gp = grid::gpar(fontface = "bold", fontsize = 12)))
  ggsave(file.path(OUT, "qq-plots-three.png"), p,
         width = 900/DPI, height = 350/DPI, dpi = DPI)
}))

# ============================================================
# Summary
# ============================================================
cat("\n========================================\n")
cat("DONE. Generated", length(success), "of", length(success) + length(failure), "figures.\n")
if (length(failure) > 0) {
  cat("FAILED:", paste(failure, collapse = ", "), "\n")
} else {
  cat("All figures generated successfully.\n")
}
cat("========================================\n")
