#include <stdio.h>
#include <float.h>

int main()
{
    int segundos, minutos, horas;

    printf("Insira um número em segundos: ");
    scanf("%d", &segundos);

    horas = segundos / 3600;
    minutos = (segundos / 60) % 60;
    segundos = (segundos % 60);

    printf("%02d:%02d:%02d\n", horas, minutos, segundos);
    return 0;
}