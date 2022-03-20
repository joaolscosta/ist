#include <stdio.h>

int main()  {
    int n1, n2, n3, n;

    printf("Introduza 3 números inteiros: ");
    scanf("%d%d%d", &n1, &n2, &n3);

    n = (n1 > n2) ? n1 : n2;
    n = (n > n3) ? n : n3;

    printf("O maior dos 3 é: %d", n);
    return 0;
    
}

