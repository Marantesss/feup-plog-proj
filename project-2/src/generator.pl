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
apply_generator_occurences_restrictrions(Board):-
    % apply restrictions per row
    generator_occurences_restrictions_per_row(Board),
    % apply restrictions per colum (with transposed matrix)
    transpose(Board, TransposedBoard),
    generator_occurences_restrictions_per_row(TransposedBoard).

generator_occurences_restrictions_per_row([]).
generator_occurences_restrictions_per_row([Row | Board]):-
    % hint can only be 1 ONE occurence of 1 (close) OR 2 (far) per row/colum
    % everything else is 0 (no hint/unknown)
    count(1, Row, #=, NumberOfOnes),
    count(2, Row, #=, NumberOfTwos),
    (
        (NumberOfOnes #= 0 #/\ NumberOfTwos #= 1)
        #\/
        (NumberOfOnes #= 1 #/\ NumberOfTwos #= 0)
    ),
    % apply restricion to next rows
    generator_occurences_restrictions_per_row(Board).

is_puzzle_solvable(Board):-
    % create new variable equal to Board
    replace_zeros_matrix(Board, NewBoard),
    % figure out if puzzle is solvable
    !,
    solve_puzzle(NewBoard).

% =================================================================
% Puzzle Generator
% =================================================================
generate_random_puzzle(Size, Board):-
    % generate empty board
    generate_board(Size, Board),
    % generate a random puzzle
    generate_puzzle(Board).

generate_puzzle(Board):-
    % populate board with hints
    build_puzzle(Board),
    % check if puzzle is solvable,
    is_puzzle_solvable(Board).

build_puzzle(Board):-
    %% --- DECISION VARIABLES ---
    % length is already defined by Board
    apply_generator_domain(Board),
    % --- RESTRICTIONS ---
    % occurence restrictions
    apply_generator_occurences_restrictrions(Board),
    % --- LABELING ---
    append(Board, FlatBoard),
    labeling([value(random_value)], FlatBoard).

random_value(Var, _Rest, BB, BB1):-
    fd_set(Var, Set),
    select_random_value(Set, Value),
    (
        first_bound(BB, BB1), Var #= Value
        ;
        later_bound(BB, BB1), Var #\= Value
    ).

select_random_value(Set, RandomValue):-
    fdset_to_list(Set, List),
    length(List, Len),
    random(0, Len, RandomIndex),
    nth0(RandomIndex, List, RandomValue).

% =================================================================
% Testing
% =================================================================
test_solvable:-
    generate_random_puzzle(6, Puzzle),
    write(Puzzle), nl,
    is_puzzle_solvable(Puzzle).

test_valid:- % works
    is_puzzle_solvable([
        [_, _, 1, _, _, _, _],
        [1, _, _, _, _, _, _],
        [_, _, _, _, 2, _, _],
        [_, 2, _, _, _, _, _],
        [_, _, _, _, _, _, 2],
        [_, _, _, _, _, 2, _],
        [_, _, _, 1, _, _, _]
    ]),
    is_puzzle_solvable([
        [_, 2, _, _, _, _],    
        [_, _, 2, _, _, _],    
        [_, _, _, _, _, 2],    
        [_, _, _, _, 2, _],    
        [_, _, _, 2, _, _],    
        [2, _, _, _, _, _] 
    ]).

print_boards([]).
print_boards([Board | BoardList]):-
    print_board(Board), nl,
    print_boards(BoardList).
