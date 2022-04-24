'''
1) Ex de ficheiros:
vais receber o nome do ficheiro e tens de retornar o n° de carateres do ficheiro usando readlines
2) Ex de recursao:
vais receber um tuplo e tens de retornar o tuplo por ordem inversa(ex (1,2,true) retorna (true,2,1)
Tens de fzr este com iteração Linear, recursao Linear e recursao de causa
Outro de recursao: soma de impares de um tuplo
'''

def numero_car(fic):
    f = open(fic,'r')
    lines = f.readlines()
    f.close()
    i = 0
    for line in lines:
        for car in line[:-1]:
            i += 1
    return i


def inverte_tuplo(tuplo):
    inv_tuplo = ()
    for item in tuplo[::-1]:
        inv_tuplo += (item,)
    return inv_tuplo



def inverte_tuplo_lin(tuplo):
    if len(tuplo) == 0:
        return ()
    
    return (tuplo[-1],) + inverte_tuplo_lin(tuplo[:-1])

def inverte_tuplo_cauda(tuplo):
    def inverte_aux(tuplo,res):
        if len(tuplo) == 0:
            return res
        else:
            return inverte_aux(tuplo[1:],(tuplo[0],) + res)
    return inverte_aux(tuplo,())


def soma_impares(tuplo):
    res = 0
    for digito in tuplo:
        if digito % 2 != 0:
            res += digito
    return res


def soma_imp_lin(tuplo):
    if len(tuplo) == 0:
        return ()
    if tuplo[0] % 2 != 0:
        return tuplo[0] + soma_imp_lin(tuplo[1:])
    else:
        return soma_impares(tuplo[1:])

def soma(tuplo):
    def soma_aux(tuplo,res):
        if len(tuplo) == 0:
            return res
        if tuplo[0] % 2 != 0:
            return soma_aux(tuplo[1:], tuplo[0] + res)
        else:
            return soma_aux(tuplo[1:], res)
    return soma_aux(tuplo,0)


'''
Contar palavras nas linhas do ficheiro
'''

def conta_palavras(ficheiro):
    f = open(ficheiro,'r')
    lines = f.readlines()
    f.close()
    i = 0

    for line in lines:
        palavras = line.split()
        for palavra in palavras:
            i += 1
    return i
















































































































































    