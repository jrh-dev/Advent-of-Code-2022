dat = readLines("data/d15.txt", warn = FALSE)

u = vector("list", length(dat))
# x is across

for (ii in seq_len(length(dat))) {
  unpack = as.numeric(unlist(strsplit(gsub(":", ",", gsub("Sensor at x=| y=| closest beacon is at x=", "", dat[ii])), ",")))
  u[[ii]] = c(unpack, sum(abs(diff(c(unpack[1],unpack[3]))),abs(diff(c(unpack[2],unpack[4])))))
}

out = c()
excl = c()

in_row = 2000000

found = 0

for (zz in seq_len(length(u))) {
  t = u[[zz]]
  d = t[5]
  if (t[2] == in_row) excl = c(excl, t[1])
  if (t[4] == in_row) excl = c(excl, t[3])
  
  if (in_row %in% (t[2]-d):(t[2]+d)) { # this will be the if ie if 10 in y_range
    d - abs(diff(c(in_row,t[2]))) + 1
    on_line = seq(1,(d*2)+2,2)[((d - abs(diff(c(in_row,t[2])))) + 1)] # 10 will change to target line
    # out[out %in% ((t[1] - floor(on_line / 2 )):(t[1] + floor(on_line / 2 )))] = Inf
    out = c(out,((t[1] - floor(on_line / 2 )):(t[1] + floor(on_line / 2 ))))
  }
}

length(unique(out[!out %in% excl]))
  