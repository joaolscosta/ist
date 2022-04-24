from os import sep


def periodos_compativeis(p1,p2):
    if p1["dia"] == p2["dia"]:
        return False
    if p1["inicio"] >= p2["fim"] or p2["inicio"] >= p1["fim"]:
        return False
    
    return True


def sala_esta_livre_periodo(sala,per):
    for periodo in sala["ocupacao"]:
        if not periodos_compativeis(periodo,per):
            return False
    return True



def cria_periodo(dia,inicio,fim):
    if not type(dia) == str:
        return False
    if dia not in ("seg","ter","qua","qui","sex","sab","dom"):
        return False
    if not type(inicio) == float or type(fim) != float:
        return False
    if inicio < 0 or inicio >= 24 or fim < 0 or fim >= 24:
        return False
    if inicio >= fim:
        raise ValueError("argumento invalido")
    return {"dia": dia, "inicio": inicio, "fim": fim}

def obter_dia_periodo(p):
    return p["dia"]
    

