#include <stdio.h>

int main()
{
    char palavra[1000];
    char *p = NULL;
    int i;

    scanf("%s", palavra);
    p = palavra;

    for(i = 0; *p != '\0'; p++)
    {
        printf("%s\n", p);
    }

    return 0;
    
}