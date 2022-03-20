#include <stdio.h>

int main()
{
    int n, m;

    printf("Introduza 2 números inteiros:\n");
    scanf("%d%d", &n, &m);

    printf("%d\n", (n<m) ? n : m);
    printf("%d", (n<m) ? m : n);

    return 0;
}