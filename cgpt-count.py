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
    birthday = "2023-12-31"  # Replace with your actual birthday in 'YYYY-MM-DD' format
    countdown_to_birthday(birthday)
