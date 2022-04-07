#include <stdio.h>

void printAge(int *age)
{
    printf("You are %d years old\n", age);
}

int main()
{
    int age = 21;
    int *pAge = &age;

    printf("adress of age: %p\n", &age);
    printf("value of pAge: %p\n", pAge);

    printf("size of age: %d bytes\n", sizeof(age));
    printf("size of pAge: %d bytes\n", sizeof(pAge));

    printf("value of age: %d\n", age);
    printf("value of age: %d\n", *pAge);

    printAge(age);

    return 0;
}
