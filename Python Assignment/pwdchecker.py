import getpass

s = getpass.getpass(prompt="Enter the password ")
lc = "abcdefghijklmnopqrstuvwxyz"
uc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
n = "1234567890"
sym = "!\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"
val = True
c=0
lower = True
upper = True
symbols = True
num = True
if len(s)>=8 and len(s)<=16:
    c+=1
    for i in range(1,len(s)):
        if(s[i]==s[i-1]):
            val=False
            break
    c+=1
    for i in range(len(s)):
        if not val:
            break
        if (s[i] in lc) and (lower):
            c+=1
            lower = False
        elif (s[i] in uc) and (upper):
            c+=1
            upper = False
        elif (s[i] in n) and (num):
            c+=1
            num = False
        elif (s[i] in sym) and (symbols):
            c+=1
            symbols = False
    if c==6 and val:
        print("It is a valid password")
    else:
        print("It is not a valid password")
        if not val :
            print("Must not have two consecutive characters that are same")
        elif symbols :
            print("Must have at least 1 symbol")
        elif num :
            print("Must have at least 1 number")
        elif upper :
            print("Must have at least 1 Uppercase letter")
        elif lower :
            print("Must have at least 1 Lowercase letter")
else:
    print("It is not a valid password")
    print("Must be at least 8 characters long")
