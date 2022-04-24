def lista_codigo(cadeia):
    lista = []
    
    for i in cadeia:
        lista.append(ord(i)) # lista += [ord(i)]
    return lista

def remove_multiplos(lista,num):
    lista_final = []
    for i in lista:
        if i % num == 0:
            lista_final.append(i)
    return lista_final


def num_occ_lista(lista,num):
    
    while True:
        res = 0
        found_list = False
        for i in lista:
            if type(i) == list:
                lista.extend(i)
                lista.remove(i)
                found_list = True
                break
            elif type(i) == int and num == i:
                res += 1
           
        if not found_list:
            break
        
    return res

def soma_cumulativa(lista):
    s = 0
    novaLista = []
    for i in lista:
        s += i
        novaLista += [s]
    return novaLista

def elemento_matriz(m,linha,coluna):
    return m[linha][coluna]

def print_matriz(matriz):
    mFinal = ""
    for linha in matriz:
        linha = ""
        for elemento in linha:
            linha += str(elemento)
        mFinal += str(linha)
    return mFinal 
        



