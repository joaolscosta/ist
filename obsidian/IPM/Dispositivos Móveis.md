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
Quanto mais pequeno for masi difícil se torna interagir.

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

### [](https://resumos.leic.pt/ipm/dispositivos-moveis/#h2-correspond%C3%AAncia-com-o-mundo-real)H2: Correspondência com o mundo real

A segunda heurística refere-se a “falar a linguagem do utilizador”, isto é utilizar terminologia que seja familiar ao utilizador evitando usar termos orientador ao sistema ou gíria técnica. Dois exemplos mais comuns desta heurística são nos _e-books_ quando o utilizador pode “passar a página” como dedo como se fosse um livro normal ou quando “dobra” o canto da página para marcar em que zona está.

### [](https://resumos.leic.pt/ipm/dispositivos-moveis/#h3-utilizador-controla-e-exerce-livre-arb%C3%ADtrio)H3: Utilizador controla e exerce livre arbítrio

É normal o utilizador querer controlar tudo, ou praticamente tudo, o que ele faça numa aplicação. Deste modo, a terceira heurística refere-se à possibilidade do utilizador sair de situações inesperadas (erros) e não obrigar o utilizador a passar por caminhos inflexíveis. O utilizador tem controlo absoluto sobre o programa.

Esta heurística está presente quando no _G-mail_ o utilizador consegue cancelar o envio do e-mail, no _Netflix_ quando o utilizador tem a possibilidade de avançar para o próximo episódio ou voltar atrás.

### [](https://resumos.leic.pt/ipm/dispositivos-moveis/#h4-consist%C3%AAncia-e-ades%C3%A3o-a-normas)H4: Consistência e adesão a normas

A quarta heurística refere-se a minimizar o fator de surpresa ou seja palavras, situações ou ações semelhantes têm significados semelhantes e palavras, situações ou ações diferentes implicam significados diferentes. Vemos a presença desta heurística nos botões de cancelar o enviar sempre do mesmo lado do ecrã, quando estamos perante uma lista se dermos _swipe_ num dos pontos conseguimos aceder a uma série de atalhos.

### [](https://resumos.leic.pt/ipm/dispositivos-moveis/#h5-evitar-erros)H5: Evitar erros

Para um boa aplicação funcionar tem que ser difícil de cometer erros que possam ser prejudiciais, visto que melhor do que uma boa mensagem de erros. Por exemplo, o utilizador deve ser alertado se de facto quer fazer uma encomenda de 5000 livros, ou seja tem um espécie de _feedback_ para que não ocorra erros.

### [](https://resumos.leic.pt/ipm/dispositivos-moveis/#h6-reconhecimento-em-vez-de-lembran%C3%A7a)H6: Reconhecimento em vez de lembrança

Para o utilizador ter uma experiência mais calma e agradável numa qualquer aplicação é necessário auxilia-o a tornar os objetos, ações e indicações visíveis de modo a reduzir a carga cognitiva. O utilizador não é obrigado a lembrar de informação é por isso que as fontes no Word não aparece só o nome mas também como a fonte fica nas letras.

### [](https://resumos.leic.pt/ipm/dispositivos-moveis/#h7-flexibilidade-e-efici%C3%AAncia)H7: Flexibilidade e eficiência

Existem aceleradores que permitem a realização mais eficiente das tarefas e permitem o utilizador realizar as tarefas de vários modos diferentes. Ou seja é requerido que as interfaces de adaptem ao utilizador. Um exemplo é no Instagram quando o utilizador pode fazer _double-click_ na foto ou carregar no coração para dar gosto.

### [](https://resumos.leic.pt/ipm/dispositivos-moveis/#h8-desenho-est%C3%A9tico-e-minimalista)H8: Desenho estético e minimalista

Contudo, apesar de haver tanta informação e auxilio que o utilizador necessita é necessário apresentar apenas o que seja necessário àquele momento. É só necessário comunicar e não decorar: na Dropbox basta pôr um ficheiro numa pasta e pronto!

### [](https://resumos.leic.pt/ipm/dispositivos-moveis/#h9-ajudar-a-reconhecer-diagnosticar-e-a-recuperar-de-erros)H9: Ajudar a reconhecer, diagnosticar e a recuperar de erros

É necessário ser preciso (indicar claramente o problema), falar a linguagem do utilizador e evitar códigos e termos técnicos, dar ajuda construtiva quereres-te recuperar e evitar novos erros e ser cortes. Um exemplo claro desta heurística e quando fazemos uma pesquisa no Google em que escrevemos mal uma palavra, apenas nos aparece uma mensagem a perguntar se queríamos escrever outra coisa com uma sugestão por baixo.

### [](https://resumos.leic.pt/ipm/dispositivos-moveis/#h10-dar-ajuda-e-documenta%C3%A7%C3%A3o)H10: dar ajuda e documentação

A última heurística refere-se a ajuda ser usada apenas quando ha problemas e, tendo isso em consideração, oferecer acesso rápido à informação. Contudo a ajuda não substitui mau desenho da IU e o sistema não deve depender dela para ser utilizado!

Alguns tipos diferentes de ajuda referem-se a:

-   Documentação
-   _Onboarding_ ao abrimos uma app pela primeira vez
-   Instruções passo-a-passo (_walkthrough_)
-   _Tooltips_
-   _Popovers_
-   _Chatbots_
-   Vídeos



