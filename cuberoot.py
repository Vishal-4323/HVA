a = int(input("Enter a Number to find cube root : "))
for i in range(abs(a)+1):
    if i*i*i>=a:
        break
if i*i*i!=abs(a):
    epsilon = 0.01
    low = 0
    high = a
    guess = (low+high)/2.0
    while abs(guess**3 - a) >= epsilon:
        if guess**3 < a:
            low = guess
        else:
            high = guess
        guess = (high+low)/2.0
    print("It is not a perfect cube close to the cube root of",a,"is",guess)
else:
    if a<0:
        i=-i
    print("Cube root of",a,"is",i)
