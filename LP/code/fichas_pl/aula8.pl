% Alguns exemplos úteis para esta ficha.

%   7.7.2

suc(N, M) :- N is M + 1.
ant(N, M) :- N is M - 1. % e ao contrario

perimetro(R, P) :-
    P is 2 * pi * R.

divisor(D, N) :-
    0 =:= N mod D.

%   7.7.6 a)

soma_digitos(_, _).

soma_digitos(N, S) :-
    N > 0,
    NewN is N // 10,
    Dig is N mod 10,
    soma_digitos(NewN, SAux),
    S is +(Dig, SAux).

% b)

soma_digitos_it(N, S) :-
    soma_digitos_it(N, S, 0).
  
  soma_digitos_it(0, Res, Res).
  
  soma_digitos_it(N, S, Ac) :-
    N > 0,
    NewAc is Ac + (N mod 10),
    NewN is N // 10,
    soma_digitos_it(NewN, S, NewAc).

