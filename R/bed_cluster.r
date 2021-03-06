#' Cluster neighboring intervals.
#' 
#' Returned \code{data_frame} contains a new \code{.id} column that can be used for
#' grouping along with \code{chrom}. Default \code{max_dist} of 0 means that
#' overlapping and book-ended intervals will be clustered.
#' 
#' @param x tbl of intervals
#' @param max_dist maximum distance between clustered intervals.
#' @param strand cluster features on same strand
#'   
#' @return \code{data_frame}
#'  
#' @seealso \url{http://bedtools.readthedocs.org/en/latest/content/tools/cluster.html} 
#'
#' @examples
#' x <- tibble::frame_data(
#'  ~chrom, ~start, ~end,
#'  "chr1", 100,  200,
#'  "chr1", 180,  250,
#'  "chr1", 250,  500,
#'  "chr1", 501,  1000
#' )
#' 
#' bed_cluster(x)
#' 
#' @export
bed_cluster <- function(x, max_dist = 0, strand = FALSE) {

  res <- group_by(x, chrom)
  
  if (strand)
    res <- group_by(res, strand, add = TRUE)
    
  res <- merge_impl(res, max_dist)
    
  res <- res %>%
    group_by(chrom) %>%
    mutate(.id = dense_rank(.merge_id)) %>%
    select(-.merge_id, -.overlap) %>%
    ungroup()
  
  res
}
