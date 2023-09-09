n = int(input("Enter the dividend : "))
print("The divisors of",n)
n = abs(n)
i = 1
while i<=n//2 :
    if(n%i==0):
        print(i)
    i+=1
print(n)