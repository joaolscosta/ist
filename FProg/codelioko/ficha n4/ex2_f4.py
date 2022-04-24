def explode(i):
    tuplo = ()
    if not isinstance(i,int):
        raise ValueError("Argumento Inválido!")
    while i > 0:
        tuplo = (i % 10,) + tuplo
        i = i  // 10
    return tuplo

def implode(tuplo):
    res = 0
    i = 0
    while i < len(tuplo):
        digit = tuplo[i]
        if not isinstance(digit,int):
            raise ValueError("Argumento Inválido!")
        res = digit * (10 ** i) + res
        i += 1
    return res

def filtra_pares(tuplo):
    res = 0
    i = 0
    while i < len(tuplo):
        digit = tuplo[i]
        if not isinstance(digit,int):
            raise ValueError("Argumento Inválido!")
        if digit % 2 == 0:
            res = res * 10 + digit
        i += 1
    return res


def algarismos_pares(num):
    implode(filtra_pares(explode(num))) 
    return num
    
def num_para_seq_cod(num):
    res = ()
    while num > 0:
        digit = num % 10
        num = num // 10
        if digit % 2 == 0:
            res = ((digit + 2) % 10,) + res 
        elif digit == 1:
            result = (9,) + res
        else:
            result = (digit - 2,) + res
    return result


def soma_quadrados_pares(num):
    res = 0
    i = 0
    while i <= num:
        digito = num % 10
        num = num // 10
        if digito % 2 == 0:
            res = (digito ** 2) + res
        i += 1
    return res

def junta_ordenados(t1,t2):
    t1 = t1 + t2
    t1 = sorted(t1)
    return t1

def reconhece(cadeia):
    i = 0
    while i < len(cadeia) and cadeia[i] in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
        i += 1
    if i == len(cadeia):
        return False
    while i < len(cadeia) and cadeia[i] in "1234567890":
        i += 1
    return True

print(reconhece("123"))    
        
