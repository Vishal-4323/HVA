import datetime
import time

def countdown_to_birthday(birthday):
    # Convert the birthday string to a datetime object
    birthday_date = datetime.datetime.strptime(birthday, '%Y-%m-%d')

    while True:
        # Get the current date and time
        current_date = datetime.datetime.now()

        # Calculate the time remaining until the birthday
        time_remaining = birthday_date - current_date

        # Check if the birthday has already passed
        if time_remaining.total_seconds() <= 0:
            print("Happy Birthday!")
            break

        # Extract days, hours, minutes, and seconds from the time remaining
        days = time_remaining.days
        hours, seconds = divmod(time_remaining.seconds, 3600)
        minutes, seconds = divmod(seconds, 60)

        # Print the countdown
        print(f"Time until your birthday: {days} days, {hours} hours, {minutes} minutes, {seconds} seconds", end='\r')

        # Wait for one second before updating the countdown
        time.sleep(1)

if __name__ == "__main__":
    birthday = "2023-12-31"  # Replace with your actual birthday in 'YYYY-MM-DD' format
    countdown_to_birthday(birthday)
