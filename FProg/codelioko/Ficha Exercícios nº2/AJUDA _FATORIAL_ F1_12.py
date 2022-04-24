x = eval(input("Insira o valor de x: "))
n = eval(input("Insira o valor de n: "))

res = 0
i = 1

while i < n:
    op = (x**i)/(n**n)
    res += op
    i += 1
print(res)

def fat(num):
    n = 1
    for i in range(1,num+1):
        n = n*i
    return n

print(fat(5))