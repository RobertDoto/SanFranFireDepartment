library(data.table)
library(lubridate)

start_time <- Sys.time()

# read the CSV file into a data.table
data_1 <- fread("C:/Users/PC/Downloads/fire-calls-truncated-comma-no-spaces.csv")

# define the "mdy_hm" and "mdy" column names to correct
datetime_columns_mdyhms <- c(
                                 "Received_DtTm",
                                 "Entry_DtTm",
                                 "Dispatch_DtTm",
                                 "Response_DtTm",
                                 "On_Scene_DtTm",
                                 "Transport_DtTm",
                                 "Hospital_DtTm",
                                 "Available_DtTm"
                            )                               

datetime_columns_mdy <- c(
                                 "Watch_Date",
                                 "Call_Date"
                         )

# create a function to parse and format columns in mdy_hms format
parse_format_datetime_mdyhms <- function(data, col_names) {
                                                           for (col_name in col_names) {
                                                                                       data[[col_name]] <- mdy_hm(data[[col_name]])
                                                                                       data[[col_name]] <- format(data[[col_name]], "%m-%d-%Y %H:%M:%S")
                                                           }
                                                           return(data)
                                                           }

# call the function for mdy_hm columns
data_1_corrected <- parse_format_datetime_mdyhms(data_1, datetime_columns_mdyhms)


# create a function to parse and format columns in mdy format
parse_format_datetime_mdy <- function(data, col_names) {
                                                        for (col_name in col_names) {
                                                                                    data[[col_name]] <- mdy(data[[col_name]])
                                                                                    data[[col_name]] <- format(data[[col_name]], "%m-%d-%Y %H:%M:%S")
                                                        }
                                                        return(data)
                                                        }


# call the function for mdy columns
data_1_corrected <- parse_format_datetime_mdy(data_1_corrected, datetime_columns_mdy)


#write the correct data to a new file, the original should remain intact 
fwrite(data_1_corrected, "C:/Users/PC/Downloads/fire-calls-truncated-comma-no-spaces-corrected.csv")



end_time <- Sys.time()
runtime <- end_time - start_time
print(runtime)


