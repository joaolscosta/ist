#include <stdio.h>
#include <stdlib.h>

typedef struct Date
{
    int day;
    int month;
    int year;
} Date;

int main()
{
    int n, i;
    Date *dates, *p;

    scanf("%d", &n);

    dates = malloc((sizeof(Date)) * n);

    for(i = 0; i < n - 1; i++)
    {
        p = dates + i;
        scanf("%02d-%02d-%04d\n", &p->day, &p->month, &p->year);
    }

    for(i = n - 1; i >= 0; i--)
    {
        p = dates + i;
        printf("%02d-%02d-%04d\n", p->day, p->month, p->year);
    }

    free(dates);

    return 0;
}