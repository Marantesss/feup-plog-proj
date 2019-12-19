:- consult('generator.pl').
:- consult('solver.pl').
:- consult('display.pl').

% =================================================================
% Replace 0's with _
% =================================================================
replace_zeros_matrix([], []).
replace_zeros_matrix([Row | Matrix], [NewRow | Rest]):-
    replace_zeros_matrix(Matrix, Rest),
    replace_zeros_row(Row, NewRow).

replace_zeros_row([], []).
replace_zeros_row([0 | Tail], [_ | Rest]):-
    replace_zeros_row(Tail, Rest).
replace_zeros_row([Head | Tail], [Head | Rest]):-
    replace_zeros_row(Tail, Rest).

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
*/

play(Size):-
    % generate random puzze with given size
    generate_random_puzzle(Size, Board),
    % print board so user can see
    print_board(Board),
    % replace 0's with _
    replace_zeros_matrix(Board, NewBoard),
    % solve puzzle
    write(NewBoard), nl,
    solve_puzzle(NewBoard),
    % print solved puzzle
    write(NewBoard).
    %print_board(NewBoard).

