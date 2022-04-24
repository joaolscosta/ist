print("Escreva um inteiro: ")
num = eval(input("\n?"))
soma = 0
i = 0
while num > 0:
    digito = num % 10
    num //= 10
    if digito % 2 == 1:
        #soma += digito     Se fizesse apenas isto metia só o último par
        soma = soma * 10 + digito
    i += 1
        
print("Resultado: ", soma)    