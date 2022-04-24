import random

print('\nBem vinda ao jogo da Adivinha!\n')

lim_max = eval(input('Limite de cima: '))
lim_min = eval(input('Limite de baixo: '))

lim = [lim_min,lim_max]
possible_num = ()

for i in range(lim_min,lim_max,1):
    possible_num += (i,)

possible_num += (lim_max,) 
random_number = random.choice(possible_num)
attemps = 1
while True:
    insert_number = eval(input('O teu palpite: '))
    if insert_number == random_number:
        print('Parabéns acertaste o número pela ' + str(attemps) + ' vez!')
        break
    if insert_number < random_number:
        print('O número misterioso é maior.')
    if insert_number > random_number:
        print('O número misterioso é menor.')
    attemps += 1