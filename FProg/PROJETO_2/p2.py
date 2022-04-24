'''
João Luis Saraiva Costa
102078
LEIC-A
2021/2022


2.1.1 TAD posicao

Este TAD que aqui vamos definir consiste em criar uma posição num espaço (x,y)
'''

# Construtores


def cria_posicao(x, y):
    '''
    Nesta função são atrubuídos dois argumentos: x e y que vão devolver a posição em que o animal se
    encontra no prado. Temos de verificar se as posições são do tipo inteiro para que se encaixe no prado.

    Argumentos:
    - x -> argumento do tipo inteiro que representa a posição no prado ao longo do eixo x
    - y -> argumento do tipo inteiro que representa a posição no prado ao longo do eixo y
    '''
    if type(x) != int or type(y) != int or x < 0 or y < 0:
        raise ValueError('cria_posicao: argumentos invalidos')
    return (x, y)


def cria_copia_posicao(p):
    '''
    Recebe um argumento que contém a posição constituída por uma coordenada no eixo x e outra no eixo y
    e devolve uma cópia dessa posição.
    '''
    copia = cria_posicao(obter_pos_x(p), obter_pos_y(p))
    return copia

# Seletores


def obter_pos_x(p):
    '''
    Esta função recebe o elemento retornado pela função cria_posição e retorna a coordenada em x.
    (primeira posição do tuplo)
    '''
    return p[0]


def obter_pos_y(p):
    '''
    Esta função recebe o elemento retornado pela função cria_posição e retorna a coordenada em y.
    (segunda posição do tuplo)
    '''
    return p[1]


# Reconhecedores
def eh_posicao(arg: tuple):
    '''
    Na próxima função em questão verificamos se todos os requesitos das coordenadas permitem que esta
    possa ser uma posição tal como verificar se se encontra num tuplo com apenas dois eixos e se
    cada um desses eixos é um inteiro do tipo pedido retornando True se isto acontecer.
    '''
    if type(arg) != tuple or len(arg) != 2:
        return False
    for digito in arg:
        if type(digito) == int or digito >= 0:
            return True
    return False

# Teste


def posicoes_iguais(p1, p2):
    '''
    Esta função recebe dois argumentos cada um composto por um tuplo de duas coordenadas x e y.
    Retorna True se a coordenada em x e y do primeiro argumento é igual à coordenada em x e y do segundo
    e se não acontecer retorna False

    Argumentos:
    - p1, p2 -> Tuplo de duas posições x e y.
    '''
    if eh_posicao(p1) == True and eh_posicao(p2) == True:
        if obter_pos_x(p1) == obter_pos_x(p2) and obter_pos_y(p1) == obter_pos_y(p2):
            return True
    return False

# Transformador


def posicao_para_str(p):
    '''
    Recebe um tuplo de posições e retorna esse uma string com essas coordenadas.
    
    Argumentos:
    - p1-> Tuplo de duas posições x e y.
    '''
    x = obter_pos_x(p)
    y = obter_pos_y(p)
    return '(' + str(x) + ', ' + str(y) + ')'

# Funções de Alto Nível


def obter_posicoes_adjacentes(p):
    '''
    O que acontece aqui é que são pedidas as posições adjacentes a uma posição inserida (posição imediatamente
    acima, seguida da sua direita, seguida da de baixo e por fim da sua esquerda.)
    Se a posição inserida tiver a coordenada em y ou x igual a zero vamos apenas obter três posições em que no caso de
    y ser zero não obtemos a imediatamente acima que não existe e no caso do x ser zero nãop obtemos a posição.
    imediatamente à esquerda que não existe.
    Com exeção destes acontecimentos obtemos as quatro posições adjacentes em que para obtermos a de cima apenas temos
    subtrair 1 a y, para a esquerda somar 1 a x, para baixo somar 1 a y e por fim para a esquerda subtrair 1 a x.
        
    Argumentos:
    - p -> Posição criada na função cria_posicao() constituida por um tuplo com dois eixos.
    '''
    if isinstance(p, tuple) and len(p) == 2 and type(obter_pos_x(p)) == int and type(obter_pos_y(p)) == int:
        tuplo_final = ()
        # Com uso a funções anteriormente definidas criamos logo desde inicio variáveis apenas para cada eixo
        # dentro das coordenadas (tuplo).
        x = obter_pos_x(p)
        y = obter_pos_y(p)

        if y > 0:
            tuplo_final += (cria_posicao(x, y-1),)  # cima

        tuplo_final += (cria_posicao(x+1, y),
                        cria_posicao(x, y+1),)  # direita e baixo

        if x > 0:
            tuplo_final += (cria_posicao(x-1, y),)  # esquerda

        return tuplo_final


def ordenar_posicoes(conj_tuplos):
    '''
    Para ordenarmos as posições adjacentes temos que respeitar a ordem de esquerda para a direita e de cima para baixo.
    Sendo assim para começarmos a ordenar temos que verificar primeiro os valores do eixo do y por ordem crescente e
    a mesma situação para os valores do eixo do x.

    Argumentos:
    - conj_tuplos -> Conjunto de posições adjacentes à posição inicialmente inserida.
    '''
    posicoes_ordenadas = ()
    tuplo_ordenado = sorted(conj_tuplos, key=lambda x: (
        obter_pos_y(x), obter_pos_x(x)))

    for posicao in tuplo_ordenado:
        posicoes_ordenadas += (posicao,)

    return posicoes_ordenadas


'''
2.1.2 TAD animal

Este TAD que vamos aqui definir é usado para representar os animais que habitam o prado e podermos distinguir se são
presas ou predadores. Para fazer a distinção os predadores são caracterizados por terem um nome da espécie,
idade, frequência de reprodução, fome e frequência de alimentação. Já as presas são identificadas por apenas
terem um nome da espécie, idade e frequência de reprodução.
'''

# Construtores


def cria_animal(s, r, a):
    '''
    Este construtor recebe três argumentos em que o primeiro refere-se ao nome da espécie, o segundo à frequência de
    reprodução e o último à frequência de alimentação.
    Para distinguirmos se o animal em questão é predador ou presa verificamos se a sua frequência de alimentação é maior
    que zero tratando-se de um predador e se for zero é uma presa.
    As validações necessárias à criação de um animal são as seguintes: Verificar se o nome é do tipo string não vazia e 
    se a frequência de reprodução e alimentação são do tipo inteiro.
    Recebe então o animal em questão em tipo dicionário indicando os seus estados atribuíudos e ainda mais uma chave Idade
    para que possamos posteriormente saber quando atinge a fase de reprodução.

    Argumentos:
    - s -> argumento correspondente ao nome da espécie do tipo string.
    - r -> argumento correspondente à frequência de reprodução do tipo int.
    - a -> argumento correspondente à frequência de alimentação do tipo int. 
    '''
    if type(s) != str or type(r) != int or type(a) != int:
        raise ValueError('cria_animal: argumentos invalidos')
    if len(s) == 0 or r < 1 or a < 0:
        raise ValueError('cria_animal: argumentos invalidos')

    if a > 0:
        animal = {'Especie': s, 'Frequencia de Reproducao': r,
                  'Frequencia de Alimentacao': a, 'Idade': 0, 'Fome': 0}
    if a == 0:
        animal = {'Especie': s, 'Frequencia de Reproducao': r, 'Idade': 0}
    return animal


def cria_copia_animal(a):
    '''
    Recebe um argumento que contém o animal no tipo dict e retorna uma cópia do desse animal.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    return a.copy()

# Seletores


def obter_especie(a):
    '''
    Esta função vai procurar no dicionário correpondente ao animal criado qual a chave correpondente ao nome da
    espécie e retornar o nome atribuído.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    return a['Especie']


def obter_freq_reproducao(a):
    '''
    Esta função vai procurar no dicionário correpondente ao animal criado qual a chave correpondente à frequência
    de reprodução e retornar o dado atribuído.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    return a['Frequencia de Reproducao']


def obter_freq_alimentacao(a):
    '''
    Esta função vai procurar no dicionário correpondente ao animal criado qual a chave correpondente à frequência
    de alimentação e retornar o dado atribuído.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    if eh_predador(a):
        return a['Frequencia de Alimentacao']


def obter_idade(a):
    '''
    Esta função vai procurar no dicionário correpondente ao animal criado qual a chave correpondente à idade e 
    retornar o dado atribuído.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    return a['Idade']


def obter_fome(a):
    '''
    Esta função vai procurar no dicionário correpondente ao animal criado qual a chave correpondente à fome e 
    retornar o dado atribuído.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    return a['Fome']

# Modificadores


def aumenta_idade(a):
    '''
    Esta função vai procurar no dicionário correpondente ao animal criado qual a chave correpondente à idade e 
    retornar o dado atribuído incrementando um ao valor.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    if 'Idade' in a:
        a['Idade'] += 1
    return a


def reset_idade(a):
    '''
    Esta função vai procurar no dicionário correpondente ao animal criado qual a chave correpondente à idade e 
    retornar o valor da idade resetado a zero.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    if 'Idade' in a:
        a['Idade'] = 0
    return a


def aumenta_fome(a):
    '''
    Esta função vai procurar no dicionário correpondente ao animal criado qual a chave correpondente à fome e 
    retornar o dado atribuído incrementando um ao valor.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    if eh_predador(a):
       a['Fome'] += 1
    return a


def reset_fome(a):
    '''
    Esta função vai procurar no dicionário correpondente ao animal criado qual a chave correpondente à idade e 
    retornar o valor da fome resetado a zero.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    if obter_fome(a) >= 0:
        a['Fome'] = 0
        return a

# Reconhecedor


def eh_animal(arg):
    '''
    Esta função vai recebe um argumento do tipo dict e verifica se as chaves e valores correspondem aos requesitos
    pretendidos. Se se tratar de uma presa o tamanho do dicionário deverá ser 3 contendo o nome da espécie, a
    frequência de reprodução e a idade. Já os predadores contém estas chaves anteriores mais a frequência de alimentação
    e a fome. Retorna True se se verificarem todas as condições caso contrário retorna False.

    Argumentos:
    - arg -> argumento do tipo dict correpondente ao animal.
    '''
    if len(arg) == 3:
        if 'Especie' in arg and 'Frequencia de Reproducao' in arg and 'Idade' in arg:
            if type(arg['Especie']) == str and type(arg['Frequencia de Reproducao']) == int and type(arg['Idade']) == int:
                if len(arg['Especie']) > 0 and arg['Frequencia de Reproducao'] > 0 and arg['Idade'] >= 0:
                    return True

    if len(arg) == 5:
        if 'Especie' in arg and 'Frequencia de Reproducao' in arg and 'Frequencia de Alimentacao' in arg and 'Fome' in arg and 'Idade' in arg:
            if type(arg['Especie']) == str and type(arg['Frequencia de Reproducao']) == int and type(arg['Frequencia de Alimentacao']) == int and type(arg['Idade']) == int and type(arg['Fome']) == int:
                if len(arg['Especie']) > 0 and arg['Frequencia de Reproducao'] > 0 and arg['Frequencia de Alimentacao'] >= 0:
                    return True
    return False


def eh_predador(arg):
    '''
    Esta função recebe um argumento do tipo dict contendo as informações sobre o animal e pretende identificar se é um
    predador. Para isto acontecer damos uso à função anteriormente definida eh_animal() e se tiver também um tamanho
    de 5 retorna True. Se estas duas condições não acontecerem em simultâneo retorna False.

    Argumentos:
    - arg -> argumento do tipo dict correpondente ao animal.
    '''
    if len(arg) == 5 and eh_animal(arg) == True:
        return True
    return False


def eh_presa(arg):
    '''
    Esta função recebe um argumento do tipo dict contendo as informações sobre o animal e pretende identificar se é um
    presa. Para isto acontecer damos uso à função anteriormente definida eh_animal() e se tiver também um tamanho
    de 3 retorna True. Se estas duas condições não acontecerem em simultâneo retorna False.

    Argumentos:
    - arg -> argumento do tipo dict correpondente ao animal.
    '''
    if len(arg) == 3 and eh_animal(arg) == True:
        return True
    return False

# Teste


def animais_iguais(a1, a2):
    '''
    Esta função recebe dois argumentos correspondentes a dois animais com o objetivo de verificar se os dois animais são iguais.
    Para começar temos que validar se têm o mesmo tamanho e número de chaves senão já corresponde a uma presa e a um predador.
    Se tiverem o mesmo tamanho é só analisarmos todas as chaves dos dois aniamis e verificarmos se são iguais.
    Se acontecer retorna booleano True senão False.

    Argumentos:
    - a1, a2 -> argumentos do tipo dict correpondentes a animais.
    '''
    if len(a1) != len(a2):
        return False

    if len(a1) == len(a2) == 3:
        if a1['Especie'] == a2['Especie'] and a1['Frequencia de Reproducao'] == a2['Frequencia de Reproducao'] and a1['Frequencia de Alimentacao'] == a2['Frequencia de Alimentacao']:
            return True

    if len(a1) == len(a2) == 5:
        if a1['Especie'] == a2['Especie'] and a1['Frequencia de Reproducao'] == a2['Frequencia de Reproducao'] and a1['Frequencia de Alimentacao'] == a2['Frequencia de Alimentacao'] and a1['Idade'] == a2['Idade'] and a1['Fome'] == a2['Fome']:
            return True

    return False

# Transformadores


def animal_para_char(a):
    '''
    Esta função recebe um argumento do tipo dict correspondente a um animal e o objetivo é apresentar apenas o primeiro 
    caracter do valor atribuído à chave 'Especie' em que se se tratar de um predador é apresentado esse caracter maiúsculo
    e se se tratar de uma presa é apresentado o primeiro caracter minúsculo para que possa haver posteriormente uma melhor 
    distinção entre os dois tipos de animais.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    if eh_predador(a):
        especie = obter_especie(a).upper()
        return especie[0]
    if eh_presa(a):
        especie = obter_especie(a).lower()
        return especie[0]



def animal_para_str(a):
    '''
    Esta função recebe um argumento do tipo dict contendo as informações sobre o animal e devolve sob a forma de uma string.
    Se for um predador: 'Especie' ['Idade' / 'Frequencia de Reprodução' ; 'Fome' / 'Frequência de Alimentação']
    Se for uma presa: 'Especie' ['Idade' / 'Frequencia de Reprodução']

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    if eh_predador(a):
        return a['Especie'] + ' [' + str(a['Idade']) + '/' + str(a['Frequencia de Reproducao']) + ';' + str(a['Fome']) + '/' + str(a['Frequencia de Alimentacao']) + ']'
    if eh_presa(a):
        return a['Especie'] + ' [' + str(a['Idade']) + '/' + str(a['Frequencia de Reproducao']) + ']'

# Funções de Alto Nível


def eh_animal_fertil(a):
    '''
    Esta função recebe um argumento do tipo dict contendo as informações de um animal e retorna True se a sua idade corresponder à
    frequência de reprodução sendo assim um animal fértil. Tudo isto com uso de funções anteriormente definidas tais como
    obter_idade() e obter_freq_alimentacao()
    Caso contrário retorna False.

    Argumentos:
    - a -> argumento do tipo dict correspondente ao animal.
    '''
    if obter_idade(a) == obter_freq_reproducao(a):
        return True
    return False


def eh_animal_faminto(a):
    '''
    Esta função recebe um argumento do tipo dict contendo as informações de um animal e retorna True se a sua fome corresponder à
    frequência de alimentação sendo assim um animal que está faminto. Caso contrário retorna False.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    if eh_presa(a):
        return False
    if eh_predador(a):
        if a['Fome'] >= a['Frequencia de Alimentacao']:
            return True
    return False


def reproduz_animal(a):
    '''
    Esta função recebe um argumento do tipo dict contendo as informações de um animal e retorna uma cópia do animal com a idade 
    e se for predador a fome resetada a zero com ajuda de funções definidas anteriormente tais como reset_idade() e reset_fome().
    O animal inicial apenas reseta a sua idade.

    Argumentos:
    - a -> argumento do tipo dict correpondente ao animal.
    '''
    copia_animal = cria_copia_animal(a)
    a = reset_idade(a)
    copia_animal = reset_idade(copia_animal)

    if eh_predador(copia_animal):
        copia_animal = reset_fome(copia_animal)

    return copia_animal


'''
2.1.3 TAD prado

Este TAD vai ser o que nos vai permitir representar o ecossistema que inclui o mapa rodeado pelas rochas
com os animais e objetos a ocupar as suas posições.
'''

# Construtor


def cria_prado(d, r, a, p):
    '''
    Esta função tem a função de criar o espaço do prado e recebe quatro argumentos: (d) que corresponde à posição
    do limite inferior direito e é ela que define quantas linhas e quantas colunas o prado vai ter, (r) que
    é composto por um tuplo de posições ocupados pelos rochedos interiores, ou seja, que não pertencem às
    casas que rodeiam o prado, (a) que contém um ou mais animais e por fim (p) que contém as respetivas posições
    dos animais portanto tem o mesmo comprimento que (a).
    O objetivo de retorno é apresentar o prado então optei por criar um dicionário que conte-se cada uma destes
    dados.

    Argumentos:
    - d -> posição da montanha do lado inferior esquerdo do prado para definir o espaço.
    - r -> tuplo que contém zero ou mais posições correpondentes aos rochedos interiores.
    - a -> tuplo de um ou mais animais.
    - p -> tuplo com o mesmo comprimento que (a) que contém as respetivas posições dos animais.
    '''
    if eh_posicao(d) == False or type(r) != tuple or type(a) != tuple or type(p) != tuple:
        raise ValueError('cria_prado: argumentos invalidos')
    if len(d) != 2 or len(r) < 0 or len(a) < 1 or len(p) != len(a):
        raise ValueError('cria_prado: argumentos invalidos')
    for posicao in r:
        if eh_posicao(posicao) == False:
            raise ValueError('cria_prado: argumentos invalidos')
    for animal in a:
        if eh_animal(animal) == False:
            raise ValueError('cria_prado: argumentos invalidos')
    return {'Dimensao': d, 'Rochedos Interiores': r, 'Animais': a, 'Posicoes Animais': p}


def copia_prado(m):
    '''
    Recebe um argumento que contém o prado do tipo dict e retorna uma cópia do desse prado.

    Argumentos:
    - m -> argumento do tipo dict correpondente ao prado.
    '''
    return m.copia

# Seletores


def obter_tamanho_x(m):
    '''
    Função que a partir da chave 'Dimensao' do dicionário do prado obtém a coordenada em x do limite inferior
    direito do prado

    Argumentos:
    - m -> argumento do tipo dict correpondente ao prado.
    '''
    return obter_pos_x(m['Dimensao']) + 1


def obter_tamanho_y(m):
    '''
    Função que a partir da chave 'Dimensao' do dicionário do prado obtém a coordenada em y do limite inferior
    direito do prado

    Argumentos:
    - m -> argumento do tipo dict correpondente ao prado.
    '''
    return obter_pos_y(m['Dimensao']) + 1


def obter_numero_predadores(m):
    '''
    Função que a partir da chave 'Animais' do dicionário do prado retorna um inteiro com indicação de quantos
    predadores existem entre os animais que se encontram no prado.

    Argumentos:
    - m -> argumento do tipo dict correpondente ao prado.
    '''
    predadores = 0
    for animal in m['Animais']:
        if eh_predador(animal):
            predadores += 1
    return predadores


def obter_numero_presas(m):
    '''
    Função que a partir da chave 'Animais' do dicionário do prado retorna um inteiro com indicação de quantas
    presas existem entre os animais que se encontram no prado.

    Argumentos:
    - m -> argumento do tipo dict correpondente ao prado.
    '''
    presas = 0
    for animal in m['Animais']:
        if eh_presa(animal):
            presas += 1
    return presas


def obter_posicao_animais(m):
    '''
    Função que a partir dos tuplos obtidos a partir da chave 'Posicoes Animais' retorna um tuplo com todas as
    posições existentes seja de predador ou presa.
    
    Argumentos:
    - m -> argumento do tipo dict correpondente ao prado.
    '''
    tuplo_posicoes = ()

    for posicao in m['Posicoes Animais']:
        tuplo_posicoes += (posicao,)
    tuplo_posicoes_ordenadas = ordenar_posicoes(tuplo_posicoes)

    return tuplo_posicoes_ordenadas


def obter_animal(m, p):
    '''
    Esta função recebe como argumentos o prado e a posição que pretendemos verificar e retorna o respetivo animal
    correspondente à posição. Para obtermos a posição damos uso a um ciclo que percorre todas as posições dos animais
    que pertencem ao prado e após encontrar qual a posição retorna o animal com o mesmo índice que a posição tem
    no tuplo de posições.

    Argumentos:
    - m -> argumento do tipo dict correpondente ao prado.
    - p -> argumento do tipo tuple que corresponde à posição de um animal que pretendemos identificar.
    '''
    posicoes_animais = m['Posicoes Animais']
    posicao = 0
    while posicao < len(posicoes_animais):
        if posicoes_animais[posicao] == p:
            posicao_pretendida = posicao
            return m['Animais'][posicao_pretendida]
        else:
            posicao += 1
    return


def eliminar_animal(m, p):
    '''
    Esta função recebe como argumentos o prado e a posição correspondente ao animal que pretendemos eliminar.
    Se pretendemos eliminar o animal naquela posição precisamos de eliminar do nosso prado a sua posição e o 
    animal com o mesmo índice que ela. Como os tuplos são imutáveis passamos primeiro para list tanto os valores
    da chave 'Animais' como da chave 'Posicoes Animais'. Depois de identificarmos qual o animal a eliminar com
    recurso à função obter_animal() recorremos a dois contadores para percorrer as duas chaves mencionadas
    e eliminar essas duas com esse índice. De seguida passamos de novo ao tipo tuple e substituimos no dicionário.

    Argumentos:
    - m -> argumento do tipo dict correpondente ao prado.
    - p -> argumento do tipo tuple que corresponde à posição de um animal que pretendemos identificar.
    '''
    lista_animais = list(m['Animais'])
    lista_posicoes_animais = list(m['Posicoes Animais'])
    animal_eliminar = obter_animal(m, p)

    i = 0
    while i < len(lista_posicoes_animais):
        if p == lista_posicoes_animais[i]:
            lista_posicoes_animais = lista_posicoes_animais[:i] + \
                lista_posicoes_animais[i+1:]
        i += 1

    j = 0
    while j < len(lista_animais):
        if animal_eliminar == lista_animais[j]:
            lista_animais = lista_animais[:j] + lista_animais[j + 1:]
        j += 1

    tuplo_animais = tuple(lista_animais)
    tuplo_posicoes_animais = tuple(lista_posicoes_animais)

    m['Animais'] = tuplo_animais
    m['Posicoes Animais'] = tuplo_posicoes_animais

    return m


def mover_animal(m, p1, p2):
    '''
    Esta função recebe três argumentos: o prado, a posição em que o animal vai deixar e a nova posição em que o 
    animal vai ficar. Vamos usar a mesma metodologia da função eliminar_animal() mas para o movermos após transformarmos
    as posições dos animais em lista percorremos essa lista e quando a posição em que o animal vai deixar corresponder à 
    da lista essa posição vai ser substituída pela nova posição transformando denovo a lista em tuplo e substituindo
    o novo valor da chave 'Posicoes Animais'.

    Argumentos:
    - m -> argumento do tipo dict correpondente ao prado.
    - p1 -> agumento do tipo tuple que corresponde à posição que o animal vai deixar de ocupar. 
    - p2 -> agumento do tipo tuple que corresponde à posição que o animal vai ocupar.
    '''
    lista_posicoes_animais = list(m['Posicoes Animais'])
    i = 0
    while i < len(lista_posicoes_animais):
        if p1 == lista_posicoes_animais[i]:
            lista_posicoes_animais[i] = p2
        i += 1
    tuplo_posicoes_animais = tuple(lista_posicoes_animais)
    m['Posicoes Animais'] = tuplo_posicoes_animais

    return m


def inserir_animal(m, a, p):
    '''
    Para inserirmos um animal no prado recebemos três argumentos correspondentes ao prado ao animal a inserir e à posição
    em que o queremos inserir. Usamos a mesma metodologia da função anterior mas desta vez em vez de eliminarmos o animal
    vamos adicionar à lista o animal à chave 'Animais' e a posição à chave 'Posicoes Animais' transformando de novo a tuple
    e substituindo no dict prado.

    Argumentos:
    - m -> argumento do tipo dict correpondente ao prado.
    - p -> argumento do tipo tuple que corresponde à posição de um animal que pretendemos implementar.
    - a -> argumento do tipo dict que corresponde ao animal a implementar.
    '''
    lista_animais = list(m['Animais'])
    lista_posicoes_animais = list(m['Posicoes Animais'])
    lista_animais += [a]
    lista_posicoes_animais += [p]
    tuplo_animais = tuple(lista_animais)
    tuplo_posicoes_animais = tuple(lista_posicoes_animais)
    m['Animais'] = tuplo_animais
    m['Posicoes Animais'] = tuplo_posicoes_animais
    return m

# Reconhecedores


def eh_prado(arg):
    '''
    Função que recebe um argumento que é o prado e faz uma série de verificações para que esta possa ser um prado.

    Argumentos:
    - arg -> argumento do tipo dict que corresponde ao prado.
    '''
    if type(arg) != dict or len(arg) != 4:
        return False
    if 'Dimensao' not in arg or 'Rochedos Interiores' not in arg or 'Animais' not in arg or 'Posicoes Animais' not in arg:
        return False
    if eh_posicao(arg['Dimensao']) == False or type(arg['Rochedos Interiores']) != tuple or type(arg['Animais']) != tuple or type(arg['Posicoes Animais']) != tuple:
        return False
    if len(arg['Animais']) != len(arg['Posicoes Animais']):
        return False
    if len(arg['Rochedos Interiores']) < 0 or len(arg['Animais']) < 1 or len(arg['Posicoes Animais']) < 1:
        return False

    if len(arg['Rochedos Interiores']) >= 1:
        for i in arg['Rochedos Interiores']:
            if eh_posicao(i) == False:
                return False

    for i in arg['Animais']:
        if eh_animal(i) == False:
            return False
    for i in arg['Posicoes Animais']:
        if eh_posicao(i) == False:
            return False
    return True


def eh_posicao_animal(m, p):
    '''
    Função que recebe dois argumentos que são o prado e a posição que pretendemos se corresponde a uma posição
    ocupada por um animal. Apenas verificamos com uso de um ciclo se a posição inserida corresponde com algum dos tuplos 
    da chave 'Posicoes Animais' retornando True se acontecer e False em caso contrário.

    Argumentos:
    - m -> argumento do tipo dict que corresponde ao prado.
    - p -> argumento do tipo tuple que corresponde a uma posição que pretendemos verificar se é ocupada por algum animal.
    '''
    for i in m['Posicoes Animais']:
        if i == p:
            return True
    return False


def eh_posicao_obstaculo(m, p):
    '''
    Função que recebe dois argumentos que são o prado e a posição que pretendemos se corresponde a uma posição
    ocupada por um rochedo. Apenas verificamos com uso de um ciclo se a posição inserida corresponde com algum dos tuplos 
    da chave 'Rochedos Interiores' retornando True se acontecer e False em caso contrário. Temos também que verificar se
    está numa posição relativa a um limite exterior do prado.

    Argumentos:
    - m -> argumento do tipo dict que corresponde ao prado.
    - p -> argumento do tipo tuple que corresponde a uma posição que pretendemos verificar se é ocupada por algum animal.
    '''
    for i in m['Rochedos Interiores']:
        if i == p:
            return True
    if obter_pos_x(p) == obter_tamanho_x(m) - 1:
        return True
    if obter_pos_y(p) == obter_tamanho_y(m) - 1:
        return True
    if obter_pos_x(p) == 0:
        return True
    if obter_pos_y(p) == 0:
        return True
    return False


def eh_espaco_livre(m, p):
    '''
    Função que recebe dois argumentos prado e posição que pretendemos verificar se está livre e para isso acontecer damos uso
    a duas funções anteriores: eh_posicao_animal() e eh_posicao_obstaculo() e nenhuma destas acontecer é porque é uma posição
    sem algum rochedo ou animal.

    Argumentos:
    - m -> tipo dict que corresponde ao prado.
    - p -> tipo tuple que corresponde à posição que queremos verificar se está livre.
    '''
    if eh_posicao_animal(m, p) == True:
        return False
    if eh_posicao_obstaculo(m, p) == True:
        return False
    return True

# Teste


def prados_iguais(p1, p2):
    '''
    Esta função recebe dois argumentos correspondentes a dois prados e retorna um booleano verdadeiro
    caso eles sejam iguais, ou seja todos os valores das chaves de um dos prados sejam iguais aos valores
    das chaves do outro dicionário.

    Argumentos:
    - p1 -> argumento do tipo dict correspondente a um dicionário.
    - p2 -> argumento do tipo dict correspondente a um dicionário.
    
    if eh_prado(p1) == False or eh_prado(p2) == False:
        return False
    if obter_tamanho_x(p1) != obter_tamanho_x(p1) or obter_tamanho_y(p1) != obter_tamanho_y(p2):
        return False
    if obter_numero_predadores(p1) != obter_numero_predadores(p2) or obter_numero_presas(p1) != obter_numero_presas(p2):
        return False
    if obter_posicao_animais(p1) != obter_posicao_animais(p2):
        return False
    return True
    '''
    return p1 == p2

# Transformador


def prado_para_str(m):
    '''
    Esta função recebe um argumento correpondente a um prado e retorna o modelo do prado em string.
    Para que isso aconteça definimos dois eixos: eixo_x e eixo_y que vão limitar o prado para que os 
    animais e os rochedos interiores não ocupem posições nos limites exteriores correspondentes às
    montanhas. Para representar o prado e facilitar a identificação de cada elemento os limites superiores
    e inferiorsão representados por '-' os espaços laterais por '|' e os cantos por '+'. Dentro destes 
    limites os espaços ocupados por rochedos são representados por '@', as presas pelo primeiro caracter
    minúsculo do valor atríbuido à chave 'Especie' e os predadores o primeiro caracter maiúsculo
    do valor atribuído à chave 'Especie'. Então dentro do prado cada vez que uma posição não corresponder
    nem a um animal nem a um rochedo então é uma posição livre. Cada vez que identifica uma posição que
    corresponda à posição de um animal cria nessa posição após verificar se é animal ou presa a posição
    com o respetivo símbolo.

    Argumentos:
    - m -> argumento do tipo dict que corresponde ao prado.
    '''
    infan = '-'
    espaco_vazio = '.'
    rochedo_interior = '@'
    lateral = '|'
    prado = '+' + ((obter_tamanho_x(m)-2) * infan) + '+\n'
    check = False
    eixo_y = 1  # Retirar o limite exterior de cima
    eixo_x = 1  # Retirar o limite exterior esquerdo

    while check == False:
        if eixo_y == obter_tamanho_y(m) - 1:
            check = True
            break
        prado += lateral

        for eixo_x in range(1, obter_tamanho_x(m)-1):
            if eh_espaco_livre(m, cria_posicao(eixo_x, eixo_y)):
                prado += str(espaco_vazio)
            if eh_posicao_animal(m, cria_posicao(eixo_x, eixo_y)):
                animal = animal_para_char(obter_animal(
                    m, cria_posicao(eixo_x, eixo_y)))
                prado += str(animal)
            if eh_posicao_obstaculo(m, cria_posicao(eixo_x, eixo_y)):
                prado += rochedo_interior
        prado += '|\n'
        eixo_y += 1

    prado += '+' + ((obter_tamanho_x(m)-2) * infan) + '+'

    return prado

# Funções de Alto Nível


def obter_valor_numerico(m, p):
    '''
    Esta função recebe dois argumentos correspondentes ap prado e à posição que pretendemos analisar. O objetivo é
    retornar o valor numérico correspondente à posição inserida.

    Argumentos:
    - m -> argumento do tipo dict que corresponde ao prado.
    - p -> argumento do tipo tuple que corresponde à posição pretendida.
    '''
    return obter_pos_x(p) + obter_pos_y(p) * (obter_tamanho_x(m))


def obter_movimento(m, p):
    '''
    Esta função recebe dois argumentos correspondentes ao prado e a uma posição. O objetivo desta função é mover o
    animal de uma posição para outra sendo as hipóteses de movimento as suas posições adjacentes ou seja, pode mover-se
    para cima para baixo para a esquerda e para a direita. Como não é possível os aniais escalarem as montanhas e pode
    haver situações em que os animais não se podem deslocar ou para rochedos interiores ou para as montanhas os mesmo
    para a posição onde está ocupada por outro animal (no caso dos predadores) define-se que é dada uma ordem de sentido
    horário para que se possam deslocar. Então as presas respeitam sempre esta ordem de sentido horário mas os predadores
    se, das quatro posições estiver inserida uma presa essa casa terá prioridade. 

    Argumentos:
    - m -> argumento do tipo dict que representa o prado.
    - p -> argumento do tipo tuple que corresponde a uma posição.
    '''
    posicoes_adjacentes = obter_posicoes_adjacentes(p)
    posicoes_vazias = ()
    posicoes_presas = ()

    if eh_presa(obter_animal(m, p)):
        for posicao in posicoes_adjacentes:
            if eh_espaco_livre(m, posicao):
                posicoes_vazias += (posicao,)
            if eh_espaco_livre(m, posicao) == False:
                posicoes_vazias = posicoes_vazias

    elif eh_predador(obter_animal(m, p)):
        for posicao in posicoes_adjacentes:
            if eh_posicao_animal(m, posicao) == True and eh_presa(obter_animal(m, posicao)) == True:
               posicoes_presas += (posicao,)
            else:
                if eh_espaco_livre(m, posicao):
                    posicoes_vazias += (posicao,)

    if len(posicoes_presas) > 0:
        return posicoes_presas[obter_valor_numerico(m, p) % len(posicoes_presas)]
    else:
        if len(posicoes_vazias) > 0:
            return posicoes_vazias[obter_valor_numerico(m, p) % len(posicoes_vazias)]
        else:
            return p


def geracao(m):
    '''
    Esta função recebe um argumento que corresponde ao prado e tem como objetivo modificar o prado. O que acontece é
    que após uma geração completa inclui o movimento o aumento de idade e o aumento de fome no caso dos predadores.
    Então para que possa ocorrer uma geração no caso do animal em questão ser uma presa o que acontece no início do
    turno é incrementar a idade. De seguida obtemos a próxima posição e para que apenas que se mova usamos uma condição
    para verificar que a sua próxima posição que também tem influência na evolução do animal tal como apenas só
    se poder reproduzir quando se move pois se este chegar à idade fértil para se reproduzir deixa uma cópia de si com
    a idade igual a zero e passa para a próxima casa. Se não puder passar para outra casa não se reproduz.
    Tudo o que foi dito para a situação das presas aplica-se para os predadores mas estes têm as uma característica
    diferente das presas que é a fome. Depois de todas as condições da geração atuarem no predador este se tiver a sua
    fome igual à frequência de alimentação morre.

    Argumentos:
    - m -> argumento do tipo dict que corresponde ao prado.
    '''
    lista_posicoes = []
    posicoes = obter_posicao_animais(m)
    for posicao in posicoes:
        if any([posicoes_iguais(posicao, p) for p in lista_posicoes]):
            continue
        animal = obter_animal(m, posicao)
        if eh_presa(animal):
            aumenta_idade(animal)
            prxm_posicao = obter_movimento(m, posicao)
            lista_posicoes.append(prxm_posicao)
            if not posicoes_iguais(prxm_posicao, posicao):
                m = mover_animal(m, posicao, prxm_posicao)
                if eh_animal_fertil(animal):
                    m = inserir_animal(m, reproduz_animal(animal), posicao)

        if eh_predador(animal):
            aumenta_idade(animal)
            aumenta_fome(animal)
            prxm_posicao = obter_movimento(m, posicao)
            lista_posicoes.append(prxm_posicao)
            if not posicoes_iguais(prxm_posicao, posicao):
                m = mover_animal(m, posicao, prxm_posicao)
                if eh_animal_fertil(animal):
                    m = inserir_animal(m, reproduz_animal(animal), posicao)
            if eh_animal_faminto(animal):
                m = eliminar_animal(m, prxm_posicao)
    return m


def simula_ecossistema(f, g, v):
    '''
    Esta função vai permitir simular o ecossistema e recebe 3 argumentos correspondentes a uma cadeia de caracteres
    que é o nome do ficheiro um valor inteiro g que vai corresponder ao número de gerações que queremos percorrer e
    v que corresponde a um booleano. Este booleano pode ter dois modos: True que corresponde ao modo verboso e este
    apresenta cada geração apenas se tiver mudado o nome de presas ou predadores. False que correponde ao modo
    quiet que apenas apresenta a primeira geração e a última. Para que aconteçam começamos por abrir o ficheiro e usar
    o método readlines() para obter numa lista as linhas do ficheiro lido. Após isso de acordo com o ficheiro definimos
    a dimensão do prado, os rochedos interiores, os animais presentes na primeira geração com auxílio a TADs definidos
    anterioremente e as suas respetivas posições. Vai ser ser apresentado um scoreboard com as informações da quantidade
    de animais presentes em cada geração do prado e logo abaixo o mapa do prado.
    Para o modo verboso, usamos um ciclo que percorre todas as gerações e verifica se a próxima geração contém um número
    diferente de animais para que possa apresentar senão continua a contar até chegar à última geração.
    Para o modo quiet apenas vai percorrer todas as gerações e só quando chegar à última geração pretendida é que vai
    retornar o scoreboard com o prado correspondente a essa última geração.

    Argumentos:
    - f -> argumento do tipo str que corresponde ao nome do ficheiro pretendido de leitura.
    - g -> argumento do tipo int que corresponde à quantidade de gerações pretendidas.
    - v -> argumento do tipo bool que corresponde ao modo pretendido de simulação.
    '''
    ficheiro = open(f, 'r')
    linhas = ficheiro.readlines()
    ficheiro.close()
    ecossistema = []
    for linha in linhas:
        ecossistema.append(eval(linha[:-1]))

    dimensao = cria_posicao(ecossistema[0][0], ecossistema[0][1])
    rochedos = []
    for rochedo in ecossistema[1]:
        rochedos.append(cria_posicao(rochedo[0], rochedo[1]))
    animais = []
    posicoes_animais = []
    cont = 2
    while cont < len(ecossistema):
        animal = ecossistema[cont]
        posicao = animal[3]
        animais.append(cria_animal(animal[0], animal[1], animal[2]))
        posicoes_animais.append(cria_posicao(posicao[0], posicao[1]))
        cont += 1

    prado = cria_prado(dimensao, tuple(rochedos),
                       tuple(animais), tuple(posicoes_animais))

    gen = 0

    presas = obter_numero_presas(prado)
    predadores = obter_numero_predadores(prado)

    print('Predadores: ' + str(predadores) + ' vs ' +
          'Presas: ' + str(presas) + ' (Gen. ' + str(gen) + ')')
    print(prado_para_str(prado))

    if v == True:
        while gen < g:
            geracao(prado)
            gen += 1
            if presas != obter_numero_presas(prado) or predadores != obter_numero_predadores(prado):
                print('Predadores: ' + str(obter_numero_predadores(prado)) + ' vs ' +
                      'Presas: ' + str(obter_numero_presas(prado)) + ' (Gen. ' + str(gen) + ')')
                print(prado_para_str(prado))            
            presas = obter_numero_presas(prado)
            predadores = obter_numero_predadores(prado)

    if v == False:
        while gen < g:
            geracao(prado)
            gen += 1
            if gen == g:
                presas = obter_numero_presas(prado)
                predadores = obter_numero_predadores(prado)
                print('Predadores: ' + str(predadores) + ' vs ' +
                      'Presas: ' + str(presas) + ' (Gen. ' + str(gen) + ')')
                print(prado_para_str(prado))

    return (predadores, presas)




