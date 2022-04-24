# EXERCICIO 1


def cria_rac(n,d):
    if not type(n) == int or not type(d) == int:
        if d <= 0:
            raise ValueError("argumento invalido")
    return {"num" : n, "den" : d}

def num(r):
    return r["num"]

def den(r):
    return r["den"]

def eh_racional(arg):
    if type(arg) == int and len(arg) == 2 and "num" in arg and "den" in arg:
        return True
    else:
        return False

def eh_racional_zero(r):
    return r["num"] == 0

def rac_iguais(r1,r2):
    equals1 = num(r1) * den(r2)
    equals2 = den(r1) * num(r2)
    if equals1 == equals2:
        return True
    else:
        return False

def escreve_rac(r):
    return str(r["num"]) + "/" + str(r["den"])

def produto_rac(r1,r2):
    a = num(r1)
    b = den(r1)
    c = num(r2)
    d = den(r2)
    return (a * c)/(b * d)


# EXECICIO 2


def cria_rel(h,m,s):
    if type(h) == int and 0 <= h <= 23:
        if type(m) == int and 0 <= m <= 59:
            if type(s) == int and 0 <= s <= 59:
                return [h,m,s]

def horas(r):
    return r[0]

def minutos(r):
    return r[1]

def segundos(r):
    return r[2]

def eh_relogio(arg):
    if type(arg) == list and len(arg) == 3 and type(arg[0]) == int and type(arg[1]) == int and type(arg[2]) == int:
        return True
    else:
        return False

def eh_meia_noite(r):
    if horas(r) == 0 and minutos(r) == 0 and segundos(r) == 0:
        return True
    else:
        return False

def eh_meio_dia(r):
    if horas(r) == 12 and minutos(r) == 0 and segundos(r) == 0:
        return True
    else:
        return False

def mesmas_horas(r1,r2):
    if horas(r1) == horas(r2):
        if minutos(r1) == minutos(r2):
            if segundos(r1) == segundos(r2):
                return True
    else:
        return False

def escreve_relogio(r):
    if horas(r) < 10:
        horas(r) = "0" + str(horas(r))
    if minutos(r) < 10:
        minutos(r) = "0" + str(minutos(r))
    if segundos(r) < 10:
        segundos(r) = "0" + str(segundos(r))

def depois_rel(r1,r2):
    return horas(r2) > horas(r1) or \
        (horas(r1) == horas(r2) and minutos(r2) > minutos(r1)) or \
        (horas(r1) == horas(r2) and
         minutos(r1) == minutos(r2) and segundos(r2) > segundos(r1))

def dif_seg(r1,r2):
    dif_horas = horas(r2) - horas(r1)
    dif_min = minutos(r2) - minutos(r1)
    dif_segundos = segundos(r2) - segundos(r1)
    
    return dif_horas * 3600 + dif_min * 60 + dif_segundos

# R[dd/mm/aa] = {"dia": d, "mes": m, "ano": a}


def ano_bissexto(ano):
    return (ano % 4 == 0 and ano % 100 == 0) or ano % 400 == 0

def cria_data(d,m,a):
    if type(d) == int and 1 <= d <= 31 and type(m) == int and 1 <= d <= 12 and type(d) == int and 0 <= a <= 31: 
        return True
    return False

def dia(dt):
    return dt["dia"]

def mes(dt):
    return dt["mes"]

def ano(dt):
    return dt["ano"]

def eh_data(arg):
    if type(arg) == dict and "dia" in arg and "mes" in arg and "ano" in arg:
        dia = arg["dia"]
        mes = arg["mes"]
        ano = arg["ano"]
        return

