#include <stdio.h>

void comprime(char s[], int size)
{
    int i, j;
    int cont = 1, a = 0;
    int times[100];

    for (i = 0; i < size; i++)
    {
        cont = 1;
        for (j = i + 1; j < size; j++)
        {
            if (s[i] == s[j])
            {
                cont++;
                times[a];
                a++;
            }
            else
            {
                break;
            }
        }
    }

    for (i = 0; i < size; i++)
    {
        for (j = i + 1; j < size; j++)
        {
            if (s[i] == s[j])
            {
                if (cont > 1)
                {
                    s[i] = '0' + cont;
                    size -= cont;
                }
            }
        }
    }
}

int main()
{
    char a[100];

    scanf("%s", a);
    comprime(a, 4);
    printf("%s", a);
    return 0;
}
