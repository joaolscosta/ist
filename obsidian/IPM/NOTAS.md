> [!TIP] IPM
> Área que desenvolve a tecnologia para pcs para que consigam servir melhor os humanos.

#### Fatores Diferenciadores

- Conveniência
- Usabilidade
- Fiabilidade

Não é o foco a rapidez ou a capacidade de armazenamento.

IPM envolve várias disciplinas, das quais se destacam:

-   **Interação — Design:** comunicação utilizador->máquina e máquina->utilizador
-   **Pessoa — Ciências Comportamentais:** utilizador, contexto social
-   **Máquina — Ciência da Computação:** hardware / software


> [!NOTE] INTERFACE UTILIZADOR ( UI )
> Elementos com que o utilizador pode interagir num sistema. Parte visível do sistema. Permite ao user interagir e realizar as suas tarefas.

Existem vários tipos de UI, incluindo, entre muitos outros:

-   interface gráfica (GUI - _Graphical User Interface_)
-   interface por linha de comandos (CLI - _Command Line Interface_)
-   interface por voz (VUI - _Voice User Interface_)
-   interface por linguagem natural (NLUI - _Natural Language User Interface_)


> [!NOTE] EXPERIÊNCIA DE UTILIZADOR ( UX )
> É a experiência do utilizador com o sistema. A facilidade e o quão satisfatório é o seu uso.
> Componente mais efetiva apelando às emoções do user.

# UI vs UX
| UI                   | UX               |
| -------------------- | ---------------- |
| utilizador           | pessoa           |
| usabilidade          | experiência      |
| + objetiva           | + subjetiva      |
| "o que fazer"        | "o que atingir"  |
| "elementos visuais"  | "experiências"   |
| desejável            | credível         |
| foco nas ferramentas | foco na interaçã |


### 1. Bom design
Não é só gráficos, é saber comunicar com o user.

### 2. Marketing conhece os users
Marketing foca-se em dados não sabendo o comportamento dos humanos.

### 3. Bom designn é senso comum
É complexo pelo contrário.

### 4. Interface é feita no final
Sistema construído com base na interface do user. 


# Modelo de Desenho

## Modelo em Cascata

![[Pasted image 20230312220333.png]]

É um padrão de gestão de projetos.
O ==problema== deste modelo é que não tem como voltar atrás se houver uma falha.
A transição de estados é unidirecional.


## Modelo Desenho Interativo

![[Pasted image 20230312221127.png]]

Este modelo utiliza uma filosofia de **fail fast**:

-   falhar _rápido_, _cedo_ e _repetidamente_;
-   iterar o máximo possível;
-   idear-prototipar-testar.

Envolve várias etapas:

![[Pasted image 20230312221523.png]]

1.  **Identificar necessidades, estabelecer requisitos**
    -   Quem são os utilizadores?
    -   Que funcionalidades pretendem?
    -   Onde realizam as tarefas?
2.  **Gerar ideias**
    -   Explorar muitas soluções
    -   Utilizar pensamento divergente
    -   Diversificar
    -   Evitar _bias_
3.  **Conceber soluções**
    -   Usar um **modelo conceptual**, central no _design_ de interações
    -   Criar soluções alternativas
4.  **Prototipar soluções**
    -   Criar protótipos que identifiquem problemas no início
        -   Não funcionais (em papel)
        -   Funcionais (código)
5.  **Avaliar e refinar protótipos**
    -   Por peritos
    -   Usando modelos
    -   Envolvendo utilizadores
    -   Identificar problemas de usabilidade

### Os dois _mantras_ de IPM

-   **Conhecer os utilizadores**
    -   Tanto a nível de capacidades físicas, cognitivas e sensoriais como o contexto social que os rodeia, entre outros fatores
-   **"O utilizador não é como eu"**
    -   Erro mais comum — não somos utilizadores típicos, conseguimo-nos adaptar a más interfaces


## Dark Patterns

> [!NOTE] DEFINIÇÃO
> São truques que obrigam o utilizador a fazer coisas que não pretende fazer. Comprar algo ou subscrever alguma coisa.

Quando uma pessoa está a ler um site quer rapidamente passar aos próximos passos e deixa muita informação por ler. Uma empresa pode enganar desta forma a aceitarmos algo a que não estamos à espera.

Um bom exemplo é a amazon que é muito difícil conseguirmos apagar uma conta.

## Dispositivo Móvel

> [!NOTE] DEFINIÇÃO
> Computador de bolso com ecrã (_output_) e teclado (_input_). Possuem um sistema operacional e são capazes de suportar aplicações móveis. Podem comunicar sem fiso comoutros dispositivos ou pela net.

## Diferenças de IPM para Desktop

#### 1. Tamanho
Dispositivos desde computadores a _smart bands_.

#### 2. Modalidade de Interação
Por exemplo nos telemóveis temos o toque, comandos de voz, etc.

##### Hidden Markov Model
> [!NOTE] DEFINIÇÃO
> É uma classe de modelos de probabilidades gráficas que nos permitem prever uma sequência desconhecida de variáveis a partir de um padrão. Um exemplo é nas comunicações de voz, o dispositivo reconhecer apenas a voz do seu utilizador.

#### 3. Experiência Integral de Utilização
Usabilidade do jogador e experiência da pessoa. (UI vs UX).

#### 4. Contexto de Utilização
Prática fácil de dispositivos móveis.

#### 5. Interações breves
Como temos sempre connosco não precisamos de fazer tudo de uma vez.


> [!TIP] MINITURIZAÇÃO NÃO!
> Não queremos reduzir um desktop a um dispositivo móvel mas sim adaptar o que temos a aparelhos mais práticos.


## Interação em dispositivos móveis

Tem de ser facilitada. No caso de browsers como as pessoas usam maioritariamente o polegar a barra de pesquisa está na parte superior de modo a não perturbar a experiência. (___Reachability___).

#### Fat Finger Problem
Botões e secções pequenas. Soluções:
1.  _Detached Overlay_;
2.  _Autocorrect_;
3.  _Swift-key_;
4.  _Back-of-the-device_ (touchscreen na parte de trás do ecrã);
5.  Gestos (_Drag_, _Swipe_, _Pinch_).

Porém tem que haver um conjunto de regras para estes gestos de modo a que os utilizadores possam ter uma experiência mais agradável:

-   Permitir vários dedos;
-   Gestos como atalhos;
-   Dar feedback imediato;
-   ter em atenção questões de descoberta.

#### Tamanho, Espaçamentos, ...
Existe um tamanho específico para cada dispositivo.

#### Novas Técnicas de Interação
Técnicas que se vão desenvolvendo para facilitar a experiência. Tecnolgogia _eyesfree_ ajuda no _multitasking_ ou na quantidade de toques que tem que existir pela parte do utilizador.


## IPM + ML + Sensor fusion

O input do utilizador pode ser ainda mais facilitado.
Para isso usam-se "previsões" do que o que o user pode querer fazer. por exemplo o teclado que já sugere as palavras.


> [!TIP] QUANTIFIED-SELF
> A interação não é totalmente direta. O dispositivo é ensinado a reconhecer certos padrões. Exemplos como o smartwatch infomar quando é que podemos terminar de lavar as mãos.


# Heurística e Usabilidade

Conjunto de _guidelines_ que ajudam os programadores a construírem uma melhor aplicação.
Funcionam quase como que uma _checklist_ para se guiarem e os avaliadores avaliarem o trabalho.
10 heurísticas de Nielsen:

#### H1: Tornar o sistema visível
A primeira heurística refere-se a dar a conhecer ao utilizador onde estão, isto é fazer com que o utilizador não tenha quaisquer dúvidas sobre em que zona da aplicação ou _website_ está e o que está a fazer ou como o está a realizar. Um bom exemplo desta heurística é quando acedemos ao site da Amazon e estamos a terminar uma compra, o site auxilia o utilizador na medida em que lhe mostra exatamente em que etapa da compra está para que não sujeite quaisquer questões do que falta/já fez.

Outro exemplo desta heurística será por exemplo no _**Paint**_ quando o utilizador está a usar o lápis, a aplicação reforça o lápis tanto no rato como no menu para não surgir dúvidas.

### H2: Correspondência com o mundo real

A segunda heurística refere-se a “falar a linguagem do utilizador”, isto é utilizar terminologia que seja familiar ao utilizador evitando usar termos orientador ao sistema ou gíria técnica. Dois exemplos mais comuns desta heurística são nos _e-books_ quando o utilizador pode “passar a página” como dedo como se fosse um livro normal ou quando “dobra” o canto da página para marcar em que zona está.

### H3: Utilizador controla e exerce livre arbítrio

É normal o utilizador querer controlar tudo, ou praticamente tudo, o que ele faça numa aplicação. Deste modo, a terceira heurística refere-se à possibilidade do utilizador sair de situações inesperadas (erros) e não obrigar o utilizador a passar por caminhos inflexíveis. O utilizador tem controlo absoluto sobre o programa.

Esta heurística está presente quando no _G-mail_ o utilizador consegue cancelar o envio do e-mail, no _Netflix_ quando o utilizador tem a possibilidade de avançar para o próximo episódio ou voltar atrás.

### H4: Consistência e adesão a normas

A quarta heurística refere-se a minimizar o fator de surpresa ou seja palavras, situações ou ações semelhantes têm significados semelhantes e palavras, situações ou ações diferentes implicam significados diferentes. Vemos a presença desta heurística nos botões de cancelar o enviar sempre do mesmo lado do ecrã, quando estamos perante uma lista se dermos _swipe_ num dos pontos conseguimos aceder a uma série de atalhos.

### H5: Evitar erros

Para um boa aplicação funcionar tem que ser difícil de cometer erros que possam ser prejudiciais, visto que melhor do que uma boa mensagem de erros. Por exemplo, o utilizador deve ser alertado se de facto quer fazer uma encomenda de 5000 livros, ou seja tem um espécie de _feedback_ para que não ocorra erros.

### H6: Reconhecimento em vez de lembrança

Para o utilizador ter uma experiência mais calma e agradável numa qualquer aplicação é necessário auxilia-o a tornar os objetos, ações e indicações visíveis de modo a reduzir a carga cognitiva. O utilizador não é obrigado a lembrar de informação é por isso que as fontes no Word não aparece só o nome mas também como a fonte fica nas letras.

### H7: Flexibilidade e eficiência

Existem aceleradores que permitem a realização mais eficiente das tarefas e permitem o utilizador realizar as tarefas de vários modos diferentes. Ou seja é requerido que as interfaces de adaptem ao utilizador. Um exemplo é no Instagram quando o utilizador pode fazer _double-click_ na foto ou carregar no coração para dar gosto.

### H8: Desenho estético e minimalista

Contudo, apesar de haver tanta informação e auxilio que o utilizador necessita é necessário apresentar apenas o que seja necessário àquele momento. É só necessário comunicar e não decorar: na Dropbox basta pôr um ficheiro numa pasta e pronto!

### H9: Ajudar a reconhecer, diagnosticar e a recuperar de erros

É necessário ser preciso (indicar claramente o problema), falar a linguagem do utilizador e evitar códigos e termos técnicos, dar ajuda construtiva quereres-te recuperar e evitar novos erros e ser cortes. Um exemplo claro desta heurística e quando fazemos uma pesquisa no Google em que escrevemos mal uma palavra, apenas nos aparece uma mensagem a perguntar se queríamos escrever outra coisa com uma sugestão por baixo.

### H10: dar ajuda e documentação

A última heurística refere-se a ajuda ser usada apenas quando ha problemas e, tendo isso em consideração, oferecer acesso rápido à informação. Contudo a ajuda não substitui mau desenho da IU e o sistema não deve depender dela para ser utilizado!

Alguns tipos diferentes de ajuda referem-se a:

-   Documentação
-   _Onboarding_ ao abrimos uma app pela primeira vez
-   Instruções passo-a-passo (_walkthrough_)
-   _Tooltips_
-   _Popovers_
-   _Chatbots_
-   Vídeos


Ao realizarmos qualquer produto este tem que passar por uma série de etapas de modo a obtermos no final o melhor produto possível. Existe então um ciclo iterativo que devemos respeitar para isto acontecer.

![[Pasted image 20230314001407.png]]

Para avaliar o trabalho usamos membros exteriores aos do grupo. Pretendemos ==__avaliar e identifcar problemas__== de duas componentes:

- Usabilidade
- Experiência de Utilização

## Métodos de Avaliação

Realizam-se testes ==analíticos e empíricos.==

### Testes Analíticos

> [!EXAMPLE] DEFINIÇÃO
> Referem-se a avaliações heurísticas. Testes que envolvem apenas o trabalho e não as pessoas. Está associada a Lei de Fitts e Machine Learning.


### Testes Empíricos

> [!EXAMPLE] DEFINIÇÃO
> Referem-se a testes de usabilidade, testes A/B, diários, shadowing, context inquiry, etc. Aqui já importam a experiência do utilizador para saber o que é preferido para ser utilizado.
> 
> Podemos dividir as observações em duas: __Observações diretas__ em que observamos os utilizadores durante a execução seja presencial ou em vídeo.
> As __observações indiretas__ podem ser manuais (uso de diários) ou automáticos (através de registo de interação).
> 

#### Como usamos um diário?

Diários podem ser utilizados para ver a utilização a longo prazo de um produto.
(1-2 semanas). Os diários permitem ao utilizador externo partilhar os seus pensamentos, utilidade e relação em vez de ser apenas a interação com o produto.
O nosso objetivo é criar um produto que incorpore as atividades do dia-a-dia, e os diários são a melhor forma de avaliar isso mesmo.


# Case Study: Halo 3

Com o Halo 3 a Microsoft gerou um registo de interação automático. Tinham milhares de jogares a jogar e a avaliar a qualidade.
O que era registado:

-   Timestamp
-   Localização do jogador
-   Número de balas
-   Eventos (morrer, acertar, etc.)
-   Para onde está a apontar

A avaliar as condições a Microsoft criou o __Heatmap__ que a cada 5s mudava a cor do jogador. Se houvesse uma grande concentração de cores num mapa sabia-se que essa parte do mapa tinha que ser melhorada e se estivesse mais disperso estava bom.

Viam também as munições. O registo automático já verificava quando é que as balas eram todas perdidas mas foi necessário um resgisto direto para perceber o porquê dos jogares perderem todas as balas.

Hoje em dia pode lançar-se um jogo e através de feedback ao longo do tempo vai-se melhorando não sendo necessário esperar 5 anos para lançar um jogo.


## Diferentes Métodos de avaliação

-   **Entrevistas**
-   Focus groups
-   Questionários online
-   Diários
-   Sondas culturais
-   **Observação**
-   Etnografia
-   Experience sampling
-   **Registo de interação**
-   Co-desenho
-   Casos de estudo
-   Contextual inquiry
-   **Wizard of Oz**
-   **Think-aloud**
-   Card sorting
-   **...**


## Testes de Usabilidade


> [!EXAMPLE] DEFINIÇÃO
> Garantem que os produtos são bons e práticos. Permitem identificar problemas, descobrir onde melhorar e compreender os utilizadores através das suas preferências.

![[Pasted image 20230314020512.png]]

Para o 1º Bake-off focámo-nos na ==avaliação formativa== e no segundo na ==avaliação final ou sumativa==.

___==Avaliação Formativa==___ - Realiza-se durante o desenho, os resultados informam a próxima fase do desenho. ( O que acontece durante a interação ).

___==Avaliação Sumativa==___ - Refere-se à avaliação final. 
( Qual o resultado )

Para realizar um bom teste de usabilidade temos que nos focar em três parâmetros diferentes:

- Participantes
- Medidas
- Tarefas

### Participantes / Utilizadores

Partcicipantes são aqueles mais próximos do público alvo, com maior disponibilidade ( mais adequados à situação ). Homens e mulheres de todas as idades.

Para vermos a descrição do grupo de pessoas que realizam os testes temos que ver a sua Demographic Info.

SEGUNDO NIELSEN, devem ser 20 utilizadores, 4 iterações com 5 utilizadores cada.

Se tivermos:

-   1 utilizador → 33% dos problemas identificados
-   5 utilizadores → 85% dos problemas identificados
-   15 utilizadores → 99% dos problemas identificados

É necessário ter um número grande de utilizadores para ter a certeza que não há uma média curta e manipulável.

### Tarefas

Tarefas que apresentamos têm que ser bastante bem definidas.
Têm que ser:

-   **Reais** e representativas
-   **O quê** e não como
-   **Específicas**
-   Mistura de Complexidades
-   **Avaliação Comparativa**
    -   não favorecer uma das soluções
    -   usar as mesmas tarefas

Não podemos então dar soluções como oferecer um rato melhor ou mencionar que custou muito trabalho certa parte.

### Medidas de Usabilidade

-   Tempo para completar a tarefa
-   Número de erros cometidos
-   Número de tarefas concluídas
-   Número de cliques
-   Número de consultas à ajuda
-   Satisfação do utilizador

### Tipos de Dados

##### Quantitativos
(quantidade, específicos e medíveis)

-   **Completou a tarefa?** Sim/Não
-   **Quanto tempo demorou?**
-   **Quantos erros?**
-   **Qual preferiu?** A ou B

##### Qualitativo
(qualidade, aberto)

-   O que gostou mais na sua experiência?
-   O que pensa do ecrã principal?
-   Mais difícil de obter?

##### Objetivos

-   Não dependem da pré-disposição (bias) inerente ao ser humano (ex.: tempo, erros, frequência cardíaca, etc.)

##### Subjetivos

-   Realça a perceção do utilizador (ex.: preferência, **SUS**, **SEQ**, etc.)

**SUS:** acima de 68% é minimamente utilizável, já há valores médios por ser tão utilizado.
**SEQ:** debriefing se tiveram dificuldade a completar alguma tarefa.

### Testes-Piloto

2 a 3 pessoas para testar:

-   Duração
-   Instruções
-   Tarefas
-   Questionário

Estes testes ajudam a encontrar últimos erros antes de sair

### Testes A/B

Melhor tipo de testes que verifica qual é o melhor tipo de cor, logotipo, layout de página, tipografia, botões, etc.


## Google 41 shades of blue

A google mostrou a utilizadores 41 tons de azul e ao escolherem a empresa faturou. Ouve conflitos por terem sido os utilizadores e não as equipas profissionais a decidir isso.

### Como dividir os grupos?

___==Intergrupos==___ - Recrutar o dobro das pessoas e grupos comparáveis.
(Um grupo tem a vacina e o outro não.)

___==Intragrupos==___ - Cada grupo testa as duas interações. Vamos trocando a ordem de uso dos sistemas. (aprendizagem, fadiga).

Contudo há fatores que influenciam as pessoas e um grupo que já tenha testado 40x um projeto pode estar viciado ou cansado e isso influencia a avaliação.

Para combater usamos counter-balacing em que se tivermos os projetos [A, B, C]:
User1: ABC
User 2: ACB
...

Counter-balancing funciona de uma forma fatorial, resumidamente:

-   3 sistemas: 3! = 6 utilizadores
-   4 sistemas: 4! = 24 utilizadores
-   5 sistemas: 5! = 120 utilizadores

___==**Variáveis Dependentes:**==___

-   O seu valor depende do sistema a testar
-   Variáveis medidas no estudo (tempo, erros, SUS)
-   Relacionados com o objetivo do protótipo

___==**Variáveis Independentes:**==___

-   Não dependem das variáveis que estamos a medir
-   Características da solução (layout, cor, etc.)
-   Características dos participantes (idade, etc.)


## Efeitos Secundários

Aqui deparamos com um problemas de Fixação Funcional.
Dunker colocou à frente do seus participantes uma vela, um caixa de pioneses e fósfororos e pediu que arranjassem uma maneira de que a vela fosse acendida mas não pingasse cera para a mesa. Dividiu em 2 grupos:

- Grupo A tinha pioneses dentro da caixa.
- Grupo B tinha pioneses fora da caixa.

Como os pioneses estavam fora da caixa era mais evidente para o grupo B que a caixa também podia ser usada como elemento e assim este grupo terminou a experiência mais rápido.


Mais tarde Glucksberg testou a mesma experiência mas adicionou a variável de obter o melhor tempo de resolução e recompensas para o top 40% e o mais rápido.
Aqui os que tinham os pioneses na caixa precisavam de mais criatividade e foi mais lento. Os que tinham os pioneses dentro da caixa foram mais rápidos.

Adicionar uma recompensa aumenta o foco mas diminui a criatividade. É bom para instruções simples para tarefas claras.


## Efeito de Hawthorne / Efeito do Observador


> [!TIP] DEFINIÇÃO
> Quanto mais pressão, mais produtividade.
> 
> ___Novely Effect___ - quando vemos algo novo ficamos excitados sem razão. Pode até não ser nada de especial mas por ser novo temos curiosidade. Por isso temos que testar o produto mais do que uma vez para testar o quão prático e bom.


## Ética com Utilizadores

Quando pensamos em experiências pensamos sempre pelo senso comum que é tudo bem intencionado mas já aconteceu participantes ficarem traumatizados após os testes.
Um exemplo (Standford Experiment) é um teste em que se dividiu dois grupos: um com polícias e outro com prisioneiros. Ao fim de um tempo o poder subio aos polícias e começaram a maltratar os outros.

Portanto para fazermos qualquer teste temos que ter algumas considerações éticas.

### Considerações Éticas

É da responsabilidade de quem está a realizar o teste de aliviar e relaxar o participante de modo a que o teste não seja desconfortável ou stressante.

Consentimento é de extrema importância já que estamos a trabalhar com voluntários. Evitar presão. Informar os participantes que podem terminar a qualquer momento. Realçar que o sistema é que está a ser testado e nunca os utilizadores. Tornar os dados anónimos e proteger esses dados.

Existem pessoas vulneráveis.

Qualquer teste tem que ter uma aprovação da comissão ética para ser realizado.

### Três princípios de investigações com pessoas

1.  É necessário haver respeito pelas pessoas:

-   Os indivíduos têm autonomia e escolha
-   Não podem ser usados como meio para atingir um fim
-   É necessário proteger os mais vulneráveis
-   É necessário usar consentimento informado

2.  Beneficência _(fazer o bem)_:

-   Obrigação de fazer o bem
-   Obrigação de não prejudicar
-   Obrigação de prevenir danos
-   Minimizar riscos, maximizar benefícios
-   Bondade além do dever
-   Avaliação de riscos e benefícios

3.  Justiça:

-   Garantir igualdade
-   Dividir riscos e benefícios pela amostra
-   Recrutamento de participantes justo