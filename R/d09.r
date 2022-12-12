
input = strsplit(readLines("data/d09.txt", warn = FALSE), " ")

#' @export 
solve = function(input, return_knots) {
    len = sum(sapply(input, function(x) as.integer(x[2])))
    ins = vector("integer", len)
    pos = 1

    # parse position of lead knot throughout
    for (moves in input) {
        dir = moves[1]
        int = as.integer(moves[2])
        ins[pos:(pos+int)] = dir
        pos = pos + int
    }

    pos = 1
    hpos = tpos = vector("list", len)
    tpos = c(tpos, list())
    hx=hy=0

    for (ii in seq_len(length(ins)-1)) {
        if (ins[ii] == "R") hx = hx + 1
        if (ins[ii] == "L") hx = hx - 1
        if (ins[ii] == "U") hy = hy + 1
        if (ins[ii] == "D") hy = hy - 1
        hpos[[ii]] = c(hx, hy)
    }

    ans = c()

    # loop through knots offsetting position against predecessor
    for (knot in 1:9) {
        if (knot != 1) hpos = tpos
        tpos[[1]] = c(0,0)
        for (ii in seq_len(length(hpos))) {
            difs = hpos[[ii]] - tpos[[ii]]
            if (any(abs(difs) > 1)) {
                if (difs[1] > 0 & difs[2] == 0) {
                    tpos[[ii]] = tpos[[ii+1]] = tpos[[ii]] + c(1,0)
                } else if (difs[1] > 0 & difs[2] > 0) {
                    tpos[[ii]] = tpos[[ii+1]] = tpos[[ii]] + c(1,1)
                } else if (difs[1] > 0 & difs[2] < 0) {
                    tpos[[ii]] = tpos[[ii+1]] = tpos[[ii]] +  c(1,-1)
                } else if (difs[1] < 0 & difs[2] == 0) {
                    tpos[[ii]] = tpos[[ii+1]] = tpos[[ii]] + c(-1,0)
                } else if (difs[1] < 0 & difs[2] < 0) {
                    tpos[[ii]] = tpos[[ii+1]] = tpos[[ii]] + c(-1,-1)
                } else if (difs[1] < 0 & difs[2] > 0) {
                    tpos[[ii]] = tpos[[ii+1]] = tpos[[ii]] + c(-1,1)
                } else if (difs[1] == 0 & difs[2] >= 1) {
                    tpos[[ii]] = tpos[[ii+1]] = tpos[[ii]] + c(0,1)
                } else if (difs[1] == 0 & difs[2] <= -1) {
                    tpos[[ii]] = tpos[[ii+1]] = tpos[[ii]] + c(0,-1)
                }
            } else {
                tpos[[ii+1]] = tpos[[ii]]
            }
        }
        if (knot %in% return_knots) {
            ans = c(ans, nrow(unique(do.call(rbind, tpos))))
        }
    }
    return(ans)
}
