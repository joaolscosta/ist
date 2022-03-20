#include <stdio.h>

int main()
{
    int n1, n2;

    printf("Insira dois números inteiros:\n");
    scanf("%d%d", &n1, &n2);

    printf("%s\n", (n1 % n2 == 0) ? "yes" : "no");

    return 0;
}