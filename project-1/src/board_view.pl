:-include('board_examples.pl').
:-use_module(library(lists)).

translate(empty, '.').
% Black pieces
translate(kingBlack, 'k').
translate(queenBlack, 'q').
translate(bishopBlack, 'b').
translate(towerBlack, 't').
translate(horseBlack, 'h').
translate(pawnBlack, 'p').

% White pieces
translate(kingWhite, 'K').
translate(queenWhite, 'Q').
translate(bishopWhite, 'B').
translate(towerWhite, 'T').
translate(horseWhite, 'H').
translate(pawnWhite, 'P').

% numbers to letters for top row
letter(1, 'A').
letter(2, 'B').
letter(3, 'C').
letter(4, 'D').
letter(5, 'E').
letter(6, 'F').

printBoard(Board):-
    nl,
    write('   |'),
    nth0(0, Board, Line),
    length(Line, Width),
    printTopBorder(1, Width),
    nl,
    printHorizontalSeparator(Width + 1),
    nl,
    length(Board, Height),
    printMatrix(Board, 1, Height),
    nl.

printTopBorder(Acc, N):-
    Acc > N.

printTopBorder(Acc, N):-
    write(' '),
    write(Acc),
    write(' |'),
    Acc1 is Acc + 1,
    printTopBorder(Acc1, N).

printHorizontalSeparator(0).
printHorizontalSeparator(N):-
    write('---|'),
    N1 is N - 1,
    printHorizontalSeparator(N1).

printMatrix([], _, 0).
printMatrix([Line | Board], Acc, N):-
    write(' '),
    letter(Acc, Letter),
    write(Letter),
    Acc1 is Acc + 1,
    write(' | '),
    printLine(Line),
    nl,
    length(Line, Length),
    TrueLength is Length + 1,
    N1 is N - 1,
    printHorizontalSeparator(TrueLength),
    nl,
    printMatrix(Board, Acc1, N1).

printLine([]).
printLine([Cell | Line]):-
    printCell(Cell),
    write(' | '),
    printLine(Line).

printCell(Cell):-
    translate(Cell, Char),
    write(Char).

/* Predicados uteis:
nth0, nth1 -> usar o google :)
select\3\4 -> select(b, [a, b, c], d, Lista): troca b por d na lista [a, b, c] -> Lista = [a, d, c]
reverse\2 ->
append\2\3 -> concatenacao de 2 listas
last\2 -> vai buscar o ultimo argumento
transpose\2 -> transposta de uma matriz
maplist\2\3\4 ->
remove_dups\2 ->
sumlist\2 ->
sort -> 
length -> 
*/