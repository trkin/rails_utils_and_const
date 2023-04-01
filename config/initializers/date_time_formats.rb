# https://github.com/duleorlovic/rails_helpers_and_const/blob/main/config/initializers/date_time_formats.rb

# included DateTime.now.to_s :db
# 2022-09-29 11:19:22

# 9th November 1988
Date::DATE_FORMATS[:date_ordinalize] = ->(date) { date.strftime("#{date.day.ordinalize} %b %Y") }

# 1988-2-1 # Feb first 1988
Date::DATE_FORMATS[:simple_date] = ->(date) { date.strftime('%Y-%m-%d') }
# 12:50 PM
Time::DATE_FORMATS[:at_time] = ->(time) { time.strftime('%l:%M %p') }
