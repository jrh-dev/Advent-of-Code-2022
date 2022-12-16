#' @export
solve = function(input, box = FALSE, break_state) {
  
  m = ._mk_matrix(input = input, box = box)
  
  outer_run = TRUE
  
  while (outer_run) {
    y=1
    x = 500
    inner_run = TRUE
    
    while(inner_run) {
      if (eval(parse(text = break_state))) break
      y = min(which(m[y:nrow(m),x] != ".")) + y - 2
      l=._dil(y,x,m)
      r=._dir(y,x,m)
      
      if (all(unlist(l)==unlist(r))) {
        m[y,x] = "o"
        inner_run = FALSE
      } else if (any(unlist(l)!=c(y,x))) {
        x = unlist(l)[2]
        y = unlist(l)[1]
      } else if (any(unlist(r)!=c(y,x))) {
        x = unlist(r)[2]
        y = unlist(r)[1]
      }
    }
    if (eval(parse(text = break_state))) outer_run = FALSE
  }
  return(sum(m == "o"))
}

._mk_matrix = function(input, box) {
    
    input = lapply(lapply(lapply(strsplit(input, " -> "), strsplit, ","), unlist), as.integer)
    
    cmax = max(sapply(1:length(input), function(x) max(input[[x]][seq(1,length(input[[x]]),2)])))
    rmax = max(sapply(1:length(input), function(x) max(input[[x]][seq(2,length(input[[x]]),2)])))

    m = matrix(
        ".",
        nrow = rmax + 2,
        ncol = cmax + (rmax * 2) + 2
        )

    for (ii in seq_len(length(input))) {
        p = input[[ii]]
        if (length(p) == 4) sequ = 1 else sequ = seq(1, (length(p))-3, 2)
        for (jj in sequ) {
            x = unique(c(p[jj+1],p[jj+3]))
            y = unique(c(p[jj],p[jj+2]))
            m[min(x):max(x),min(y):max(y)] = "#"
        }
    }

    if (box) {
        m[nrow(m),] = "#"
        m[,1] = "#"
        m[,ncol(m)] = "#"
    }
    return(m)
}

._dil = function(y,x,m) {
    if (y+1 <= nrow(m) & x-1 > 0) {
        if (m[y+1,x-1] == ".") {
            y = y+1
            x = x-1
        }
    }
    return(list(y,x))
}

._dir = function(y,x,m) {
    if (y+1 <= nrow(m) & x+1 < ncol(m)) {
        if (m[y+1,x+1] == ".") {
            y = y+1
            x = x+1
        }
    }
    return(list(y,x))
}
