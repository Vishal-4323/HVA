import getpass
play = "yes"
while(play=="yes" or play=="Yes"):
    print("Please choose any one of these ['Rock','Paper','Scissors']")
    user1 = getpass.getpass(prompt="player 1's turn ")
    user2 = getpass.getpass(prompt="player 2's turn ")
    if user1==user2:
        print("Match is draw")
        continue
    elif user1=="rock" or user1=="Rock":
        if user2=="paper" or user2=="Paper":
            print("User2 Won")
        else:
            print("User1 Won")
    elif user1=="paper" or user1=="Paper":
        if user2=="Scissors" or user2=="scissors":
            print("User2 Won")
        else:
            print("User1 Won")
    elif user1=="scissors" or user1=="Scissors":
        if user2=="Rock" or user2=="rock":
            print("User2 Won")
        else:
            print("User1 Won")
    else:
        print("please, select the right option")
    play = input("If you like to play then type Yes, else No ")