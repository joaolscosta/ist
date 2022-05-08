#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct node
{
    int value;
    struct node *next;
} Node;

Node *del_last(Node *head)
{
    Node *aux = NULL;

    aux = head;

    if (head == NULL)
    {
        return head;
    }

    if (head != NULL && head->next == NULL)
    {
        free(head->value);
        free(head);
        return head;
    }

    while (aux != NULL)
    {
        if (aux->next == NULL)
        {
            free(aux->value);
            free(aux);
            return head;
        }

        aux = aux->next;
    }
}