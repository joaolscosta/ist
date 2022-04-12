#include <stdio.h>
#include <stdlib.h>

typedef struct stru_node
{
    struct stru_node *next;
    int v;
} node;

node *head;

/* remove the first element of the list and return the new head */
node *pop(node *head)
{
    node *t;

    t = head->next;
    free(head);
    return t;
}

/* add integer e as the first element of the list and return the new head */
node *push(node *head, int e)
{
    node *d;

    d = malloc(sizeof(node) * 1);
    d->v = e;
    d->next = head;

    return d->next;
}

/* frees all memory associated with the list and returns NULL */
node *destroy(node *head)
{
    free(head);
    return NULL;
}

/* print the elements of the integers in the list, one per line */
void print(node *head)
{
    node *temp;

    temp = head;
    while (temp != NULL)
    {
        printf("%d\n", temp->v);
        temp = temp->next;
    }
}