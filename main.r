box::use(
  ./R
)

options(scipen = 999)

# Day 1
d01_dat = readLines("data/d01.txt", warn = FALSE)

# Day 1 Part 1 answer
R$d01$solve(d01_dat, 1)

# Day 1 Part 2 answer
R$d01$solve(d01_dat, 3)

# Day 2
d02_dat = gsub(" ", "",readLines("data/d02.txt", warn = FALSE))

opt_1 = unlist(list(
    "AX"= 4, #  rock rock
    "AY"= 8, #  rock paper
    "AZ"= 3, #  rock scissors
    "BX"= 1, #  paper rock
    "BY"= 5, #  paper paper
    "BZ"= 9, #  paper scissors
    "CX"= 7, #  scissors rock
    "CY"= 2, #  scissors paper
    "CZ"= 6  #  scissors scissors
))

opt_2 = unlist(list(
    "AX"= 3, #  rock scissors
    "AY"= 4, #  rock rock
    "AZ"= 8, #  rock paper
    "BX"= 1, #  paper rock
    "BY"= 5, #  paper paper
    "BZ"= 9, #  paper scissors
    "CX"= 2, #  scissors paper
    "CY"= 6, #  scissors scissors
    "CZ"= 7  #  scissors rock
))

# Day 2 Part 1 answer
R$d02$solve(d02_dat, opt_1)

# Day 2 Part 2 answer
R$d02$solve(d02_dat, opt_2)

# Day 3
d03_dat <- readLines("data/d03.txt", warn = FALSE)

# Day 3 Part 1 answer
R$d03$solve_p1(d03_dat)

# Day 3 Part 2 answer
R$d03$solve_p2(d03_dat)

# Day 4
d04_dat = readLines("data/d04.txt", warn = FALSE)

d04 = R$d04$solve(d04_dat)

# Day 4 Part 1 answer
print(d04$contain)

# Day 4 Part 2 answer
print(d04$overlap)

# Day 5
d05_dat = readLines("data/d05.txt", warn = FALSE)

# Day 5 Part 1 answer
print(R$d05$solve(d05_dat, 9000))

# Day 5 Part 2 answer
print(R$d05$solve(d05_dat, 9001))
