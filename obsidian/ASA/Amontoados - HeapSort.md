
> [!abstract] Vetor de valores interpretado como uma árvore binária

- length[A] : Tamanho do vetor.
- heap-size[A] : número de elementos do amontoado.
- A[1] : raiz da árvore.

- Parent(i) = [i/2]
- Left(i) = 2i
- Right(i) = 2i + 1

- A[Parent(i)] >= A[i]

![[Pasted image 20221126202742.png]]

## Árvore Binária Completa

- Cada nó tem exatamente 0 ou 2 filhos.
- Cada folha tem a mesma profundidade.

## Essencialmente Completa

- Cada nó pode ter 0,1 ou 2 filhos.
- Folha pode ter profundidade  d ou d-1.


## Invariante Min-Heap

> [!abstract] O valor do nó é <= ao valor dos nós descendentes.

- A[Parent(i) <= A[i]]
- Usa-se em priority queues

#### Invariante Max-Heap

> [!abstract] O valor do nó é >= ao valor dos nós descendentes.
> 

- A[Parent(i) >= A[i]]
- Usa-se no heapsort


> [!example] Exemplo
> ![[Pasted image 20221126203815.png]]

##### Operações
- **Heap-Maximum(A)**: devolve o valor máximo de A.
	- O(1).


- **Max- Heapify(A, i)**: corrige uma violação da variante i

	- Altura do amontoado: h =  ==CORRIGIR AQUI== log n 
	- Complexidade: O(log n).

> [!example]
> 
> Recorrência: T(n) = T(2n/3) + O(1)
> d = log(3/2).1
> T(n) = O(n^d log n) = O(log n)
> 

- **Build-Max-Heap(A)** : constroi um max heap a partir de um vetor.
	- O(n log n).

- Extrair consecutivamente o elemento máximo de um amontoado;
- Colocar esse elemento na posição certa do vetor.


# Priority Queues


> [!TIP] Definição 
> Implementa um conjunto de elementos S e em cada um desses elementos tem associada um valor/prioridade

- Para manipulara a fila precisamos de operações:


> [!INFO] Operações
> - **Max-Heap-Insert(S, x)** - insere um elemento $x$ num conjunto $S$.
> - **Heap-Maximum(S)** - devolve o elemento de $S$ com o valor máximo.
> - **heap-Extract-Max(S)** - remove e devolve o elemento de $S$ com o valor máximo.
> - **Heap-Increase-Key(S, x, k)** - incrementa o valor de $x$ com o valor de $k$.


> [!Sucess] 
> Para implementarmos estas operações de forma mais eficiente usamos um ==Amontoado (Heap)==.


