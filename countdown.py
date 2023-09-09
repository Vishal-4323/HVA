import datetime

def get_user_birthday():
    print("When you where born? [DD-MM-YYYY]")
    li = (input()).split('-')
    day = int(li[0])
    month = int(li[1])
    year = int(li[2])
    birthday = datetime.date(year,month,day)
    return birthday

def calc_dates(original_date, now):
    this_year = datetime.datetime(now.year, original_date.month, original_date.day)
    if original_date.month==now.month :
        if original_date.day<now.day : 
            this_year = datetime.datetime(now.year+1, original_date.month, original_date.day)
        else:
            this_year = datetime.datetime(now.year, original_date.month, original_date.day)
    elif original_date.month<now.month :
        this_year = datetime.datetime(now.year+1, original_date.month, original_date.day)
    date = this_year - now
    days = 0
    if date.total_seconds()//86400>0:
        days = date.total_seconds()//86400
    hours = date.total_seconds()//3600
    minutes = (date.total_seconds()%3600)//60
    seconds = (date.total_seconds()%3600)%60
    return hours,minutes,seconds,days

bday = get_user_birthday()
today = datetime.datetime.today()
countdown = calc_dates(bday, today)
if countdown[3]==0:
    print("Happy Birthday")
else:
    print("Your birthday is in {} days".format(int(countdown[3])),"{} hours".format(int(countdown[0])),"{} minutes".format(int(countdown[1])),"{} seconds".format(int(countdown[2])))