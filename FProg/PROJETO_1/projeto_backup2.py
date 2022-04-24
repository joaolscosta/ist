def corrigir_palavra(cadeia): # 121
    '''
    Recebe uma palavra corrompida e corrige atraves de codicoes pre indicadas
    
    Esta funcao recebe uma cadeia de caracteres como argumento (cadeia) que
    representa a palavra corrompida e com uso de condicoes corrigimos a palavra
    '''
    i = 0
    while i < len(cadeia) - 1:
        car = cadeia[i]            
        car_next = cadeia[i+1]
    # O que acontece aqui é  que se dois caracteres forem diferentes
    # e isto inclui: "aA" mas, quando ambas minusculas forem caracteres 
    # iguais isto corresponde a um conjunto que pretendemos eliminar
        if car != car_next: 
            if car.lower() == car_next.lower():
                cadeia = cadeia[:i] + cadeia[i+2:]
     # reiniciar a posicao e fundamental para que nao fiquem conjuntos por eliminar
                i = -1
        i += 1
    return cadeia

def eh_anagrama(car1,car2): # 122
    '''
    Verifica se uma palavra e anagrama de outra
    
    Esta funçao recebe duas cadeias como argumentos (cad1,cad2) e para uma palavra ser 
    anagrama de outra as palavras tem que ter o mesmo numero de caracteres e de seguida
    verificar se tem as mesmas letras
    '''
    # Para verificar se duas palavras sao anagramas uma da outra partimos do principio que nao sao
    # Verificamos antes de tudo se os tamanhos das strings forem diferentes ja nao sao anagramas
    # mas, se tiverem o mesmo tamanho e quando ordenadas por odem alfabetica tiverem exatamente os mesmos
    # caracteres ordenados então as palavras sao anagramas uma da outra
    if len(car1) != len(car2): 
        return False
    else:
    # Colocamos primeiramente o caracteres minusculos pois quando se ordena por ordem alfabetica
    # se houver caracteres maiusculos e minusculos ordena primeiro os maiusculos e depois os minusculos
        car1 = car1.lower()
        car2 = car2.lower()
        car1 = sorted(car1) 
        car2 = sorted(car2)
        if car1 == car2:
            return True    
    return False

def corrigir_doc(cadeia): # 123
    '''
    Corrige uma cadeia de caracteres com varias palavras retirando tambem os seus anagramas.
    
    Esta funcao recebe uma cadeia de caracteres corrompida como argumento (cadeia) que vai ser posteriormente
    corrigida e retirados os seus anagramas. Esta cadeia de caracteres vai agora possuir varias palavras dando origem
    a frase corrigida
    '''
    if  not type(cadeia) == str  or cadeia == "" or "  " in cadeia or not cadeia.replace(" ","").isalpha():
        raise ValueError("corrigir_doc: argumento invalido")
    cadeia = corrigir_palavra(cadeia)                                           
    cadeia = cadeia.split()    
    # Damos uso a dois ciclos em que o i representa a primeira posicao e o j vai analisar todas as outras posicoes
    # ate ao final da lista.
    '''                                                       
    for i in range(0,len(cadeia)):
        for j in range (i+1 ,len(cadeia)):
            if eh_anagrama(cadeia[i],cadeia[j]):
                if cadeia[i].lower() != cadeia[j].lower():
                    del cadeia[j]
    '''
    i = 0
    j = i + 1
    while i < len(cadeia):
        return
    cadeia = " ".join(cadeia)
    return cadeia

def obter_posicao(car,pos): # 221
    '''

    Insere um caracter e uma posição inicial e retorna a posicao final
    
    Esta funcao possui dois argumentos sendo um deles (car) que corresponde ao caracter
    inserido para indicar o movimento pretendido e um argumento (pos) indica em que posicao
    inicial para esse processo.
    '''
    # Para sabermos qual a posicao em que termina apos a insercao das teclas
    # temos que ter varias condicoes para cada tecla e excecoes tais como certas
    # posicoes quando inserida uma tecla ter que continuar na mesma posicao
    
    #       1   2   3
    #       4   5   6
    #       7   8   9

    if car == "C":
        if pos != 1 and pos != 2 and pos != 3:
            pos = pos - 3 
    if car == "B":
        if pos != 7 and pos != 8 and pos != 9:
            pos = pos + 3                             
    if car == "E":
        if pos != 1 and pos != 4 and pos != 7:
            pos = pos - 1
    if car == "D":
        if pos != 3 and pos != 6 and pos != 9:
            pos = pos + 1   
    return pos

def obter_digito(car,pos): # 222
    """
    Permite saber a posicao final mas apos varias teclas inseridas

    A funcao recebe na mesma situacao a posicao inicial (pos) mas desta vez
    podem ser introduzidos varios caracteres e ter executado todos os movimentos (car) 
    pretendidos

    """
    for c in car:
    # Usamos a funcao definida anteriormente mas damos uso a um contador que vai
    # percorrer todos os caracteres introduzidos na variável car
        pos = obter_posicao(c,pos)
    return pos

def obter_pin(t): # 223
    """
    Esta funcao tem o objetivo de receber um tuplo com varias sequencias de caracteres
    e retorna a posicao final corresponde no final a uma combinacao de 4 a 10 digitos.

    Recebe apenas o argumento (t) que tem como objetivo serem introduzidas as diversas 
    sequencias posteriormente manipuladas de maneira a obter o digito e apresentar um tuplo
    com a respetiva combinacao
    """
    pos = 5                                                                      
    if not isinstance(t,tuple) or len(t) < 4 or len(t) > 10:                                           
        raise ValueError("obter_pin: argumento invalido")
    tuplo = ()
    i = 0
    while i < len(t):
    # Para cada digito da combinacao a variavel comb vai armazenar os valores obtidos a partir
    # do uso da funcao obter_digito() definida anteriormente                                                               
        if i == "":
            raise ValueError("obter_pin: argumento invalido")
        comb = obter_digito(t[i],pos)
        tuplo = tuplo + (comb,)
        pos = comb
        i += 1
    return tuplo
t = ("CEE", "DDBBB", "ECDBE", "CCCCB")
print(obter_pin(t))


def eh_entrada(tuplo): # 321
    """
    Esta funcao verifica se a cifra, a sequencia de controlo e a sequencia de seguranca
    cumprem com os requisitos pre indicados

    Esta função recebe um argumento (tuplo) de qualquer tipo e atraves de condicoes pre
    indicadas analisamos se o tuplo correponde ao pedido retornando um booleano
    """
    if type(tuplo) != tuple:
        return False
    if tuplo == ():
        return False
    if len(tuplo) < 3 or len(tuplo) > 3:
        return False
    cifra = tuplo[0]
    seq_ctrl = tuplo[1]
    seq_seguranca = tuplo[2]
    
    if type(cifra) != str:
        return False
    if cifra[0] == "-" or cifra[-1] == "-":
        return False    
    for letra in cifra:
        if not ("a" <= letra <= "z" or letra == "-"):
            return False
    if type(seq_ctrl) != str or len(seq_ctrl) < 7 or len(seq_ctrl) > 7:
        return False
    if not seq_ctrl[0] == "[" or not seq_ctrl[6] == "]":
        return False
    for letra1 in seq_ctrl[1:6]:
        if not ("a" <= letra1 <= "z"):
            return False
    if not type(seq_seguranca) == tuple:
        return False
    if len(seq_seguranca) < 2:
        return False
    for num in seq_seguranca:
        if type(num) != int:
            return False
        if num < 0:
            return False
    
    return True 

def validar_cifra(cifra,seq_ctrl): # 322
    cifra_str = ""
    for car in cifra:
        if car != "-": 
            cifra_str += car
    cifra_str = sorted(cifra_str)
    dic = {}
    for letra in cifra_str:
        if letra not in dic: # Se o valor ainda não estive presente no dicionario
            dic[letra] = 0   # Inicializa lo senao adicionar mais uma ocorrencia  
        if letra in dic:
            dic[letra] += 1
    dic = list(sorted(dic,key=dic.get,reverse = True)) 
    dic = "".join(dic)

    if dic[0:5] == seq_ctrl[1:6]:
        return True
    else:
        return False

def filtrar_bdb(lista): # 323
    if not isinstance(lista,list) or len(lista) < 3 or lista == []:
        raise ValueError("filtrar_bdb: argumento invalido")
    lista_final = []
    for i in range(0,len(lista),1):
        cifra = lista[i][0]
        checksum = lista[i][1]
        # num_seg = lista[i][2]
        if validar_cifra(cifra,checksum) == True:
            i += 1
        else:
            lista_final += (lista[i],)
            i += 1
    
    return lista_final


def obter_num_seguranca(tuplo): # 422
    difList = []
    for i in range(0,len(tuplo)-1,1):
        for j in range(i + 1,len(tuplo)):
            dif = tuplo[i] - tuplo[j]
            dif = abs(dif)
            difList.append(dif)
    difList = sorted(difList)
    return difList[0]

def decifrar_texto(cadeia,num): # 423
    finalString = ""
    for i in range(0,len(cadeia)):
        car = cadeia[i]
        if car == "-":
            finalString += " "
        else:
            ord_car = ord(car)
            if i % 2 == 0:
                ord_car += 1
            else:
                ord_car -= 1
            ord_car += num
            while ord_car > 122:
                ord_car -= 26
            chr_car = chr(ord_car)
            finalString += chr_car
    return finalString

def decifrar_bdb(bdb): # 424
    if not isinstance(bdb,list) or len(bdb) == 0:
        raise ValueError("decifrar_bdb: argumento invalido")
    bdb_final = []
    for entrada in bdb:
        if not eh_entrada(entrada):
            raise ValueError("decifrar_bdb: argumento invalido")
        entrada_final = decifrar_texto(entrada[0],obter_num_seguranca(entrada[2]))
        bdb_final.append(entrada_final)
    return bdb_final



def eh_utilizador(dicionario): # 521
    if not type(dicionario) == dict:
        return False
    if "name" not in dicionario or "pass" not in dicionario or "rule" not in dicionario:
        return False
    if len(dicionario) != 3:
        return False
    nome = dicionario["name"]
    senha = dicionario["pass"]
    regra = dicionario["rule"]
    
    if not type(nome) == str or not type(senha) == str:
        return False
    if nome == "" or senha == "":
        return False
    if not type(regra) == dict:
        return False
    if len(regra) != 2:
        return False
    if "vals" not in regra or "char" not in regra:
        return False
    if not type(regra["vals"]) == tuple:
        return False 
    if not len(regra["vals"]) == 2:
        return False
    for digito in regra["vals"]:
        if type(digito) != int or digito <= 0:
            return False
    if regra["vals"][0] > regra["vals"][1]:
        return False 
    if type(regra["char"]) != str or len(regra["char"]) != 1 or not "a" <= regra["char"] <= "z" or regra["char"].lower() != regra["char"]:
        return False
    
    return True

def eh_senha_valida(senha,dic): # 522
    cont = 0
    check = 0
    for car in senha:
        if car in "aeiou":
            cont += 1
    if cont < 3:
        return False
    tuplo = tuple(senha)
    for i in range(len(tuplo)-1):
        if tuplo[i] ==  tuplo[i+1]:
            check = 1
    if not check == 1:
        return False
    rep = senha.count(dic["char"])
    menor_valor = dic["vals"][0] 
    maior_valor = dic["vals"][1]
    if rep < menor_valor or rep > maior_valor:
        return False
    return True

def filtrar_senhas(lista): # 523
    lista_final = []
    if not type(lista) == list or lista == []:
        raise ValueError("filtrar_senhas: argumento invalido")
    for dic in lista:
        if eh_utilizador(dic) == False:
            raise ValueError("filtrar_senhas: argumento invalido")
        if eh_senha_valida(dic["pass"],dic["rule"]) == False:
            lista_final += [dic["name"]]
    lista_final = sorted(lista_final)
    return lista_final


    

    

