https://resumos.leic.pt/bd/relational-algebra/

##### Relação:
![[Pasted image 20230520172321.png]]

### Conversão E-A Relacional
Esta conversão permite __preservar relações e minimazir a redundância de dados.___
![[Pasted image 20230520172529.png]]

### Operadores:
![[Pasted image 20230520172840.png]]


## Select
> [!NOTE] Definição
> Seleciona linhas de uma relação. 
> 
>Notação: __σprice≤50 ∧ stock>5​(product)__
> 
> Podemos ter os operadores: =, ≠, >, ≥, <, ≤
> Predicados compostos podem ser compostos por: ∧ (and), ∨ (or), ¬ (not)

##### Propriedades:
- σp1(σp2(r)) = σp2(σp1(r))
- σp1(σp2(r)) = σp1∧p2(r)


## Projeção
> [!NOTE] Definição
> Seleciona as colunas de uma relação. 
> 
> Notação: __πproduct_name,stock​(product)__
> 
> Linhas duplicadas são removidas.
> Não há ordem nos tuplos obtidos.
> 
> ![[Pasted image 20230520174721.png]]
> Notar aqui que a ordem está diferente e removeu-se um tuplo.
> 
> 
##### Propriedades:


## Combinação de Operações
> [!EXAMPLE] Exemplo
> __∏name (σ dept_name=“Physics” (professor))__
> 
> ![[Pasted image 20230520175456.png]]


## Produto Cartesiano / Cross - Join
> [!NOTE] Definição
> Combina todos os tuplos de uma relação com os de outra relação numa nova relação.
> 
> Notação: __r × s__
> 
> ![[Pasted image 20230520175648.png]]

##### Propriedades:
- r × s = s × r
- r × (s × t )= r × s × t

> [!EXAMPLE] Uso de Seleção e Produto Cartesiano
> __σprofessor.id=teaches.id (professor × teaches)__
> 
> ![[Pasted image 20230520175924.png]]
> 
> Mais exemplos em Resumos.leic.


## Join
> [!NOTE] Definição
> 
> **r ⨝θ s = σθ (r × s)**
> 
> **θ** é um predicado da união entre r e s.

## Natural Join
> [!NOTE] Definição
> 
> ![[Pasted image 20230520180740.png]]


## Join vs. Natural Join
![[Pasted image 20230520180838.png]]

## Rename
> [!NOTE] Definição
> 
> Notação: __ρproduct_code↦code,product_name↦name​(product)__


## Diferença / Set-Difference
> [!NOTE] Definição
> Devolve os tuplos que estão na primeira relação mas não estão na segunda.
> 
> Notação: __r – s__
> 
> ![[Pasted image 20230520181641.png]]


## União / Union
> [!NOTE] Definição
> Devolve tuplos que estão na primeira ou na segunda relação.
> 
> Notação: __r ∪ s__
> 
> ![[Pasted image 20230520181834.png]]


## Interseção / Set - Intersection
> [!NOTE] Definição
> Devolve tuplos que estão na primeira e na segunda relação.
> 
> Notação: __r ∩ s__
> 
> É como duas diferenças: __r ∩ s = r − (r − s)__
> 
> ![[Pasted image 20230520182341.png]]


## Atribuição / Assignment
> [!NOTE] Definição
> Atribui a uma variável um tuplo.
> 
> cheap_products ← σ price<100 ​(products)
> π name​ (cheap_products)​
> 
> Pode ser usada para remoção de tuplos ou adição de tuplos.
> r ← s − (E)
> r ← s ∪ (E)


## Divisão 
> [!NOTE] Definição
> Seleciona todos os tuplos de uma primeira relação que contém todos os tuplos de uma segunda relação devolvendo os da primeira relação que não estão na segunda.
> 
> Notação: __r ÷ s__
> 
> r ÷ s = ∏r∩¬s (r) − ∏r∩¬s ((s × ∏r∩¬s (r)) − r)
> 
> ![[Pasted image 20230520183639.png]]
> ![[Pasted image 20230520183700.png]]


## Projeção Generalizada / Composta
![[Pasted image 20230520184449.png]]

## Agregação
![[Pasted image 20230520184543.png]]


## Exemplos
Os slides T10 - Álgebra Relacional têm bons exemplos para compreensão.




