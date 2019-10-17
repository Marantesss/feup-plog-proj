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

printBoard(Board):-
    nl,
    write('   |'),
    nth0(0, Board, Line),
    length(Line, Length),
    printTopBorder(Length),
    printMatrix(Board),
    nl.

printTopBorder(Acc, N):-
    Acc > N.

printTopBorder(N):-
    write(' '),
    write(N),
    write(' |'),
    N1 is N - 1,
    printTopBorder(N1).

printHorizontalSeparator([], 0).
printHorizontalSeparator([Cell | Line], N):-
    write('---|'),
    N1 is N - 1,
    printHorizontalSeparator(Line, N1).

printMatrix([], 0).
printMatrix([Line | Board], N):-
    write(' '),
    letter(N, Letter),
    write(Letter),
    N1 is N - 1,
    write(' L '),
    printLine(Line),
    nl,
    length(Board, Length),
    TrueLength is Length + 1,
    printHorizontalSeparator(Line, TrueLength),
    nl,
    printMatrix(Board, N1).

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