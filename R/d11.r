box::use(R6)

#' @export
parse_input = function(input) {
  start = strsplit(gsub(" ", "", substr(input[substr(input,1,7) == "  Start"], 18, nchar(input[substr(input,1,7) == "  Start"],))),",")
  names(start) = paste0("q",0:7)
  start = lapply(start, as.integer)
  return(start)
}

#' @export
solve = function(q,y,mod,to) {
  q0=q[[1]]
  q1=q[[2]]
  q2=q[[3]]
  q3=q[[4]]
  q4=q[[5]]
  q5=q[[6]]
  q6=q[[7]]
  q7=q[[8]]
  
  for (pass in 1:to){
    monkey0 = monkey$new(._fun(q0*3,y,mod,11), if(exists("monkey0")) monkey0$cnt + length(q0) else length(q0))
    q0 = c()
    q2 = c(q2, monkey0$monkey_a)
    q7 = c(q7, monkey0$monkey_b)
    
    monkey1 = monkey$new(._fun(q1*q1,y,mod,7), if(exists("monkey1")) monkey1$cnt + length(q1) else length(q1))
    q1 = c()
    q0 = c(q0, monkey1$monkey_a)
    q2 = c(q2, monkey1$monkey_b)
    
    monkey2 = monkey$new(._fun(q2+1,y,mod,3), if(exists("monkey2")) monkey2$cnt + length(q2) else length(q2))
    q2 = c()
    q7 = c(q7, monkey2$monkey_a)
    q5 = c(q5, monkey2$monkey_b)
    
    monkey3 = monkey$new(._fun(q3+8,y,mod,5), if(exists("monkey3")) monkey3$cnt + length(q3) else length(q3))
    q3 = c()
    q6 = c(q6, monkey3$monkey_a)
    q4 = c(q4, monkey3$monkey_b)
    
    monkey4 = monkey$new(._fun(q4+3,y,mod,17), if(exists("monkey4")) monkey4$cnt + length(q4) else length(q4))
    q4 = c()
    q1 = c(q1, monkey4$monkey_a)
    q0 = c(q0, monkey4$monkey_b)
    
    monkey5 = monkey$new(._fun(q5+4,y,mod,13), if(exists("monkey5")) monkey5$cnt + length(q5) else length(q5))
    q5 = c()
    q6 = c(q6, monkey5$monkey_a)
    q3 = c(q3, monkey5$monkey_b)
    
    monkey6 = monkey$new(._fun(q6*17,y,mod,19), if(exists("monkey6")) monkey6$cnt + length(q6) else length(q6))
    q6 = c()
    q4 = c(q4, monkey6$monkey_a)
    q1 = c(q1, monkey6$monkey_b)
    
    monkey7 = monkey$new(._fun(q7+7,y,mod,2), if(exists("monkey7")) monkey7$cnt + length(q7) else length(q7))
    q7 = c()
    q5 = c(q5, monkey7$monkey_a)
    q3 = c(q3, monkey7$monkey_b)
    
  }
  
  return(
    prod(sort(c(
      monkey0$cnt,
      monkey1$cnt,
      monkey2$cnt,
      monkey3$cnt,
      monkey4$cnt,
      monkey5$cnt,
      monkey6$cnt,
      monkey7$cnt
    ), decreasing = TRUE)[1:2])
  )
}

monkey <- R6$R6Class("monkey",
                  public = list(
                    monkey_a = NULL,
                    monkey_b = NULL,
                    cnt = NULL,
                    initialize = function(items = NA, cnt = NA) {
                      self$monkey_a = items[[1]]
                      self$monkey_b = items[[2]]
                      self$cnt = cnt
                    }
                  )
                )

._fun = function(x,y,mod,z) {
  a = floor((x[floor(x/y) %% z == 0]/y))
  if (mod) a = a %% (2*7*3*11*17*5*13*19)
  b = floor((x[floor(x/y) %% z != 0]/y))
  if (mod) b = b %% (2*7*3*11*17*5*13*19)
  return(list(a,b))
}

