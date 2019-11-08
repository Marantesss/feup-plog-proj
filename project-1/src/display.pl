:-use_module(library(lists)).
:-include('utils.pl').

%---------------------------------------------------%
%------------------- MENU STUFF --------------------%
%---------------------------------------------------%

printMenu:-
    nl,nl,
    write(' _________________________________________________________________ '),nl,
    write('|                                                                 |'),nl,
    write('|                      _____     _       _                        |'),nl,
    write('|                     |   __|___| |_ ___| |_                      |'),nl,
    write('|                     |   __|  _|   | -_| "_|                     |'),nl,
    write('|                     |_____|___|_|_|___|_,_|                     |'),nl,
    write('|                                                                 |'),nl,
    write('|                                                                 |'),nl,
    write('|                                                                 |'),nl,
    write('|                       1. Player vs Player                       |'),nl,
    write('|                                                                 |'),nl,
    write('|                       2. Player vs Computer                     |'),nl,
    write('|                                                                 |'),nl,
	write('|                       3. Computer vs Computer                   |'),nl,
    write('|                                                                 |'),nl,
    write('|                       0. Exit                                   |'),nl,
    write('|                                                                 |'),nl,
    write('|_________________________________________________________________|'),nl,
    nl,nl.

%---------------------------------------------------%
%------------------ BOARD DISPLAY ------------------%
%---------------------------------------------------%

printBoard(Board):-
    nl,
    write('    |'),
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
    write('  '),
    write(Acc),
    write(' |'),
    Acc1 is Acc + 1,
    printTopBorder(Acc1, N).

printHorizontalSeparator(0).
printHorizontalSeparator(N):-
    write('----|'),
    N1 is N - 1,
    printHorizontalSeparator(N1).

printMatrix([], _, 0).
printMatrix([Line | Board], Acc, N):-
    write('  '),
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

printCell(Piece-Color):-
    translate(Piece, Char),
    write(Char),
    translate(Color, Char2),
    write(Char2).

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
