:- consult('utils.pl').

% =================================================================
% Display Board
% =================================================================
print_board([Line | Board]):-
    length(Line, Width),
    write('|'),
    print_horizontal_separator(Width),
    nl,
    length([Line | Board], Height),
    print_matrix([Line | Board], Height),
    nl.

print_horizontal_separator(0).
print_horizontal_separator(N):-
    write('---|'),
    N1 is N - 1,
    print_horizontal_separator(N1).

print_matrix([], 0).
print_matrix([Line | Board], N):-
    write('| '),
    print_line(Line),
    nl,
    length(Line, Length),
    N1 is N - 1,
    write('|'),
    print_horizontal_separator(Length),
    nl,
    print_matrix(Board, N1).

print_line([]).
print_line([Cell | Line]):-
    print_cell(Cell),
    write(' | '),
    print_line(Line).

print_cell(Cell):-
    translate(Cell, Char),
    write(Char).
