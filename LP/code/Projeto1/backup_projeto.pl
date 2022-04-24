%                   :::::::::::::::::::::::::::::::::::::::::::::::
%                       Solucionador de Puzzles Hashi (Parte I)
%                               Joao Luis Saraiva Costa
%                                 LEIC-A  102078  LP
%                   :::::::::::::::::::::::::::::::::::::::::::::::

%:- [codigo_comum, puzzles_publicos].

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

caminho_livre(_, _, Posicoes, ilha(_, (L_I, C_I)), ilha(_, (L_V, C_V))) :-
    posicoes_entre((L_I, C_I), (L_V, C_V), EntreIlhas),
    verifica_pertence(Posicoes, EntreIlhas).

verifica_pertence([], _).

verifica_pertence([P_Pos | Res_Pos], EntreIlhas) :-
    member(P_Pos, EntreIlhas),
    verifica_pertence(Res_Pos, EntreIlhas).


%______________________________________________________________________________________________
%   
%   2.8     actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, Entrada, Nova_Entrada)
%______________________________________________________________________________________________

    
    