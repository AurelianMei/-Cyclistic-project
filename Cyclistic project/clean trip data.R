library(tidyverse)
#combine data from the last one year into a central data frame
df = rbind(X202212_divvy_tripdata, 
           X202301_divvy_tripdata,
           X202302_divvy_tripdata,
           X202303_divvy_tripdata,
           X202304_divvy_tripdata,
           X202305_divvy_tripdata,
           X202306_divvy_tripdata,
           X202307_divvy_tripdata,
           X202308_divvy_tripdata,
           X202309_divvy_tripdata,
           X202310_divvy_tripdata,
           X202311_divvy_tripdata)
glimpse(df)
#clean data by emitting columns containing null values
df_cleaned <- drop_na(df, c(start_station_name, end_station_name))

#add a column containing duration of each trip
df_cleaned <- df_cleaned %>%
  mutate(df_cleaned, session_length=difftime(ended_at,started_at, units="secs"))

#turn session_length into hh:mm:ss
df_cleaned$session_length <- hms::hms(seconds_to_period(df_cleaned$session_length))

#emit records saying rides end before it starts
df_cleaned <- subset(df_cleaned, session_length>60)

#find day of the week 
df_cleaned <- df_cleaned %>% mutate(wday=wday(started_at, label=TRUE))

#export the cleaned data into csv
write.csv(df_cleaned, "C:\\Users\\HOME\\OneDrive\\Documents\\Cyclistic project\\cleaned_data.csv", row.names=FALSE)
