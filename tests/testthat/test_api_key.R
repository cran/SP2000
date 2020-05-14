context("Using API keys")

test_that("API keys can be passed as search_* functions", {
  set_search_key("063198343fec41479da3478755fb9a81")
  familyID <- search_familyID(query = "Cyprinidae")
  expect_match(familyID$familyIDs, "bf72e220caf04592a68c025fc5c2bfb7")

  taxonID <- search_taxonID(query = "Uncia uncia",name = "scientificName")
  expect_match(taxonID$scientificName, "Uncia uncia")

  checklist <- search_checklist(query="025397f9-9891-40a7-b90b-5a61f9c7b597")
  expect_match(checklist$taxonTree$kingdom, "Animalia")
})
