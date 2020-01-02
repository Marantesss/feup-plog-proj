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
% Populate Puzzle with hints from Solution
% =================================================================
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
    % 4 'pieces' (2 C's + 2 F's), select a random one
    random(0, 3, HintNumber),
    % populate puzzle
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
    populate_puzzle(SolutionBoard, PuzzleBoard).

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


