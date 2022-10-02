#ifndef __ANIMAL_H__
#define __ANIMAL_H__

// this typedef is used to hide the concept's implementation details
typedef struct animal *Animal;

Animal newAnimal(const char *name, int age, double weight);
void destroyAnimal(Animal animal);

int equalsAnimal(Animal animal1, Animal animal2);
const char *getAnimalName(Animal animal);
int getAnimalAge(Animal animal);
double getAnimalWeight(Animal animal);
void printAnimal(Animal animal);

#endif