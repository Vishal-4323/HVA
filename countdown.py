import datetime

def get_user_birthday(now):
    day = int(input("Give your birthday date "))
    month = int(input("Give your birthday month "))
    year = now.year
    birthday = datetime.date(year, month, day)
    return birthday

def calc_dates(original_date, now):
    this_year = datetime.datetime(now.year, original_date.month, original_date.day)
    
    if this_year < now:
        this_year = datetime.datetime(now.year + 1, original_date.month, original_date.day)
    
    date = this_year - now
    days = date.days
    hours, remainder = divmod(date.seconds, 3600)
    minutes, seconds = divmod(remainder, 60)
    
    return days, hours, minutes, seconds

today = datetime.datetime.today()
bday = get_user_birthday(today)
countdown = calc_dates(bday, today)

if today.day == bday.day and today.month == bday.month:
    print("Happy Birthday!")
else:
    print("Your birthday is in {} days, {} hours, {} minutes, and {} seconds.".format(countdown[0], countdown[1], countdown[2], countdown[3]))
