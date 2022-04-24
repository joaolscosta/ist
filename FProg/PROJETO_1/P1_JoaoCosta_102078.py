def corrigir_palavra(cadeia): # 121
    '''
    Recebe uma palavra corrompida e corrige atraves de codicoes pre-indicadas
    
    A funcao recebe um argumento(cadeia) que representa uma palavra potencialmente corrompida
    e para resover essa string vamos percorrer todos os elementos dessa cadeia e comparar se,
    um caracter for diferente do caracter seguinte mas quando minusculas forem iguais correponde
    a uma situacao a qual queremos eliminar. 
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
    verificar se tem as mesmas letras.
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
    # ate ao final da lista e assim em diante.                                                
    for i in range (0,len(cadeia)):
        for j in range (i+1,len(cadeia)):
            if eh_anagrama(cadeia[i],cadeia[j]):
                if cadeia[i].lower() != cadeia[j].lower():
                    del cadeia[j]
    
    cadeia = " ".join(cadeia)
    return cadeia



def obter_posicao(car,pos): # 221
    '''

    Insere um caracter e uma posição inicial e retorna a posicao final
    
    Esta funcao possui dois argumentos sendo um deles (car) que corresponde ao caracter
    inserido para indicar o movimento pretendido e um argumento (pos) indica em que posicao
    inicial para esse processo.
    Sendo assim apenas podemos introduzir teclas tais como C,B,D,E para manifestarmos os 
    nossos movimentos e por exemplo se estivermos perante a posicao 1, 2 ou 3 e darmos ordem
    de um movimento para cima executanto a tecla C devemos permanecer na mesma posicao.
        
        1   2   3
        4   5   6
        7   8   9

    '''
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
    podem ser introduzidos varios caracteres e ter executado todos os movimentos introduzidos 
    em car.

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
    com a respetiva combinacao.
    Apenas foi necessario criar um novo tuplo que recebesse as posicoes finais de cada sequencia
    de movimentos.
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



def eh_entrada(tuplo): # 321
    """
    Recebe um argumento de qualquer tipo e devolve um booleano conforme se correponde a uma 
    entrada bdb potencialmente corrupta.

    Esta função recebe um argumento (tuplo) de qualquer tipo e atraves varias validacoes
    analisamos se o tuplo correponde ao pedido retornando um booleano.
    Foram necessarias validacoes tais como:
    Validacao se o argumento introduzido e um tuplo, nao pode ser vazio e tem que ter
    apenas 3 elementos.
    A respeito da cifra tem que ser do tipo string, nao pode começar ou terminar com um "-".
    Cada caracter introzido entre os "-" tem que estar presente no alfabeto e nao pode estar vazio.
    A sequencia de controlo tem que ser tambem do tipo string e tem que ter um tamanho com 7
    elementos já que os caracteres "[" e "]" tambem estao incluidos nessa cadeia.
    Ja a sequencia de seguranca tem que ser do tuplo tuplo na terceira posicao do tuplo inicial
    com um tamanho de pelo menos dois elementos e cada digito nesse tuplo tem que ser do tipo int
    e positivo incluindo o zero.


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
    '''
    Recebe uma cadeia com uma cifra e uma outra com uma sequencia de controlo
    e devolve um booleano se a sequencia e coerente com a cifra.

    Para verificarmos se a sequencia de controlo corresponde com a cifra ou seja,
    esteja por ordem dos cinco caracteres mais utilizados, comecamos por ordenar a cifra
    e apos isso criamos um dicionario e atribuimos as chaves os caracteres contidos na cadeia
    e o valor atribuido a cada chave vai ser o numero de vezes que esse caracter esta presente.
    Assim quando obtemos as chaves por ordem alfabetica apenas com 5 elementos dentro da string,
    comparamos com a sequencia de controlo desde a posicao posterior ao "[" até penultima 
    posicao antes do caracter final "]" e verificamos se de facto acontece a condicao pretendida.
    '''
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
    '''
    Recebe uma ou mais listas e retorna a/s lista/s que não pertence/m.

    Recebe como argumento (lista) que contem uma ou mais listas em que para analisar
    qual ou quais listas nao pertencem a condicao pretendida,ou seja, se a sequencia de
    controlo tem por ordem o os caracteres que sao mais utilizados na cadeia inserida.
    Assim se usarmos a funcao anteriormente definida se a condicao der falsa adicionamos 
    a uma nova lista todas as listas que nao pertencem.
    '''
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
    '''
    Recebe um tuplo e devolve a menor diferenca entre os elementos 
    presentes no tuplo.

    Recebe como argumento um tuplo que com o uso de um for para podermos comparar um elemento com
    todos os outros e realizamos a sua diferenca absoluta. Vamos retornar o valor numa nova 
    lista em que vao estar presentes todas as diferencas por ordem crescente sendo que o valor 
    pretendido vai estar presente na primeira posicao dessa lista.
    '''
    difList = []
    for i in range(0,len(tuplo)-1,1):
        for j in range(i + 1,len(tuplo)):
            dif = tuplo[i] - tuplo[j]
            dif = abs(dif)
            difList.append(dif)
    difList = sorted(difList)
    return difList[0]

def decifrar_texto(cadeia,num): # 423
    '''
    Recebe uma cadeia de caracteres com uma cifra e um numero de seguranca
    e devolve o texto decifrado.

    Recebe como argumento (cadeia) e (num) em que a cadeia vai ser o conjunto de caracteres
    que pretendemos corrigir. Para que possamos corrigir usamos um contador em que cada vez
    que apareca um "-" vai apresentar na string final um espaco nesse elemento. Se o caracter
    nao for um "-" recorremos a tabela UTF-8. Sabemos entao que o caracter "a" comeca na
    posicao 97 dessa mesma tabela e o caracter "z" tem a posicao 122.
    Quando estivermos a percorrer o ciclo e a posicao do elemento na cadeia seja par temos que
    somar o (num) inserido mais 1 senao somamos o (num) e subtraimos 1.
    O que acontece e que quando somamos o (num) e somamos ou subtraimos 1 podemos ultrapassar 
    o caracter "z" na posicao 122 entao o que fazemos e subtrair o numero de letras num alfabeto
    (26) ate que de a letra que pretendemos obter.
    Para passarmos os valores da tabela UTF para string usamos chr() e juntamos a string final
    obtendo entao a cadeia inicial mas corrigida.
    '''
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
    '''
    Recebe uma ou mais entradas e retorna uma string com as cifras dessas entradas corrigidas.

    Recebe como argumento (bdb) que corresponde a uma lista com varios tuplos e apos fazer
    validacoes tais como verificar se e uma lista ou se tem um tamanho diferente de zero.
    Apos isso com um contador for verifica com auxilio da funcao anteriormente definida:
    eh_entrada() se cada tuplo dentro dessa lista e valido e se for o que acontece e que 
    com o uso da funcao decifrar_texto() corrigimos a cifra de cada um dos tuplos.
    Para finalizar apenas apresenta se todas as cifras corrigidas numa lista.
    '''
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
    '''
    Recebe um argumento que passa por uma serie de validacoes e retorna um booleano.

    Recebe o argumento (dicionario) que passa pelas seguintes validacoes:
    Verifica se o argumento e do tipo dict, se as chaves "name", "pass" e "rule" estao presentes
    e se tiver mais ou menos chaves que apenas essas retorna Falso.
    Para validarmos o que esta dentro do dicionario comecamos por verificar se os elementos
    de "name" e "pass" sao string. Verificamos tambem se o valor de "name" e "pass" nao sao
    strings vazias. O valor de "rule" tem que ser tambem um dicionario que pode ter apenas 
    dois elementos e tem que ser as chaves "vals" e " char".
    O tipo de "vals" tem que ser um tuplo com duas posicoes e cada digito dentro desse tuplo
    tem que ser do tipo int maior que zero. Para alem disso o valor que esta na segunda posicao
    tem que ser obrigatoriamente maior que o primeiro.
    O valor de "char" tem que ser do tipo string e apenas pode ter um caracter que esteja no
    alfabeto e minusculo.
    '''
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
    '''
    Recebe uma cadeia de caracteres com uma senha e um dicionario e verifica
    se o que esta inserido no dicionario corresponde com a senha e retorna um booleano.

    Recebe como argumentos (senha) e (dic) em que a senha tem que ter presente uma vogal do
    alfabeto minusculo inserido no dicionario pelo menos 3 vezes e pelo menos um caracter
    que apareca pelo menos duas vezes consecutivas.
    Assim para confirmarmos se ter pelo menos 3 vogais usamos um contador que percorre a senha
    e conta quantas vogais tem. Para verificarmos se tem dois caracteres consecutivos iguais,
    percorremos essa senha mas agora em tuplo e se o a posicao que estamos a analisar tiver um
    caracter igual a proxima posicao continuamos senao retorna imediatamente falso.
    Para contarmos se o caracter em "char" esta inserido as vezes presentes no "vals" na senha
    apenas temos que contar o nomero de vezes que esta na senha e validar posteriormente se
    primeiro valor do tuplo e menor que o segundo valor do tuplo. 
    '''
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
    '''
    Recebe uma lista com um ou mais dicionarios e devolve por ordem alfabetica os
    nomes dos utilizadores com as senhas erradas.

    Recebe um argumento (lista) que tem um ou mais dicionarios e valida se esse argumento
    e do tipo list e nao e vazia.
    Com um ciclo verificamos se cada dicionario corresponde as validacoes da funcao
    anteriormente definida eh_utilizador() e se for verdadeiro com a funcao anterior
    eh_senha_valida() verificamos se a senha e o tuplo e caracter dao falso para que
    possamos adicionar as suas chaves a uma nova lista onde vao ser apresentadas todas as 
    chaves correpondentes a dicionarios em que a senha nao correponde com a regra por ordem
    alfabetica.
    '''
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


    

    

