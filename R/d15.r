#' @export
solve_p1 = function(input, target_row) {
  input = ._parse_input(input)
  out = c()
  excl = c()
  found = 0
  
  for (zz in seq_len(length(input))) {
    t = input[[zz]]
    d = t[5]
    if (t[2] == target_row) excl = c(excl, t[1])
    if (t[4] == target_row) excl = c(excl, t[3])
    
    if (target_row %in% (t[2]-d):(t[2]+d)) {
      d - abs(diff(c(target_row,t[2]))) + 1
      on_line = seq(1,(d*2)+2,2)[((d - abs(diff(c(target_row,t[2])))) + 1)]
      out = c(out,((t[1] - floor(on_line / 2 )):(t[1] + floor(on_line / 2 ))))
    }
  }
  return(length(unique(out[!out %in% excl])))
}

#' @export
solve_p2 = function(input, max_range) {
  input = ._parse_input(input)
  
  for (this in input) {
    t1=._border(this,max_range)
    for (jj in seq_len(length(input))) {
      t1 = t1[(abs(t1$x-input[[jj]][1])) + abs(t1$y-input[[jj]][2]) > input[[jj]][5],]
    }
    t1 = t1[t1$x %in% 0:max_range & t1$y %in% 0:max_range,]
    if (nrow(t1) > 0) break
  }
  return((t1$x[1] * max_range) + t1$y[1])
}

._border = function(t,max_range) {
  x_range = (t[1]-(t[5]+1)):(t[1]+(t[5]+1))
  offsets = c(0,1:(t[5]),(t[5]+1),(t[5]):1,0)
  l_y_range = t[2] - offsets
  r_y_range = t[2] + offsets
  df = data.frame(x=c(x_range,x_range), y=c(l_y_range,r_y_range))
  df = df[df$x >= 0 & df$x <= max_range & df$y >= 0 & df$y <= max_range,]
  return(df)
}

._parse_input = function(input) {
  
  u = vector("list", length(input))
  
  for (ii in seq_len(length(input))) {
    unpack = as.numeric(unlist(strsplit(gsub(":", ",", gsub("Sensor at x=| y=| closest beacon is at x=", "", input[ii])), ",")))
    u[[ii]] = c(unpack, sum(abs(diff(c(unpack[1],unpack[3]))),abs(diff(c(unpack[2],unpack[4])))))
  }
  
  return(u)
}
