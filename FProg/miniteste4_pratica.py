p1 = {'codigo': 'c1', 'em_stock': 420}
p2 = {'codigo': 'c2', 'em_stock': 12}
p3 = {'codigo': 'c3', 'em_stock': 93}

info = {'c1': {'designacao': 'parafuso1', 'quant_min': 500, 'quant_rec': 600},\
        'c2': {'designacao': 'martelo', 'quant_min': 10, 'quant_rec': 15},\
        'c3': {'designacao': 'parafuso1', 'quant_min': 100, 'quant_rec': 150}}


def cria_produto(codigo,em_stock):
    return {'codigo': codigo, 'em_stock': em_stock}

def cod_produto(p):
    return p['codigo']

def stock_produto(p):
    return p['em_stock']



def cria_info(tup_info):
    info = {}
    for item in tup_info:
        codigo = item[0]
        info[codigo] = {'designacao': item[1], 'quant_min': item[2], 'quant_recomendada': item[3]}
    return info

def info_produto(info,codigo):
    return info[codigo]

def designacao_produto(info,codigo):
    return info[codigo]['designacao']

def qt_min_produto(info,codigo):
    return info[codigo]['quant_min']

def qt_rec_produto(info,codigo):
    return info[codigo]['quant_recomendada']


def produtos_a_encomendar(loja,info):
    a_encomendar = ()
    for item in loja:
        codigo = item['codigo']
        info_produto = info[codigo]
        if item['em_stock'] < info_produto['quant_min']:
            quant_encomendar = info_produto['quant_rec'] - item['em_stock']
            a_encomendar += ((codigo, info_produto['designacao'], quant_encomendar),)
    return a_encomendar


def produtos_a_encomendar_TAD(loja,info):
    a_encomendar = ()
    for item in loja:
        codigo = cod_produto(item)
        if stock_produto(item) < qt_min_produto(info,codigo):
            a_encomendar += ((codigo,designacao_produto(info,codigo),qt_rec_produto(info,codigo)-stock_produto(item),))
    return a_encomendar


tup_cod_desig_qmin_qrec = (
    ('c1', 'parafuso1', 500, 600),
    ('c2', 'martelo', 10, 15),
    ('c3', 'prego1', 100, 150)
)
infoB = cria_info(tup_cod_desig_qmin_qrec)
#print( infoB )     # compara com a variável "infoA" acima
#print( info_produto(infoB, 'c2') )
#print( designacao_produto(infoB, 'c1') )
#print( qt_min_produto(infoB, 'c1') )
#print(qt_rec_produto(infoB, 'c1'))






