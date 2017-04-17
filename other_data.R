library(dplyr)
library(tidyr)
library(data.table)
# stations = read.csv("Stations.csv")
# station_complexes = read.csv("StationComplexes.csv")
# stop_times = read.csv("stop_times.txt")
# mta_performance = read.csv("/Users/rezarad/Google Drive/NYC Data Science Academy/Projects/Project 1/NYC_MTA/MTA_Performance_Data/MTA_Performance_NYCT.csv")

# set data directory
data_dir = "~/data/nyc_mta/"

# Merge all fare files into one dataframe
fares_dir = "/home/reza/Stardust/server/data/nyc_mta/fares" # Directory of fares data
fares_files = paste(fares_dir, list.files(fares_dir), sep="/") # list of fares data files

fread_add_date_fares = function(file) {
  fares_data = fread(file, skip = 2)
  fares_data = data.table(fares_data, date_range = read.csv(file, nrows = 1)[[2]]) # append date of data file to the merged data 
}

mylist = lapply(fares_files, fread_add_date_fares) # create a list of data.tables 
fares_dt = rbindlist(mylist, use.names = TRUE, fill = TRUE) # merge the data.tables into one data.table


# Merge all turnstile files into one dataframe
turnstile_dir = "/home/reza/Stardust/server/data/nyc_mta/turnstile" # Directory of turnstile data
turnstile_files = paste(turnstile_dir, list.files(turnstile_dir), sep="/") # list of turnstile data files

mylist = lapply(turnstile_files, fread) # create a list of data.tables 
turnstile_dt = rbindlist(mylist, use.names = TRUE, fill = TRUE) # merge the data.tables into one data.table


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
