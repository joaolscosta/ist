def conta_linhas(cadeia):
    string = open(cadeia, 'r')
    string_f = string.readlines()
    string.close()
    i = 0
    for item in string_f:
        if len(item) > 1:
            i += 1
    return i


def conta_vogais(nome):
    f = open(nome,'r')
    lines = f.readlines()
    f.close()
    dic = {"a": 0, "e": 0, "i": 0, "o": 0, "u": 0}
    for line in lines:
        for car in line:
            if car in dic:
                dic[car] += 1
    return dic


def troca_linhas(f1,f2):
    file1 = open(f1,'r')
    lines1 = file1.readlines()
    file1.close()
    lines1.reverse()

    file2 = open(f2,'w')
    file2.writelines(lines1)
    file2.close()

troca_linhas('ficheiro1.txt','ficheiro2.txt')

def concatena(lista,f2):
    fsaida = open(f2,'w')
    for ficheiro in lista:
        f = open(ficheiro,'r')
        lines = f.read()
        f.close()
        print(lines,file = fsaida)
    fsaida.close()

def procura(palavra,ficheiro):
    f = open(ficheiro,'r')
    lines = f.readlines()
    f.close()
    for line in lines:
        if palavra not in line:
            del line

def corta(entrada,saida,num):
    f1 = open(entrada,'r')
    f2 = open(saida,'w')
    f2.write(f1.read(num))
    f1.close()
    f2.close()

def ordena_ficheiro(ficheiro):
    f = open(ficheiro,'r')
    lines = f.readlines()
    f.close()
    linhas_ordenadas = sorted(lines)
    f = open(ficheiro,'w')
    f.write(linhas_ordenadas)
    f.close()

def divide(fic,n):
    f = open(fic,'r')
    lines = f.readlines()
    f.close()
    fic0 = open('fic0.txt','w')
    fic1 = open('fic1.txt','w')
    for line in lines:
        fic0.write(line[:n] + '\n')
        fic1.write(line[n:] + '\n')

        


    


        
        