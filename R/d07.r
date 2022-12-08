box::use(
    dplyr[group_by, ungroup, summarise]
)

#' @export
solve_p1 = function(input) {
    dt = ._parse_input(input)
    return(sum(dt[dt$size < 100000,]$size))
}

#' @export
solve_p2 = function(input, req_space) {
    dt = ._parse_input(input)
    req_space = abs(40000000 - dt[dt$path == "/",]$size)
    return(min(dt[dt$size > req_space,]$size))
}

._parse_input = function(input) {
    paths = vector("list", length(input))
    size = vector("list", length(input))

    wd = NULL

    dt = data.frame(path=NULL,size=NULL) 

        for (ii in seq_len(length(input))) {
          x = input[ii]
          if (substr(x,1,7) == "$ cd ..") {
            wd = wd[1:(length(wd)-1)]
          } else if (substr(x,1,4) == "$ cd") {
            wd = c(wd, substr(x,6,nchar(x)))
          } else if (grepl("[[:digit:]]",substr(x,1,1))) {
            tmp = unlist(strsplit(x, " "))
            for (jj in 1:length(wd)) {
              dt = rbind(dt, data.frame(path=paste0(wd[1:jj],collapse = "/"),size=tmp[1]))
            }
          } else {
            next
          }
        }

        dt$size = as.integer(dt$size)
        dt = group_by(dt, path)
        dt = summarise(dt, size = sum(size))
        
        return(dt)
}
