#' @export
solve = function(input) {
    con = 0
    ovr = 0

    for (line in input) {
    p = as.integer(unlist(strsplit(unlist(strsplit(line, ",")), "-")))

    if ((._between(p[1], p[3], p[4]) & ._between(p[2], p[3], p[4])) |
        (._between(p[3], p[1], p[2]) & ._between(p[4], p[1], p[2]))) con = con + 1

    if (!(max(p[1],p[2]) < min(p[3],p[4]) | min(p[1],p[2]) > max(p[3],p[4]))) ovr = ovr + 1
    }

    return(list(contain = con, overlap = ovr))
}

._between = function(x, y, z) return(x >= y & x <= z)