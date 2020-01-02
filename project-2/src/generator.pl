:- consult('utils.pl').
:- consult('solver.pl').
:- use_module(library(random)).
:- consult('display.pl').

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
% Decision Variables
% =================================================================
apply_generator_domain([]).
apply_generator_domain([Row | Board]):-
    % (0 - empty, 1 - close, 2 - far)
    domain(Row, 0, 2),
    apply_generator_domain(Board).

apply_generator_domain_per_row([]).
apply_generator_domain_per_row([Cell | Row]):-
    % (_ - unknown, 1 - close, 2 - far)
    Cell in {_, 1, 2},
    apply_generator_domain_per_row(Row).

% =================================================================
% Restrictions
% =================================================================
apply_generator_occurrences_restrictrions(Board):-
    % calculate number of 0's (empty)
    % get number of cells per row (same as per col)
    length(Board, NumberOfCellsPerRow),
    % get number of 0's (number of cells per row - (number of 1's + number of 2's))
    NumberOfZeros #= NumberOfCellsPerRow - 1,
    % apply restrictions per row
    generator_occureences_restrictions_per_row(Board, NumberOfZeros),
    % apply restrictions per colum (with transposed matrix)
    transpose(Board, TransposedBoard),
    generator_occureences_restrictions_per_row(TransposedBoard, NumberOfZeros).

generator_occureences_restrictions_per_row([], _NumberOfZeros).
generator_occureences_restrictions_per_row([Row | Board], NumberOfZeros):-
    % hint can only be 1 ONE occureence of 1 (close) OR 2 (far) per row/colum
    % everything else is 0 (no hint/unknown)
    count(0, Row, #=, NumberOfZeros),
    count(1, Row, #=, NumberOfOnes),
    count(2, Row, #=, NumberOfTwos),
    (
        (NumberOfOnes #= 0 #/\ NumberOfTwos #= 1)
        #\/
        (NumberOfOnes #= 1 #/\ NumberOfTwos #= 0)
    ),
    % apply restricion to next rows
    generator_occureences_restrictions_per_row(Board, NumberOfZeros).

% row is empty
populate_puzzle_row([], [], _HintNumber).
% solution is a 0, so puzzle is unknown
populate_puzzle_row([0 | SolutionRow], [_ | PuzzleRow], HintNumber):-
    populate_puzzle_row(SolutionRow, PuzzleRow, HintNumber).
% solution is different from 0 and HintNumber is 0, write solution in puzzle
populate_puzzle_row([SolutionCell | SolutionRow], [SolutionCell | PuzzleRow], 0):-
    populate_puzzle_row(SolutionRow, PuzzleRow, -1).
% solution is different from 0 but HintNumber is different from 0, puzzle is unknown
populate_puzzle_row([_SolutionCell | SolutionRow], [0 | PuzzleRow], HintNumber):-
    NewHintNumber is HintNumber - 1,
    populate_puzzle_row(SolutionRow, PuzzleRow, NewHintNumber).

populate_puzzle([], []).
populate_puzzle([SolutionRow | SolutionBoard], [PuzzleRow | PuzzleBoard]):-
    random(0, 3, HintNumber),
    populate_puzzle_row(SolutionRow, PuzzleRow, HintNumber),
    populate_puzzle(SolutionBoard, PuzzleBoard).

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
    apply_solver_occurrences_restrictrions(Board),
    apply_solver_distance_restrictrions(Board),
    % --- LABELING ---
    % flatten Board into a 1 dimensional list
    append(Board, FlatBoard),
    labeling([variable(random_variable), value(random_value)], FlatBoard).

generate_random_puzzle(Size, PuzzleBoard):-
    % generate random solution
    generate_random_solution(Size, SolutionBoard),
    % generate a puzzle from random solution
    generate_puzzle(SolutionBoard, PuzzleBoard).

generate_puzzle(SolutionBoard, PuzzleBoard):-
    %% --- DECISION VARIABLES ---
    % length is already defined by Board
    apply_generator_domain(PuzzleBoard),
    % --- RESTRICTIONS ---
    % occurrence restrictions
    apply_generator_occurrences_restrictrions(PuzzleBoard),
    % --- LABELING ---
    append(PuzzleBoard, FlatBoard),
    labeling([], FlatBoard).

% =================================================================
% Labeling Options
% =================================================================
% select random variable
random_variable(ListOfVars, Var, Rest):-
    random_select(Var, ListOfVars, Rest).

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

% =================================================================
% Testing
% =================================================================
test_solvable:-
    generate_random_puzzle(6, Puzzle),
    write(Puzzle), nl,
    is_puzzle_solvable(Puzzle).

