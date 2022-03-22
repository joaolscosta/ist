#include <stdio.h>

typedef struct
{
    int hora;
    int minuto;
} Data;

int main()
{
    Data d1;
    Data d2;
    Data d;

    scanf("%d", &d1.hora);
    scanf("%d", &d2.hora);

    scanf("%d", &d1.minuto);
    scanf("%d", &d2.minuto);

    d.hora = d1.hora + d2.hora;
    d.minuto = d1.minuto + d2.minuto;

    while (d.minuto > 60)
    {
        d.minuto -= 60;
        d.hora += 1;
    }

    printf("%02d:%02d", d.hora, d.minuto);

    return 0;
}
