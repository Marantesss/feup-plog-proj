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
% Decision Variables -> DOES NOT WORK
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
apply_generator_occurences_restrictrions(Board):-
    % apply restrictions per row
    generator_occurences_restrictions_per_row(Board),
    % apply restrictions per colum (with transposed matrix)
    transpose(Board, TransposedBoard),
    generator_occurences_restrictions_per_row(TransposedBoard).

generator_occurences_restrictions_per_row([]).
generator_occurences_restrictions_per_row([Row | Board]):-
    % hint can only be 1 ONE occurence of 1 (close) OR 2 (far) per row/colum
    count(1, Row, #=, NumberOfOnes),
    count(2, Row, #=, NumberOfTwos),
    (NumberOfOnes #= 1 #/\ NumberOfTwos #= 0) #\/ (NumberOfOnes #= 0 #/\ NumberOfTwos #= 1), 
    % apply restricion to next rows
    generator_occurences_restrictions_per_row(Board).

% =================================================================
% Puzzle Generator
% =================================================================
generate_random_puzzle:-
    % find all possible puzzles
    findall(Board, generate_puzzle(6, Board), PossibleBoard),
    % choose a random puzzle
    random_member(RandomBoard, PossibleBoard).

generate_puzzle(Size, Board):-
    % generate empty board
    generate_board(Size, Board),
    !,
    % populate board with hints
    build_puzzle(Board).

build_puzzle(Board):-
    %% --- DECISION VARIABLES ---
    % length is already defined by Board
    apply_generator_domain(Board),
    % --- RESTRICTIONS ---
    apply_generator_occurences_restrictrions(Board),
    % --- LABELING ---
    append(Board, FlatBoard),
    labeling([], FlatBoard).

% =================================================================
% Testing
% =================================================================
test_findall:- % WORKS
    Puzzle = [
        [_, _, _, _, _, _],    
        [_, _, _, _, _, _],    
        [_, _, _, _, _, _],    
        [_, _, _, _, _, _],    
        [_, _, _, _, _, _],    
        [_, _, _, _, _, _]
    ],
    findall(Puzzle, solve_puzzle(Puzzle), PB),
    print_boards(PB).

print_boards([]).
print_boards([Board | BoardList]):-
    print_board(Board), nl,
    print_boards(BoardList).
