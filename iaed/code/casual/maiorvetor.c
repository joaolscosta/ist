#include <stdio.h>

int maior(int vetor[], int tamanho);

int main()
{
    int tamanho;
    int vetor[tamanho];

    scanf("%d", &tamanho);
    printf("O maior é: %d", maior(vetor[tamanho], tamanho)); // mano o que se passa aqui
    return 0;
}

int maior(int vetor[], int tamanho)
{
    int i, maior = 0;

    for (i = 0; i < tamanho; i++)
    {
        if (vetor[i] > maior)
        {
            maior = vetor[i];
        }
    }

    return maior;
}