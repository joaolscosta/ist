#include <stdio.h>

void troca(char s[])
{
    int i = 0;

    while (i != '\0')
    {
        if (s[i] >= 'a' && s[i] <= 'z')
        {
            s[i] = s[i] + 'A' - 'a';
        }
        i++;
    }
    return s;
}

int main()
{
    char s[100];
    scanf("%s", s);
    troca(s);
    return 0;
}