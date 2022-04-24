def acrescentarIndice(lista):
    for i in range(len(lista)):
        lista[i] = str(i)+str(lista[i])
    return lista # return exatamente ao mesmo que inserimos

def explode(num):
    tuplo = ()
    while num > 0:
        digito = num % 10
        tuplo = (digito,) + tuplo
        num = num // 10
    return tuplo

def implode(tuplo):
    num = 0
    for i in tuplo:
        if i % 2 == 0:
            num = (num * 10) + i
    return num

def multiplicaLista(lista):
    res = 1
    for i in lista:
        res = res * i
    return res

def maiorNmrLista(lista):
    res = 0
    for i in lista:
        if i > res:
            res = i
    return res

def removeClones(lista):
    for i in range(0,len(lista)-1):
        for j in range(i+1,len(lista)):
            if i == j:
                lista = lista[:j] + lista[j+1,]
    return lista






