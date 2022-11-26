> [!TODO] Definição
> $T (n) = aT (n/b) + O(nd ) , a ≥ 1,  b > 1,  d ≥ 0$

![[Pasted image 20221126232349.png]]

## Multiplicação de matrizes

Podemos ter 3 casos com diferentes complexidades assimptóticas:

#### Primeiro Caso

3 ciclos for -> O(n³).

![[Pasted image 20221126202236.png]]


#### Segundo Caso

- Partir cada matriz $n * n$ em 4 matrizes, cada uma com dimensão n/2 x n/2, até as matrizes terem dimensão n = 1.
- Fazer as 8 multiplicaões das matrizes partidas e mais 4 somas.

$T(n)=8.T(n/2)+O(n²)$  
- a = 8, b = 2, d = 2;
- d < $log2.8$ 
- $T(n)=O(n^{logb.a})=O(n³)$

#### Terceiro Caso

Usamos o algoritmo de Strassen:

![[Pasted image 20221126202255.png]]

> [!TIP] Das três complexidades esta é a mais indicada.
