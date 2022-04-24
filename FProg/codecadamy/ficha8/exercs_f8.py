def agrupa_por_chave(lista):
    dic = {}
    for item in lista:
        if item[0] not in dic:
            dic[item[0]] = []
        dic[item[0]] += item[1]
    return dic

print(agrupa_por_chave([("a", 8), ("b", 9), ("a", 3)]))




