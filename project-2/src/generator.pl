:- consult('utils.pl').
:- consult('solver.pl').
:- consult('display.pl').

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
generate_puzzle(Size, Board):-
    % generate board with size equal to Size
    generate_board(Size, EmptyBoard),
    % get all possible solved puzzles with size equal to Size
    findall(EmptyBoard, solve_puzzle(EmptyBoard), PossibleBoards),
    write(PossibleBoards).

% =================================================================
% Testing Purposes
% =================================================================
test:-
    Goal = (
        Puzzle = [
            [_, _, _, _, _, _],    
            [_, _, _, _, _, _],    
            [_, _, _, _, _, _],    
            [_, _, _, _, _, _],    
            [_, _, _, _, _, _],    
            [_, _, _, _, _, _]
        ],
        solve_puzzle(Puzzle)
    ),
    findall(Puzzle, Goal, PB),
    print_boards(PB).

print_boards([]).
print_boards([Board | BoardList]):-
    print_board(Board), nl,
    print_boards(BoardList).
    
