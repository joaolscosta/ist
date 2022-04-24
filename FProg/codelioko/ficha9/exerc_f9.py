# a) Real [n/d] = {"n": n, "d": d}

def cria_rac(n,d):
    if isinstance(n,int) and isinstance(d,int):
        if d <= 0:
            raise ValueError("cria_rac: argumento invalido")
        else:
            return {"n" : n , "d" : d}

def num(r):
    return r["n"]

def den(r):
    return r["d"]

def eh_racional(r):
    if isinstance(r,dict) and len(r) == 2 and "n" in r and "d" in r:
        return True
    else:
        return False

def eh_rac_zero(r):
    return r["n"] == 0

def rac_iguais(r1,r2):
    return r1["n"] * r2["d"] == r1["d"] * r2["n"]

def escreve_rac(r):
    return str(r["n"]) + "/" + str(r["d"])

def produto_rac(r1,r2):
    a = num(r1)
    b = den(r1)
    c = num(r2)
    d = den(r2)
    return (a * c)/(b * d)


# EXERCICIO 2

# a) r = [h , m , s] 

def cria_relogio(h,m,s):
    if isinstance(h,int) and 0 <= h <= 23:
        if isinstance(m,int) and 0 <= m <= 59:
            if isinstance(s,int) and 0 <= s <= 59:
                return[h,m,s]

def horas(r):
    return r[0]

def minutos(r):
    return r[1]

def segundos(r):
    return r[2]

def eh_relogio(arg):
    if isinstance(arg,list):
        if len(arg) == 3:
            if isinstance(arg[0],int) and isinstance(arg[1] == int) and isinstance(arg[2] == int):
                return arg

def eh_meia_noite(r):
    if r[0] == r[1] == r[2] == 0:
        return True
    else:
        return False

def eh_meio_dia(r):
    if r[0] == 12 and r[1] == r[2] == 0:
        return True
    else:
        return False

def mesmas_horas(r1,r2):
    if r1 == r2:
        return True
    else:
        return False

def escreve_relogio(r):
    if r[0] < 10:
        r[0] = "0" + str(r[0])
    if r[1] < 10:
        r[1] = "0" + str(r[1])
    if r[2] < 10:
        r[2] = "0" + str(r[2])
    return str(r[0]) + ":" + str(r[1]) + ":" + str(r[2])





# R[dd/mm/aa] = {'d': d, 'm': m, 'a': a}

















