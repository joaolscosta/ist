#ifndef __GATO_H__
#define __GATO_H__

typedef struct cat *Cat;

Cat newCat(char *name, int age, double weight, int purrLevel,
           double fluffiness);

void destroyCat(Cat cat);

int equalsCat(Cat c1, Cat c2);

char *getCatName(Cat cat);

int getCatAge(Cat cat);

double getCatWeight(Cat cat);

int getCatPurrLevel(Cat cat);

double getCatFluffiness(Cat cat);

void printCat(Cat cat);