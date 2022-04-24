% 7.6.1     nao_membro(El, Lst)

nao_membro(_, []).
nao_membro(E, [P|R]) :- 
    E \== P, nao_membro(E, R).

% 7.6.2     insere_ordenado(El, Lst1, Lst2)

insere_ordenado(N, [], [N]).
insere_ordenado(N, [P|R], [N, P|R]) :-
    N < P.
insere_ordenado(N, [P|R], [P|R2]) :-
    N >= P, insere_ordenado(N, R, R2).

% 7.6.3     junta_novo_aleatorio(Lst1, Lim_Inf, Lim_Sup, Lst2)

junta_novo_aleatorio([P|R], I, S, Lst2) :-
    random_between(I, S, Aleat), nao_membro(Aleat, [P|R]),
    insere_ordenado(Aleat, [P|R], Lst2).
    

% 7.6.4     n_aleatorios(N, Lim_Inf, Lim_Sup, Lst)

n_aleatorios(0, _, _, []).

n_aleatorios(N, I, S, Lst) :-
    N > 0, NewN is N - 1,
    n_aleatorios(NewN, I, S, LstAux),
    junta_novo_aleatorio(LstAux, I, S, Lst).


% chave_euromilhoes(Numeros, Estrelas)

chave_euromilhoes(Numeros, Estrelas) :-
    n_aleatorios(5, 1, 50, Numeros),
    n_aleatorios(2, 1, 12, Estrelas).

