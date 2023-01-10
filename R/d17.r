pob = 2022

box::use(R6)

jet_state <- R6$R6Class("jet_state", list(
  idx = 0,
  dir = NULL,
  jets = NULL,
  initialize = function(jets) {
    self$jets = jets
  },
  iterate = function(x) {
    self$idx = self$idx + x 
    if (self$idx > length(self$jets)) self$idx = self$idx - length(self$jets) 
    self$dir = self$jets[self$idx]
    invisible(self)
  })
)

jet = readLines("data/d17.txt")
jet = unlist(strsplit(jet, ""))
state = NULL

rocks = list(
  list(c(1,1,1,1), c(3,4,5,6)),
  list(c(1,2,2,2,3), c(4,3,4,5,4)),
  list(c(1,2,3,3,3), c(5,5,3,4,5)),
  list(c(1,2,3,4), c(3,3,3,3)),
  list(c(1,1,2,2), c(3,4,3,4))
)

state = matrix(1, nrow = 1, ncol = 7)

js = jet_state$new(jet)

drop = function(rock, state) {
  
  y = rock[[1]]
  x = rock[[2]]
  
  state = rbind(matrix(0, nrow = length(unique(y)) + 3, ncol = 7), state)
  
  run = TRUE
  vert_block = 0
  
  while (run) {
    js$iterate(1)
    
    if (js$dir == ">" & max(x) < 7) {
      try_x = x + 1
      if (all(sapply(seq_len(length(x)), function(xe) state[y[xe], try_x[xe]]) == 0)) x = try_x
    } else if (js$dir == "<" & min(x) > 1) {
      try_x = x - 1
      if (all(sapply(seq_len(length(x)), function(xe) state[y[xe], try_x[xe]]) == 0)) x = try_x
    }
    
    try_y = y + 1
    if (all(sapply(seq_len(length(y)), function(ye) state[try_y[ye], x[ye]]) == 0)) {
      y = try_y
      vert_block = 0
      } else {
        vert_block = vert_block + 1
    }
    
    if (vert_block > 0) run = FALSE
    
    ts = state
    for (e in seq_len(length(x))) ts[y[e], x[e]] = 1
    ts
  }
  
  for (e in seq_len(length(x))) state[y[e], x[e]] = 1
  
  state = state[rowSums(state) > 0,]
  
  return(state)
}


for (iter in c(rep(1:5, abs(pob / 5)), 1:(pob%%5))) {
  
  state = drop(rock=rocks[[iter]], state)
  
}


nrow(state) - 1
