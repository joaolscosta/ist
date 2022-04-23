#include <stdio.h>
#include <stdlib.h>

typedef struct node
{
    int value;
    struct node *next;
} Node;

int count(Node *head, int val)
{
    Node *aux;
    val = 0;

    aux = head;
    if (head == NULL)
    {
        return val;
    }
    if (aux->value == val && aux->next == NULL)
    {
        val++;
        return val;
    }
    if (aux->value == val && aux->next != NULL)
    {
        val++;
        aux = aux->next;
    }
    while (head != NULL)
    {
        if (aux->value == val)
        {
            val++;
        }
        aux = aux->next;
    }

    return val;
}

Node *insertLast(Node *head, int val)
{
    Node *aux;

    aux = head;

    if (head == NULL)
    {
        aux->value = val;
        return aux;
    }
    while (aux != NULL)
    {
        aux = aux->next;
    }
    aux->value = val;

    return head;
}