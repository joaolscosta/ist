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
- guardar dados independentes de forma independente.
- haver dados facilmente consultados.






