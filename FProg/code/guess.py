import random

print('Welcome to the Guess Number Game!\n')

lim_max = eval(input('Enter the max limit: '))
lim_min = eval(input('Enter the min limit: '))

lim = [lim_min,lim_max]
possible_num = ()

for i in range(lim_min,lim_max,1):
    possible_num += (i,)

possible_num += (lim_max,) 
random_number = random.choice(possible_num)
print(random_number)
attemps = 1
while True:
    insert_number = eval(input('Enter your guess: '))
    if insert_number == random_number:
        print('Congrats! You guessed the mistery for the ' + attemps + ' try!')
        break
    if insert_number < random_number:
        print('The mistry number is greater than the input.')
    if insert_number > random_number:
        print('The mistry number is lower than the input.')