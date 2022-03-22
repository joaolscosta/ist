#include <stdio.h>

typedef struct
{
    int dia;
    int mes;
    int ano;

} Data;

int main()
{
    int dias_mes = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    Data d;

    d.dia = d.dia % dias_mes[d.mes - 1] + 1;
    if (d.dia == 1)
        d.mes++;
    if (d.mes > 12)
    {
        d.mes = 12;
        d.ano++;
    }

    return 0;
}