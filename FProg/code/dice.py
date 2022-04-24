import random

possible_numbers = (1,2,3,4,5,6)

pc_first_one = random.choice(possible_numbers)
pc_second_one = random.choice(possible_numbers)
#print('The opponent got ' + str(first_one) + ' and ' + str(second_one) + ' :O')
pc_combination = int(pc_first_one) + int(pc_second_one)
print('Opponent rolled and got ' + pc_combination + '\n')

player_first_one = random.choice(possible_numbers)
player_second_one = random.choice(possible_numbers)
#print('The opponent got ' + str(first_one) + ' and ' + str(second_one) + ' :O')
player_combination = int(player_first_one) + int(player_second_one)
print('We rolled and got ' + player_combination + '\n')


if player_combination > pc_combination:
    print('Player Wins.')
if player_combination < pc_combination:
    print('PC Wins.')
if player_combination == pc_combination:
    print('Draw.')

