def agrupa_por_chave(lista):
    dic = {}
    for k, v in lista:
        if k not in dic:
            dic[k].append([v])
    return dic 
print(agrupa_por_chave([("a", 8), ("b", 9), ("a", 3)]))