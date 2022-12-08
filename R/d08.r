#' @export
solve_p1 = function(d, x, y) {
  d = matrix(d, nrow=x, ncol=y, byrow=TRUE)
  r = matrix(0, nrow=x, ncol=y, byrow=TRUE)

  for (xx in 1:x){
    for (yy in 1:y){

      val = d[xx,yy]

      if (xx %in% c(1,x) | yy %in% c(1,y)) {
        r[xx,yy] = 1
      } else if(
        any(
        all(d[1:(xx-1),yy] < val),
        all(d[(xx+1):x,yy] < val),
        all(d[xx,1:(yy-1)] < val),
        all(d[xx,(yy+1):y] < val)
        )
      ) {
        r[xx,yy] = 1
      }
    }
  }
  return(sum(r))
}

#' @export
solve_p2 = function(d, x, y) {
  d = matrix(d, nrow=x, ncol=y, byrow=TRUE)
  r = matrix(0, nrow=x, ncol=y, byrow=TRUE)

  # [x,y]
  for (xx in 1:x){
    for (yy in 1:y){
      val = d[xx,yy]

      if (!(xx %in% c(1,x)) & !(yy %in% c(1,y))) r[xx,yy] = 1
      if (r[xx,yy] == 1) {
        r[xx,yy] = r[xx,yy] * ._view(rev(d[1:(xx-1),yy]),val)
        r[xx,yy] = r[xx,yy] * ._view(d[(xx+1):x,yy],val)
        r[xx,yy] = r[xx,yy] * ._view(rev(d[xx,1:(yy-1)]),val)
        r[xx,yy] = r[xx,yy] * ._view(d[xx,(yy+1):y],val)
      }
    }
  }
  return(max(r))
}

._view = function(x, y) {
  if (any(x >= y)) {
    out = which(x >= y)[1]
  } else {
    out = length(x)
  }
  return(out)
}
