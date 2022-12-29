Problema de sistema de atualizações de contas bancárias.
Temos um servidor que recebe pedidos de débiro e créditos numa conta bancária.
Para tornar o servidor eficiente cada pedudi é __servido por uma tarefa independente.__

Podemos ter um ou vários clientes ao mesmo tempo.

![[Pasted image 20221213154751.png]]

![[Pasted image 20221213154818.png]]


- Programa está errado porque a sequência de testar o valor do saldo da conta e atualizado tem de ser indivisível.

#### Quando pode ocorrer a comutação?

Quando o Despacho é chamado na sequência de uma __Interrupção__, normalmente do _timer_.
Interrupções aceites no fim da instrução.
Se a operação fosse só uma instrução não há como comutar a tarefa.

## Trinco Lógico

Pode ser __aberto__ ou __fechado__.

Quando fechado outra tarefa que tente fechar espera até ser aberto.

Propriedade de __Exclusão Mútua__.

![[Pasted image 20221213155406.png]]


Agora podemos ver o programa ser problemas:

![[Pasted image 20221213155443.png]]


> [!TIP] Definição Exclusão Mútua
> Quando uma tarefa entra numa secção critica mais nenhuma tarefa poderá entrar até o trinco ser libertado.


## Propriedades num trinco

- Propriedade de correção (safety).

==Exclusão mútua== - no máximo uma tarefa detém um trinco.


- Propriedade de progresso

==Ausência de Interblocagem== - Se nenhuma tarefa está a executar a secção crítica e existem tarefas que a pretendem executar, então uma delas tem de conseguir entrar num intervalo de tempo finito.

Esta condição visa impedir que uma secção crítica possa bloquear indefinidamente as tarefas entre si colocando-as numa situação de interblocagem (deadlock).

==Ausência de míngua== - se uma tarefa tenta onbter o trinco, essa tarefa consegue obtê-lo (dentro de um tempo finito)

==Eficiência==.

## Implementações Simplistas

A comutação só é possível se gouver interrupções de outra forma o Despacho não é invocado.
Lock do trinco executa um _disable interrupt_.


## Inibir as Interrupções

As instruções de interrupções só podem ser executadas em __modo núcleo__ do processador.

O sistema operativo ficaria vulnerável a secções críticas erradas que não libertassem a secção crítica.

Não funciona em multiprocessadores.


# Trinco do Sistema Operativo

#### Recapitular:

- ==Inibir Interrupções== - não é possível em modo utilizador.
- ==Soluções Algorítmicas== - complexas e elevada latência.
- ==Mecanismo de espera== - espera ativa.

### Eliminar a Espera ativa com o suporte do SO

Retirar a tarea da fila de Despacho SEMPRE que não pode prosseguir a sua execução.
Corresponde a mudar o estado da tarefa para __BLOQUEADO__.

![[Pasted image 20221213160800.png]]


## Mutex com suporte do núcleo

O _mutex_ tem um estado __ABERTO__ ou __FECHADO__.

Caso a tarefa tente interferir com um fechado, o núcleo retura-a de execução, bloqueando-a numa lista de tarefas bloqueadas associadas ao _mutex_.

###### Operações:
- Criar
- Fechar (lock)
- Abrir (unlock)
- Eliminar

### Funções Lock e Unlock

![[Pasted image 20221213161218.png]]


Quando um trinco é libertado e existem tarefas bloqueadas, uma vai poder continuar.
A tarefa que vai acontecer quando existem várias bloqueadas é indeterminada.


### Interface POSIX para mutexes

```c
int pthread_mutex_lock(pthread_mutex_t *mutex)

int pthread_mutex_unlock(pthread_mutex_t *mutex)
```

Existem 2 formas de inicializar:

- Declarar mutex como variável estática.
```c
pthread_mutex_t trincoA = PTHREAD_MUTEX_INIT
```

- Declaração dinâmica durante a execução.
```c
int pthread_mutex_init(pthread_mutex_t *trincoA, pthread_mutexattr_t *attr)
```

*trincoA -> identificador do mutex
*attr -> atributos previamente definidos (podem ser NULL)


## Quando é que precisamos de usar _mutexes_?

Com uso de trincos os resultados podem ser inconsistentes.
Para uma função que só leia algo não é necesário usar mutex.


## Trinco Global

Normalmente é a solução mais simples mas __limita__ o paralelismo.

- Quanto mais paralelo for o programa maior é a limitação.

## Trincos finos: programação com objetos partilhados

Objeto cujos métodos podem ser chamados em concorrência por diferentes tarafas podem ter:
- Interface dos métodos públicos
- Código de cada método
- Variáveis de estado
- Váriáveis de sincronização - um trinco garante que métodos críticos se executam em exclusão mútua

Pode é trazer mais _bugs_ este método.




