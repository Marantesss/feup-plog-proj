:- use_module(library(lists)).

% =================================================================
% translate board atoms into chars
% =================================================================
translate(0, '.').
translate(1, 'C').
translate(2, 'F').

% =================================================================
% Replace 0's with _
% =================================================================
replace_zeros_matrix([], []).
replace_zeros_matrix([Row | Matrix], [NewRow | Rest]):-
    replace_zeros_matrix(Matrix, Rest),
    replace_zeros_row(Row, NewRow).

replace_zeros_row([], []).
replace_zeros_row([0 | Tail], [_ | Rest]):-
    replace_zeros_row(Tail, Rest).
replace_zeros_row([Head | Tail], [Head | Rest]):-
    replace_zeros_row(Tail, Rest).
