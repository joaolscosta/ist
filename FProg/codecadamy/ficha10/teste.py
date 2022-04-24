def conta_linhas(cadeia):
    f = open(cadeia,'r')
    string_f = f.readlines()
    f.close()
    i = 0
    for item in string_f:
        if len(item) > 1:
            i += 1
    return i

print(conta_linhas('joao.txt'))

def conta_vogais(cadeia):
    f = open(cadeia,'r')
    lines = f.readlines()
    f.close()
    dic = {'a': 0, 'e': 0, 'i': 0, 'o': 0, 'u': 0}
    for line in lines:
        for car in line:
            if car in dic:
                dic[car] += 1
    return dic

def escreve_invertido(cadeia1,cadeia2):
    f1 = open(cadeia1,'r')
    linhas_f1 = f1.readlines()[::-1]
    f1.close()
    f2 = open(cadeia2,'w')
    f2.write(linhas_f1)
    f2.close()

def concatena(lista,file):
    fsaida = open(file,'a')
    for ficheiro in lista:
        f = open(ficheiro,'r')
        lines = f.readlines  ()
        fsaida = f.write(lines)
        f.close()
    fsaida.close()

print(concatena(['joao.txt', 'daniela.txt'], 'doisnomes.txt'))

    


