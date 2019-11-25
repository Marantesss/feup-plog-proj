:- consult('utils.pl').


% generate board row given its size
generateRow(0, []).
generateRow(Size, [empty | Row]):-
    NewSize is Size - 1,
    generateRow(NewSize, Row).

% generate board matrix given its size
generateBoard(Size, Board):-
    generateBoardAux(Size, Size, Board).

generateBoardAux(_, 0, []).
generateBoardAux(Size, N, [Row | Board]):-
    generateRow(Size, Row),
    NewN is N - 1,
    generateBoardAux(Size, NewN, Board).

% display board
printBoard([Line | Board]):-
    length(Line, Width),
    write('|'),
    printHorizontalSeparator(Width),
    nl,
    length([Line | Board], Height),
    printMatrix([Line | Board], 1, Height),
    nl.

printHorizontalSeparator(0).
printHorizontalSeparator(N):-
    write('---|'),
    N1 is N - 1,
    printHorizontalSeparator(N1).

printMatrix([], _, 0).
printMatrix([Line | Board], Acc, N):-
    write('| '),
    printLine(Line),
    nl,
    length(Line, Length),
    N1 is N - 1,
    write('|'),
    printHorizontalSeparator(Length),
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
