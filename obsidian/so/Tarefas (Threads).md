## Especificação Posix de tarefas

	Deu-se já que no Unix original não existia um modelo multi tarefa.

| Tarefas | Criar | Sincronizar com a terminação | Transferir | Terminar |
| - | -| - | - | - |
| Posix | pthread_create | pthread_join | pthread_yield | sleep | pthread_exit|

## Criar Tarefa

```c
int  pthread_create(pthread_t *thread, attr *attr, void *(*start), void *arg)
```

- (pthread_t * thread) -  identificador da tarefa
- (attr * attr) - define atraibutos da tarefa (apontador para estrututra)
- (void * (* start)) - função a executar
- (void * arg) - ponteiro para um parâmetro da função

A tarefa começa com a sua execução chamando a função `start` com o argumento `arg`

## Terminar Tarefa

```c
int  int pthread_exit(void *value_ptr)
```

- Termina Tarefa
- Retorna ponteiro para resultados

```C
int pthread_join(pthread_t thread, void **value_ptr)
```

- Tarefa espera até tarefa indicada ter terminado
- Ponteiro retornado colocado no segundo parâmetro
 

## Solução Sequencial vs Solução com Paralelismo
