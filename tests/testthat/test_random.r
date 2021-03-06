context('bed_random')

genome <- tibble::frame_data(
  ~chrom, ~size,
  "chr1", 5000,
  "chr2", 1e6
) %>% mutate(chrom = as.character(chrom))

test_that("returns correct number of intervals", {
  res <- bed_random(genome, n = 1e6)
  expect_equal(nrow(res), 1e6)   
})

test_that("returns correctly sized intervals", {
  len <- 1000
  res <- bed_random(genome, length = len, n = 1e6)
  expect_true(all(res$end - res$start == len))
})

test_that("all ends are less or equal to than chrom size", {
  len <- 1000
  res <- bed_random(genome, length = len, n = 1e6) %>%
    mutate(chrom = as.character(chrom)) %>%
    left_join(genome, by = 'chrom')
  expect_true(all(res$end <= res$size))
})
