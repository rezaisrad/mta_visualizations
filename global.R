## global.R ##
library(RSQLite)
library(dplyr)
library(dbplyr)
library(tidyr)

data_dir = paste(getwd(),"data", sep = "/") 

dbname = "db.sqlite"

## connect to database
conn = DBI::dbConnect(SQLite(), dbname)
## list tables
dbListTables(conn)
## set tables as dbplyr objects
turnstile_tbl = tbl(conn,"turnstile_data")
fares_tbl = tbl(conn,"fares_data")


fares_by_date = fares_tbl %>% 
  select(-REMOTE) %>%
  group_by(STATION)

fares_by_date = collect(fares_by_date) %>% 
  separate(DATE_RANGE, c("Start_Date", "End_Date"), sep="-", remove = TRUE) %>% 
  mutate(Week_Of = as.Date(Start_Date,format = "%m/%d/%Y")) 



## disconnect
dbDisconnect(conn)


# fares_tbl = fares_tbl %>% 
#   rename(10-T    = `10 TRIP`,
#          14-D    = `14 DAY`,
#          1-D     = `ONE DAY FUNPASS`,
#          2-T     = `2 TRIP`,
#          30-D    = `30 DAY`,
#          7-D     = `7 DAY`,
#          ADA     = AMERICANS_WITH_DISABLITIES_ACT,
#          AFAS    = ADA_FARECARD_ACCESS_SYSTEM,
#          EXP     = EXPRESS,
#          MR.EZPAY.UNL = EASY_PAY,
#          FF      = FULL_FARE,
#          MC      = METROCARD,
#          MR      = MAIL_AND_RIDE,
#          MTHLY   = MONTHLY,
#          RFM     = REDUCED_FARE_MEDIA,
#          RR      = RAIL_ROAD,
#          SEN/DIS = SENIOR_CITIZEN_DISABLED,
#          SPEC    = SPECIAL,
#          TCMC    = TRANSIT_CHECK_METROCARD,
#          TKT     = TICKET,
#          UNL     = UNLIMITED,
#          XBUS    = EXPRESS_BUS,
#          STUDENT = STUDENT_USAGE)
  


