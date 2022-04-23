#include <stdio.h>

#define NUMERO 15
#define NOME 100
#define MORADA 100

#define MAX_NUMEROS 10
#define MAX_DIG 9
#define CODE_CART 50
#define MAX_CALLS 1000

typedef struct date
{
    int dia;
    int mes;
    int ano;
} Date;

typedef struct cliente
{
    char id[NUMERO];
    char nome[NOME];
    char morada[MORADA];
    Date data;

} cliente;

typedef struct chamada
{
    Data chamada;
    int duracao;
};
