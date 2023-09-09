def balance(paran, stack):
    for i in paran:
        if(i=='(' or i=='{' or i=='['):
            stack.append(i)
        elif((i==')' or i=='}' or i==']') and len(stack)!=0):
            if(i==')' and stack[len(stack)-1]=='('):
                stack.pop()
            elif(i==']' and stack[len(stack)-1]=='['):
                stack.pop()
            elif(i=='}' and stack[len(stack)-1]=='{'):
                stack.pop()
            else:
                return False
        else:
            return False
    return True


paran = input()
l=list(paran)
stack = []
if(balance(l, stack)):
    print("It is balanced")
else:
    print("It is not balanced")
