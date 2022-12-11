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
2. Núcleo valida de na ACL do ficheiro UID/GID correspondente ao processo tem direitors para executar aquela operação sobre aquele objeto
3. 

