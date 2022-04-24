%                     Joao Luis Saraiva Costa  LEIC-A  102078  LP

%                   :::::::::::::::::::::::::::::::::::::::::::::::
%                       Solucionador de Puzzles Hashi (Parte I)                             
%                   :::::::::::::::::::::::::::::::::::::::::::::::

%_______________________________________________________________________________________________
% 
%   2.1     extrai_ilhas_linha(N_L, Linha, Ilhas)
%_______________________________________________________________________________________________

%   extrai_ilhas_linha(N_L, Linha, Ilhas), em que N_L eh um inteiro positivo,
%   correspondente ao numero de uma linha e Linha eh uma lista correspondente a uma linha
%   de um puzzle, significa que Ilhas eh a lista ordenada (ilhas da esquerda para a direita)
%   cujos elementos sao as ilhas da linha Linha.

%   Recorri a um predicado auxiliar para poder adicionar um parametro
%   novo que corresponde ao indice da linha, 1.

extrai_ilhas_linha(N, Linha, Ilhas) :-
    extrai_ilhas_linha(N, Linha, Ilhas, 1).

extrai_ilhas_linha(_, [], [], _).

%   ColunaAux e o que nos faz incrementar o indice semore que passamos para a proxima
%   situacao, ou seja, sempre que depois de verificar se o numero de pontes da ilha
%   e superior a zero, adicionamos mais um ao indice para que na recursao
%   analisemos o proximo caso.

extrai_ilhas_linha(N, [P_Linha | R_Linha], [ilha(P_Linha, (N, Coluna)) | Ilhas], Coluna) :-
    P_Linha > 0, ColunaAux is Coluna + 1,
    extrai_ilhas_linha(N, R_Linha, Ilhas, ColunaAux).

extrai_ilhas_linha(N, [P_Linha | R_Linha], Ilhas, Coluna) :-
    P_Linha == 0, ColunaAux is Coluna + 1,
    extrai_ilhas_linha(N, R_Linha, Ilhas, ColunaAux).


%_______________________________________________________________________________________________
%  
%   2.2     ilhas(Puz, Ilhas)
%_______________________________________________________________________________________________

%   ilhas(Puz, Ilhas), em que Puz eh um puzzle, significa que Ilhas eh a lista ordenada
%   (ilhas da esquerda para a direita e de cima para baixo) cujos elementos sao as ilhas de
%   Puz.

%   Recorremos a um predicado auxiliar para que tenhamos um novo parametro corresponde
%   a lista final onde vamos adicionar todas as ilhas que pertencerem ao puzzle.

ilhas(Puz, Ilhas) :-
    ilhas(Puz, Ilhas, 1, []).

ilhas([], Ilhas, _, Ilhas).

%   O parametro 1 vai corresponde a linha com que vamos trabalhar da linha em questao
%   e sempre que extrair as ilhas de uma ilha ira incrementar. Portanto usamos a nossa
%   lista vazia criada no predicado auxiliar para acumular todas as ilhas existentes
%   de cada linha usando um metodo de recursao para que possamos passar a proxima linha.

ilhas([P | R], Ilhas, Linha, AcumulaAux) :-
    extrai_ilhas_linha(Linha, P, IlhasLinha),  
    Linha1 is Linha + 1,
    append(AcumulaAux, IlhasLinha, Aux),
    ilhas(R, Ilhas, Linha1, Aux).


%______________________________________________________________________________________________
%   
%   2.3     vizinhas(Ilhas, Ilha, Vizinhas)
%______________________________________________________________________________________________

%   vizinhas(Ilhas, Ilha, Vizinhas), em que Ilhas eh a lista de ilhas de um puzzle
%   e Ilha eh uma dessas ilhas, significa que Vizinhas eh a lista ordenada (ilhas de cima para
%   baixo e da esquerda para a direita ) cujos elementos sao as ilhas vizinhas de Ilha.

%   Sendo assim optei por recorrei a predicados auxiliares para verificar todas as condicoes que
%   precisava tais como se havia vizinhas nas quatro direcoes posiveis da ilha alvo. Para que isto
%   acontecesse apenas precisei de dois parametros correspondentes a ilha_alvo e a uma ilha_teste.


vizinhas(Ilhas, IlhaAlvo, Vizinhas) :-
    include(vizinha_cima(IlhaAlvo), Ilhas, ListaIlhas_Acima),
    include(vizinha_baixo(IlhaAlvo), Ilhas, ListaIlhas_Abaixo),
    include(vizinha_esquerda(IlhaAlvo), Ilhas, ListaIlhas_Esquerda),
    include(vizinha_direita(IlhaAlvo), Ilhas, ListaIlhas_Direita),

%   Apos obtermons as condicoes correspondentes as ilhas vizinhas com auxilio dos predicados
%   auxiliares usados em baixo recorri a uma funcao built-in (include\3) para que possa criar
%   quatro listas que contem todas as ilhas nas quatro direcoes da ilha alvo.
    
    ((last(ListaIlhas_Acima, VizinhaAcimaAux), VizinhaAcima = [VizinhaAcimaAux]) ; VizinhaAcima = []),
    ((last(ListaIlhas_Esquerda, VizinhaEsquerdaAux), VizinhaEsquerda = [VizinhaEsquerdaAux]) ; VizinhaEsquerda = []),
    ((nth1(1, ListaIlhas_Direita, VizinhaDireitaAux), VizinhaDireita = [VizinhaDireitaAux]) ; VizinhaDireita = []),
    ((nth1(1, ListaIlhas_Abaixo, VizinhaBaixoAux), VizinhaBaixo = [VizinhaBaixoAux]) ; VizinhaBaixo = []),

%   Como para ser vizinha da ilha_alvo apenas so pertence a primeira ilha mais perto da ilha_alvo,
%   optei por usar outras duas funcoes built-in (last\2) que obtem de uma lista o ultimo elemento
%   e atribui a uma lista e (nth1\3) que consigo obter ou o elemento ou o indice desse elemento de
%   uma dada lista.

%   Com isto apenas tive que, para os casos em que existe ilhas acima e a esquerda da ilha_alvo,
%   obter o ulltimo elemento da lista e caso nao houver nenhuma linha nessa coluna ou nessa linha
%   devolve uma linha vazia. Utilizo o mesmo raciocinio para as ilhas vizinhas da direita e abaixo
%   mas obtenho o primeiro elemento dessas duas listas e caso nao haja nenhuma ilha retorna
%   uma lista vazia.

    VizinhasAux = [VizinhaAcima, VizinhaEsquerda, VizinhaDireita, VizinhaBaixo],
    append(VizinhasAux, Vizinhas).
    
%   Para terminar este predicado apenas tem mais um passo fundamental em que quando organizar as
%   ilhas na lista final apenas temos que passar primeiro por uma lista auxiliar pois pode acontecer
%   os casos em que existem listas vazias nessa lista obtidas nas quatro linhas de codigo anteriores
%   entao apenas usamos a funcao (append\2) para colocar na lista final todas as ilhas da funcao
%   auxiliar nao correspondentes a ilhas vazias.

%   Predicados auxiliares para verificar as ilhas vizinhas:
%   Todas estas quatro funcoes auxiliares tem apenas dois paramentros correspondentes a ilha_alvo e a
%   ilha_teste respetivamente.

vizinha_cima(ilha(_, (L1, C1)), ilha(_, (L2, C2))) :-
    L2 < L1, C2 == C1.

vizinha_baixo(ilha(_, (L1, C1)), ilha(_, (L2, C2))) :-
    L2 > L1, C2 == C1.

vizinha_esquerda(ilha(_, (L1, C1)), ilha(_, (L2, C2))) :-
    L2 == L1, C2 < C1.

vizinha_direita(ilha(_, (L1, C1)), ilha(_, (L2, C2))) :-
    L2 == L1, C2 > C1.


%______________________________________________________________________________________________
%   
%   2.4     estado(Ilhas, Estado)
%______________________________________________________________________________________________

%   estado(Ilhas, Estado), em que Ilhas eh a lista de ilhas de um puzzle, significa que
%   Estado eh a lista ordenada cujos elementos sao as entradas referentes a cada uma das
%   ilhas de Ilhas.

%   Como por recursao acabaria por eliminar as ilhas em que posteriormente poderia precisar
%   pois podem ser ilhas vizinhas de ilhas em analise mais a frente recorri a um predicado
%   auxiliar que vai ter exatamente o mesmo conteudo que o parametro Ilhas tem mas esta lista
%   nao se vai alterar para que consiga ai analisar cada ilha e nao faltar nenhuma ilha vizinha
%   que tenha sido antes analisada e removida apos isso.

estado(Ilhas, Estado) :-
    estado(Ilhas, Estado, Ilhas, []).

estado([], [], _, _).

estado([Ilha | RestoIlhas], [Estado | ListaEstados], Ilhas, Ponte) :-
    vizinhas(Ilhas, Ilha, Vizinhas),
    Estado = [Ilha, Vizinhas, Ponte],
    estado(RestoIlhas, ListaEstados, Ilhas, Ponte).

%______________________________________________________________________________________________
%  
%   2.5     posicoes_entre(Pos1, Pos2, Posicoes)  
%______________________________________________________________________________________________

%   posicoes_entre(Pos1, Pos2, Posicoes), em que Pos1 e Pos2 sao posicoes, sig-
%   nifica que Posicoes eh a lista ordenada de posicoes entre Pos1 e Pos2 (excluindo Pos1 e
%   Pos2). Se Pos1 e Pos2 nao pertencerem a mesma linha ou a mesma coluna, o resultado
%   eh false.

posicoes_entre((L1, C1), (L2, C2), Posicoes) :-
    ((L1 =\= L2, C1 == C2) ; (L1 == L2, C1 =\= C2) ; (L1 == L2, C1 == C2)),
    linhas_diferentes(L1, L2, LinhasDiferentes),
    colunas_diferentes(C1, C2, ColunasDiferentes),
    findall((L,C), (member(L,LinhasDiferentes), member(C, ColunasDiferentes)), PosicoesAux),
    subtract(PosicoesAux, [(L1, C1)], PosicoesAux1) , subtract(PosicoesAux1, [(L2, C2)], Posicoes).

%   Para verificar quais as posicoes entre as duas posicoes dadas recorri a duas funcoes
%   auxiliares que verificam a mesma condicao mas se sao linhas ou colunas diferentes.
%   O que cada precido destes faz quando e chamado e ver o maximo e minimo das linhas e das
%   colunas respetivamente e retorna uma lista com as posicoes da condicao que se verificar.

%   Posteriormente na funcao main com auxilio dos predicados auxiliares forma-se uma lista com
%   todas essas posicoes entre elas e atraves do metapredicado subtract\2, retira-se as duas posicoes
%   iniciais pois nao pertencem ao que queremos obter.

linhas_diferentes(L1, L2, LinhasDiferentes) :-
    Lm is min(L1, L2), LM is max(L1, L2), 
    findall(Linha, between(Lm, LM, Linha), LinhasDiferentes).

colunas_diferentes(C1, C2, ColunasDiferentes) :-
    Cm is min(C1, C2), CM is max(C1, C2),
    findall(Coluna, between(Cm, CM, Coluna), ColunasDiferentes).

%______________________________________________________________________________________________
%   
%   2.6     cria_ponte(Pos1, Pos2, Ponte)
%______________________________________________________________________________________________

%   cria_ponte(Pos1, Pos2, Ponte), em que Pos1 e Pos2 sao 2 posicoes, significa
%   que Ponte e uma ponte entre essas 2 posicoes.

cria_ponte((L1, C1), (L2, C2), Ponte) :-
    ((L1 =\= L2, C1 == C2) ; (L1 == L2, C1 =\= C2) ; (L1 == L2, C1 == C2)),
    ordena_ponte((L1, C1), (L2, C2), Ponte).
    
%   Com o auxilio de um predicado auxliar eh me possivel verificar 4 condicoes que
%   podem acontecer para ordenar pontes.

%   No dois primeiros predicados podemos verificar se das duas posicoes uma delas 
%   tiver uma linha inferior doque a outra entao essa decerteza vem primeiro. 

ordena_ponte((L1, C1), (L2, C2), Ponte) :-
    (L1 < L2) ,
    Ponte = ponte((L1, C1), (L2, C2)).
    
ordena_ponte((L1, C1), (L2, C2), Ponte) :-
    (L2 < L1) , 
    Ponte = ponte((L2, C2), (L1, C1)).

%   Ja quando as linhas sao iguais passamos as colunas e verificamos qual das posicoes
%   tem a coluna inferior pois essa posicao antecede a outra.

ordena_ponte((L1, C1), (L2, C2), Ponte) :-
    (L1 == L2 , C1 < C2),
    Ponte = ponte((L1, C1), (L2, C2)).
    
ordena_ponte((L1, C1), (L2, C2), Ponte) :-
    (L1 == L2 , C2 < C1),
    Ponte = ponte((L2, C2), (L1, C1)).
    
%______________________________________________________________________________________________
%   
%   2.7     caminho_livre(Pos1, Pos2, Posicoes, I, Vz)
%______________________________________________________________________________________________

%   caminho_livre(Pos1, Pos2, Posicoes, I, Vz), em que Pos1 e Pos2 sao posicoes, Posicoes
%   e a lista ordenada de posicoes entre Pos1 e Pos2, I eh uma ilha, e Vz
%   eh uma das suas vizinhas, significa que a adicao da ponte ponte(Pos1, Pos2) nao faz
%   com que I e Vz deixem de ser vizinhas

%   Para que o caminho seja livre as posicoes entre as duas ilhas a analisar nao podem
%   corresponder a nenhuma das posicoes entre as duas posicoes Pos1 e Pos2. Entao fiz
%   uma serie de predicados auxiliares para me ajudar a verificar cada uma dessas situacoes.


caminho_livre(Pos1, Pos2, Posicoes, ilha(_, PosI), ilha(_, PosV)) :-
    posicoes_entre(PosI, PosV, EntreIlhas),
    aux_comum(Pos1, Pos2, Posicoes, EntreIlhas, ilha(_, PosI), ilha(_, PosV)).

%   Basicamente temos que os dois primeiros predicados auxiliares verificam se as posicoes
%   das ilhas correspondem ou nao as duas posicoes inseridas e apos isso com recurso ao
%   metapredicado findall/3 obtemos uma lista que corresponde a lista de posicoes que
%   pertenco tanto as posicoes entre ilhas como as das posicoes.

%   Para verificar se existem posicoes entre essas duas unificamos a lista obtida
%   anteriormente com uma lista vazia e se for der valor true nao existem
%   ilhas correspondentes nas duas listas. Se der false e porque a lista nao eh
%   vazia e entao existem ilhas que pertencem as duas listas e o caminho nao e
%   livre

aux_comum(Pos1, Pos2, Posicoes, EntreIlhas, ilha(_, PosI), ilha(_, PosV)) :-
    (Pos1 \== PosI ; Pos2 \== PosV ; Pos2 \== PosI ; Pos1 \== PosV),
    findall(El, (member(El, Posicoes), member(El, EntreIlhas)), ListaComum),
    ListaComum == [].
    
aux_comum(Pos1, Pos2, Posicoes, EntreIlhas, ilha(_, PosI), ilha(_, PosV)) :-
    Pos1 == PosI , Pos2 == PosV,
    findall(El, (member(El, Posicoes), member(El, EntreIlhas)), ListaComum),
    ListaComum == [].

%   Ja para este predicado auxiliar o seu objetivo e verificar que as duas posicoes
%   inseridas sao exatamente as mesmas que as duas ilhas e entao da true pois eh
%   um caminho livre.

aux_comum(Pos1, Pos2, _, _, ilha(_, PosI), ilha(_, PosV)) :-
    ((Pos1 == PosI , Pos2 == PosV) ; (Pos2 == PosI , Pos1 == PosV)).


%______________________________________________________________________________________________
%   
%   2.8     actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, Entrada, Nova_Entrada)
%______________________________________________________________________________________________

%   actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, Entrada,
%   Nova_Entrada), em que Pos1 e Pos2 sao as posicoes entre as quais ira ser adi-
%   cionada uma ponte, Posicoes e a lista ordenada de posicoes entre Pos1 e Pos2,
%   e Entrada e uma entrada (ver Seccao 2.4), significa que Nova_Entrada e igual a
%   Entrada, excepto no que diz respeito a lista de ilhas vizinhas; esta deve ser actualizada,
%   removendo as ilhas que deixaram de ser vizinhas, apos a adicao da ponte.

actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, [Ilha, Vizinhas, Pontes], Nova_Entrada) :-
    include(caminho_livre(Pos1, Pos2, Posicoes, Ilha), Vizinhas, ListaVizinhas),
    Nova_Entrada = [Ilha, ListaVizinhas, Pontes].

%______________________________________________________________________________________________
%   
%   2.9     actualiza_vizinhas_apos_pontes(Estado, Pos1, Pos2, Novo_estado)
%______________________________________________________________________________________________

%   actualiza_vizinhas_apos_pontes(Estado, Pos1, Pos2, Novo_estado) ,
%   em que Estado e um estado (ver Seccao 2.4), Pos1 e Pos2 sao as posicoes entre as
%   quais foi adicionada uma ponte, significa que Novo_estado eh o estado que se obtem de
%   Estado apos a actualizacao das ilhas vizinhas de cada uma das suas entradas.

actualiza_vizinhas_apos_pontes(Estado, Pos1, Pos2, Novo_estado) :-
    posicoes_entre(Pos1, Pos2, Posicoes),
    actualiza_vizinhas_apos_pontes(Estado, Pos1, Pos2, Novo_estado, [], Posicoes).

actualiza_vizinhas_apos_pontes([], _, _, NovoEstado, NovoEstado, _).

actualiza_vizinhas_apos_pontes([P_Entrada | R_Entrada], Pos1, Pos2, NovoEstado, AcumulaEstados, Posicoes) :-
    actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, P_Entrada, NovaEntrada),
    append(AcumulaEstados, [NovaEntrada], NovoAux),
    actualiza_vizinhas_apos_pontes(R_Entrada, Pos1, Pos2, NovoEstado, NovoAux, Posicoes).


%______________________________________________________________________________________________
%   
%   2.10     ilhas_terminadas(Estado, Ilhas_term)
%______________________________________________________________________________________________

%   ilhas_terminadas(Estado, Ilhas_term), em que Estado eh um estado (ver Seccao 2.4), 
%    significa que Ilhas_term eh a lista de ilhas que ja tem todas as pontes associadas,
%   designadas por ilhas terminadas. Se a entrada referente a uma ilha for [ilha(N_pontes,
%   Pos), Vizinhas, Pontes], esta ilha esta terminada se N_pontes for diferente de
%   X (a razao para esta condicao ficara aparente mais a frente) e o comprimento da lista
%   Pontes for N_pontes.

%   Optei por um metodo de recursao que percorre todo o Estado analisando cada entrada
%   uma a uma de maneira que verifica neste primeiro predicado se o numero de pontes eh
%   igual ao numero de espacos do ultimo indice de cada entrada. Usei o metapredicado
%   nth1/3 para cinseguir obter as pontes e a ilha e para obter o numero de pontes
%   usei arg/3 em que temos a ilha(X,Y) e como nao eh uma lista e sim uma funcao o arg atua
%   exatamente da mesma maneira que o nth/3 mas para funcoes compostas.
%   Quando verifica que sao iguais adiciona a lista final a lista final essa ilha.

ilhas_terminadas([P_Entrada | R_Entrada], [Ilha | Ilhas_term]) :-
    nth1(1, P_Entrada, Ilha), arg(1, Ilha, N_pontes),
    nth1(3, P_Entrada, Pontes), length(Pontes, Nmr_Pontes),
    N_pontes == Nmr_Pontes,
    ilhas_terminadas(R_Entrada, Ilhas_term).

%   Este eh o caso em que verifica que o numero de pontes e as pontes sao diferentes entao
%   este predicado apenas da continuidade a funcao e nao adiciona absolutamente nada a lista.

ilhas_terminadas([P_Entrada | R_Entrada], Ilhas_term) :-
    nth1(1, P_Entrada, Ilha), arg(1, Ilha, N_pontes),
    nth1(3, P_Entrada, Pontes), length(Pontes, Nmr_Pontes),
    N_pontes \= Nmr_Pontes,
    ilhas_terminadas(R_Entrada, Ilhas_term).
        
ilhas_terminadas([], []).


%______________________________________________________________________________________________
%   
%   2.11     tira_ilhas_terminadas(Estado, Ilhas_term, Novo_estado)
%______________________________________________________________________________________________

%   tira_ilhas_terminadas_entrada(Ilhas_term, Entrada, Nova_entrada),
%   em que Ilhas_term eh uma lista de ilhas terminadas e Entrada eh uma entrada (ver
%   Seccao 2.4), significa que Nova_entrada eh a entrada resultante de remover as ilhas de
%   Ilhas_term, da lista de ilhas vizinhas de entrada.

%   Para isto usamos mais ou menos o ciclo de raciocinio do predicado anterior mas desta vez
%   temos apenas uma entrada e com auxilio a metapredicados obtemos as suas ilhas vizinhas
%   que queremos comparar com as Ilhas_term e quais destas correspondem. No final apenas
%   apresentamos a mesma entrada mas alterada de maneira a que aparecam as vizinhas
%   alteradas.

tira_ilhas_terminadas_entrada(Ilhas_term, Entrada, Nova_entrada) :-
    nth1(2, Entrada, IlhasVizinhas),
    findall(X, (member(X, IlhasVizinhas), not(member(X, Ilhas_term))), IlhasDiferentes),
    nth1(1, Entrada, IlhaAlvo),
    nth1(3, Entrada, Ponte),
    Nova_entrada = [IlhaAlvo, IlhasDiferentes, Ponte].
    

%______________________________________________________________________________________________
%   
%   2.12     tira_ilhas_terminadas(Estado, Ilhas_term, Novo_estado)
%______________________________________________________________________________________________

%   tira_ilhas_terminadas(Estado, Ilhas_term, Novo_estado), em que
%   Estado eh um estado (ver Seccao 2.4) e Ilhas_term eh uma lista de ilhas termi-
%   nadas, significa que Novo_estado eh o estado resultante de aplicar o predicado
%   tira_ilhas_terminadas_entrada a cada uma das entradas de Estado.

tira_ilhas_terminadas(Estado, Ilhas_term, Novo_estado) :-
    findall(Y, (member(X, Estado), tira_ilhas_terminadas_entrada(Ilhas_term, X,Y)), Novo_estado).


%______________________________________________________________________________________________
%   
%   2.13    marca_ilhas_terminadas_entrada(Ilhas_term, Entrada, Nova_entrada)
%______________________________________________________________________________________________

%   marca_ilhas_terminadas_entrada(Ilhas_term, Entrada,
%   Nova_entrada), em que Ilhas_term eh uma lista de ilhas terminadas e Entrada
%   eh uma entrada (ver Seccao 2.4), significa que Nova_entrada eh a entrada obtida de
%   Entrada da seguinte forma: se a ilha de Entrada pertencer a Ilhas_term, o numero
%   de pontes desta eh substituido por 'X'; em caso contrario Nova_entrada eh igual a
%   Entrada.

%   Para que isto aconteca existem apenas dois casos: se a ilha alvo corresponder com
%   alguma das ilhas terminadas, e por isso usamos o member, susbtituimos no primeiro
%   caso o numero de pontes por 'X'. Se de facto nao houver nenhuma ilha que corresponda
%   a nova entrada sera exatamente a mesma.

marca_ilhas_terminadas_entrada(Ilhas_term, Entrada, Nova_entrada) :-
    nth1(1, Entrada, IlhaAlvo),
    nth1(2, Entrada, Vizinhas),
    nth1(3, Entrada, Ponte),
    member(IlhaAlvo, Ilhas_term),
    IlhaAlvo = ilha(_, (L, C)),
    NovaIlha = ilha('X', (L, C)),
    Nova_entrada = [NovaIlha, Vizinhas, Ponte].
    

marca_ilhas_terminadas_entrada(Ilhas_term, Entrada, Nova_entrada) :-
    nth1(1, Entrada, IlhaAlvo),
    nth1(2, Entrada, Vizinhas),
    nth1(3, Entrada, Ponte),
    not(member(IlhaAlvo, Ilhas_term)),
    Nova_entrada = [IlhaAlvo, Vizinhas, Ponte].


%______________________________________________________________________________________________
%   
%   2.14    marca_ilhas_terminadas(Estado, Ilhas_term, Novo_estado)
%______________________________________________________________________________________________

%   marca_ilhas_terminadas(Estado, Ilhas_term, Novo_estado), em que
%   Estado eh um estado (ver Seccao 2.4) e Ilhas_term eh uma lista de ilhas termi-
%   nadas, significa que Novo_estado eh o estado resultante de aplicar o predicado
%   marca_ilhas_terminadas_entrada a cada uma das entradas de Estado.

marca_ilhas_terminadas(Estado, Ilhas_term, Novo_estado) :-
    findall(Y, (member(X, Estado), marca_ilhas_terminadas_entrada(Ilhas_term, X,Y)), Novo_estado).


%______________________________________________________________________________________________
%   
%   2.15    trata_ilhas_terminadas(Estado, Novo_estado)
%______________________________________________________________________________________________

%   trata_ilhas_terminadas(Estado, Novo_estado), em que Estado eh um estado
%   (ver Seccao 2.4), significa que Novo_estado eh o estado resultante de aplicar os predica-
%   dos tira_ilhas_terminadas e marca_ilhas_terminadas a Estado.

trata_ilhas_terminadas(Estado, Novo_estado) :-
    ilhas_terminadas(Estado, Ilhas_term),
    tira_ilhas_terminadas(Estado, Ilhas_term, TiraTerminadas),
    marca_ilhas_terminadas(TiraTerminadas, Ilhas_term, Novo_estado).


%______________________________________________________________________________________________
%   
%   2.16    junta_pontes(Estado, Num_pontes, Ilha1, Ilha2, Novo_estado)
%______________________________________________________________________________________________

%   junta_pontes(Estado, Num_pontes, Ilha1, Ilha2, Novo_estado), em
%   que Estado eh um estado e Ilha1 e Ilha2 sao 2 ilhas, significa que Novo_estado e
%   o estado que se obtem de Estado por adicao de Num_pontes pontes entre Ilha1 e
%   Ilha2 .

%   Para realizar este predicado pedido vamos ter uma serie de passos que temos que ter
%   em consideracao. 
%   Comecamos por criar uma ponte ponte(Ilha1, Ilha2) com auxilio de um predicado
%   anteriormente definido criou-se um predicado auxiliar que cria as pontes
%   de acordo com o numero de pontes pretendidas.

%   De seguida, Nas entradas cuja ilha alvo eh a ilha1 e a ilha dois ao mesmo tempo
%   adiciona-se as pontes ao terceiro parametro da lista de entrada correspondente
%   a lista das pontes. Tudo isto dito com auxilio de um predicado auxiliar chamado
%   percorre_entradas que faz tanto a verificacao das ilhas serem iguais como da sua
%   substituicao.

%   Para acabar apenas tive que aplicar os dois predicados anteriormente definidos
%   actualiza_vizinhas_apos_pontes e trata_ilhas_terminadas para apresentar o 
%   Novo_estado que se obtem pela adicao das n_pontes entre a ilha1 e a ilha2.

junta_pontes(Estado, Num_pontes, ilha(N1, Pos1), ilha(N2, Pos2), Novo_estado) :-
    cria_pontes(Num_pontes, Pos1, Pos2, ListaPontes),
    percorre_entradas(Estado, ilha(N1, Pos1), ilha(N2, Pos2), ListaPontes, ListaEntradas),
    actualiza_vizinhas_apos_pontes(ListaEntradas, Pos1, Pos2, VizinhasAtualizadas),
    trata_ilhas_terminadas(VizinhasAtualizadas, Novo_estado).


cria_pontes(0, _, _, []).
cria_pontes(Num_pontes, Pos1, Pos2, [Ponte | ListaPontes]) :-
    Num_pontes > 0,
    cria_ponte(Pos1, Pos2, Ponte),
    Num_pontes_aux is Num_pontes - 1,
    cria_pontes(Num_pontes_aux, Pos1, Pos2, ListaPontes).

percorre_entradas([], _, _, _, []).
percorre_entradas([P_Entrada | R_Entrada], ilha(N1, Pos1), ilha(N2, Pos2), ListaPontes,  [P_Entrada | ListaEntradas]) :-
    P_Entrada = [Ilha, _, _],
    Ilha \== ilha(N1, Pos1),
    Ilha \== ilha(N2, Pos2),
    percorre_entradas(R_Entrada, ilha(N1, Pos1), ilha(N2, Pos2), ListaPontes, ListaEntradas).
percorre_entradas([P_Entrada | R_Entrada], ilha(N1, Pos1), ilha(N2, Pos2), ListaPontes, [EntradaAlterada | ListaEntradas]) :-
    P_Entrada = [Ilha, Vizinhas, Pontes],
    (Ilha == ilha(N1, Pos1) ; Ilha == ilha(N2, Pos2)),
    append(Pontes, ListaPontes, PontesAtualizadas),
    EntradaAlterada = [Ilha, Vizinhas, PontesAtualizadas],
    percorre_entradas(R_Entrada, ilha(N1, Pos1), ilha(N2, Pos2), ListaPontes, ListaEntradas).
    






