:- consult('generator.pl').
:- consult('solver.pl').
:- consult('display.pl').

/*
|---|---|---|---|---|---|---|
| . | . | C | . | . | . | . | 
|---|---|---|---|---|---|---|
| C | . | . | . | . | . | . | 
|---|---|---|---|---|---|---|
| . | . | . | . | F | . | . | 
|---|---|---|---|---|---|---|
| . | F | . | . | . | . | . | 
|---|---|---|---|---|---|---|
| . | . | . | . | . | . | F | 
|---|---|---|---|---|---|---|
| . | . | . | . | . | F | . | 
|---|---|---|---|---|---|---|
| . | . | . | C | . | . | . | 
|---|---|---|---|---|---|---|

Puzzle = [
    [_, _, 1, _, _, _, _],
    [1, _, _, _, _, _, _],
    [_, _, _, _, 2, _, _],
    [_, 2, _, _, _, _, _],
    [_, _, _, _, _, _, 2],
    [_, _, _, _, _, 2, _],
    [_, _, _, 1, _, _, _]
],

AnotherPuzzle = [
    [_,_,_,_,1,_],
    [_,_,_,1,_,_],
    [_,_,_,_,_,2],
    [2,_,_,_,_,_],
    [_,2,_,_,_,_],
    [_,_,2,_,_,_]
]
*/

play(Size):-
    % generate random puzzle with given size
    generate_random_puzzle(Size, PuzzleBoard),
    % print puzzle
    print_board(PuzzleBoard),
    % replace 0's with _
    replace_zeros_matrix(PuzzleBoard, SolutionBoard),
    % solve puzzle
    solve_puzzle(SolutionBoard),
    % print solved puzzle
    print_board(SolutionBoard).

