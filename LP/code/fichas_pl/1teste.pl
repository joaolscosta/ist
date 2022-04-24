% substitui(lst, el, novo, lstnovo)

substitui_novo([], _, _, []).

substitui_novo([P_l | R_l], El, Novo, [P_l | LstF]) :-
    P_l \== El, substitui_novo(R_l, El, Novo, LstF).

substitui_novo([P_l | R_l], El, Novo, [Novo | LstF]) :-
    P_l == El, substitui_novo(R_l, El, Novo, LstF).


% substitui(lst, El, lstnovo)

substitui_par([], _, []).

substitui_par([P_l1 | R_l1], El, [El | LstF]) :-
    P_l1 mod 2 =:= 0, substitui_par(R_l1, El, LstF).

substitui_par([P_l1 | R_l1], El, [P_l1 | LstF]) :-
    P_l1 mod 2 =\= 0, substitui_par(R_l1, El, LstF).


% substitui_vazia(lstI, lstF)

substitui_vazia([],[]).

substitui_vazia([P_l2 | R_l2], [vazia | LstF]) :-
    P_l2 == [], substitui_vazia(R_l2, LstF). 

substitui_vazia([P_l2 | R_l2], [P_l2 | LstF]) :-
    P_l2 \== [], substitui_vazia(R_l2, LstF).




    