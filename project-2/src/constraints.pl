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
% ====== Occurences ======
two_occurences_per_row([]).
two_occurences_per_row([Row | Board]):-
    % 2 occurences of 1 (close) per row
    count(1, Row, #=, 2),
    % 2 occurences of 2 (far) per row
    count(2, Row, #=, 2),
    % apply restriction to next rows
    two_occurences_per_row(Board).

two_occurences_per_column_aux(_, 0).
two_occurences_per_column_aux(Board, ColumnNumber):-
    % get column
    get_column(Board, ColumnNumber, Column),
    % 2 occurences of 1 (close) per column
    count(1, Column, #=, 2),
    % 2 occurences of 2 (far) per column
    count(2, Column, #=, 2),
    % apply restriction to next columns
    NextColumnNumber #= ColumnNumber - 1,
    two_occurences_per_column_aux(Board, NextColumnNumber).

two_occurences_per_column(Board):-
    % get number of columns in Board
    length(Board, NumberOfColumns),
    two_occurences_per_column_aux(Board, NumberOfColumns).

board_remainder_zeros([Row | Board]):-
    % --- everything in a row besides two 1's and two 2's are 0's ---
    % get number of columns
    length(Board, NumberOfColumns),
    % get number of 0's per row (number of colums - (number of 1's + number of 2's))
    NumberOfZeros #= NumberOfColumns - 4,
    % apply restriction
    count(0, Row, #=, NumberOfZeros),
    % apply restriction to next rows
    board_remainder_zeros(Board).

% ====== Distances ======
get_distance_between_elements(List, Element, Distance):-
    % find indexes of Element in List
    element(FirstIndex, List, Element),
    element(SecondIndex, List, Element),
    % indexes have to be unique
    FirstIndex #\= SecondIndex,
    % calculate distance
    Distance #= SecondIndex - FirstIndex.

distance_restriction_per_line([Row | Board]):-
    % get distance between 1's (close)
    get_distance_between_elements(Row, 1, CloseDistance),
    % get distance between 2's (far)
    get_distance_between_elements(Row, 2, FarDistance),
    % apply MAIN restriction
    CloseDistance #< FarDistance,
    % apply restriction to next rows
    distance_restriction_per_line(Board).

distance_restriction_per_column_aux(_, 0).
distance_restriction_per_column_aux(Board, ColumnNumber):-
    % get column
    get_column(Board, ColumnNumber, Column),
    % get distance between 1's (close)
    get_distance_between_elements(Column, 1, CloseDistance),
    % get distance between 2's (far)
    get_distance_between_elements(Column, 2, FarDistance),
    % apply MAIN restriction
    CloseDistance #< FarDistance,
    % apply restriction to next columns
    NextColumnNumber #= ColumnNumber - 1,
    distance_restriction_per_column_aux(Board, NextColumnNumber).

distance_restriction_per_column(Board):-
    % get number of columns in Board
    length(Board, NumberOfColumns),
    distance_restriction_per_column_aux(Board, NumberOfColumns).

% =================================================================
% Board Solver
% =================================================================
solve_board(Board):-
    % --- DECISION VARIABLES ---
    % length is already defined by Board
    apply_domain(Board),
    % --- RESTRICTIONS ---
    % 2 occurences of 1 (close) and 2 occurences of 2 (far) per row
    two_occurences_per_row(Board),
    % 2 occurences of 1 (close) and 2 occurences of 2 (far) per column
    two_occurences_per_column(Board),
    % remaining elements are all 0's (empty)
    board_remainder_zeros(Board),
    % distance between 1's (close) is smaller than 2's (far) in each line
    distance_restriction_per_line(Board),
    % distance between 1's (close) is smaller than 2's (far) in each column
    distance_restriction_per_column(Board),
    % --- LABELING ---
    labeling([], Board).


% =================================================================
% Testing Purposes
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
    labeling([], Line).

test_board:-
    puzzle_1(Board),
    solve_line(Board),
    write(Board).

test_line:-
    Line = [2, _, _, _, _, _],
    solve_line(Line),
    write(Line).
