```c
FILE *fp; 
fp = fopen("tests.txt", "r"); // abrimos o ficheiro em modo leitura
```


## Exemplo 1

```c
#include <stdio.h>
#include <stdlib.h>
int main()
{
	FILE *fp;
	fp = fopen("teste.txt", "r");
	if (fp == NULL){
		printf("teste.txt: No such file or directory\n");
		exit(1);
	}
	return 0;
}
```

## Exemplo 2

```c
int main(){
	FILE *myfile; int i;
	float mydata[100];
	myfile = fopen("info.dat", "r");
	if (myfile == NULL){
		perror("info.dat");
		exit(1);
	}
	for (i = 0; i < 100; i++){
		fscanf(myfile, "%f", &myfile);
	}

	fclose(myfile);
	return 0;
}
```

### O que se ganha com o uso de Funções Sistema

Prós:
- funções de baixo nível então tem-se mais controlo
- algumas funções sobre ficheiros só estão disponíveis nesta API

Contras:
- `stdio` é mais simples e otimizado


## Abertura, Criação e Fecho de Ficheiros

Operações __SIMPLES__
```c
int open(const char *path, int *flags, mode_t mode)

int close(int fd)
```

É mantida uma __Tabela de Ficheiros Abertos__ por __processo__.

Abrir um ficheiro:
- pesquisar o diretório
- verificar as permissões de acesso
- copiar a meta-informação ( _i_node_ ) para a memória
- devolve um identificador ao utilizador ( _file descriptor_ ) que é usado como referência de posição de memória

Fechar um ficheiro:
- liberta memória da meta-informação que continha o ficheiro
- se necessário, atualiza a informação no sistema de memóri


> [!TIP] Definição de Processo
> Instância de um programa em execução.

## Autenticação de Processos

- Cada processo corre em nome de um utilizador _UID_ / _GID_.
- Atribuídos ao primeiro processo criado quando o utilizador dá login. Obtidos em `etc/passwd` no momento do login.
- Processos filho herdam _UID_ / _GID_.

#### Controlo dos Direitos de Acesso

O modelo mais frequente de autorização baseia-se numa __Matriz de Direitos de Acesso__.
- Colunas designam-se __Listas de Direitos de Acesso (ACL).
- Linhas designam-se por __Capacidades__.

### ACL em Unix

Simplificação das ACL do Unix consideram-se em três grupos:

- Dono
- Grupo
- Restantes utilizadores

`-rw-r--r-- 1 joao 21314  0 nov 15  2017  containder.dat`

- (-) regular file
- (rw) owner
- (r) group
- (--) others

#### Controlo dos Direitos de Acesso

1. Processo pede para executar operação sobre o objeto gerido pelo núcleo.
2. Núcleo valida de na ACL do ficheiro UID/GID correspondente ao processo tem direitors para executar aquela operação sobre aquele objeto.
3. Se sim o núcleo executa operação se não retorna erro.

#### Operações sobre Ficheiros Abertos

```c
int read(int fd, void *buffer, size_t count)
```

- o `count` especifica o número de bytes a ler.
- o `buffer` indica o endereço de memória no qual os dados devem ser colocados. Deve ter a dimensão de `count`. As chamadas do sistema não alocam memória para os dados que retornam.
- Uma chamada bem sucessida retorna o número de _bytes_ realmente lidos, ou 0 se o fim do ficheiro for encontrado. Em caso de erro o retorno é -1.
- Uma chamada `read()` pode ler menos bytes que o pretendido. No caso de um ficheiro regular, provavelmente estamos perto do fim do ficheiro.


```c
int write(int fd, void *buffer, size_t count)
```

- `buffer` é o endereço de dados a serem escritos
- `count` é o número de bytes a escrever
- `fd` é um _filedescriptor_ que referencia o ficheiro para o qual os dados devem ser gravados

- Se tiver sucesso, write() retorna o número de bytes realmente escritos, pode ser menos do que `count`

- Um retorno bem sucessido de `write()` não garante que os dados foram transferidos para o disco.


### O Cursor

- Para qualquer ficheiro aberto, o núcleo mantém um cursor
- Este índice indica a posição no ficheiro onde a próxima operação `read()` ou `write()` se executará
- o cursor é expresso como o deslocamento em bytes a partir do início ( o 1º byte do ficheiro tem deslocamento 0 )
- Avança automaticamente com cada byte lido ou escrito


```c
int lseek(int fd, off_t offset, int origin)
```

- o cursor pode ser alterado pelo programa
- o `offset` especifica um valor em _bytes_
- o argumento `whence` indica o ponto base a partir do qual o deslocamento deve ser interpretado

![[Pasted image 20221211032712.png]]


### Comando do Shell `strace` 

- usar o comando `strace` para ver as chamadas sistema que os programas estão a executar


## Diretórios e Nomes de Ficheiros

Um ficheiro pode ter vários nomes e chamos a isto de __links__.

## Links: _Hard Link_

- Entradas em diversos diretórios apontam para o mesmo ficheiro ( mesmo _inode_ ) e indistinguíveis.

- É uma cópia do ficheiro sem cópia real dos dados.

- Se apagarmos um ficheiro com vários _hard links_ o ficheiro continua a existir. Só é removido quando o __último__ for removido.

- A chamada `unlink()` usada para apagar ficheiros o que faz é eliminar um link e não apagar o ficheiro.


## Links: _Symbolic Link_

- O _symbolic_ é um ficheiro que contém o caminho para o ficheiro original. (de tipo diferente)

- Se o ficheiro original for apagado o link fica quebrado.

- Mais genérico para utilização, podendo ser usado para diretórios ou entre partições enquanto os _hard_ estão limitados a uma partição.

`lrwxrwxrwx ... .... ... exemplo2 -> exemplo1 ` : indica um ficheiro do tipo _symbolic_.


### Funções de Gestão de Ficheiros

- Copiar (Origem, Destino)
```c
int symlink(const char *oldpath, const char *newpath)
int link(const char *oldpath, const char *newpath)
```

- Mover (Origem, Destino)
```c
int rename(const char *oldpath, const char *newpath)
```

- Apagar (Nome)
```c
int unlink(const char *path)
```

- ListaDir (Nome, Buffer)
```c
int readdir(int fd, struct dirent *buffer, int count)
```

- MudaDir (Nome)
```c
int chdir(const char *path)
```

- CriaDir (Nome, Proteção)
```c
int mkdir(const char *path, mode_t mode)
```

- RemoveDir (Nome)
```c
int rmdir(const char *path)
```

### Descritores Individuais de Ficheiros (_i-nodes_)

- Um ficheiro é identificado dentro de cada partição pelo seu _i-node_.
- Os diretórios só fazem a ligação entre um nome do file e o seu descritor.

## Programação com Diretórios

- são lidos sequencialmente de uma entrada para a seguinte
- para abrir usamos `opendir()` que retorna uma estrutura de dados

```c
#include <dirent.h>
DIR *opendir(const char *dirpath);
```

### Leitura de Diretórios

`struct dirent *readdir(DIR *dirp`

- Cada chamada a `readdir()` lê a próxima entrada do diretório referenciado por `dirp` e devolve um ponteiro para uma estrutura de tipo `dirent` que contém:

```c
struct dirent {
ino_t d_ino; // File i-node number
char d_name[]; // Null-terminated name of file
};
```

- No __fim__ do diretório ou erro, `readdir()` retorna _NULL_, neste último caso `errno` infica o erro.

## Ler e Modificar Atributos

- `stat` -> permite ver a informação de um ficheiro.

### Estado do Ficheiro: _System Calls_

O estado de um ficheiro pode ser obtido através de um conjunto de _system calls_ que preenchem um _buffer_ passado como parâmetro da função.

Para executar é necessário ter acesso à diretoria. (não énecessário ao ficheiro)

```c
int stat(const char *restrict pathname, struct stat *restrict statbuf);

int fstat(int fd, struct stat *statbuf);

int lstat(const char *restrict pathname, struct stat *restrict statbuf);
```

### Mudança de Permissões

- `chmod` -> muda as permissões de um ficheiro.
```c
#include <sys/stat.h>
int chmod(const char *pathname, mode_t mode)
```


# Operações Globais sobre o Sistema de Ficheiros


## Comando Mount

- periféricos têm um diretório especial `/dev`.
- Para aceder aos sistemas de ficheiros dos dispositivos é preciso montá-los no sistema de ficheiros primário. Consiste em ligar a raiz do novo sistema de ficheiro a um diretório do sistema de ficheiros raiz.
- Tanto o dispositivo de base operação de montagem quer o que é montado possuem uma __árvore de diretórios com uma raiz única__.

##### Organizar Múltiplos Sistemas de Ficheiros
```
mount -t <filesystem> /dev/hd1 /b
```

![[Pasted image 20221211233140.png]]
- Depois de montar o diretório b do dispositivo `/dev/hd0` e a raiz do dispositivo `dev/hd1` passam a ser o mesmo diretório.
- Os ficheiros no dispositivo `/dev/hd1` ficam posteriormente acessíveis através dessa raiz.

## `mount`

- o mount existe para que em vez de ter um número de sistemas de ficheiros separados, este unifica todos numa árvore tornando uniforme e conveniente.
- para ver o que está montado no sistema e em que pontos basta executar `mount`.


## Resumo muito resumido

- A relação entre os ficheiros e os nomes dos diretórios é estabelecida através de __links__.
- Os diretórios são ficheiros com uma estrututra própria, podem ser lidos ou pesquisados.
- O estado dos ficheiros pode ser consultado e alterado (ACL).
- Existem operações globais como o mount que permite montar uma hierarquia única em diferentes sistemas de ficheiros.



# Organização dos Ficheiros no disco

- A gestão do disco é feita em blocos de tamanho fixo com o objetivo de otimizar o acesso ao disco.
- Um bloco é a unidade mínima que pode ser indexada diretamente pelo so.

#### Tamanho dos blocos:
- Quando maior for o bloco maior é a taxa de transferência bruta pois os tempos de latência de setores consecutivos são quase nulos, mas a taxa de transferência efetiva depende do número de bytes dentro do bloco com informação útil.
- Se um bloco estiver apenas meio cheio a sua transferência efetiva é metade da transferência bruta, o que significa que quantos maiores forem os blocos maiores serão as diferenças entre as transferências entre a bruta e a efetiva.

## Visão de um Dispositivo do Tipo Disco

![[Pasted image 20221212001322.png]]

- Uma __partição__ é uma subdivisão de um dispositivo físico dividida em blocos de tamanho físico.
- Uma partição é vista pelo SO como um vetor de blocos ordenado a partir do número zero.
- Cada partição não tem nada a haver com as outras.
- Não existem ficheiros repartidos por partições diferentes.

- O _Master Boot Record_ e o bloco de boot são identidades para localizar e executar um sistema operativo.
- O MBR possui código independente do SO que localiza a partição que contém o sistema operativo a executar e transfere a execução para o código existente no primeiro bloco dessa partição - o bloco de _boot_.

## Boot

- O bloco de boot possui