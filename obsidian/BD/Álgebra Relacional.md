___Select___: seleciona/filtra linhas
___Project___: seleciona/filtra colunas
___Union___: une relacções (tabelas)
___(Natural Join)___: faz match entre colunas
___(Outer Join)___: mesma coisa que o anterior mas no final admite os que não foram selecionados e coloca a NULL

### Seleção

- Oa e b(n)

### Projeção

- Cuidado ao eliminar as chaves primárias porque quando filtramos as colunas pode ser que não se saiba qual selecionar
- Para isso quando se filtram as colunas temos sempre que deixar um id ou algo parecido para não se confundir e também não eliminar linhas repetidas. Acontece esta última situação na filtração (problema dos __tuplos duplicados__)

### Produto Cartesiano

> [!TIP]
> Quando se faz isto para duas tabelas basicamente junta-as.

- A ampulheta na horizontal pode ser usada em vez do cartesiano que faz automaticamente a identicação de duas colunas iguais para as comparar.
- Por exemplo se fizermos o cartesiano de duas relações que tenham o mesmo parâmetro id mas para situações diferentes, a ampulheta reconhece automaticamente

Para duas relações: 1(a,b,c,d) e 2(a,b,d,e) resultava o Natural Join (ampulheta na horizontal) de 3(a,b,d)

Resumos.leic