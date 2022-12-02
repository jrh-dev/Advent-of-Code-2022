#' Solve day 1 AOC 2022
#'
#' @param input puzzle input stripped of whitespace
#' @param dict a named numeric vector specifying the
#'  score of various game outcomes
#' @return a numeric denoting the score of all rounds played
#' @export
solve = function(input, dict) return(sum(dict[input]))
