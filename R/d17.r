
jet = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"

jet = unlist(strsplit(jet, ""))

#' idea is to track state of each column


#' initial matrix
state = matrix(0, nrow = 1, ncol = 7)


####

.#.
###
.#.

..#
..#
###

#
#
#
#

##
##

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





drop = function(x, y, state) {
  
  
  if (all(state == 0)) {
    state = rbind(matrix(0, nrow = (2 + length(unique(y))), ncol = 7), state)
  } else {
    state = rbind(matrix(0, nrow = (3 + length(unique(y))), ncol = 7), state)
  }
  
  
  
  run = TRUE
  
  while (run) {
    js$iterate(1)
    
    if (js$dir == "<" & min(x) > 1) {
      try_x = x - 1
    } else if (js$dir == ">" & max(x) < 7) {
      try_x = x + 1 
    }
    
    if (!any(sapply(seq_len(length(x)), \(idx) state[y[idx], try_x[idx]] > 0))) {
      x = try_x
    }
    
    try_y = y + 1
    
    if (any(try_y > nrow(state))) {
      for (e in seq_len(length(x))) state[y[e],x[e]] = 1
      run = FALSE
    } else if (!any(sapply(seq_len(length(x)), \(idx) state[try_y[idx], x[idx]] > 0))) {
      y = try_y
    } else {
      for (e in seq_len(length(x))) state[y[e],x[e]] = 1
      run = FALSE
    }
  }
  state = state[which(rowSums(state) > 0),]
  return(state)
}


js = jet_state$new(jet)


state = matrix(0, nrow = 1, ncol = 7)

state = drop(x=c(3,4,5,6), y=c(1,1,1,1), state=state)

state


state = drop(x=c(3,4,4,4,5), y=c(2,2,1,3,2), state=state)





