box::use(
  glue[glue]
)

#' @export
solve = function(input, target) {
  m = v = input
  v[v != 0] = Inf
  it = 0
  end = FALSE
  
  while (it < 10000) {
    it = it + 1
    opts = ._options(m,v)
    if (sum(sapply(opts, is.null)) == 4) {
      if (m[opts[[1]][1],opts[[1]][2]] == target) {
        break
      } else {
        v[opts[[1]][1],opts[[1]][2]] = m[opts[[1]][1],opts[[1]][2]] = Inf
      }
    }
    
    for (ii in 2:5) {
      if (is.null(opts[[ii]])) next
      cx = opts[[1]][1]
      cy = opts[[1]][2]
      x = opts[[ii]][1]
      y = opts[[ii]][2]
      
      if (m[cx,cy] == (target-1) & m[x,y] == target) {
        end = TRUE
        break
      }
      v[x,y] = min(v[cx,cy] + 1, v[x,y])
    }
    
    if (end) break else v[cx,cy] = m[cx,cy] = Inf
  }
  return(glue("Shortest path is {v[opts[[1]][1],opts[[1]][2]] + 1}"))
}

#' @export
parse_input = function(input, invert = FALSE) {
  cols = nchar(input[1])
  rows = length(input)
  
  dat = unlist(strsplit(input, ""))
  dat = unname(unlist(sapply(dat, function(x) {
    if (x == "E") {
      o = 27
    } else if (x == "S") {
      o = 0
    } else {
      o = which(letters == x)
    }
    return(o)
  })))
  
  if (invert) dat = max(dat) - dat
  
  return(matrix(dat, nrow=rows, ncol=cols, byrow=TRUE))
}

._options = function(m, v) {
  cur = which(v == min(v), arr.ind = T)[1,]
  u = cur + c(-1, 0)
  d = cur + c(1,0)
  l = cur + c(0,-1)
  r = cur + c(0,1)
  opts = vector("list",5)
  rows = nrow(m)
  cols = ncol(m)

  opts[[1]] = cur
  if (u[1] %in% c(1:rows)) if (diff(c(m[cur[1],cur[2]],m[u[1],u[2]])) <= 1) opts[[2]] = u
  if (d[1] %in% c(1:rows)) if (diff(c(m[cur[1],cur[2]],m[d[1],d[2]])) <= 1) opts[[3]] = d
  if (l[2] %in% c(1:cols)) if (diff(c(m[cur[1],cur[2]],m[l[1],l[2]])) <= 1) opts[[4]] = l
  if (r[2] %in% c(1:cols)) if (diff(c(m[cur[1],cur[2]],m[r[1],r[2]])) <= 1) opts[[5]] = r
  
  return(opts)
}
