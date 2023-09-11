import datetime
import time

def countdown_to_birthday(birthday):
    birthday_date = datetime.datetime.strptime(birthday, '%Y-%m-%d')
    while True:
        current_date = datetime.datetime.now()
        time_remaining = birthday_date - current_date
        if time_remaining.total_seconds() <= 0:
            print("Happy Birthday!")
            break
        days = time_remaining.days
        hours, seconds = divmod(time_remaining.seconds, 3600)
        minutes, seconds = divmod(seconds, 60)
        print(f"Time until your birthday: {days} days, {hours} hours, {minutes} minutes, {seconds} seconds", end='\r')
        time.sleep(1)

if __name__ == "__main__":
    day = str(int(input("Give your birthday date ")))
    month = str(int(input("Give your birthday month ")))
    birthday = str(datetime.date.today().year)+"-"+month+"-"+day
    countdown_to_birthday(birthday)

# import datetime

# def get_user_birthday():
#     print("When you where born? [DD-MM-YYYY]")
#     li = (input()).split('-')
#     day = int(li[0])
#     month = int(li[1])
#     year = int(li[2])
#     birthday = datetime.date(year,month,day)
#     return birthday

# def calc_dates(original_date, now):
#     this_year = datetime.datetime(now.year, original_date.month, original_date.day)
#     if original_date.month==now.month :
#         if original_date.day<now.day : 
#             this_year = datetime.datetime(now.year+1, original_date.month, original_date.day)
#         else:
#             this_year = datetime.datetime(now.year, original_date.month, original_date.day)
#     elif original_date.month<now.month :
#         this_year = datetime.datetime(now.year+1, original_date.month, original_date.day)
#     date = this_year - now
#     days = 0
#     if date.total_seconds()//86400>0:
#         days = date.total_seconds()//86400
#     hours = date.total_seconds()//3600
#     minutes = (date.total_seconds()%3600)//60
#     seconds = (date.total_seconds()%3600)%60
#     return hours,minutes,seconds,days

# bday = get_user_birthday()
# today = datetime.datetime.today()
# countdown = calc_dates(bday, today)
# if countdown[3]==0:
#     print("Happy Birthday")
# else:
#     print("Your birthday is in {} days".format(int(countdown[3])),"{} hours".format(int(countdown[0])),"{} minutes".format(int(countdown[1])),"{} seconds".format(int(countdown[2])))