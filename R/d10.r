#' @export
solve_p1 = function(input, tar) {
  c = x = 1

  for (ins in input) {
    if (ins[1] == "noop") {
      c = c + 1
      if (c %in% tar) tar[which(c == tar)] = c * x
    }
  
    if (ins[1] == "addx") {
      c = c + 1
      if (c %in% tar) tar[which(c == tar)] = c * x
      c = c + 1
      x = x + as.integer(ins[2])
      if (c %in% tar) tar[which(c == tar)] = c * x
    }
  }
  return(sum(tar))
}

#' @export
solve_p2 = function(input) {
  c = x = 1
  crt = rep(".", 40 * 6)
  
  for (ins in input) {
    crt[c] = x
    if (ins[1] == "noop") c = c + 1
    
    if (ins[1] == "addx") {
      c = c + 1
      crt[c] = x
      c = c + 1
      x = x + as.integer(ins[2])
    }
  }
  
  crt_out = vector("list", 6)

  crt_strt = c(1,41,81,121,161,201)

  for (line in 1:6) {
    crt_out[[line]] = rep(" ", 40)
    lit = as.integer(crt[crt_strt[line]:(crt_strt[line]+39)])
  
    for (ii in 1:40) {
      if (lit[ii] %in% c(ii-2,ii-1,ii)) crt_out[[line]][ii] = "#"
    }
    
    crt_out[[line]] = paste0(crt_out[[line]], collapse="")
  }
  return(noquote(do.call(rbind, crt_out)))
}
