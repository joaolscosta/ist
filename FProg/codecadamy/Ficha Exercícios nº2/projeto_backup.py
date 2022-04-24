def corrigir_palavra(cadeia):
    '''
    Esta função recebe uma cadeia de carateres que representa uma palavra (potencialmente
    modificada por um surto de letras) e devolve a cadeia de carateres que corresponde à
    aplicação da sequência de reduções conforme descrito para obter a palavra corrigida.
    ''' 
    i = 0
    # Pra corrigirmos a palavra corrompida reccorremos a um ciclo que percorre
    # a cadeia de caracteres inserida e definimos a variável car como um caracter
    # a analisar e car_next como o próximo caracter na cadeia
    while i < len(cadeia) - 1:
        car = cadeia[i]            
        car_next = cadeia[i+1]
    # O que acontece aqui é  que se dois caracteres forem diferentes
    # e isto inclui: "aA" mas, quando ambas minúsculas forem caracteres 
    # iguais isto corresponde a um conjunto que pretendemos eliminar
        if car != car_next: 
            if car.lower() == car_next.lower():
    # Para altermos a cadeia de maneira a que fiquem apenas os caracteres
    # qeu não pertencem ao conjunto que queremos eliminar, quando se verificar 
    # a condição a cadeia contém todos os caracteres até à posição anterior a car
    # e só continua a conter na cadeia duas posições à frente de car para eliminar o conjunto.
                cadeia = cadeia[:i] + cadeia[i+2:]
    # A posição de i tem que ser sempre reiniciada à primeira posição pois se isto não acontecesse
    # Podiam escapar elementos que querímaos eliminar tais como "aBbA" que se não esgtivesse presente
    # Esta linha de código apenas ficaria "aA" em vez de ""
                i = -1
            else:
                i += 1
    return cadeia
   
print(corrigir_palavra("Aab"))
'''
Esta função recebe duas cadeias de carateres correspondentes a duas palavras e devolve
True se e só se uma é anagrama da outra, isto é, se as palavras são constituídas pelas
mesmas letras, ignorando diferenças entre maiúsculas e minúsculas e a ordem entre
carateres.
'''

def eh_anagrama(car1,car2): 
    # Para verificar se duas palavras são anagramas uma da outra partimos do princípio que não são.
    check = False
    # Verificamos antes de tudo se os tamanhos das strings forem diferentes já não são anagramas
    # mas, se tiverem o mesmo tamanho e quando ordenadas por odem alfabética tiverem exatamente os mesmos
    # caracteres ordenados então as palavras são anagramas uma da outra.
    if len(car1) != len(car2): 
        check = False
    else:
        car1 = sorted(car1) 
        car2 = sorted(car2)
        if car1 == car2:
            check = True    
        return check

def corrigir_doc(cadeia):
    if  not type(cadeia) == str  or cadeia == "" or "  " in cadeia or not cadeia.replace(" ","").isalpha():
        raise ValueError("corrigir_doc: argumento invalido")
    cadeia = corrigir_palavra(cadeia)                                           
    cadeia = cadeia.split()                                                          
    for i in range (len(cadeia)-2):
        for j in range (i+1,len(cadeia)-1):
            if eh_anagrama(cadeia[i],cadeia[j]):
                if cadeia[i] != cadeia[j]:
                    del cadeia[j]
    
    cadeia = " ".join(cadeia)
    return cadeia       

'''
Esta função recebe duas cadeias de carateres correspondentes a duas palavras e devolve
True se e só se uma é anagrama da outra, isto é, se as palavras são constituídas pelas
mesmas letras, ignorando diferenças entre maiúsculas e minúsculas e a ordem entre
carateres.
'''

def obter_posicao(car,pos):
    # Para sabermos qual a posiação em que termina após a inserção das teclas
    # temos que ter várias condições para cada tecla e exceções tais como certas
    # posições quando inserida uma tecla ter que continuar na mesma posição
    
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

'''
Esta função recebe uma cadeia de carateres contendo uma sequência de um ou mais movimentos
e um inteiro representando a posição inicial; e devolve o inteiro que corresponde
ao dígito a marcar após finalizar todos os movimentos.
'''

def obter_digito(car,pos):
    # Esta função tal como é dito tem o mesmo objetivo de apresentar a posição final tal como
    # na função anterior mas esta permite 
    for c in car:   
        pos = obter_posicao(c,pos)
    return pos    

def obter_pin(t):
    pos = 5                                                                      
    if not isinstance(t,str) and (len(t) > 10 or len(t) < 4):                                           
        raise ValueError("obter_pin: argumento invalido")
    tuplo = ()
    i = 0
    while i < len(t):                                                               
        comb = obter_digito(t[i],pos)
        tuplo = tuplo + (comb,)
        pos = comb
        i += 1
    return tuplo
        
    

    
        
    
    