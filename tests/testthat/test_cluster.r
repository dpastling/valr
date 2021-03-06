context("bed_cluster")

# https://github.com/arq5x/bedtools2/blob/master/test/cluster/test-cluster.sh
 
x <- tibble::frame_data(
  ~chrom, ~start,  ~end,    ~name, ~id, ~strand,
  "chr1", 72017,   884436,  'a',   1,   '+',
  "chr1", 72017,   844113,  'b',   2,   '+',   
  "chr1", 939517,  1011278, 'c',   3,   '+',   
  "chr1", 1142976, 1203168, 'd',   4,   '+',   
  "chr1", 1153667, 1298845, 'e',   5,   '-',   
  "chr1", 1153667, 1219633, 'f',   6,   '+',   
  "chr1", 1155173, 1200334, 'g',   7,   '-',   
  "chr1", 1229798, 1500664, 'h',   8,   '-',   
  "chr1", 1297735, 1357056, 'i',   9,   '+',   
  "chr1", 1844181, 1931789, 'j',   10,  '-'
)

test_that("basic cluster works", {
  res <- bed_cluster(x)
  # test number of groups in output
  expect_equal(length(unique(res$.id)), 5)
})

test_that("stranded cluster works", {
  res <- bed_cluster(x, strand = TRUE)
  # test number of groups in output
  expect_equal(length(unique(res$.id)), 7)
})
