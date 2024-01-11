library(tidyverse)
library(ggplot2)

#for days in the week analysis
week <- df_cleaned %>%
 group_by(member_casual) %>%
 count(wday, sort = TRUE)

ggplot(week, mapping=aes(x=wday, y=n)) + 
  geom_bar(stat='identity',fill='#33BBC5') +
  labs(title='number of rides in terms of days in a week', caption='by Trần Hiếu My')

#for session by hour analysis
df_hour <- data.frame(df_cleaned$started_at)%>%
  mutate(df_hour, start_hour=hour(df_cleaned$started_at)) %>%
  mutate(df_hour, membership=df_cleaned$member_casual)

start_time <- df_hour %>% 
  group_by(membership, start_hour) %>%
  count(start_hour, sort=TRUE)

ggplot(start_time, mapping=aes(x=start_hour, y=n, color=membership)) + 
  geom_point() +
  geom_smooth() +
  labs(title='number of rides in terms of hours', subtitle='divided by membership', caption='by Trần Hiếu My')

time <- df_hour %>%
  group_by(start_hour) %>%
  count(start_hour, sort=TRUE)

ggplot(time, mapping=aes(x=start_hour, y=n)) + 
  geom_point(color="#33BBC5") +
  geom_smooth(color='#24A19C') +
  labs(title='number of rides in terms of hours',
       subtitle='in a day',
       caption='by Trần Hiếu My')

#for session length analysis
x <- data.frame(
  session_length=difftime(df_cleaned$ended_at,df_cleaned$started_at, units="secs"),
  member_casual=df_cleaned$member_casual) 
x <- x %>%
  mutate(x, length=as.numeric(session_length))

length_statistics <- data.frame(variable='length', max=max(x$length),
                                  min=min(x$length),
                                  mean=mean(x$length),
                                  standard_deviation=sd(x$length))

ggplot(data=x) +
  geom_histogram(aes(x=length, fill=member_casual), breaks=(c(seq(61,2000,by=100))))  +
  labs(title='typical distribution of session length',
       subtitle='divided by membership',
       caption='by Trần Hiếu My')

x <- x %>% 
  mutate(x, wday=df_cleaned$wday)

ggplot(data=x) +
  geom_histogram(aes(x=length, fill=wday), breaks=(c(seq(61,2000,by=100)))) +
  labs(title='typical distribution of session length',
       subtitle='divided into days in a week',
       caption='by Trần Hiếu My')

x_casual <- subset(x, member_casual == "casual")
ggplot(data=x_casual) +
  geom_histogram(aes(x=length), breaks=(c(seq(61,2000,by=100))))  +
  labs(title='typical distribution of session length',
       subtitle='casual riders',
       caption='by Trần Hiếu My')

x_member <- subset(x, member_casual != "casual")
ggplot(data=x_member) +
  geom_histogram(aes(x=length, fill=member_casual),
                 breaks=(c(seq(61,2000,by=100))), fill="#24A19C")  +
  labs(title='typical distribution of session length',
       subtitle='member riders',
       caption='by Trần Hiếu My')
