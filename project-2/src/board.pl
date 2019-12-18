:- consult('utils.pl').

%----------------------------------------%
%----------- generate board -------------%
%----------------------------------------%
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
generate_row(Size, [0 | Row]):-
    NewSize is Size - 1,
    generate_row(NewSize, Row).

%----------------------------------------%
%----------- display board --------------%
%----------------------------------------%
print_board([Line | Board]):-
    length(Line, Width),
    write('|'),
    print_horizontal_separator(Width),
    nl,
    length([Line | Board], Height),
    print_matrix([Line | Board], 1, Height),
    nl.

print_horizontal_separator(0).
print_horizontal_separator(N):-
    write('---|'),
    N1 is N - 1,
    print_horizontal_separator(N1).

print_matrix([], _, 0).
print_matrix([Line | Board], Acc, N):-
    write('| '),
    print_line(Line),
    nl,
    length(Line, Length),
    N1 is N - 1,
    write('|'),
    print_horizontal_separator(Length),
    nl,
    print_matrix(Board, Acc1, N1).

print_line([]).
print_line([Cell | Line]):-
    print_cell(Cell),
    write(' | '),
    print_line(Line).

print_cell(Cell):-
    translate(Cell, Char),
    write(Char).
