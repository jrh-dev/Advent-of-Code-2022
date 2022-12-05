#' @export
solve = function(input, crane =  c(9000, 9001)) {
    stack = ._parse_stack(input)
    move = ._parse_mvs(input)

    for (ii in seq_len(length(move))) {
        stack = ._mk_mv(stack, move[[ii]][1], move[[ii]][2], move[[ii]][3], crane)
    }
    
    return(paste0(sapply(stack, function(x) x[length(x)]), collapse = ""))
}

._parse_stack = function(input) {
    box_pos = input[1:(which(input == "")-2)]
    n_stack = unlist(strsplit(input[which(input == "")-1], ""))
    n_stack = n_stack[n_stack != " "]
    stacks = vector("list", length(n_stack))
    typ_idx = c(2, seq(6, 4 * (length(n_stack)), 4))

    for (e in box_pos[length(box_pos):1]) {
        for (ii in seq_len(length(typ_idx))) {
            content = substr(e, typ_idx[ii], typ_idx[ii])
            if (content != " ") stacks[[ii]] = c(stacks[[ii]], content)
        }
    }
    
    return(stacks)
}

._parse_mvs = function(input) {
    mv = input[(which(input == "")+1):length(input)]
    mv = strsplit(gsub("move |from | to", "", mv), " ")
    mv = lapply(mv, as.integer)
    return(mv)
}

._mk_mv = function(start, move, from, to, crane = c(9000, 9001)) {
    if (crane == 9000) {
        start[[to]] = c(start[[to]], start[[from]][(length(start[[from]])):(length(start[[from]]) - move + 1)])
    } else {
         start[[to]] = c(start[[to]], start[[from]][(length(start[[from]]) - move + 1):(length(start[[from]]))])
    }
    
    if ((length(start[[from]]) - move) == 0) {
        start[[from]] = vector(mode="character", length = 0)
    } else {
        start[[from]] = start[[from]][1:(length(start[[from]]) - move)]
    }   

    return(start)
}
