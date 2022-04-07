#include <stdio.h>
#include <stdlib.h>

typedef struct data
{
    int dia;
    int mes;
    int ano;
} Data;

Data data_introduzida()
{
    Data data;
    scanf("%d-%d-%d", &data.dia, &data.mes, &data.ano);
    return data;
}

void printData(Data data)
{
    printf("%02d-%02d-%04d", data.dia, data.mes, data.ano);
}

int main()
{
    int i, n;
    Data *datas;
    scanf("%d", &n);
    datas = malloc(sizeof(Data) * n);
    if (!datas)
    {
        printf("a");
        return 0;
    }

    for (i = 0; i < n; i++)
    {
        datas[i] = data_introduzida();
    }

    for (i = n - 1; i = 0; i--)
    {
        printData(datas[i]);
    }

    free(datas);
    datas = NULL;
    return 0;
}