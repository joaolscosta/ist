### 1. Introdução aos SO

- Interface operacional e gráfica


### 2. Everything is a File

- Ficheiro
- Sistema de Ficheiros
- Everything is a File
- Nomes absolutos e relativos
- Hard Links
- Mount
- Processo
	- Abrir
	- Ler / Escrever
	- Fechar
- Memória Principal e Secunsária
- Canais Standart
- Cursor
- `ftell` e `fseek`
	- SEEK_SET, SEEK_CUR, SEEK_END
- `fflush`


### 3. FileSystem

- Alternativas de organização do disco
- FS CP/M
	- Blocos, Mapa de blocos, entradas 
	- aumentar dim max
- FS MS-DOS
- FAT: 3 alocações
	- Identificar blocos
	- Entradas da FAT
	- Pontos importantes e desvantagens
- i-nodes
	- atributos, tipo de estrutura, vantagens
	- Percorrer a árvore de dirs
- Descritor Volume
- Tabela de Blocos Livres / Tabela de Alocação
	- Bitmap
	- Vantagens
- FS EXT
	- bitmap de inodes e de blocos
- Referência Indireta
	- vetor `i_block`
	- dim máxima de um file
- Estruturas de suporte à utilização de files
	- Passos
- Tabela de files abertos
	- Tabela de files abertos por processo
	- Tabela de files abertos global


### 4. Programação Paralela

- Processo tem:
	- Espaço de endereçamento virtual
	- instruções
	- execução
	- Propriedades de processo
	- Operações
- PID
	- pid 0 swaapper
	- pid 1 init
- fork
	- copia oq do pai
	- o que devolve ao pai ao filho e em erro
- exit
	- o que liberta
	- o que acontecegth
- wait
	- o que faz
	- o que retorna
	- onde é usado
	- qual filho é retornado
- relação entre exit de um processo e wait do pai
	- o que se mantém
- quando é que um processo está em estado zombie
- quando é que o processo é totalmente esquecido
- Executar programas
	- execl
	- execv
- O que é e faz uma shell
	- passos
- Threads
	- o que threads do mesmo processo partilham
	- o que não partilham
- pthread_join oq faz




### 5. Programação Multi-Tarefa

- Mutexes
	- o que garante
- Trincos Finos
	- desvantagens
- Espera Ativa
	- o que é e como se resolve
- Condvars
	- wait
	- signal
	- broadcast


### 6. Implementação de um Mutex

- Para bom funcionamento do mutex
	- Propriedade Correção (Safety)
		- Exclusão Mútua
	- Propriedade Progresso (Liveness)
		- _Deadlock_
	- Ausência de Míngua (Starvation)
- Soluções Algorítmicas
- Soluções hardware


### 7. Comunicação entre Processos

- Dois paradigmas de programação concorrente:
	- Memória Partilhada
	- Troca de Mensagens 
- Canal de Comunicação:
	- no núcleo
	- no user
- Pipes
	- definição
	- o que acontece quando escreve num cheio
	- oq acontece quando lê um vazio
	- 0 para ler, 1 para escrever
- dup
	- para o que aponta, qual modo de acesso e qual fd
- Redirecionamento da shell
- Named Pipes / FIFO
	- definições
	- named pipe unidirecional (bytestream)
	- Como criar mkfifo
	- Como eliminar unlink
- Signals
	- tratamento de forma assíncrona
	- definição
- Rotinas Assíncronas
	- Como são tratadas
	- Tabela de eventos, testa-se cada uma para identificar se é assíncrona
	- onde estão, signal.h
	- `SIG_DFL SIG_IGN`
- Mandar Signals:
	- kill
	- unsigned_alarm
		- `SIGALRM`
	- pause
	- sleep
	- raise
- Semânticas de Signals:
	- SystemV
	- BSD


### 8. Organização do SO

- Abstrato
- Multitarefa
- Segurança
- Modo User
	- tipo de acesso
	- modo de acesso
	- chamada de sistema
- Modo Núcleo
	- Interação
	- executador
	- o que corre neste modo
	- exceções
		- assincrocas: interrupções
		- sincronas: programa
- interrupções
- O que acontece numa chamada de sistema
- Incializar o SO
- Estrutura de SO
	- Monolítica
	- Sistema de Chamadas
	- Micro Núcleo

### 9. Gestão de Processos

- Gestor de Processos (kernel)
	- Todas as suas funcionalidades
- Contexto de um processo
	- Contexto de hardware
		- registos
		- UGM
	- Contexto de software
		- metadados
- Vida de um Processo
- Gestor de Interrupções
	- Passos (fdd)
		- agulhagem
		- RTI
- Chamadas de Sistema estruturadas em:
	- Rotina de Interface
		- trap
	- Função de Núcleo
- Sistema garante:
	- Proteção
	- Uniformidade
	- Flexibilidade
- Pilha para utilizador e pilha para núcleo
- Quando o CPU comuta processo em modo user tem de:
- Porque se usam duas pilhas
- Scheduling (Escalonamento)
	- definição
	- métricas para bom escalonamento:
		- Débito
		- Turn around time
		- Uso CPU
		- Responsividade
		- Deadlines
		- Previsibilidade
- Round-Robin
	- Como funciona
	- Onde se dispõem os processos
	- qual o próximo processo a ser executado
	- quanto tempo é executado cada processo
	- Quando é que o processo perde o CPU
	- Desvantagem
- Multi-lista
	- definição
	- tipos de prioridades
	- desvantagem da fixa
	- vantagem da dinâmica
	- tipos de quantums
- Preempção
	- quando é que se retira o CPU ao processo
	- pseudo-preempção
		- quando é que se perde um CPU
- Gestor de Processos do UNIX
	- Estrutura `proc`
		- p_stat
		- p_pri
		- p_sig
		- p_time
		- p_cpu
		- p_pid
		- p_ppid
	- Estrutura `u (user)`
		- registos de CPU
		- pilha do núcleo
		- códigos de proteção
		- ref ao dir
		- tabela de files abertos
		- apontador para proc
		- parâmetros da f sistema em exec
- Escalonamento em UNIX, prioridades:
	- Prioridades do processo em user
		- quais prioritários
		- forma de cálculo
	- Prioridades do processo em núcleo:
		- quais prioritários
		- forma de cálculo
	- Prioridades em modo user:
		- qual processo fica com o CPU e durante quandto tempo
		- Qual o método de escalonamento
		- qual cálculo de prioridades
		- Fórmula
			- Prioridade
			- Tempo de Processador
	- Chamadas de sistema:
		- nice
		- getpriority
		- setpriority
	- qual método de recalculo de processos em unix
- Gestor de Processos em LINUX
	- como divide o tempo
	- quando acaba uma época
	- formulas
		- quantum_epoca
		- prio_epoca
		- qual processo mais prioritário
- CFS - Completely Fair Schedule 
	- vruntime
	- qual processo mais prioritário
	- qual o vruntime de um novo processo
	- red-black tree
	- complexidade de tempo de execução
- Operações do Gestor de Processos em POSIX
	- fork
	- exit
	- wait
	- exec
	- signal

### 10. Gestão de Memória

- Espaço de endereçamento
- Memória Principal
- Memória Secundária
- Gestor de Memória gere endereçamentos dos processos que ...
- Endereçamento virtual
- UGM
- O que acontece na conversão
- 2 tipos de blocos
	- segmentos
	- páginas
- Modo normal de acesso
- Quando é que tem que ser pelo núcleo:
- Fragmentação Interna
- Fragmentação Externa
- Segmento
	- dimensão de cada
	- tabela de segmentos
		- bit p
		- bit prot
		- limite
		- base
	- como obter a posição na tabela de segmentos
		- BTS
		- LTS
- Páginas
	- endereçamento virtual
	- tabela de páginas
		- bit p
		- bit R e M
		- bit Prot
		- base
	- o que acontece se CPU aceder a endereços com mais do que uma página:
		- page fault
	- Dimensão das páginas influencia:
- Otimização de tradução
	- TLB guardada pela UGM
	- Princípio da localidade de referência
	- página visitada UGM mete na TLB
	- dim
- Tabelas Multi-nível
	- contas
	- objetivo destas tabelas
- Algoritmos de gestão de Memória
	- Alocação
	- transferência
	- Substituição
- Alocação
	- para paginação o que faz
	- para segmentação o que faz
- Fragmentação Interna
- Fragmentação Externa
- Segmento
	- para reserva de segmentos:
		- best-fit
		- worst-fit
		- first-fit
		- next-fit
- Transferência
		- a pedido
		- por necessidade
		- por antecipação
	- Transferência de Segmentos
		-  a pedido
		- swapping
		- swap area
		- swapped out
	- Transferência de Páginas
		- por necessidade
	- Critérios para decidir qual processo transferir para o disco
		- estado e prioridade
		- tempo e permanência na memória principal
		- dimensão do processo
	- Espaço de trabalho de um processo
- Substituição
	- Por página
		- FIFO
			- timestamp
		- NRU 
			- paginador
			- R e M
		- LRU
			- principio da localidade de referência
			- idade
			- paginador
- Vantagens e Desvantagens da Segmentação e Paginação
