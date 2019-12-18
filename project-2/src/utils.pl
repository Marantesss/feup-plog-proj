:- use_module(library(lists)).

% translate board atoms into chars
translate(0, '.').
translate(1, 'C').
translate(2, 'F').

% get specific rows or cols from board matrix
get_column([], _, []).
get_column([Row | Board], N, [Element | Col]):-
    nth1(N, Row, Element),
    get_column(Board, N, Col).

get_row(Board, N, Row):-
    nth1(N, Board, Row).

% List indexes in which Element appears
get_indexes(List, Element, Indexes):-
    findall(Index, nth1(Index, List, Element), Indexes).
