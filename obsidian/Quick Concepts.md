# 2. 

__FS__ - organizado por nomes (hier), tem metadados de cada file na mem sec. Ligação entre nome e ident numérico. -l
-rwxrwxrwx
Everything is a File - todos os objetos acedidos por fd.
__Nome absoluto__ - caminho desde a raiz.
__Nome Relativo__ - caminho desde o dir atual.
__Hardlink__ - só quando o ultimo hardlink é apagado é que o arquivo é apagado e libertado o espaço.
__Mount__ - liga a raiz do novo FS a um dir do FS base. mount -t FS /dev/hd1 /b (liga /dev/hd1 a b)
__Processo__ - instancia de programa. 1 tabela de files abertos por processo. Para abrir pesquisar dir e ver se file existe. Verificar permissões. Copiar metadados e modo de acesso e devolver o ident.
__Standart__  - processo criado, canal stdin, stout, sterr. + simples que bibliotecas.
__Cursor__ - em q posição de file estamos. avança automaticamente com cada byte lido ou escrito.
```c
long ftell(FILE *stream) // em q posição estamos
int fseek(FILE *stream, long offset, int whence) // meter noutra posição
// offset: se positivo anda para a frente e negativo para trás
// whence: SEEK_SET -> inicio, SEEK_CUR -> atual, SEEK_END -> final
int fflush(FILE *stream) // faz com  que tudo seja escrito no disco porque as escritas fazem-se tarde e assim faz logo.
```


# 3.

Para cada disco um boot block com instruções em RAM.
__FS CP/M__ - mapa de blocos por ficheiro com 16 entradas de 1kbyte.
__FS MS-DOS__ - tabela de blocos global partilhada por todos os files
__FAT__ - alocação na FAT nos dirs e o resto em blocos de igual dimensão. File identificado no dir pelo nome e na FAT pelo indice. Nas entradas valor 0 indice bloco livre. Cabe em RAM e tem tantas entradas como numero de blocos
__i-nodes__ - estrutura entre dirs que referenciam files e os seus blocos. Vantagem de várias entradas apontarem para o mesmo file. Número máximo de files numa partição é o número máximo de inodes.
__Descritor de Volume__ - info do FS como loc cas tabelas de descritores e a tabela de blocos livres
__tabela de blocos livres__ - bitmap que vê se bloco está livre. cada inode tem os metadados e a loc do file. 
__FS EXT__ - inumbers aos inodes. inodes limitados pelo tamanho das tabelas
__Referência Indireta__ - EXT3, indices dos blocos num vetor i_block do inode primeiras 12 posições diretas e 1 para 13, 2 para 14 e 3 para 15. Dim Máxima fórmula

Todos os FS têm uma struct em memória voltátil para apoiar a info persistente. Cria canais virtuais, > desempenho com caches, tolera falhas, isola apps.

__File table__ - tem cursor de RW e modo como foi aberto.
__Tabela de files Abertos__: Existem duas para garantir isolamento entre processos.
	__Por processo__ - tem fd para cada file aberto e espaço protegido só acedido por núcleo.
	__Global__ - tem info do file aberto e o espaço protegido.

# 4.

exit() não elimina a task_struct marcando o processo como zombie. Elimina as regiões de memória do processo, fecha files abertos e elimina-os se não houver hardlinks nem outros processos abertos com o mesmo file.

```c
pid = fork();
if(pid == 0){
	exit(0)
}
else{
pid = wait(&estado);
}

//pai espera que um filho termine. Se algum está no estado Zombie retorna imediatamente o PID e o estado de terminação.
```

Processo tem:
	__Espaço de endereçamento virtual__ - tem memória a que pode aceder, código, dados, pilha e dim variável.
	__Intruções__  - instruções em modo user e função de sistema.
	__Execução__ - info para retomar.

```c
int fork() // copia espaço de endereçamento e contexto. Lança novo processo com o mesmo código

void exit(int status) // liberta recursos e fecha files. Notifica pai que acabou.

int wait(int status) // suspende até um filho acaba. Retorna PID do que terminou.
```

Quando se faz exit mantém-se o necessário para o pai chamar wait. Entre estes dois o filho está em zombie.

```c
int execl(char file, char arg0, ...,  char argn, NULL ou 0)
int execv(char file, char argv[]);
```

__Shell__ - ciclo infinito em que cada iteração imprime msg, lê comando, cria filho q executa programa, shell bloqueia até iteração terminar e prxm iteração.

__Threads__ : No mesmo processo partilham código, amontoado (heap) e atributos do processo.
Não partilham stack, estados do registos no CPU, atributos da thread TID.

```c
int pthread_create(&tid, attr, func, arg)
void pthread_exit(void value_ptr)

int pthread_join(pthread_t thread_2, void value_ptr ou NULL) // tarefa espera até thread_2 ter terminado


```

# 5.

RWlocks permitem mais paralelismo quando os acessos são de leitura pois podem várias threads aceder ao mesmo tempo.
Em cenários de escrita mutexes têkm mais paralelismo e duram mais.

Trylock em vez de lock evita interblocagem.

__Espera Ativa (Spinlock)__ - thread contunua a veruficar se um estado ou condição continua bloqueado. Não entra em espera. Resolve-se com condvars.

__Interblocagem (Deadlock)__ - duas ou mais threads estão bloqueadas esperando que os recursos de cada um deles sejam libertados para continuarem com as suas operações. Não podem continuar o seu trabalho sem aqueles recursos. Leva a uma paralisação do sistema e só com interrupções é que saimos dessas situações.

__Problema de Míngua (Starvation)__ - Quando as threads não podem prosseguir com as suas funções por falta de recursos. Não por já estarem a ser utilizados mas por não haverem mesmo. Devido a escalonamento, prioridades mal definidas e deadlocks.

__Trinco Fino__ - bloqueia o necessário. Desvantagem: ocupam memória, abrir e fechar é demorado e pode levar a bugs.

```c
wait(condVar, mutex) // liberta mutex e bloqueia tarefa e coloca-a atomicamente na fila da condVar. Quando libertada a tarefa vai buscar o mutex e só depois a função retorna.

signal(condVar) // se há tarefas na fila desbloqueia uma passando a executável.

broadcast(condVar) // desbloqueia todas.
```

__Named Pipes / FIFO__ - Counica dois processos que não sejam pai e filho. Comporta-se como file e tem entrada na dir. Pode ser aberto pro processos, tem dono e permissões.
Named Pipe unidirecional (byte stream)

```c

int mkfifo(const char pathname, mode_t mode) // mode = 0666. Bidirecional em que os dados escritos num lado do FIFO podem ser lidos pro ordem de chegada. Abre com open bloqueando até pelo menos 1 processo abrir a outra extremidade.

int unlink(const char pathname) // Excluir um arquivo. R bloqueia até escrever no pipe. W bloqueia até alguém ler a mensagem.
```

```c
int arquivo = fopen("exemplo.txt", "w");
fprintf(arquivo, "blablabla");
fread(buffer, 1, , sizeof(buffer), arquivo);
fwrite(buffer, 1, elementos_lidos, stdout);
fclose(arquivo);
// se o ficheiro não existir abre para escrita.

int fd = open("exemplo.txt", O_WRONLY | O_CREAT | O_TRUNC, 0666);
read/write(fd, char mensagem, sizeof(mensagem));
close(fd);
// Ele não é criado automaticamente se não existir para escrita. Temos que abrir com create() ou open() 
```

__Signals__: Notifica o SO. Um processo pode notificar outro. Reage e trata-se de forma assíncrona.

__Rotina Assíncrona__ - Tratadas com interrupções de sistema. (CTL-C ou timeout). Existe uma tabela com todos os eventos. Testa-se cada um para identificar qual é o que estamos a testar.
Podem terminar o processo, ignorar o sinal, suspender o processo ou continuar o suspenso.

SIG_DFL - omissão
SIG_IGN - ignora

signal(SIG_IGN, func)

```c	
int kill(pid_t pid, int sig) // pid é para que processo o signal é enviado. SIGTERM - processo terminar. SIGKILL - termina à força. SIGINT - interrupção.

unsigned_alarm(unsigned int segundos) // SIGALARM enviado para o processo.

int pause() // aguarda sinal.

unsigned_sleep(int segundos) // espera

int raise(int sig) // sig enviado para o proprio processo.
```

__SystemV__: signal faz uma ativação e omite.

__BSD__: Depois da ativação não é desfeito e a receção de um novo signal é inibida durante a rotina.
# 6.

Num mutex para o bom funcionamento:

__Propriedade de Correção (Safety)__: Exclusão Mútua - uma tarefa para um mutex.

__Propriedade de Progresso (Liveness)__: Não interblocagem.

__Ausência de Míngua (Starvation)__: não haver deadlock mas + eficiente.

# 7.

Quando acontece um signal num processo o sighandler mete isso na tabela de signals. Quando o signal é detetado o SO verifica a tabela para encontrar a rotina para aquele signal. Quando muda de núcleo para user o SO verifica se há signals pendentes. Se houver a rotina é executada em modo usuário depois da mudança de núcleo para user.

Uma rotina de tratamento de um signal não é uma rotina do núcleo mas sim uma função do user.

Uma rotina só trata de um signal de cada vez.

Pode haver um tratamento por omissão para um signal mas não para todos como em cima.

O contador de um semáforo vê a quantidade de recursos disponíveis. Se for 0 quer dizer que todos os recursos estão em uso, as threads têm que bloquear até ser maior que zero.
Quando tem o valor 1 uma thread pode entrar na secção crítica sem esperar. Quando outra thread verifica se o valor do semáforo e seja 1 pode entrar e muda o valor do semáforo para 0 antes de entrar.

pause() suspende um programa até receber um signal.

__Memória Partilhada__: threads partilham heap. RW na mm memória partilhada. Sincronização com mutexes, semáforos...
__Troca de Mensagens__: thread trabalha com dados privados. Tarefas transmitem dados trocando mensagens. Mensagens sincronizam tarefas.

Canal de comunicação no núcleo, dados enviados por syscalls, no user, processos acedem a memória partilhada.

__Pipe__: bloqueado quando escreve num cheio e quando lê um vazio.

```c
int fd[ 2 ] - 0 para ler e 1 para escrever.

int dup(int oldfd) // o novo fd duplicado é o mais baixo e cria uma nova entrada na tabela que aponta para o fd oldfd.
```

Redirecionar I/O de programas na Shell. `ls -la | grep xpto | ...` redireciona o output de ls -ls para grep xpto cujo output é redirecionado para os que se seguem.
# 9.

__kernel__ - entidade do núcleo que executa processos e tarefas e também responsável por interrupções, otimização de processos (escalonamento) e das chamadas de sistema e sincronização.
__Contexto de Processo__
	__Hardware__ - Registos de processador. Fazem parte do processo e são guardados quando se troca. Guarda-se também UGM.
	__Software__ - guardados metadados do processo em execução.
__Ciclo do gestor de Interrupções__
	__Agulhagem__ - identifica a interrupção.
	__RTI__ - sai do modo núcleo para o novo processo escolhido.
__Chamadas de Sistema__
	__Rotina de Interface__ - usa trap para invocar funções no núcleo e código e executado pelo user.
	__Função do Núcleo__ - código do núleo e executado oq é solicitado pelo user.
__Proteção__ - o que é do núcleo não é acedido pelo user.
__Uniformidade__ - funções de sistema partilhadas por todos os processos.
__Flexibilidade__ - pode ser modificado desde que não se altere a interface.
__Pilha para user e para núcleo__ - dá segurança para nao se aceder a info do núcleo. Quando se comuta um processo em modo user muda-se o espaço de endereçamento e pilha para núcleo.
__Escalonamento__ - para qual processo trocamos. métricas:
	__débito__ - maximizar jobs.
	__Turn around time__ - minimizar tempo entre jobs
	__Maximizar uso do CPU__
	__Responsividade rápida__
	__Deadlines__
	__Previsibilidade__
__Round-Robin__ - cada processo tem um quantum definido e pode executar-se enquanto que se esgote ou bloqueie. Processos prontos a executar-se vão para a fila e o primeiro a chegar é o primeiro a executar. Se o processo já não vai executar mais antes de acabar o seu quantum este é retirado da fila, senão volta para lá para depois terminar.
__Multi-lista__ - multilista com listas que têm processos com dada prioridade. Processos + prioritários recebem CPU primeiro. Prioridade fixa podem processos menos prioritários nunca receber CPU e dinâmicos os processos que não recebem o CPU há mais tempo + prioritários com quantums diferentes.
__Preempção__ - retira-se o CPU ao processo assim que houver um + importante.
	pseudo-preempção faz com que haja um tempo mínimo de execução para não estar a haver trocas constantementes. 
__Gestor de Processos em UNIX__ - 2 estruturas
	__Estrutura proc__ - info do proc em RAM mesmo não em execução. Info para escalonamento e signals.
	__Estrutura u__ - restante info do proc quando em execução.
__Escalonamento em UNIX__ - Prioridades em:
	__Processo em user__ - de 0(+ prioritário) a N. dinâmico.
	__Processo em núcleo__ - quanto mais negativo mais prioritário. fixas. + prioritárias que em user.
__Prioridades em user__ - CPU atribuído ao p + prioritáraio com quantum de 100ms (5 ticks). Round-Robin. A cada 50 ticks prioridades calculadas.
__nice(int val)__ - adiciona val ao nice. este p fica cada vez menos prioritário.
__Gestor de Processos em LINUX__ - divide tempo em épocas. Época acaba quando todos os seus processos esgotam quantum. No início é atribuido um quantum e uma prioridade a cada quantum. Os mais importantes têm valor elevado e são estes escolhidos primeiro.
__CFS (Completly Fair Schedule)__ - Cada processo tem um vruntime. Este é o tempo de execução em user. Quando o p perde o CPU o seu vruntime é incrementado com o tempo do quantum. Processo + prioritário é com o vruntime mínimo. Novo processo entra com vruntime mínimo entre os ativos. Processos guardados numa red-black tree ordenada por vruntime que encontra o mais prioritário em O(logn).
__Gestor de Processos de POSIX__
	__fork()__ - 

# 10.

__Memória Principal__ - RAM. Armazena temporariamente dados do CPU enquanto executa tarefas. Volátil (desligado perde-se). Acessado com tempo constante seja onde for. Mais rápida. Custo elevado
__Memória Secundária__ - Permanente. Armazena mais. Não volátil. Mais lenta
__UGM__ - traduz end virtual em mem física. Divide em segmentos ou páginas.
Sempre em user só vai para núcleo qd comuta processos, acede ilegalmente.
__Frag Interna__ - Fica memória por preencher no bloco.
__Frag Externa__ - Blocos livres espalhados pela memória. Blocos alocados substituídos por menores.
__Segmentos__ - divide programas.
__Páginas__ - blocos tamanho fixo.
__TLB__ - guardada na UGM para otimizar (principio da localidade de referência). TLB limpa em cada comutação de processos. + quantum + páginas acedidas + entradas na tabela.
__Tabelas Multinível__ - espaço = espaço de endereçamento / páginas.
tabela de páginas = entrada x espaço. Usam-se estas porque consomem menos memória que só fazem algumas coisas. Esta em memória apenas páginas usadas pelo processo.
__Partilha mem entre processos__ - basta ter a mesma base da pagina nos dois. + eficiente para criar novos.
__Copy on write__ - adia cópia até ser necessário modificar os dados. Cria uma referência em vez de copiar completamente logo. Quando o processo que está referenciado for alterado aí copia-se tudo.
__Alocação__ - onde colcoar bloco na mem primária. Para paginação encontrar livre.
Para segmentação temos que reservar com:
	- __best-fit__ - menor possível. gera fragmentos e é uma lista ordenada por tamanho e percorre-se para introduzir.
	- __worst-fit__ - maior possível. pode não alocar blocos de grandes dimensões. lista percorrida.
	- __first-fit__ - primeiro. menos tempo, frag externa. blocos pequenos no inicio e grandes no fim.
	- __next-fit__ - blocos pequenos por toda a memória.
__Transferência__ - transferir blocos entre memórias.
	- __a pedido__ - programa ou SO decidem quando se carrega bloco na mem princ.
	- __por necessidade__ - bloco acedido e gera falta.
	- __por antecipação__ - bloco carregado na mem principal depois do principio da localidade de referência.
__Transferência de Segmentos__ - a pedido.
	- __swapping__ - com pouca memória os processos não utilizados vão para o disco.
	- __swap__ __area__ - área separada do disco chamada área de transferência.
	- __swapped out__ - todos os segmentos do processo transferidos.
__Transferência de Páginas__ - por necessidade. páginas não acediddas não chegam a ser carregadas na mem principal
	- __swapping__ - guardar todas as páginas de um processo no disco.
	- __paging__ - guardar páginas individuais no disco.
__Decidir qual processo transferir__ - processos bloqueados e menos prioritários. tempo e dimensão.
__Substituição__ - bloco que retiramos da memória.
__Por paginação__ - retira-se a com mais distante. Mede-se com:
	- __FIFO__ - timestamp a cada entrada de quando foi colocada em RAM. Tirar a colocada há mais tempo.
	- __NRU (not recently used)__ - UGM mete R=1 se há leitura e M=1 se há escrita. Paginador corre e mete R=0. R referenciada e M modificada. Liberta-se as páginas com grupos mais baixos.
	- __LRU (Least recently used)__ - princípio da localidade de referência. Bit R e idade. Paginador aumenta idades das R=0. Sempre que acedida UGM faz R=1 e idade anula. Quando chega a determinada idade passa a lista para poder ser transferida.
__Vantagens e Desvantagens__

Quando um processo é executado acede a endereços virtuais para acessar a memória. Estes endereços são gerados pelo processo e não correspondem diretamente aos reais em RAM. A conversão é feita pela MMU que utiliza a tabela de páginas para encontrar a correspondência entre os dois endereços.

Dois processos podem ter enderços virtuais iguais. Cada um tem a sua tabela de páginas

Quanto mais bits tiver o número de página mais espaço de endereçamento e maior número de páginas na memória virtual tem.

Para 32 bits de endereçamento virutal com 12 de deslocamento para sabermos o número de hexadecimais pertencentes ao número da página é 2⁵=32 -> 5 primeiror hexa.  
0x**A0001**FB0

Quando se visita um endereço virtual existe um acesso à página. Pode existir é dois acessos um à pagina e um à tabela de páginas caso o número de página não tenha sido visitado e mete-se na TLB.

BTS realiza uma operação atómica em um bit de um valor em memória. Implementa algoritmos de exclusão mútua (mutexes) e sincronização de processos e threads.
Processador lê memória e testa bit. Se estiver a 0 passa a 1 e retorna 1. Se estiver a 1 retorna 0 sem mudar o valor. Acontece esta operação sem sem interrompida por outros processos (é atómica)

Espera ativa quando um processo/thread verfica constantemente se um mutex já está livre em vez de entrar em suspensão e ser notificado quando já estiver livre. 
