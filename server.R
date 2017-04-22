## server.R ##
source("./helpers.R")

dbname = "db.sqlite"
tblname = "turnstile_data"

function(input, output, session) {
  
  conn = dbConnector(session, dbname = dbname)
  
  output$fares_data = dataTableOutput(fares_by_date)
}

