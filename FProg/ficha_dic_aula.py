def periodos_compativeis(p1,p2):
    if type(p1) != dict or type(p2) != dict:
        return False
    if len(p1) != 3 or len(p2) != 3:
        return False
    if p1['dia'] != p2['dia']:
        return True
    if p1['dia'] != p2['dia'] and p1["inicio"] >= p2["fim"] or p2["inicio"] > p1["fim"]:
        return False
    return True

def sala_esta_livre(sala,per):
    for periodos in sala['ocupacao']:
        if not periodos_compativeis(periodos,per):
            return False
    return True

def cria_periodo(dia,inicio,fim):
    if type(dia) != str or type(inicio) != int or type(fim) != int:
        return False
    if dia not in ('seg','ter','qua','qui','sex'):
        return False
    if not 0 <= inicio <= 23 or not 0 <= fim <= 23:
        return False
    if inicio > fim:
        return False
    return {'dia': dia, 'inicio': inicio, 'fim': fim}


p1 = {'dia': 'seg', 'inicio': 13.5, 'fim': 15}


def obter_dia_per(p):
    return p['dia']

def obter_inicio_periodo(p):
    return p['inicio']

def obter_fim_periodo(p):
    return p['fim']


def criar_sala(nome,tipo,capacidade,ocupacao):
    if type(nome) != str or type(tipo) != int or type(capacidade) != int and type(ocupacao) != dict:
        return False
    if capacidade < 0:
        return False
    if len(ocupacao) < 1:
        return False
    for item in ocupacao:
        if not cria_periodo(item[0],item[1],item[2]):
            return False
    return {'nome': nome, 'tipo': tipo, 'capadidade': capacidade, 'ocupacao': ocupacao}

def obter_nome_sala(sala):
    return sala['nome']

def obter_tipo_sala(sala):
    return sala['tipo']

def obter_capacidade_sala(sala):
    return sala['capacidade']

def obter_ocupacao_sala(sala):
    return sala['ocupacao']

