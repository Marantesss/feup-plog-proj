:-consult('constraints.pl').
:-consult('puzzles.pl').
:-consult('board.pl').

% =================================================================
% Testing Purposes
% See puzzles in file 'puzzles.pl'
% =================================================================
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

% test for puzzle 6
test_puzzle_6:-
    puzzle_6(Board),
    solve_puzzle(Board),
    print_board(Board).

% test for puzzle 7
test_puzzle_7:-
    puzzle_7(Board),
    solve_puzzle(Board),
    print_board(Board).

% test for puzzle 8
test_puzzle_8:-
    puzzle_8(Board),
    solve_puzzle(Board),
    print_board(Board).

% test for puzzle 9
test_puzzle_9:-
    puzzle_9(Board),
    solve_puzzle(Board),
    print_board(Board).

% test for puzzle 10
test_puzzle_10:-
    puzzle_10(Board),
    solve_puzzle(Board),
    print_board(Board).

% test for puzzle 11
test_puzzle_11:-
    puzzle_11(Board),
    solve_puzzle(Board),
    print_board(Board).

% test for puzzle 12
test_puzzle_12:-
    puzzle_12(Board),
    solve_puzzle(Board),
    print_board(Board).

% test for puzzle 13
test_puzzle_13:-
    puzzle_13(Board),
    solve_puzzle(Board),
    print_board(Board).
