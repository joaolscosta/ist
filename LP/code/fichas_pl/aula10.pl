
substitui(T_c, Novo_F, Novo_T_c) :-
    Tc =.. [- | Args],
    Novo_T_c = [Novo_F | Args].


substitui_arg(T_c, Arg, Novo_Arg, Novo_T_c) :-
    T_c =.. [F | Args],
    maplist(substitui_se(Arg, Novo_Arg), Args, Novos_Args),
    Novo_T_c =..  [F | Novos_Args].    
substitui_se(Arg, _, Entrada, Entrada) :- Arg \== Entrada, !.
substitui_se(Arg, Subst, Entrada, Subst) :- Arg == Entrada, !.


todos(_, []) :- !.
todos(Pred, [P | R]) :-
    T_c =.. [Pred, P],
    call(T_c), !,
    todos(Pred, R).
par(X) :- X mod 2 =:= 0.


algum(Pred, [P | _]) :- 
    T_c =.. [Pred, P],
    call(T_c), !.
algum(Pred, [P | R]) :- 
    algum(Pred, R).


quantos(_, [], N, N) :- !.
quantos(Pred, [P | R], N, Aux) :-
    T_c =.. [Pred, P],
    call(T_c), !,
    New_Aux is Aux + 1,
    quantos(Pred, R, N, New_Aux).
quantos(Pred, [P | R], N, Aux) :-
    T_c =.. [Pred, P],
    \+ call(T_c),
    quantos(Pred, R, N, Aux).


transforma(_, [], []).
transforma(Tr, [P1 | R], [P2 | Res]) :-
    T_c =.. [Tr, P1, P2],
    call(T_c),
    transforma(Tr, R, Res).
soma_1(N, L) :- L is N + 1.


filtra_inc([], _, []) :- !.
filtra_inc([P | R], Tst, [P | Res]) :-
    T_c =.. [Tst, P],
    call(T_c), !,
    filtra_inc(R, Tst, Res).
filtra_inc([P | R], Tst, Res) :-
    filtra_inc(R, Tst, Res).
par(X) :- X mod 2 =:= 0.


filtra_exc([], _, []) :- !.
filtra_exc([P | R], Tst, [P | Res]) :-
    T_c =.. [Tst, P],
    \+ call(T_c), !,
    filtra_exc(R, Tst, Res).
filtra_exc([P | R], Tst, Res) :-
    filtra_exc(R, Tst, Res).
par(X) :- X mod 2 =:= 0.


acumula([P | R], Op, Res) :- acumula(R, Op, Res, P).
acumula([], _, Res, Res).
acumula([P | R], Op, Res, Aux) :-
    T_c =.. [Op, Aux, P, New_Aux],
    call(T_c),
    acumula(R, Op, Res, New_Aux).
mais(X, Y, Res) :- Res is X + Y.
menos(X, Y, Res) :- Res is X - Y.




