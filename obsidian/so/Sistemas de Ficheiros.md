São objetos persistentes já que a informação é mantida mesmo quando a energia é desligada.

Pode haver memória de acesso rápido mas de custo elevado e memória de custo mais reduzido mas mais lentas.

![[Pasted image 20221209150543.png]]

 
## Dois níveis de Hierarquia de Memória

### Memória Principal (RAM)

- tempo de acesso reduzido
- custo elevado
- bom desempenho
- informação volátil
- RAM + _caches_ + (registos)

### Memória Secundária (Disco)

- tempo de acesso elevado
- custo reduzido
- pior desempenho
- informação persistente


# Objeto Ficheiro


> [!TIP] Definição
> É uma coleção de dados persistentes, relacionados e identificados por um nome.

A estrutura de dados é um __vetor de bytes__.
Tem um __nome__.
Modo de acesso é __sequencial__ tanto que cada ficheiro tem um índex que indica a posição onde está a ler ou escrever.
Tem informação de gestão - __metadata__.


# Objeto Diretório


> [!TIP] Definição
> É uma lista de ficheiros e atributos associados aos ficheiros.

- Lista os nomes dos ficheiros.
- No _Unix_ apenas relaciona o nome e o identificador, em outros SF pode ter _metadata_.

## Árvores de Diretórios

- Estão organizados de forma hierárquica.
- Navegação intuitiva.

## Caminhos de Acesso - _Pathname_

- Nomes absolutos: _/home/joao/SO/project.zip_
- Nomes relativos: _../SO/project.zip_

## Nomes e Extensões

Ficheiros têm uma extensão introduzida por um " . "

## Atributos de um File

Para além do tipo, um ficheiro tem:
- identificação de quem o criou.
- Proteção ( quem pode aceder ).
- Dimensão do ficheiro.
- Data de criação, última leitura e escrita.

## Ficheiros em Unix

### Tipos de Ficheiros:

- Normais ( sequência de bytes sem organização )
- Especiais ( periféricos, pipes, FIFOS, sockets )
- Ficheiros Diretório

#### Quando um processo começa a executar:

- O sistema abre três ficheiros:
	- _stdin_ - (fd - 0)
	- stdout - (fd - 1)
	- stderr - saída para assinalar erros (fd - 2)


