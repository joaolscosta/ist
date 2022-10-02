#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "animal.h"

struct animal
{
    char _name[16];
    int _age;
    double _weight;
};

Animal newAnimal(const char *name, int age, double weight)
{
    Animal animal = (Animal)malloc(sizeof(struct animal));
    if (animal != NULL)
    {
        strcpy(animal->_name, name);
        animal->_age = age;
        animal->_weight = weight;
    }
    return animal;
}

void destroyAnimal(Animal animal)
{
    if (animal)
        free(animal);
}

const char *getAnimalName(Animal animal) { return animal->_name; }
int getAnimalAge(Animal animal) { return animal->_age; }
double getAnimalWeight(Animal animal) { return animal->_weight; }

/* note that we require animal1 and animal2 to be valid animals: any of
   them being NULL pointers will result in a false comparison. */
int equalsAnimal(Animal animal1, Animal animal2)
{
    if (animal1 == NULL || animal2 == NULL)
        return 0;
    return !strcmp(getAnimalName(animal1), getAnimalName(animal2)) &&
           getAnimalAge(animal1) == getAnimalAge(animal2) &&
           getAnimalWeight(animal1) == getAnimalWeight(animal2);
}

void printAnimal(Animal animal)
{
    printf("== Animal ==\n");
    printf("Name:   %s\n", getAnimalName(animal));
    printf("Age:    %d\n", getAnimalAge(animal));
    printf("Weight: %g\n", getAnimalWeight(animal));
}