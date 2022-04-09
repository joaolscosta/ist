#include <stdio.h>
#include <stdlib.h>

typedef struct
{
    int *v;  /* contents of the stack */
    int cap; /* capacity of v, i.e. how many elements can fit in v */
    int sz;  /* number of elements currently stored in v */
} stack;

stack *build()
{
    stack *s = malloc(sizeof(stack));
    s->cap = 4;
    s->sz = 0;
    s->v = malloc(sizeof(int) * s->cap);
    return s;
}

void push(stack *s, int e)
{
    if (s->sz == s->cap)
    {
        s->cap += 4;
        s->v = realloc(s->v, sizeof(int) * s->cap);
    }
    s->v[s->sz] = e;
    s->sz++;
}

void top(stack *s)
{
    return s->v[s->sz - 1];
}

void pop(stack *s)
{
    int e1 = top(s);
    s->sz--;
    return e1;
}

int is_empty(stack *s)
{
    return s->sz == 0;
}

void destroy(stack *s)
{
    free(s->v);
    free(s);
}