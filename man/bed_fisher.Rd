% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bed_fisher.r
\name{bed_fisher}
\alias{bed_fisher}
\title{Fisher's test on number of shared and unique intervals.}
\usage{
bed_fisher(x, y, genome, strand = FALSE)
}
\arguments{
\item{x}{tbl of intervals}

\item{y}{tbl of intervals}

\item{genome}{tbl of genome intervals}

\item{strand}{group intervals by strand}
}
\value{
\code{data_frame}
}
\description{
Fisher's test on number of shared and unique intervals.
}
\examples{
x <- tibble::frame_data(
  ~chrom, ~start, ~end,
  "chr1", 10,     20,
  "chr1", 30,     40,
  "chr1", 51,     52,
  "chr2", 10,     40
)

y <- tibble::frame_data(
  ~chrom, ~start, ~end,
  "chr1", 15,     25,
  "chr1", 51,     52,
  "chr2", 35,     60
)

genome <- tibble::frame_data(
  ~chrom, ~size,
  "chr1", 500,
  "chr2", 1000
)

bed_fisher(x, y, genome)

}
\seealso{
http://bedtools.readthedocs.org/en/latest/content/tools/fisher.html
}

