box::use(
  glue[glue],
  stats[setNames]
  )

#' @export
solve_p1 = function(input) {
  parsed = ._parse_input(input)
  moves = ._map_vlv(parsed$mv)
  res = ._open_vlvs(cv = "AA", t = 30, vlvs = parsed$tar, dist = moves, fr = parsed$fr, rel=0)
  ans = res[[which.max(sapply(res, \(x) x[[2]]))]]
  return(glue("Max pressure release is {ans[[2]]} by opening valves {paste(ans[[1]], collapse = \", \")}"))
}

#' @export
solve_p2 = function(input) {
  parsed = ._parse_input(input)
  moves = ._map_vlv(parsed$mv)
  res = ._open_vlvs(cv = "AA", t = 26, vlvs = parsed$tar, dist = moves, fr = parsed$fr, rel=0)
  ans=0
  sub = res[order(sapply(unique(res), \(x) x[[2]]), decreasing = TRUE)[1:1000]]
  for (x in sub) {
    for (y in sub) {
      if (!any(x[[1]][2:length(x[[1]])] %in% y[[1]][2:length(y[[1]])])) ans=max(ans, (x[[2]] + y[[2]]))
    }
  }
  return(glue("Max pressure released with the help of an elephant is {ans}"))
}

._parse_input = function (input) {
  
  ins = vector("list", length(input))
  
  for (ii in seq_len(length(input))) {
    x = strsplit(input[ii], ";")
    valve = substr(x[[1]][1], 7, 8)
    flow = as.numeric(gsub("[^0-9.-]", "", x[[1]][1]))
    to = unlist(strsplit(gsub(" ", "", gsub(" tunnels lead to valves | tunnel leads to valve ", "", x[[1]][2])), ","))
    ins[[ii]] = list(valve = valve, flow = flow, to = to)
  }
  
  fr = unlist(lapply(ins, function(x) setNames(x$flow, x$valve)))
  mv = unlist(lapply(ins, function(x) setNames(x$to, rep(x$valve, length(x$to)))))
  tar = names(fr[fr > 0])
  
  return(list(fr = fr, mv = mv, tar = tar))
}

._map_vlv = function(moves) {
  nms = unique(names(moves))
  sp = vector("list", length(nms))
  names(sp) = nms
  
  for (vlv in nms) {
    out = vector("integer")
    
    for (dest in nms) {
      run = TRUE
      tmp_vlv = vlv
      cnt = 0
      if (vlv == dest) {
        out = c(out, 0)
        names(out)[length(out)] = dest
      } else {
        while (run) {
          cnt = cnt + 1
          if (dest %in% moves[names(moves) %in% tmp_vlv]) {
            out = c(out, cnt)
            names(out)[length(out)] = dest
            run = FALSE
          } else {
            tmp_vlv = unname(moves[names(moves) %in% tmp_vlv])
          }
        }
      }
      
    }
    sp[[vlv]] = out
  }
  return(do.call(rbind, sp))
}

#' Credit to https://github.com/plannapus/Advent_of_Code for inspiring me to
#'  use recursion
._open_vlvs = function(cv, t, vlvs, dist, fr, rel) {
  res = list()
  from = cv[length(cv)]
  
  for (vlv in vlvs) {
    tmp_path = c(cv, vlv) 
    
    if (dist[from, vlv] < t) {
      tmp_rel = unname(fr[names(fr) == vlv]) * (t - (dist[from, vlv] + 1))
      res[[length(res)+1]] = list(tmp_path, rel + tmp_rel)
      if (length(vlvs[vlvs != vlv]) > 0) res = c(res, ._open_vlvs(tmp_path, t - (dist[from, vlv] + 1), vlvs[vlvs != vlv], dist, fr, rel + tmp_rel))
    }
  }
  return(res)
}
