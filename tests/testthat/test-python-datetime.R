context("datetime")

test_that("R dates can be converted to / from Python datetimes", {
  skip_if_no_python()

  before <- Sys.Date()
  after <- py_to_r(r_to_py(before))

  expect_equal(
    as.numeric(as.POSIXct(before)),
    as.numeric(as.POSIXct(after))
  )
})

test_that("R times can be converted to / from Python datetimes", {
  skip_if_no_numpy()

  before <- Sys.time()
  attr(before, "tzone") <- "UTC"
  after <- py_to_r(r_to_py(before))

  expect_equal(as.numeric(before), as.numeric(after))
})

test_that("lists of times are converted", {
  skip_if_no_python()

  dates <- replicate(3, Sys.Date(), simplify = FALSE)
  expect_equal(
    py_to_r(r_to_py(dates)),
    dates
  )

})

test_that("R times are converted to NumPy datetime64", {
  skip_if_no_numpy()

  np <- import("numpy", convert = TRUE)

  before <- rep(Sys.time(), 3)
  converted <- r_to_py(before)
  expect_true(np$issubdtype(converted$dtype, np$datetime64))

  after <- py_to_r(converted)
  expect_equal(
    as.numeric(as.POSIXct(before)),
    as.numeric(as.POSIXct(after))
  )

})
