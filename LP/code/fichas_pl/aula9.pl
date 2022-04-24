

classe(0, Zero)) :- !.

classe(X, Negativo) :-
    X < 0, !.

classe(X, Positivo) :-
    X > 0, !.


intersecao([], _, []) :- !.

intersecao(_, [], []) :- !.

intersecao([P | R], L2, [P | R1]) :-
    member(P, L2),
    !.

intersecao([P | R], L2, I) :-
    \+ member(P, L2),
    intersecao(R, L2, I).


%   a)
disjuntas([], _) :- !.

disjuntas(_, []) :- !.

disjuntas([P | _], L2) :-
    member(P, L2), !, fail.

disjuntas([P | R], L2) :-
    \+ member(P, L2),
    disjuntas(R, L2).

%   b)

disjuntas(_, []).

disjuntas([], _).

disjuntas([P | R], L2) :-
    \+ member(P, L2),
    disjuntas(R, L2).


%   7.13.6


























