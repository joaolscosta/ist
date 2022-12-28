
Para saber como programar com vários processos que partilham memória temos de:

-   Identificar as secções críticas.
-   Sincronizar cada secção com trincos.

> [!TIP] Definição
> Um trinco (mutex) é uma flag que garante que uma parte da memória é acedida __apenas__ por um _thread_ Se outra _thread_ quiser aceder a essa parte de memória não o poderá fazer, ficando à espera que a memória não esteja a ser acedida por qualquer outra _thread_.

## Trinco Global

Para garantir que uma _thread_ não tente aceder a uma parte de memória que outra _thread_ já esteja a correr é fazer com que não corram duas _threads_ ao mesmo tempo.


### Exemplo simples de _locks_

```c
struct {
  int saldo;
  // ...
} conta_t;

pthread_mutex_t mutex;

int levantar_dinheiro (conta_t* conta, int valor) {
  mutex_lock(&mutex); // Bloqueia o acesso a este endereço
                      // de memória a outras threads
  if (conta->saldo >= valor)
    conta->saldo = conta->saldo - valor;
  else
    valor = -1; /* -1 indica erro ocorrido */
  mutex_unlock(&mutex); // Desbloqueia o acesso a este
                        // endereço de memória
  return valor;
}
```

## Trincos Finos

Teoricamente queremos que as nossas funções sejam chamadas várias vezes por várias tarefas.
Pode acontecer que estas funções acedam a dados partilhados e para garantir que não existem bugs, devemos:

-   Identificar zonas críticas.
- "Trancar" as zonas críticas.

Apesar das funções terem bastante eficiência existem também contras:

-   Trincos ocupam espaço de memória.
-   As operações de Abrir e Fechar são demoradas.
-   Programar com muitos trincos finos leva a ter muitos bugs.

Existe um problema conhecido com este problema conhecido como _O Jantar dos Filósofos_.

### Jantar dos Filósofos

Cinco filósofos estão sentados à mesa e precisam de dois garfos para comer só que a mesa apenas tem um garfo por pessoa.
Os filósofos têm 3 estados: Pensar, Decidir e Comer.

##### Primeira Implementação

```c
filosofo(int id) {
  while (TRUE) {
    pensar();
    <adquirir os garfos>
    comer();
    <libertar os garfos>
  }
}
```

O problema disto éque o problema pode parar para sempre. Se cada filósofo fizer _lock_ do garfo à sua direita, __nenhum__ conseguirá efetuar o _lock_ do seu garfo à esquerda, ficando o problema parado para sempre.

##### Jantar mas com semáforos

```c
mutex_t garfo[5] = {...};

filosofo(int id) {
  while (TRUE) {
    pensar();
    fechar(garfo[id]);
    fechar (garfo[(id + 1) % 5]);
    comer();
    abrir(garfo[id]);
    abrir(garfo[(id + 1) % 5]);
  }
}
```

0 -> 1 -> 2 -> 3 -> 4

Um filósofo com esta implementação se quiser o garfo 3 e 4 terá de seguir a ordem de coletar primeiramente o garfo 3.
Isto resolve o acima dito mas abre o problema que o filósofo 4 escolherá o garfo 4 e posteriormente o 0.

```c
mutex_t garfo[5] = {...};
filosofo(int id) {
  while (TRUE) {
    pensar();
    if (id < 4) {
      fechar(garfo[id]);
      fechar(garfo[(id + 1) % 5]);
    else {
      fechar(garfo[(id + 1) % 5]);
      fechar(garfo[id]);
    }
    comer();
    abrir(garfo[id]);
    abrir(garfo[(id + 1) % 5]);
  }
}
```

Assim corre bem e apenas o filósofo 4 tem uma implementação diferente.

## Limitações dos Trincos

Têm a desvantagem que apenas servem para proteger secções críticas e não são sufecientemente expressivos para resolver outros problemas de sincronização.

### Exemplo Parque de Estacionamento

```c
int vagas = N

void entrar() {
  if (vagas == 0) {
    // esperar até haver vaga
  }
  vagas--;
}

void sair() {
  vagas++;
}
```

Agora com _mutexes_:

```c
int vagas = N;
mutex m;

void entrar() {
  do {
    lock(m);
    if (vagas > 0) break;
    else unlock(m);
  } while (1); // Existe problema
  vagas--;
  unlock(m);
}

void sair() {
  lock(m);
  vagas++;
  unlock(m);
}
```

Esta é de facto uma solução mas está constatemente dependente de __espera ativa__ ou seja, fica à espera de uma condição dentro de um ciclo.
Para otimizar estas situações usamos __Variáveis de Condição__.


## Variáveis de Condição


> [!TIP] Definação
> Estas variáveis permitem a uma tarefa esperar por uma condição dependenete da ação de outra tarefa. 
> A condição é um _bool_ determinado em função do estado de varoáveis partilhadas. Uma variável destas está sempre associada a um trinco. Pode haver mais do que uma variável associada a um trinco.
> Um conjunto de variável + trinco é chamado de __monitor__.

### Primitivas (Semântica Mesa)

```c
wait(conditionVar, mutex)
```

Atomicamente, liberta o trinco associado e bloqueia a tarefa e coloca-a na fila de espera associada à variável de condição. Quando for desbloqueada, a tarefa re-adquire o trinco e só depois é que a função esperar retorna.  
Uma tarefa só pode chamar `wait` quando detenha o trinco associado à variável de condição.

```c
signal(conditionVar)
```

Se houver tarefas na fila de espera da variável de condição, desbloqueia uma, passando o seu estado para executável. Se não houver tarefas na fila da variável de condição, esta operação não tem efeito.

```c
broadcast(conditionVar)
```

Análogo ao `signal` mas desbloqueia todas as tarefas na fila de espera da variável de condição.

Normalmente estas primitivas são chamadas quando a tarefa ainda não libertou o trinco associado à variável de condição



