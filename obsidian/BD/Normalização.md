

### Qualidade do Esquema Relacional

___Funcionalidade___: O esquema suporta todos os resquisitos funcionais e captura todas as restrições de integridade e relações semânticas entre os dados necessários para o efeito.

___Atomicidade___: A inserção, leitura, atualização e remoção de factos independentes é feita de forma independente.

#### Exemplos de Não-Atomicidade
![[Pasted image 20230525141157.png]]

### Consequências de Não-Atomicidade

Anomalias quando há alteração de estado:

- ___Inserção___: não é possível inserir um item na bd a não ser que outro independente seja inserido também (que não devia estar relacionado).
- ___Remoção___: para remove um item temos que remover outros independentes (que não devia estar relacionado).
- ___Atualiação___: para atualizar um item temos que atualizar outros que não deviam estar relacionados.

### Exemplos de Anomalias

No caso do exemplo anterior, podemos ver que existem as seguintes anomalias:

- quando se quer inserir uma conta para um cliente existente, temos que voltar a inserir a cidade do cliente.
- quando se quer alterar o saldo da conta A-101, tem que se atualizar em várias linhas.
- quando se quer apagar a conta A-101, também se vai estar a apagar o cliente Hayes (o que pode não ser desejado).

# Normalização

Existe a teoria da normalização já que existem anomalias causadas pela redundància na base de dados vindas das falhas nos desenhos e portanto a BD não está normalizada.

Os objetivos desta teoria são então:

- evitar informação repetida.
- guardar dados independentes de forma independente. (garantir atomicidade)
- haver dados facilmente consultados.
- transformar as RI's de Dependências Funcionais em restrições de chaves candidatas suportadas pelo modelo relacional

## Dependências Funcionais ( FD )


> [!TIP] Definição
> Para uma relação r(X, Y), em que X e Y são subconjuntos de um atributo, diz-se que:
> - X determina Y ou Y determina X, se para cada valor de X está associado apenas um valor de Y.
> 
> Diz-se neste caso que X → Y.
> Ou seja, sabendo X sabemos Y.
> Dizmemos que X é __determinante__ e Y é __dependente__.
> 
> Formalmente não podemos deduzir uma dependência funcional. Apenas podemos determinar se há independência entre atributos.
> 
> ![[Pasted image 20230603125854.png]]

### Propriedades das Dependências
###### Axiomas de Armstrong

- **Refletividade**: Se Y ⊆ X, então X ⋀ Y.
Qualquer conjunto de atributos é funcionalmente dependente de  
qualquer dos seus super-conjuntos.

- **Aumentação**: Se X → Y, então XZ → YZ.
Qualquer número de atributos podem ser adicionados em simultâneo  
ao determinante e dependente.

- **Transitividade**: Se X → Y ⋀ Y → Z, então X → Z.
Um dependente de um dependente é dependente do primeiro  
determinante.

- **Auto-reflexividade**: X ⋀ X
Qualquer conjunto de atributos depende de si mesmo.

- **Decomposição**: Se X → YZ, então X → Y ⋀ X → Z.
Cada um dos atributos do dependente é dependente do determinante.

- **União**: Se X → Y ⋀ X → Z, então X → YZ.
Dois dependentes do mesmo determinante podem ser unidos.

- **Composição**: Se X → Y ⋀ A → B, então XA → YB.
Quaisquer dois pares de dependências funcionais podem ser  
combinados.

#### Fecho dos Atributos

> [!NOTE] Definição
> O fecho, α+, de um conjunto de atributos α, corresponde ao conjunto de atributos β que dependem de α - isto é, α→β.
> 
> Caso o fecho de αα inclua todos os elementos da relação, dizemos que αα é uma **super-chave** da mesma.


> [!EXAMPLE] Exemplo
> Considere a seguinte relação com o seu conjunto de dependências:
> 
> - r(A, B, C, G, H, I)
> - A→B, A→C, CG→H, CG→I, B→H
> 
> 1. result = AG  
> 2. A → B, A ⊆ result ⇒ result := result ∪ B = ABG  
> 3. A → C, A ⊆ result ⇒ result := result ∪ C = ABCG  
> 4. CG → H, CG ⊆ result ⇒ result := result ∪ H = ABCGH  
> 5. CG → I, CG ⊆ result ⇒ result := result ∪ I = ABCGHI
> 
> (agora por extenso)
> O fecho de AG, (AG)^{+}, pode ser computado tal que:
> 
> - começamos com um fecho que corresponde ao próprio AG;
> - pegando em A → B ( porque A ⊂ AG ), podemos adicionar B ao fecho, ficando então com o fecho ABG;
> - pegando em A→C ( porque A ⊂ AG ), podemos adicionar C ao fecho, ficando então com o fecho ABCG;
> - pegando em CG→H ( porque G ⊂ AG ), podemos adicionar H ao fecho, ficando então com o fecho ABCGH;
> - pegando em CG→I ( porque G ⊂ AG ), podemos adicionar I ao fecho, ficando então com o fecho ABCGHI.
>   
>   Chegámos agora a um ponto em que todos os atributos da relação estão no fecho do conjunto inicial, pelo que podemos afirmar que AG é uma **super-chave**.

##### Dependência Total
Dizemos que um conjunto de atributos Y é __totalmente dependente__ de outro conjunto X se X → Y **e** não haja nenhum subconjunto X que também determine Y.


> [!NOTE] Dada uma relação r definida pelo conjunto de atributos R, r(R) definimos:
> #### Super Chave 
> - K ⊆ R é uma superchave de r(R) se K → R
>   
>  #### Chave Candidata
>   - corresponde a uma chave em que nenhum dos seus subconjuntos é uma chave - isto é, um subconjunto de atributos X de uma relação R tal que X→R−X.
>   - se se retirar um atributo deixa de ser chave.
>   
>   #### Chave Primária
>   Podendo haver mais que uma chave candidata, chamamos a chave primária:
>   - chave candidata escolhida para identificar unicamente tuplos numa relação de uma base de dados.

### Determinação de Chaves Candidatas

Maneira mais prática é começar com o conjunto completo de atributos e reduzi-lo:
- para cada dependência , retirar os dependentes da super-chave, sempre que o determinante esteja na superchave;
- verificar se a chave resultante é a chave candidata;
- verificar se existem outras chaves candidatas.


> [!EXAMPLE] Exemplos:
> ![[Pasted image 20230603151153.png]]
> 
> ![[Pasted image 20230603151206.png]]
> 
> ![[Pasted image 20230603151216.png]]


# Fases Formais
Formas de representar a BD, por forma a evitar ao máximo a redundância da mesma procurando manter a coerência dos dados.

### 1ª Forma Normal

> [!TIP] Definição
> Está nesta forma quando todos os atributos são valores atómicos, isto é, cada atributo da relação tem apenas um valor por tuplo.
> 
> Esta é umas das condições necessárias para estarmos na presença de uma relação já que precisamos que a nossa relação seja consultável.
> 
> ![[Pasted image 20230603151919.png]]
> 
> Nesta forma não existe qualquer verificação em relação à independência dos atributos.

### 2ª Forma Normal


> [!TIP] Definição
> Está nesta forma se estiver na 1FN.
> E se cada atributo não-chave dependa de __todos os atributos__ da relação.
> 
> Se tivermos a relação com as dependências:
> - maquina(**modelo**, **id**, voltagem)
> - id → modelo, modelo → voltagem
>   
>  Como a voltagem depende totalmente do modelo (não é preciso _id_ para se saber qual o seu valor), então não está a respeitar a 2ª FN. Essa informação deveria estar representada noutra tabela.
>  
>  Nesta forma podemos ainda não ter corrigido por completo a redundância pelo que pode haver depedências entre atributos não chave 




