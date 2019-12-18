:- use_module(library(lists)).

% translate board atoms into chars
translate(0, '.').
translate(1, 'C').
translate(2, 'F').

% get specific rows or cols from board matrix
get_column([], _, []).
get_column([Row | Board], N, [Piece-Color | Col]):-
    nth1(N, Row, Piece-Color),
    getCol(Board, N, Col).

get_row(Board, N, Row):-
    nth1(N, Board, Row).

% List indexes in which Element appears
get_indexes(List, Element, Indexes):-
    findall(Index, nth1(Index, List, Element), Indexes).

get_distance_between_elements(List, Element, Distance):-
    % find indexes of Element in List
    get_indexes(List, Element, Indexes),
    % get single indexes
    nth1(1, Indexes, FirstIndex),
    nth1(2, Indexes, SecondIndex),
    % calculate distance
    Distance is SecondIndex - FirstIndex.
