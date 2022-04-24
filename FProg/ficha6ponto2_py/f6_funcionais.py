'''
map(int,str) passa todos os elementos de string para int ou seja
passa todos os elementos do segundo argumento para o primeiro 
argumento

reduce() basicamente faz a função de um contador/ciclo em que 
percorre todos os elementos de uma lista e acumula o valor da primeira
variável inserida

filter() o filter tem a função de filtrar os valores que pretendemos
como por exemplo os pares de uma lista e em vez de acumular os pares vai
filtrar a lista e recolher apenas eles. 
'''


def filtra(lista,tst):
    if len(lista) == 0:
        return []
    else:
        if tst(lista[0]):
            return [lista[0]] + filtra(lista[1:],tst)
        return filtra(lista[1:],tst)

def transforma(lst,fn):
    if len(lst) == 0:
        return []
    else:
        return [fn(lst[0])] + transforma(lst[1:],fn)

def acumula(lst,fn):
    def acumula_aux(lst,fn,res):
        if len((lst)) == 0:
            return res
        else:
            return acumula_aux(lst[1:],fn,fn(res,lst[0]))    
    return acumula_aux(lst,fn,0)

def soma_fn(n,fn):
    res = 0
    for i in range(n):
        res += fn(i)
    return res

def soma_fn(n, fn):
    def soma_fn_aux(acc, i, n, fn):
        if i > n:
            return acc
        return soma_fn_aux(acc + fn(i), i + 1, n, fn)

    return soma_fn_aux(0, 1, n, fn)

def soma_quadrados_impares(lst):
    return acumula(transforma(filtra(lst,(lambda x: x % 2 != 0)),(lambda x: x ** 2)),(lambda x,y: x + y))

def eh_primo(n):
    if n == 1:
        return False
    else:
        for i in range(2, n):
            if n % i == 0:
                return False
        return True

def nao_primos(num):
    if num == 0:
        return []
    if not eh_primo(num):
        return [num] + nao_primos(num - 1)
    return nao_primos(num - 1)

def misterio(num, p):
    if num == 0:
        return 0
    elif p(num % 10):
        return num % 10 + 10 * misterio(num // 10, p)
    else:
        return misterio(num // 10, p)

def filtra_pares(n):
    return misterio(n,lambda x: x % 2 == 0)

def lista_digitos(n):
    return list(map(lambda x: int(x), str(n)))

from functools import reduce

def produto_digitos(n,pred):
    return reduce(lambda x, y: x * y , filter(pred,lista_digitos(n)))

def apenas_digitos_impares(n):
    return reduce(lambda x,y: x * 10 + y, filter(lambda x: x % 2 != 0,lista_digitos(n)))


        














