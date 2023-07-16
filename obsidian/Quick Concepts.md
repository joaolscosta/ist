
# 3.

__FS CP/M__ - mapa de blocos por ficheiro com 16 entradas de 1kbyte.
__FS MS-DOS__ - tabela de blocos global partilhada por todos os files
__FAT__ - alocação na FAT nos dirs e o resto em blocos de igual dimensão. File identificado no dir pelo nome e na FAT pelo indice. Nas entradas valor 0 indice bloco livre. Cabe em RAM e tem tantas entradas como numero de blocos
__i-nodes__ - estrutura entre dirs que referenciam files e os seus blocos.
__Descritor de Volume__ - info do FS como loc cas tabelas de descritores e a tabela de blocos livres
__tabela de blocos livres__ - bitmap que vê se bloco está livre
__FS EXT__ - inumbers aos inodes. inodes limitados pelo tamanho das tabelas
__Referência Indireta__ - EXT3, indices dos blocos num vetor i_block do inode primeiras 12 posições diretas e 1 para 13, 2 para 14 e 3 para 15.

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
