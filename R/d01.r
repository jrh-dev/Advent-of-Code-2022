#' Solve day 1 AOC 2022
#'
#' @param input puzzle input
#' @param top integer specifying how many elements to include
#'  in the returned sum.
#' @return a numeric; the sum of the top n results
#' @export
solve = function(input, top) {
  input = ._process(input)
  return(sum(sort(unlist(input), decreasing = TRUE)[1:top]))
}

._process = function(data) {
  data = as.double(data)
  splits = c(which(is.na(data)), length(data))
  res = vector(mode = "list", length = length(splits))
  start = 1

  for (ii in seq_len(length(splits))) {
    res[ii] = sum(data[start:(splits[ii] - 1)])
    start = splits[ii] + 1
  }

  return(res)
}
