#funcao(numero,digito)
#tens que percorrer o numero até descobrires o digito e elimná-lo

def eliminaDigito(numero,digito):
    numero=str(numero)
    digito=str(digito)
    i = 0
    while i<len(numero):
        if numero[i] == digito:
            numero = numero[:i] + numero[i+1:]
            break
        i+=1
    numero = int(numero)
    return numero

#pede um numero inteiro e verificar se existem digitos repetidos

def verificaRepetido(numero):
    numero = str(numero)
    i = 0
    while i<len(numero)-1:
        j = i+1
        while j<len(numero):
            if numero[i]==numero[j]:
                return True
            j+=1
        i+=1
    return False

#3- só se pode usar conteudos do cap2 e 3
#criar uma função q recebe 2 valores n(inteiro positivo) e dig
#a função tem de devolver o número formado pelos digitos de n que são divisiveis por dig e devolve zero se nenhum for divisivel. Exemplo:

def mantem_digitos(n,dig):
    n=str(n)
    output = ""
    i=0
    while i<len(n):
        if int(n[i])%dig==0:
            output+=n[i]
        i+=1
    if output=="":
        return 0
    return int(output)
