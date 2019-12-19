:-consult('constraints.pl').
:-consult('puzzles.pl').
:-consult('board.pl').

% =================================================================
% Testing Purposes
% See puzzles in file 'puzzles.pl'
% =================================================================
test_line:-
    Line = [2, _, _, _, _, _],
    solve_line(Line),
    write(Line), nl,
    fail.

% test for puzzle 1
test_puzzle_1:-
    puzzle_1(Board),
    solve_puzzle(Board),
    print_board(Board).

% test for puzzle 2
test_puzzle_2:-
    puzzle_2(Board),
    solve_puzzle(Board),
    print_board(Board).

% test for puzzle 3
test_puzzle_3:-
    puzzle_3(Board),
    solve_puzzle(Board),
    print_board(Board).

% test for puzzle 4
test_puzzle_4:-
    puzzle_4(Board),
    solve_puzzle(Board),
    write(Board).

% test for puzzle 5
test_puzzle_5:-
    puzzle_5(Board),
    solve_puzzle(Board),
    print_board(Board).

