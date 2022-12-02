box::use(
  ./R
)

options(scipen = 999)

# Day 1

d01_dat = readLines("data/d01.txt", warn = FALSE)

# Day 1 Part 1 answer
R$d01$d01(d01_dat, 1)

# Day 1 Part 2 answer
R$d01$d01(d01_dat, 3)

