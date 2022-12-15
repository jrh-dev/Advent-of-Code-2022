#' @export
solve_p1 = function(input) {
    p = ._parse_input(input)
    idx_sum = 0
    
    for (ii in seq_len(length(p$lhs))) {
        l = ._parse_line(p$lhs[ii])
        r = ._parse_line(p$rhs[ii])
    
        if (._is_ord(l,r)) idx_sum = idx_sum + ii
    }

    return(idx_sum)
}

#' @export
solve_p2 = function(input) {
    p = ._parse_input(input)
    p = c(p$lhs, p$rhs)
    return(prod(._sort(p,2,1), ._sort(p,6,2)))
}

._parse_input = function(input) {
    input = input[input != ""]
    len = length(input)
    lhs = input[seq(1, len, 2)]
    rhs = input[seq(2, len, 2)]
    return(list(lhs = lhs, rhs = rhs))
}

._parse_line = function(line) {
    return(as.list(rjson::fromJSON(line, simplify = FALSE)))
}

._is_ord = function(l,r) {
    
    if (length(l) == 0 & length(r) == 0) {
        return(NA)
    } else if (length(l) == 0) {
        return(TRUE)
    } else if (length(r) == 0) {
        return(FALSE)
    }
    
    if (all(is.numeric(l[[1]]), is.numeric(r[[1]]))) {
        if (l[[1]] < r[[1]]) {
          return(TRUE)
        } else if (l[[1]] > r[[1]]) {
          return(FALSE)
        } else {
          l[[1]] = r[[1]] = NULL
          return(._is_ord(l, r))
        }
    }
    
    if (all(is.list(l[[1]]), is.list(r[[1]]))) {
        tmp = ._is_ord(l[[1]],r[[1]])
        if (is.na(tmp)) {
            l[[1]] = r[[1]] = NULL
            return(._is_ord(l,r))
        } else {
            return(tmp)
        }
    }
    
    if (is.numeric(l[[1]]) & is.list(r[[1]])) {
        l[[1]] <- list(l[[1]])
        return(._is_ord(l,r))
    }
    
    if (is.list(l[[1]]) & is.numeric(r[[1]])) {
        r[[1]] <- list(r[[1]])
        return(._is_ord(l,r))
    }
}

._sort = function(input, n, offset) {
    s = sapply(input, function (lhs) {
        l = ._parse_line(lhs)
        r = as.list(as.list(n))
        return(._is_ord(l,r))
        })
    return(sum(s) + offset)
}
