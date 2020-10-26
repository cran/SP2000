context("Using API keys")

test_that("API keys can be passed as search_* functions", {
  set_search_key("063198343fec41479da3478755fb9a81")
  familyid <- search_family_id(query = "Cyprinidae")
  expect_match(familyid$Cyprinidae$data$record_id, "bf72e220caf04592a68c025fc5c2bfb7")
})
