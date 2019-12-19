:- use_module(library(clpfd)).
:- consult('utils.pl').
:- consult('puzzles.pl').

/*
0 -> EMPTY
1 -> CLOSE
2 -> FAR
*/

% =================================================================
% Decision Variables
% =================================================================
apply_domain([]).
apply_domain([Row | Board]):-
    % (0 - empty, 1 - close, 2 - far)
    domain(Row, 0, 2),
    apply_domain(Board).

% =================================================================
% Restrictions
% =================================================================
% ====== Size restrictions =====
size_restrictions_per_row(_Size, []).
size_restrictions_per_row(Size, [Row | Board]):-
    length(Row, Size),
    size_restrictions_per_row(Size, Board).

size_restrictions(Size, Board):-
    length(Board, Size),
    size_restrictions_per_row(Size, Board).

% ====== Occurences restrictions ======
apply_occurences_restrictrions(Board):-
    % calculate number of 0's (empty)
    % get number of cells per row (same as per col)
    length(Board, NumberOfCells),
    % get number of 0's (number of cells - (number of 1's + number of 2's))
    NumberOfZeros #= NumberOfCells - 4,
    % apply restrictions per row
    occurences_restrictions_per_row(Board, NumberOfZeros),
    % apply restrictions per colum (with transposed matrix)
    transpose(Board, TransposedBoard),
    occurences_restrictions_per_row(TransposedBoard, NumberOfZeros).

occurences_restrictions_per_row([], _NumberOfZeros).
occurences_restrictions_per_row([Row | Board], NumberOfZeros):-
    global_cardinality(Row, [
        % NumberOfZeros occurences of 0 (empty) per row
        0-NumberOfZeros,
        % 2 occurences of 1 (close) per row
        1-2,
        % 2 occurences of 2 (far) per row
        2-2
    ]),
    % apply restriction to next rows
    occurences_restrictions_per_row(Board, NumberOfZeros).

% ====== Distances ======
apply_distance_restrictrions(Board):-
    % apply restrictions per row
    distance_restrictions_per_row(Board),
    % apply restrictions per colum (with transposed board matrix)
    transpose(Board, TransposedBoard),
    distance_restrictions_per_row(TransposedBoard).

get_distance_between_elements(List, Element, Distance):-
    % find indexes of Element in List
    element(FirstIndex, List, Element),
    element(SecondIndex, List, Element),
    % indexes have to be unique
    FirstIndex #\= SecondIndex,
    % first index has to come first
    FirstIndex #< SecondIndex,
    % calculate distance
    Distance #= SecondIndex - FirstIndex.

distance_restrictions_per_row([]).
distance_restrictions_per_row([Row | Board]):-
    % get distance between 1's (close)
    get_distance_between_elements(Row, 1, CloseDistance),
    % get distance between 2's (far)
    get_distance_between_elements(Row, 2, FarDistance),
    % apply MAIN restriction
    CloseDistance #< FarDistance,
    % apply restriction to next rows
    distance_restrictions_per_row(Board).

% =================================================================
% Board Solver
% =================================================================
solve_puzzle(Board):-
    % --- DECISION VARIABLES ---
    % length is already defined by Board
    apply_domain(Board),
    % --- RESTRICTIONS ---
    apply_occurences_restrictrions(Board),
    apply_distance_restrictrions(Board),
    % --- LABELING ---
    labeling([], Board).

% =================================================================
% Line Solver
% =================================================================
solve_line(Line):-
    % --- DECISION VARIABLES ---
    % length is already defined by Line
    domain(Line, 0, 2),
    % --- RESTRICTIONS ---
    % ==== 2 occurences of 1 (close) and 2 occurences of 2 (far)
    count(1, Line, #=, 2), count(2, Line, #=, 2),
    % ==== remaining elements are all 0's (empty)
    % get number of cells
    length(Line, NumberOfCells),
    % get number of 0's (number of cells - (number of 1's + number of 2's))
    NumberOfZeros #= NumberOfCells - 4,
    % apply restriction
    count(0, Line, #=, NumberOfZeros),
    % ==== distance between 1's (close) is smaller than 2's (far) in each line
    % get distance between 1's (close)
    get_distance_between_elements(Line, 1, CloseDistance),
    % get distance between 2's (far)
    get_distance_between_elements(Line, 2, FarDistance),
    % apply MAIN restriction
    CloseDistance #< FarDistance,
    % --- LABELING ---
    labeling([], Line),
    write(Line), nl.
