box::use(R6)

clean = R6$R6Class("clean",
    public = list(
        lhs = NULL,
        rhs = NULL,
        lhsa = NULL,
        lhsb = NULL,
        rhsa = NULL,
        rhsb = NULL,
        contain = NULL,
        overlap = NULL,
        initialize = function(input = NA) {
            self$lhs = self$build_hs(input, 1)
            self$rhs = self$build_hs(input, 2)
            self$lhsa = as.integer(self$lhs[[1]])
            self$lhsb = as.integer(self$lhs[[2]])
            self$rhsa = as.integer(self$rhs[[1]])
            self$rhsb = as.integer(self$rhs[[2]])
            self$contain = sum(self$contained(self$lhsa, self$lhsb, self$rhsa, self$rhsb))
            self$overlap = sum(self$overlapped(self$lhsa, self$lhsb, self$rhsa, self$rhsb))
        },
        build_hs = function(val, side) {
            hsa = hsb = vector(mode = "character", length = length(val))

            for (ii in seq_len(length(val))) {
                hs = strsplit(val[ii], ",")[[1]][side]
                hsa[ii] = strsplit(hs, "-")[[1]][1]
                hsb[ii] = strsplit(hs, "-")[[1]][2]
            }

            return(list(hsa, hsb))
        },
        contained = function(lhsa, lhsb, rhsa, rhsb) {
            return(
                (self$between(lhsa, rhsa, rhsb) & self$between(lhsb, rhsa, rhsb)) |
                (self$between(rhsa, lhsa, lhsb) & self$between(rhsb, lhsa, lhsb))
            )            
        },
        overlapped = function(lhsa, lhsb, rhsa, rhsb) {
            return(!(pmax(lhsa, lhsb) < pmin(rhsa, rhsb) | pmin(lhsa, lhsb) > pmax(rhsa, rhsb)))
        },
        between = function(x, y, z) {
            return(x >= y & x <= z)
        }
    )
)

#' @export
solve = function(input) {
    sol = clean$new(input)
    return(sol)
}
