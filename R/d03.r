#' @export
solve_p1 = function(data) {
    lens = unname(sapply(data, nchar) / 2)

    lhs = sapply(seq_len(length(data)), function(x) {
        return(strsplit(substr(data[x], 1, lens[x]), ""))
    })

    rhs = sapply(seq_len(length(data)), function(x) {
        return(strsplit(substr(data[x], lens[x] + 1, lens[x] * 2), ""))
    })

    it = 0

    for (ii in seq_len(length(data))) {
        it = it + sum(
            which(letters == lhs[[ii]][lhs[[ii]] %in% rhs[[ii]]]),
            which(LETTERS == lhs[[ii]][lhs[[ii]] %in% rhs[[ii]]]) + 26,
            na.rm = TRUE
        )
    }

    return(it)
}

#' @export
solve_p2 = function(data) {
    data = strsplit(data, "")
    it = 0

    for (ii in seq_len(length(data))) {
        if (ii %% 3 != 0) {
            next
        }
        badge_is = NA

        for (jj in seq_len(length(data[[ii]]))) {
            try_let = data[[ii]][jj]

            if (try_let %in% data[[ii - 1]] & try_let %in% data[[ii - 2]]) {
                badge_is = try_let
            } else {
                next
            }
        }

        it = it + sum(
            which(letters == badge_is),
            which(LETTERS == badge_is) + 26,
            na.rm = TRUE
        )
    }
    return(it)
}
