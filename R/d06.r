#' @export
solve = function(s, len) {
    for (ii in seq_len(length(s) - (len - 1))) {
        if (length(unique(s[(ii):(ii + (len - 1))])) == len) break
    }
    return(ii + (len - 1))
}
