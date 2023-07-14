Considere um sistema de gestão de memória baseado em segmentos, com 32 bits de espaço de endereçamento virtual, com 3 bits (os mais significativos) para a identificação do segmento.

Certo, podemos considerar um sistema de gestão de memória baseado em segmentos com um espaço de endereçamento virtual de 32 bits e 3 bits para a identificação do segmento.

Com 3 bits para identificar o segmento, temos um total de 2^3 = 8 segmentos possíveis. Cada segmento terá um espaço de endereçamento virtual de 2^(32-3) = 2^29, ou seja, 536,870,912 endereços virtuais disponíveis para cada segmento.

Os 32 bits do espaço de endereçamento virtual serão divididos em duas partes: a parte mais significativa com 3 bits para a identificação do segmento e a parte menos significativa com 29 bits para o deslocamento dentro do segmento.

Assim, um endereço virtual de 32 bits será composto por:

`| 3 bits | 29 bits | 
| -------- | ---------    |
| Segmento | Deslocamento |


Dessa forma, ao utilizar um sistema de gestão de memória baseado em segmentos com 32 bits de espaço de endereçamento virtual e 3 bits para a identificação do segmento, cada segmento terá 536,870,912 endereços virtuais disponíveis.