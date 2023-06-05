# Restrições de Integridade

Restrições de preenchimento e unicidade:
- **Chave Primária** : ``PRIMARY KEY``
- **Chave Candidata** : ``UNIQUE NOT NULL``
- **Unicidade sem obrigatoriedade** : ``UNIQUE``
- **Obrigatoriedade sem unicidade**:`` NOT NULL``

Restrições de Integridade Referencial:
- **Chave estrangeira** : ``FOREING KEY`` / ``REFERENCES``

```sql
CREATE TABLE superclass(  
	id SERIAL PRIMARY KEY,  
	att1 VARCHAR UNIQUE NOT NULL  
);  
CREATE TABLE subclass(  
	id INTEGER PRIMARY KEY REFERENCES superclass,  
	att2 VARCHAR NOT NULL  
);  
INSERT INTO superclass(att1) VALUES('some value');  
INSERT INTO subclass(id,att2) VALUES(1,'another value');  
DELETE FROM superclass;
```


> [!NOTE] Chaves Estrangeiras
> Por omissão impedem a remoção ou atualização de valores que estão a ser referenciados.
> 
> ``ON DELETE CASCADE``
> ``ON UPDATE CASCADE``
> 
> ```sql
> ALTER TABLE subclass DROP CONSTRAINT subclass_id_fkey;  
ALTER TABLE subclass ADD FOREIGN KEY (id) REFERENCES superclass ON DELETE  
CASCADE ON UPDATE CASCADE;  
DELETE FROM superclass;  
(1 rows affected)


#### Criar tipo de dados personalizado

```sql
CREATE TYPE species AS ENUM (‘chicken’,‘cow’,‘goat’,‘sheep’);  
CREATE TYPE gps AS (latitude NUMERIC(8,6),longitude NUMERIC(8,6));

-- CHECK permite verificar valores

CHECK (LENGTH(name) > 3)  
CHECK (birthdate > '1920-01-01')  
CHECK (EXTRACT(YEAR FROM AGE(birthdate)) > 18)  
CHECK (start_date < end_date)
```

_Permite:_
- Expressões algébricas e funções sobre o valor de um atributo;
- Expressões algébricas envolvendo vários atributos.

_Não Permite:_
- Olhar para mais do que uma linha a inserir
- Olhar para outras tabelas


### Restrições de Integridade Comuns

**1.** “RI-1: Todas as chaves de entidade têm de existir em associação”  

**2.** “RI-2: Todas as chaves de superclasse têm de existir em subclasse1 ou  
subclasse2 mas não em ambas”  

**3.** “RI-3: Todos os pares att1,att2 em rel1 têm de existir em rel2”  

**4.** “RI-4: Todos os pares att3,att4 em rel3 têm de existir na junção de rel4 e  
rel5”


# Introdução ao SQL/PSM


> [!TIP] Define a sintaxe e a semântica de:
> - fluxo de controlo
> - lidar com exceções
> - variáveis locais
> - atribuição de expressões variáveis e parâmetros
> - uso processual de cursores
> 
> Define *esquema de informação* para procedimentos armazenados.
> 
> Permite *definir métodos* para tipos de dados personalizados.


## Exemplo usado ao longo da teoria

```sql
Account (_account-number_, branch-name, balance)
		 
Loan (_loan-number, branch-name_, amount)  
		 
Borrower (_customer-name, loan-number_)  
	loan-number: FK(Loan)  
	
Depositor (_customer-name, account-number_)  
	account-number: FK(Account)  
	
Credit-info (_customer-name_, limit, credit-balance)  
		 
Employee (_employee-name_, street, city)  
		 
Works (_employee-name, branch-name_, salary)  
	employee-name: FK(Employee)
```

