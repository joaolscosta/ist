

def apenas_dig_impares(num):
    if num == 0:
        return 0
    else:
        if num % 2 != 0:
            return num % 10 + apenas_dig_impares(num//10) * 10
        else:
            return apenas_dig_impares(num//10)

def somadig(num):
    res = 0
    i = 0
    while num > 0:
        dig = num % 10
        num //= 10
        res += dig
    return res

def somadigitosrec(num):
    if num < 10:
        return num
    else:
        return num % 10 + somadigitosrec(num//10)

def somadig_str(num):
    if num == '':
        return '0'
    else:
        return int(num[0]) + somadig_str(num[1:])


def junta_ordenadas(l1,l2): # [1,4],[2,3,5]
    lista_final = []
    i = 0
    j = 0
    while i < len(l1):
        while j < len(l2):
            if l1[i] <= l2[j]:
                lista_final += lista_final[l1[i]:]
            else:
                lista_final += lista_final[l2[j]:]
    return lista_final

print(junta_ordenadas([1,4],[2,3,5]))

def junta_ordenadas_rec(l1,l2):
    if l1 == [] and l2 == []:
        return []
    else:
        if l1[0] < l2[0]:
            return l1[0] + junta_ordenadas_rec(l1[1:],l2[:])
        else:
            return l2[0] + junta_ordenadas_rec(l1[:],l2[1:])

