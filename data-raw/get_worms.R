library(dplyr)
install.packages("worrms")
library(worrms)

species <- get_species()

AphiaID <- character(nrow(species))

for (i in 1:nrow(species)){
  sci_name <- species$scientific_name[i]

  id_result <- tryCatch(
    wm_name2id(sci_name, accepted_only = TRUE),
    error = function(e) NA
  )
  if (!is.null(id_result)){
    AphiaID[i] <- as.character(id_result)
  } else {
    AphiaID[i] <- NA
    warning(paste("Could not find Aphia ID for:", sci_name))
  }
}

species_worms <- species %>%
  mutate(AphiaID = AphiaID)

saveRDS(species_worms, "data-raw/species_worms.rds")
