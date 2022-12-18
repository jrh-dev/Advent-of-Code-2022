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

# Day 6
d06_dat = unlist(strsplit(readLines("data/d06.txt", warn = FALSE), ""))

# Day 6 Part 1 answer
print(R$d06$solve(d06_dat, 4))

# Day 6 Part 2 answer
print(R$d06$solve(d06_dat, 14))

# Day 7
d07_dat = readLines("data/d07.txt", warn = FALSE)

# Day 7 Part 1 answer
print(R$d07$solve_p1(d07_dat))

# Day 7 Part 2 answer
print(R$d07$solve_p2(d07_dat))

# Day 8
d08_dat = readLines("data/d08.txt", warn = FALSE)

x = nchar(d08_dat[1])
y = length(d08_dat)

d08_dat = as.integer(unlist(strsplit(paste0(d08_dat, collapse=""), "")))

# Day 8 Part 1 answer
R$d08$solve_p1(d08_dat, x, y)

# Day 8 Part 2 answer
R$d08$solve_p2(d08_dat, x, y)

# Day 9
d09_dat = strsplit(readLines("data/d09.txt", warn = FALSE), " ")

ans = R$d09$solve(d09_dat, c(1,9))

# Day 9 Part 1 answer
ans[1]

# Day 9 Part 2 answer
ans[2]

# Day 10
d10_dat = strsplit(readLines("data/d10.txt", warn = FALSE), " ")

# Day 10 Part 1 answer
R$d10$solve_p1(d10_dat, c(20, 60, 100, 140, 180, 220))

# Day 10 Part 2 answer
R$d10$solve_p2(d10_dat)

# Day 11
d11_dat = readLines("data/d11.txt", warn = FALSE)

d11_dat = R$d11$parse_input(d11_dat)

# Day 11 Part 1 answer
R$d11$solve(q=d11_dat,y=3,mod=FALSE,to=20)

# Day 11 Part 2 answer
R$d11$solve(q=d11_dat,y=1,mod=TRUE,to=10000)

# Day 12
d12_dat = readLines("data/d12.txt", warn = FALSE)

# Day 12 Part 1 answer
R$d12$solve(R$d12$parse_input(d12_dat, FALSE), 27)

# Day 12 Part 2 answer
R$d12$solve(R$d12$parse_input(d12_dat, TRUE), 26)

# Day 13
d13_dat = readLines("data/d13.txt", warn = FALSE)

# Day 13 Part 1 answer
R$d13$solve_p1(d13_dat)

# Day 13 Part 2 answer
R$d13$solve_p2(d13_dat)

# Day 14
d14_dat = readLines("data/d14.txt", warn = FALSE)

# Day 14 Part 1 answer
R$d14$solve(d14_dat, FALSE, "!any(m[y:nrow(m),x] != \".\")")

# Day 14 Part 2 answer
#' NOTE: very slow, needs optimisation
R$d14$solve(input=d14_dat, box=TRUE, break_state="all(m[1,499:501] == \"o\")") + 1

# Day 15
d15_dat = readLines("data/d15.txt", warn = FALSE)

# Day 15 Part 1 answer
R$d15$solve_p1(d15_dat, 2000000)

# Day 15 Part 2 answer
R$d15$solve_p2(d15_dat, 4000000)
