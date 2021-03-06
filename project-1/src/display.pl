:-use_module(library(lists)).
:-consult('utils.pl').

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
	write('|                       3. Computer vs Player                     |'),nl,
    write('|                                                                 |'),nl,
    write('|                       4. Computer vs Computer                   |'),nl,
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