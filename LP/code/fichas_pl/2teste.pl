%   remove_pares(L1, L2)

remove_pares(L1, L2) :-
    findall(X, (member(X, L1), X mod 2 =\= 0), L2).

%_________________________________________________________
%   filtra_menores_n(N, L1, L2)

filtra_menores_n(N, L1, L2) :-
    exclude(menores(N), L1, L2).

menores(X, N) :-
    X < N.

%_________________________________________________________
%   asterisco(N)

asterisco(N) :-
    N > 0,
    write('*'),
    N_Aux is N - 1,
    asterisco(N_Aux).

asterisco(0) :- ln.

%_________________________________________________________
%   subsitui_par(L1, Subst, L2)

subsitui_par(Sub, L1, L2) :-
    maplist(par(Sub), L1, L2).

par(X, Sub, Y) :-
    X mod 2 =:= 0,
    Y = Sub.

par(X, Y, _) :-
    X mod 2 =\= 0,
    Y = X.

%_________________________________________________________
%   triangulo(N)

esc_N_ast(N) :-
    N > 0,
    write('*'),
    N_Aux is N - 1,
    esc_N_ast(N_Aux).

esc_N_ast(0) :- nl.

triangulo(N) :-
    N > 0,
    esc_N_ast(N),
    N_Aux is N - 1,
    triangulo(N_Aux).

triangulo(0).

%_________________________________________________________
%   substitui_pares(L1, N, L2)

aux(_, El1, El1) :- El1 mod 2 =\= 0.
aux(Subst, El1, Subst) :- El1 mod 2 =:= 0.

substitui_pares(L1, Subst, L2) :-
    maplist(aux(Subst), L1, L2).

