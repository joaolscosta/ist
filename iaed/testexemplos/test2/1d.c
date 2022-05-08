typedef struct node
{
    int value;
    struct node *left;
    struct node *right;
} Node;

typedef struct
{
    int count;   /* number of values in the vector */
    int *values; /* dynamically allocated vector of values */
} Vec;

Vec tree2vec(const Node *h)
{
}

/* MEN NÃO ENTENDI FOI NADA DESTA CHATICE */