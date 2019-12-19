:- consult('utils.pl').
:- consult('solver.pl').

% =================================================================
% Generate Board
% =================================================================
% generate board matrix given its size
generate_board(Size, Board):-
    generate_board_aux(Size, Size, Board).

generate_board_aux(_, 0, []).
generate_board_aux(Size, N, [Row | Board]):-
    generate_row(Size, Row),
    NewN is N - 1,
    generate_board_aux(Size, NewN, Board).

% generate board row given its size
generate_row(0, []).
generate_row(Size, [_ | Row]):-
    NewSize is Size - 1,
    generate_row(NewSize, Row).

% =================================================================
% Puzzle Generator
% =================================================================
generate_puzzle(Board):-
    findall(PossibleBoard, , Bag)
    
