% elimnaNumeros(Lista,ListaSemNumeros)

eliminaNumeros([],[]).

eliminaNumeros([P | R], Res) :- number(P) , eliminaNumeros(R , Res).

eliminaNumeros([P | R], [P | Res]) :- not(number(P)) 
    , eliminaNumeros(R, Res).


% descodificaDia2(SequenciaFonte, SequenciaAlvo, MensagemCodificada,
%   MensagemDescodificada)

descodificaDia2(_, _, [], []).

descodificaDia2(SequenciaFonte, SequenciaAlvo, [P|R], [El | LstF]) :-
    nth1(Indice, SequenciaAlvo, P),
    nth1(Indice, SequenciaFonte, El),
    descodificaDia2(SequenciaFonte, SequenciaAlvo, R, LstF).

descodificaDia2(SequenciaFonte, SequenciaAlvo, [P|R], LstF) :-
    not(nth1(Indice, SequenciaAlvo, LstF),
    descodificaDia2(SequenciaFonte, SequenciaAlvo, R, LstF).

% programa1Dia3(SequenciaFonte, SequenciaAlvo, ListaParesCodigo)

programa1Dia3([], [], []).

programa1Dia3([P_fonte | R_fonte], [P_alvo | R_alvo], [par(P_fonte, P_alvo) | Res]) :-
    programa1Dia3(R_fonte, R_alvo, Res).


% programa2Dia3(ListaParesCodigo, MensagemCodificada, MensagemDescodificada)

programa2Dia3(_, [], []).

programa2Dia3(ListaParesCodigo, [P_cod | R_cod], MensagemDescodificada) :-
    