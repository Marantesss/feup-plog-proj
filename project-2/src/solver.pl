:- use_module(library(clpfd)).
:- consult('utils.pl').

/*
0 -> EMPTY
1 -> CLOSE
2 -> FAR
*/

% =================================================================
% Decision Variables
% =================================================================
apply_solver_domain([]).
apply_solver_domain([Row | Board]):-
    % (0 - empty, 1 - close, 2 - far)
    domain(Row, 0, 2),
    apply_solver_domain(Board).

% =================================================================
% Constraints
% =================================================================
% ====== Occurrences constraints ======
apply_solver_occurrences_constraints(Board):-
    % calculate number of 0's (empty)
    % get number of cells per row (same as per col)
    length(Board, NumberOfCellsPerRow),
    % get number of 0's (number of cells per row - (number of 1's + number of 2's))
    NumberOfZeros #= NumberOfCellsPerRow - 4,
    % apply constraints per row
    solver_occurrences_constraints_per_row(Board, NumberOfZeros),
    % apply constraints per colum (with transposed matrix)
    transpose(Board, TransposedBoard),
    solver_occurrences_constraints_per_row(TransposedBoard, NumberOfZeros).

solver_occurrences_constraints_per_row([], _NumberOfZeros).
solver_occurrences_constraints_per_row([Row | Board], NumberOfZeros):-
    global_cardinality(Row, [
        % NumberOfZeros occurrences of 0 (empty) per row
        0-NumberOfZeros,
        % 2 occurrences of 1 (close) per row
        1-2,
        % 2 occurrences of 2 (far) per row
        2-2
    ]),
    % apply constraints to next rows
    solver_occurrences_constraints_per_row(Board, NumberOfZeros).

% ====== Distances ======
apply_solver_distance_constraints(Board):-
    % apply constraints per row
    solver_distance_constraints_per_row(Board),
    % apply constraints per colum (with transposed board matrix)
    transpose(Board, TransposedBoard),
    solver_distance_constraints_per_row(TransposedBoard).

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

solver_distance_constraints_per_row([]).
solver_distance_constraints_per_row([Row | Board]):-
    % get distance between 1's (close)
    get_distance_between_elements(Row, 1, CloseDistance),
    % get distance between 2's (far)
    get_distance_between_elements(Row, 2, FarDistance),
    % apply MAIN constraints
    CloseDistance #< FarDistance,
    % apply constraints to next rows
    solver_distance_constraints_per_row(Board).

% =================================================================
% Puzzle Solver
% =================================================================
solve_puzzle(Board, Runtime):-
    % --- START STATISTICS ---
    %statistics - runtime calculation (ms) 
    statistics(runtime, [Start|_]),
    % --- DECISION VARIABLES ---
    % length is already defined by Board
    apply_solver_domain(Board),
    % --- CONSTRAINTS ---
    apply_solver_occurrences_constraints(Board),
    apply_solver_distance_constraints(Board),
    % --- LABELING ---
    % flatten Board into a 1 dimensional list
    append(Board, FlatBoard),
    labeling([], FlatBoard),
    % --- END STATISTICS ---
    %statistics - runtime calculation (ms) 
    statistics(runtime, [Stop|_]),
    Runtime is Stop - Start.
