:-include('board_examples.pl').
:-use_module(library(lists)).


%---------------------------------------------------%
%------------------ BOARD PIECES -------------------%
%---------------------------------------------------%

% Pieces
translate(king, 'k').
translate(queen, 'q').
translate(bishop, 'b').
translate(tower, 't').
translate(horse, 'h').
translate(pawn, 'p').
translate(empty, '.').

% Color
translate(black, 'B').
translate(white, 'W').

% numbers to letters for top row
letter(1, 'A').
letter(2, 'B').
letter(3, 'C').
letter(4, 'D').
letter(5, 'E').
letter(6, 'F').

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
    write(' '),
    letter(Acc, Letter),
    write(Letter),
    Acc1 is Acc + 1,
    write('  | '),
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

%---------------------------------------------------%
%----------------- BOARD REARRANGE -----------------%
%---------------------------------------------------%

isEmptyCell(empty-empty).

isEmptyRowAux([]).
isEmptyRowAux([Cell | Row]):-
    isEmptyCell(Cell),
    isEmptyRowAux(Row).

isEmptyRow(Board, RowNum):-
    nth1(RowNum, Board, Row),
    isEmptyRowAux(Row).

isEmptyCollumn([], ColNum).
isEmptyCollumn([Row | Board], ColNum):-
    nth1(ColNum, Row, Cell),
    isEmptyCell(Cell),
    isEmptyCollumn(Board, ColNum).
    

removeTopRow([TopRow | Board], Board).

removeBottomRow([TopRow | OldBoard], NewBoard) :-
    removeBottomRowAux(OldBoard, NewBoard, TopRow).
 
removeBottomRowAux([], [], _).
removeBottomRowAux([X1|Xs], [X0|Ys], X0) :-
    removeBottomRowAux(Xs, Ys, X1).


removeLeftCollumn(OldBoard, NewBoard):-
    length(OldBoard, ColNumber),
    removeLeftCollumnAux(OldBoard, NewBoard, ColNumber).

removeLeftCollumnAux(_, _, 0).
removeLeftCollumnAux([Row | Board], [NewRow | NewBoard], N):-
    removeTopRow(Row, NewRow),      % removes left cell in row
    N1 is N-1,
    removeAux(Board, NewBoard, N1).


removeRightCollumn(OldBoard, NewBoard):-
    length(OldBoard, ColNumber),
    removeRightCollumnAux(OldBoard, NewBoard, ColNumber).

removeRightCollumnAux(_, _, 0).
removeRightCollumnAux([Row | Board], [NewRow | NewBoard], N):-
    removeBottomRow(Row, NewRow),      % removes right cell in row
    N1 is N-1,
    removeRightCollumnAux(Board, NewBoard, N1).

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
