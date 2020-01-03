:- consult('utils.pl').
:- consult('solver.pl').
:- use_module(library(random)).

% =================================================================
% Generate Empty Board
% =================================================================
% generate empty board matrix given its size
generate_board(Size, Board):-
    generate_board_aux(Size, Size, Board).

generate_board_aux(_, 0, []).
generate_board_aux(Size, N, [Row | Board]):-
    generate_row(Size, Row),
    NewN is N - 1,
    generate_board_aux(Size, NewN, Board).

% generate empty board row given its size
generate_row(0, []).
generate_row(Size, [_ | Row]):-
    NewSize is Size - 1,
    generate_row(NewSize, Row).

% =================================================================
% Populate Puzzle with hints found from Solution
% =================================================================
populate_puzzle([], [], []).
populate_puzzle([PuzzleRow | PuzzleBoard], [HintColumnsCell | HintColumns], [HintValuesCell | HintValues]):-
    % write HintValue in HintColumn of PuzzleRow
    nth1(HintColumnsCell, PuzzleRow, HintValuesCell),
    % repeat for next row
    populate_puzzle(PuzzleBoard, HintColumns, HintValues).

% =================================================================
% Find hints from Solution
% =================================================================
apply_generator_occurrences_restrictions([], [], []).
apply_generator_occurrences_restrictions([SolutionRow | SolutionBoard], [HintColumnsCell | HintColumns], [HintValuesCell | HintValues]):-
    % hint column and value have to be consistent with solution row
    element(HintColumnsCell, SolutionRow, HintValuesCell),
    % repeat for next row
    apply_generator_occurrences_restrictions(SolutionBoard, HintColumns, HintValues).

find_hints(SolutionBoard, HintColumns, HintValues):-
    % --- DECISION VARIABLES ---
    length(SolutionBoard, NumberOfColumns),
    % hintColumns' domain is [1, Board's number of columns]
    length(HintColumns, NumberOfColumns),
    domain(HintColumns, 1, NumberOfColumns),
    % hintValues's domain is 1 or 2 (C or F)
    length(HintValues, NumberOfColumns),
    domain(HintValues, 1, 2),
    % --- RESTRICTIONS ---
    % only one hint per row and column
    all_distinct(HintColumns),
    apply_generator_occurrences_restrictions(SolutionBoard, HintColumns, HintValues),
    % --- LABELING ---
    % flatten Board into a 1 dimensional list
    append(HintColumns, HintValues, Hints),
    labeling([value(random_value)], Hints).

% =================================================================
% Puzzle Generator
% =================================================================
generate_random_solution(Size, Board):-
    % --- DECISION VARIABLES ---
    % generate empty board
    generate_board(Size, Board),
    % length is already defined by Board
    apply_solver_domain(Board),
    % --- RESTRICTIONS ---
    apply_solver_occurrences_restrictions(Board),
    apply_solver_distance_restrictions(Board),
    % --- LABELING ---
    % flatten Board into a 1 dimensional list
    append(Board, FlatBoard),
    labeling([value(random_value)], FlatBoard).

generate_random_puzzle(Size, PuzzleBoard):-
    % generate random solution
    generate_random_solution(Size, SolutionBoard),
    % find hints from solution board
    find_hints(SolutionBoard, HintColumns, HintValues),
    % generate empty board
    generate_board(Size, PuzzleBoard),
    % populate puzzle from hints found
    populate_puzzle(PuzzleBoard, HintColumns, HintValues).

% =================================================================
% Labeling Options
% =================================================================
% select random value
random_value(Var, _Rest, BB, BB1):-
    % get finite domain set
    fd_set(Var, Set),
    % trasform it to list and choose a random value
    fdset_to_list(Set, List),
    random_member(RandomValue, List),
    (
        first_bound(BB, BB1), Var #= RandomValue
        ;
        later_bound(BB, BB1), Var #\= RandomValue
    ).
