#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "gato.h"

struct cat
{
    char _name[16];
    int _age;
    double _weight;
    int _purrLevel;
    double _fluffiness;
};

Cat newCat(char *name, int age, double weight, int purrLevel,
           double fluffiness)
{
    Cat cat = (Cat)malloc(sizeof(Cat));

    if (cat != NULL)
    {
        strcpy(cat->_name, name);
        cat->_age = age;
        cat->_weight = weight;
        cat->_purrLevel = purrLevel;
        cat->_fluffiness = fluffiness;
    }

    return cat;
}

void destroyCat(Cat cat)
{
    if (cat)
        free(cat);
}

int equalsCat(Cat c1, Cat c2)
{
    if (c1 == NULL || c2 == NULL)
    {
        return 0;
    }

    if (strcmp(c1->_name, c2->_name) == 0 &&
        c1->_age == c2->_age &&
        c1->_weight == c2->_weight &&
        c1->_purrLevel == c2->_purrLevel &&
        c1->_fluffiness == c2->_fluffiness)
    {
        return 1;
    }

    return 0;
}

char *getCatName(Cat cat) { return cat->_name; }
int getCatAge(Cat cat) { return cat->_age; }
double getCatWeight(Cat cat) { return cat->_weight; }
int getCatPurrLevel(Cat cat) { return cat->_purrLevel; }
double getCatFluffiness(Cat cat) { return cat->_fluffiness; }

void printCat(Cat cat)
{
    printf("== Cat ==\n");
    printf("Name:       %s\n", getCatName(cat));
    printf("Age:        %d\n", getCatAge(cat));
    printf("Weight:     %g\n", getCatWeight(cat));
    printf("Purr level: %d\n", getCatPurrLevel(cat));
    printf("Fluffiness: %g\n", getCatFluffiness(cat));
}