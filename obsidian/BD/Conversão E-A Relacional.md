
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

```
- Aplicadas a um conjunto de relações. Existem dois tipos:
```

##### Restrições de Integridade Referencial (Foreign Keys)
```
Requer que existe um valor/combinação de valores correspondente noutra relação. Chama-se Foreign Key.

- Se os dados numa das relações é alterado temos que verificar se as relações continuam válidas.

order(code, client_id, quantity, date)

- code: FK(product.code)

Podemos aplicar também uma FK a um conjunto de atributos:

course(name, year, degree)
enrollment(student, name, year)

- name, year: FK(course.name, course.year)
```

- Caso o nome dos atributos seja igual em ambas as relações podemos omitir:```code: FK(product)```

##### Restrições de Intergidade Genéricas ()
```
degree(degree_id, name)
student(ist_id, name, degree)

- degree: FK(degree.degree_id)

course(course_name, year, degree)

- degree: FK(degree.degree_id)

enrollment(student, course_name, year)

- student: FK(student.ist_id)
- course_name, year: FK(course.course_name, course.year)
- IC-1: Students can only be enrolled in courses belonging to the same degree they signed up for.
```


## Conversão a partir do E-A

![[Pasted image 20230513191406.png]]

```
student(ist_id, name, birthdate)
(ist_id sublinhado)
- UNIQUE(name)
```

### Associações

___Many-to-Many___ e ___Ternárias___: nova relação com as chaves envolvidas.

![[Pasted image 20230513192450.png]]

```
student(ist_id, name)
course(course_id, course_name, department)
enrolls(ist_id, course_id, enrollment_date)

- ist_id: FK(student)
- course_id: FK(course)
```


___One-to-Many___: nova relação em que chave primária é a chave da entidade com multiplicadade 1.

![[Pasted image 20230513192657.png]]

```
student(ist_id, name)
degree(degree_acronym, degree_name, department)
studies(ist_id, degree_acronym, start_date)

- ist_id: FK(student)
- degree_acronym: FK(degree)
```


___One-to-One___: igual à primeira mas adiciona-se restrição de unicidade às chaves envolvidas.

![[Pasted image 20230513193200.png]]

```
student(ist_id, name)
degree(degree_acronym, degree_name, department)
is_delegate(ist_id, degree_acronym, start_date)

-   ist_id: FK(student)
-   degree_acronym: FK(degree)
-   UNIQUE(ist_id)
-   UNIQUE(degree_acronym)

```


___Many-to-Many com participação obrigatória___: não possível representar então precisamos de uma restrição de integridade.

![[Pasted image 20230513193716.png]]

```
teacher(ist_id, name)
course(course_id, course_name, department)

-   IC-1: Every course (_course_id_) must participate in the lectures association

lectures(ist_id, course_id)

-   ist_id: FK(teacher)
-   course_id: FK(course)
```


**_One-to-Many_ com participação obrigatória**: deixamos de precisar de uma nova relação, e colocamos os atributos na relação da entidade com multiplicidade 1.

![[Pasted image 20230513193808.png]]

```
department(department_acronym, department_name)
teacher(ist_id, name, department_acronym, join_date)

-   department_acronym: FK(department)
```


