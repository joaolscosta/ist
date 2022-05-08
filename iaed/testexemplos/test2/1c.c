#define MAX 1009

typedef struct node
{
    int value;
    struct node *next;
} Node;

Node *hash_tab[MAX];

int hash(int val)
{
    return val % MAX;
}

find(int val)
{
    Node *aux;
    int check = 0;

    for (aux = hash_tab[hash(val)]; aux; aux->next)
    {
        if (aux->value == val)
        {
            check = 1;
            return 1;
        }
    }

    if (check == 0)
    {
        return 0;
    }
}