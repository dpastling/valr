#' Sort a tbl of intervals.
#' 
#' Sorting strips groups from the input.
#'
#' @param x tbl of intervals
#' @param by_size sort by interval size
#' @param by_chrom sort within chromosome
#' @param reverse reverse sort order
#' 
#' @seealso \url{http://bedtools.readthedocs.org/en/latest/content/tools/sort.html}
#'
#' @examples
#' x <- tibble::frame_data(
#'    ~chrom, ~start, ~end,
#'    "chr8", 500, 1000,
#'    "chr8", 1000, 5000,
#'    "chr8", 100, 200,
#'    "chr1", 100, 300,
#'    "chr1", 100, 200
#' )
#' 
#' # sort by chrom and start
#' bed_sort(x)
#' 
#' # reverse sort order
#' bed_sort(x, reverse = TRUE)
#' 
#' # sort by interval size
#' bed_sort(x, by_size = TRUE)
#' 
#' # sort by decreasing interval size
#' bed_sort(x, by_size = TRUE, reverse = TRUE)
#' 
#' # sort by interval size within chrom
#' bed_sort(x, by_size = TRUE, by_chrom = TRUE)
#' 
#' @export
bed_sort <- function(x, by_size = FALSE,
                     by_chrom = FALSE, reverse = FALSE) {

  if (by_size) {
    
    res <- x %>% mutate(.size = end - start) 
    
    if (by_chrom) {
       res <- res %>% group_by(chrom) 
    }
    
    if (reverse) {
      res <- res %>% arrange(desc(.size))
    } else {       
      res <- res %>% arrange(.size)
    }
    
    # remove .size column and groups in result
    res <- res %>% select(-.size)
    
  } else {
  
    if (by_chrom) {
       res <- res %>% group_by(chrom) 
    }
    
    # sort by coordinate 
    if (reverse) {
      res <- x %>%
        arrange(chrom, desc(start))
    } else {
      res <- x %>%
        arrange(chrom, start)
    } 
  } 
 
  # remove groups in result 
  res <- res %>% ungroup() %>% as_data_frame
 
  # add `sorted` attribute 
  attr(res, "sorted") <- TRUE
  
  res
}

#' Ask whether tbl is sorted.
#' 
#' @param x tbl of intervals
#' 
#' @export
is_sorted <- function(x) {
  
  sorted_attr <- attr(x, "sorted")
  
  if (is.null(sorted_attr) || ! sorted_attr) {
    return (FALSE)
  } else {
    return (TRUE)
  }
}
