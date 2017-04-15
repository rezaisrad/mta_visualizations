library(dplyr)
library(tidyr)
library(data.table)
# stations = read.csv("Stations.csv")
# station_complexes = read.csv("StationComplexes.csv")
# stop_times = read.csv("stop_times.txt")
# mta_performance = read.csv("/Users/rezarad/Google Drive/NYC Data Science Academy/Projects/Project 1/NYC_MTA/MTA_Performance_Data/MTA_Performance_NYCT.csv")
data_dir = "/mnt/stardust/server/data/nyc_mta/"

# Merge all fare files into one dataframe
setwd(paste(data_dir,"fares",  sep="/"))

for (file in list.files()) {
  if (!exists("fares_data")){
    fares_data <- read.csv(file)
  }
  if (exists("fares_data")) {
    temp_data = read.csv(file)
    fares_data = rbind(fares_data, temp_data)
    rm(temp_data)
  }
}

test_fares = merge("fares_140719.txt","fares_140726.txt")

# Merge all turnstile files into one dataframe
setwd(paste(data_dir,"turnstile",  sep="/"))




# data_folders = c("turnstile","fares")

turnstile_dir = paste(data_dir,"turnstile",  sep="/")
turnstile_files = paste(turnstile_dir, list.files(turnstile_dir), sep="/")
turnstile_data = data.table(do.call("rbind", sapply(turnstile_files, read.csv, sep=";")),
                            keep.rownames = TRUE)


fares_dir = paste(data_dir,"fares", sep="/")
fares_files = paste(fares_dir, list.files(fares_dir), sep="/")
fares_data = data.table(do.call("rbind", sapply(fares_files, read.csv, sep=";")),
                            keep.rownames = TRUE)

# for (file in turnstile_files) {
#   if (!exists("turnstile_dataset")){
#     turnstile_dataset <- read.table(file, header=TRUE, sep="\t")
#   }
#   if (exists("turnstile_dataset")){
#     temp_dataset = read.table(file, header=TRUE, sep="\t")
#     turnstile_dataset = rbind(turnstile_dataset, temp_dataset)
#     rm(temp_dataset)
#   }
# }

fares_dir = paste(getwd(),'/fares/', sep="")
fare_files = list.files(fares_dir)
