#include <stdio.h>

int main()
{
    int n;
    float min, max, v;
    scanf("%d", &n);
    scanf("%f", &v);

    min = v;
    max = v;
    n--;

    while (n--)
    {
        scanf("%f", &v);
        min = (min < v) ? min : v;
        max = (max > v) ? max : v;
    }

    printf("min: %f, max: %f\n", min, max);

    return 0;
}