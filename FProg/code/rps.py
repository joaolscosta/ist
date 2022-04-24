import random

jogadas_possiveis = ['pedra','papel','tesoura']
tua_jogada = input('Pedra, Papel ou Tesoura: ')
jogada_pc = random.choice(jogadas_possiveis)
print('A tua escolha foi ' + tua_jogada + ', e a jogada do oponente foi ' + jogada_pc + '.')

if tua_jogada == jogada_pc:
    print('As jogadas são as mesmas então é um empate.')
else:
    if tua_jogada == 'papel':
        if jogada_pc == 'pedra':
            print('Ganhaste!')
        else:
            print('Perdeste...')
    if tua_jogada == 'pedra':
        if jogada_pc == 'tesoura':
            print('Ganhaste!') 
        else:
            print('Perdeste!')
    if tua_jogada == 'tesoura':
        if jogada_pc == 'papel':
            print('Ganhaste!')
        else:
            print('Perdeste!')

