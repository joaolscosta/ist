def posicoes(lista):
    for i in range(len(lista)):
        lista[i] = str(i) + str(",")+ str(lista[i])
    return lista

print(posicoes([3.5,"b","c+a","e","f"]))