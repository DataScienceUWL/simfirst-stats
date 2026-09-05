# _colors.R — Shared color constants (IMSCOL palette)
#
# Single source of truth for the named chapter colors. Dependency-free
# (plain hex literals, no packages) so any chapter can source it directly
# without pulling in the full _common.R setup (theme, geom defaults, seed).
# _common.R also sources this file, so the two never drift.
#
# Values match openintro::IMSCOL[<color>, "full"]:
#   blue  = #569BBD   red   = #F05133   green = #114B5F   gray = #808080
# (COL_PINK is a slightly more saturated custom pink.)

COL_BLUE   <- "#569BBD"
COL_RED    <- "#F05133"
COL_GREEN  <- "#114B5F"
COL_GRAY   <- "#808080"
COL_PINK   <- "#E97583"
# Warm orange for the minority / highlighted / "extreme" class, matching the
# StatLens sampling-lab and mechanism highlight (#E07020). Pairs with COL_BLUE
# for the majority class — a blue/orange split that stays distinct under the
# common color-vision deficiencies (unlike red/green).
COL_ORANGE <- "#E07020"
