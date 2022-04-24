%   O QUE PODEMOS USAR NESTA FICHA:

%   maplist(Pred, Lst) 2,3,4,5
%   include(Pred, l1, l2)
%   exclude
%   findall
%   setof - Aqui não há repetiçao
%   append
%   lenght
%   nth

%   1.  insere_ordenado(El, Lst1, Lst2)

insere_ordenado(E, L1, L2) :-
    findall(X, (member(X, L1), X < E) , Menores),
    findall(X, (member(X, L1), X > E) , Maiores),
    append(Menores, [E | Maiores], L2).


%   2. junta_novo_aleatorio(L1, I, S, L2)

junta_novo_aleatorio(L1, Inf, Sup, L2) :-
    findall(N, between(Inf, Sup, Todos)), % faz a lista [1,2,3,4,5]
    subtract(Todos, L1, Possiveis), % tira os el da lista inicial [2,4,5]
    length(Possiveis, T), % assim sabemos o tamanho da lista
    random_between(1,T,Aleat), 
    nth1(Aleat, Possiveis, Novo),
    insere_ordenado(Novo, L1, L2).


%   3. repete(El, N, L)
repete_el(E, N, L) :-
    % afirmar que L, desconhecida, tem comprimento N
    length(L, N),
    % o predicado fará com que todos os espaços vazios sejam "unificados" com E
    maplist(=(E), L).


%   4. duplica_elementos(l1, l2)

duplica_elementos(L1, L2) :-
    findall([E, E], member(E, L1), L_Aux),
    append(L1, L_Aux, L2).


%   5. num_occ(L, El, N)

num_occ(L, El, N) :-
    findall(El, member(El, L), Aux),
    length(Aux, N).


%   6.substitui_maiores(N, Subst, L1, L2)

substitui_maiores(N, Subst, L1, L2) :-
    maplist(maiores_aux(N, Subst, L1, L2)).

maiores_aux(N, Subst, El, Subst) :- 
    El > N.

maiores_aux(N, Subst, El, El) :-
    El <= N.


% OUUUUUUU ( Este pode dar errado em alguns casos )

substitui_maiores(N, Subst, L1, L2) :-
    findall(X, (member(X, L1), X <= N), Lm),
    findall(Y, (member(Y, L1), Y > N), LM),
    length(LM, , Comp), repete_el(Sub, Comp, LSub),
    append(Lm, Lsub, L2).
    
