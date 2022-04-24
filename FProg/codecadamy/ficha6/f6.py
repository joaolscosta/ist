
# EXERCICIO 1

def apenas_digitos_imapares_lin(num):
    if num == 0:
        return 0
    if num % 2 != 0:
        return num % 10 + apenas_digitos_imapares_lin(num // 10) * 10
    else:
        return apenas_digitos_imapares_lin(num // 10)




def apenas_digitos_impares_cauda(num):
    def impares_aux(num,res):
        if num == 0:
            return res
        if num % 2 != 0:
            return impares_aux(num//10, res * 10 + (num%10))
        return impares_aux(num // 10, res)
    return impares_aux(num,0)


# EXERCICIO 2

def junta_ordenadas(lista1,lista2):
    if lista1 == [] and lista2 == []:
        return []
    else:
        if lista1[0] < lista2[0]:
            return lista1[0] + junta_ordenadas(lista1[1:],lista2[:])
        else:
            return lista2[0] + junta_ordenadas(lista1[:],lista2[1:])


def sublistas(lista):
    if len(lista) == 0:
        return 0
    else:
        if type(lista[0]) == list:
            return 1 + sublistas(lista[0]) + sublistas(lista[1:])
        else:
            return sublistas(lista[1:])


def soma_n_vezes(a,b,n):
    i = 0
    res = b
    while i < n:
        res += a
        i += 1
    return res

def soma_n_vezes_rec(a,b,n):
    if n == 0:
        return b
    else:
        return a + soma_n_vezes_rec(a,b,n-1)

def soma_els_atomicos(tuplo):
    res = 0
    for i in tuplo:
        if type(i) == int:
            res += i
        if type(i) == tuple:
            for j in i:
                if type(j) == int:
                    res += j
    return res

def soma_els_atomicos_rec(tuplo):
    if tuplo == ():
        return 0
    if type(tuplo[0]) == int:
        return tuplo[0] + soma_els_atomicos_rec(tuplo[1:])
    if type(tuplo[0]) == tuple:
        return soma_els_atomicos_rec(tuplo[0]) + soma_els_atomicos_rec(tuplo[1:])

def inverte(lista):
    if lista == []:
        return 0
    else:
        return inverte(lista[1:]) + [lista[0]]

def subtrai(l1,l2):
    listaf = []
    for i in l1:
        for j in l2:
            if i != j:
                listaf += [i]
            else:
                listaf += []    
    return listaf

def subtrai_rec(l1,l2):
    if len(l1) == 0:
        return 0
    if l1[0] in l2:
        return subtrai(l1[1:],l2)
    return [l1[0]] + subtrai(l1[1:],l2)

def maior(l):
    def maior_aux(l,m):
        if len(l) == 0:
            return m
        if l[0] > m:
            return maior_aux(l[1:],l[0])
        return maior_aux(l[1:],m)
    return maior_aux(l,l[0])
