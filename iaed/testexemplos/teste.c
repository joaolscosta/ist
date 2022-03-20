#include <stdio.h>

#define MIN 0
#define MAX 300
#define STEP 10

int main()
{
    float i, celsius;

    for (i = MIN; i <= MAX; i += STEP)
    {
        celsius = (5 / 9) * (i - 32);
        printf("%.0f\t%.1f\n", i, celsius);
    }
    return 0;
}