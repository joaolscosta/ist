#include <stdio.h>

typedef struct
{
    int dia;
    int mes;
    int ano;
} Data;

int main()
{
    Data d1;
    Data d2;
    Data maior, menor;

    scanf("%d", &d1.dia);
    scanf("%d", &d2.dia);

    scanf("%d", &d1.mes);
    scanf("%d", &d2.mes);

    scanf("%d", &d1.ano);
    scanf("%d", &d2.ano);

    if (d1.ano < d2.ano)
    {
        printf("%d-%d-%d", d2.dia, d2.mes, d2.ano);
    }
    else if (d1.ano > d2.ano)
    {
        printf("%d-%d-%d", d1.dia, d1.mes, d1.ano);
    }
    else if (d1.ano == d2.ano && d1.mes < d2.mes)
    {
        printf("%d-%d-%d", d2.dia, d2.mes, d2.ano);
    }
    else if (d1.ano == d2.ano && d1.mes > d2.mes)
    {
        printf("%d-%d-%d", d1.dia, d1.mes, d1.ano);
    }
    else if (d1.ano == d2.ano && d1.mes == d2.mes && d1.dia < d2.dia)
    {
        printf("%d-%d-%d", d2.dia, d2.mes, d2.ano);
    }
    else if (d1.ano == d2.ano && d1.mes == d2.mes && d1.dia > d2.dia)
    {
        printf("%d-%d-%d", d1.dia, d1.mes, d1.ano);
    }
    else
    {
        printf("São iguais");
    }
    return 0;
}
