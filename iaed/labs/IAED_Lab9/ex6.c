#include <stdio.h>
#include <string.h>

int main()
{
    char *ponteiro;
    char stra[1000];

    scanf("%s", stra);

    ponteiro = stra;

    while (*ponteiro != '\0')
    {
        printf("%s\n", ponteiro);
        ponteiro++;
    }
    return 0;
}