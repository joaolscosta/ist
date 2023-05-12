
## Relações

```
product(code: string, name: string, price: integer, stock: integer)
```

A relação aqui é:

```
product (contido em) string x string x integer x integer
```

```
product = {
	<a1, bolachas, 50, 10>
	<a2, napolitanas, 30, 20>
}
```

___Grau de uma relação___ - corresponde ao nmr de atributos
___Cardinalidade___ - nmr de tuplos

- Uma relação tem que ter pelo menos um tuplo.
- Todos os tuplos tem que ter os mesmos números de elementos com os mesmos tipos.

- Não existem tuplos duplicados nem importa a ordenação.


## Conversão a partir do modelo E-A

### Restrições

https://resumos.leic.pt/bd/relational-model-conversion/

#### De Domínio

```
product(code, name, price, stock)

- (price > 0): tem que ser sempre um inteiro positivo
```

#### De Unicidade

```
- Não se pode repetir valores de atributos
- Dois produtos podem ter o nome "Bolacha mas com preços diferentes"

product(code, name, price, stock)

- UNIQUE(code)
- UNIQUE(name, price)

(As restrições acima indicam que não podem ter os mesmo código de barras, e o mesmo nome e preço)
```


___Elemento minimal___: não existe nenhum elemento menor que ele.
___Elemento mínimo___: elemento menor que todos os outros.

- Podem existir vários minimais mas só um mínimo. Um mínimo é sempre minimal.

#### De Chave

```
- Identifica um tuplo pela/s sua/s chaves primárias.
```

#### Aplicadas a Bases de Dados

