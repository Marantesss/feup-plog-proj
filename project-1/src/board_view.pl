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

% TOP, BOT, LEFT and RIGHT
rearrangeBoard(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    length(TopBoard, RowNum), ActRowNum is RowNum - 1, isEmptyRow(TopBoard, ActRowNum), removeBottomRow(TopBoard, BotBoard), % remove bottom row
    isEmptyColumn(BotBoard, 2), removeLeftColumn(BotBoard, [Row | LeftBoard]), % remove left column
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | LeftBoard], ActColNum), removeRightColumn([Row | LeftBoard], NewBoard). % remove right column

% TOP, BOT and LEFT
rearrangeBoard(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    length(TopBoard, RowNum), ActRowNum is RowNum - 1, isEmptyRow(TopBoard, ActRowNum), removeBottomRow(TopBoard, BotBoard), % remove bottom row
    isEmptyColumn(BotBoard, 2), removeLeftColumn(BotBoard, NewBoard). % remove left column

% TOP, BOT and RIGHT
rearrangeBoard(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    length(TopBoard, RowNum), ActRowNum is RowNum - 1, isEmptyRow(TopBoard, ActRowNum), removeBottomRow(TopBoard, [Row | BotBoard]), % remove bottom row
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | BotBoard], ActColNum), removeRightColumn([Row | BotBoard], NewBoard). % remove right column

% BOT, LEFT and RIGHT
rearrangeBoard(Board, NewBoard):-
    length(Board, RowNum), ActRowNum is RowNum - 1, isEmptyRow(Board, ActRowNum), removeBottomRow(Board, BotBoard), % remove bottom row
    isEmptyColumn(BotBoard, 2), removeLeftColumn(BotBoard, [Row | LeftBoard]), % remove left column
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | LeftBoard], ActColNum), removeRightColumn([Row | LeftBoard], NewBoard). % remove right column

% TOP, LEFT and RIGHT
rearrangeBoard(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    isEmptyColumn(TopBoard, 2), removeLeftColumn(TopBoard, [Row | LeftBoard]), % remove left column
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | LeftBoard], ActColNum), removeRightColumn([Row | LeftBoard], NewBoard). % remove right column

% TOP and BOT
rearrangeBoard(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    length(TopBoard, RowNum), ActRowNum is RowNum - 1, isEmptyRow(TopBoard, ActRowNum), removeBottomRow(TopBoard, NewBoard). % remove bottom row

% TOP and LEFT
rearrangeBoard(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    isEmptyColumn(TopBoard, 2), removeLeftColumn(TopBoard, NewBoard). % remove left column

% TOP and RIGHT
rearrangeBoard(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, [Row | TopBoard]), % remove top row
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | TopBoard], ActColNum), removeRightColumn([Row | TopBoard], NewBoard). % remove right column

% BOT and LEFT
rearrangeBoard(Board, NewBoard):-
    length(Board, RowNum), ActRowNum is RowNum - 1, isEmptyRow(Board, ActRowNum), removeBottomRow(Board, BotBoard), % remove bottom row
    isEmptyColumn(BotBoard, 2), removeLeftColumn(BotBoard, NewBoard). % remove left column

% BOT and RIGHT
rearrangeBoard(Board, NewBoard):-
    length(Board, RowNum), ActRowNum is RowNum - 1, isEmptyRow(Board, ActRowNum), removeBottomRow(Board, [Row | BotBoard]), % remove bottom row
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | BotBoard], ActColNum), removeRightColumn([Row | BotBoard], NewBoard). % remove right column

% LEFT and RIGHT
rearrangeBoard(Board, NewBoard):-
    isEmptyColumn(Board, 2), removeLeftColumn(Board, [Row | LeftBoard]), % remove left column
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | LeftBoard], ActColNum), removeRightColumn([Row | LeftBoard], NewBoard). % remove right column

% TOP
rearrangeBoard(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, NewBoard). % remove top row

% BOT
rearrangeBoard(Board, NewBoard):-
    length(Board, RowNum), ActRowNum is RowNum - 1, isEmptyRow(Board, ActRowNum), removeBottomRow(Board, NewBoard). % remove bottom row

% LEFT
rearrangeBoard(Board, NewBoard):-
    isEmptyColumn(Board, 2), removeLeftColumn(Board, NewBoard). % remove left column

% RIGHT
rearrangeBoard([Row | Board], NewBoard):-
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | Board], ActColNum), removeRightColumn([Row | Board], NewBoard). % remove right column



% ---- Empty Cconditions ----%

isEmptyCell(empty-empty).

isEmptyRowAux([]).
isEmptyRowAux([Cell | Row]):-
    isEmptyCell(Cell),
    isEmptyRowAux(Row).

isEmptyRow(Board, RowNum):-
    nth1(RowNum, Board, Row),
    isEmptyRowAux(Row).

isEmptyColumn([], ColNum).
isEmptyColumn([Row | Board], ColNum):-
    nth1(ColNum, Row, Cell),
    isEmptyCell(Cell),
    isEmptyColumn(Board, ColNum).

% ---- Add Cells ----%

getNewRow(3, [empty-empty, empty-empty, empty-empty]).
getNewRow(4, [empty-empty, empty-empty, empty-empty, empty-empty]).
getNewRow(5, [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]).
getNewRow(6, [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]).

addTopRow([Row | Board], NewBoard):-
    length(Row, RowLength),
    getNewRow(RowLength, NewEmptyRow),
    append([NewEmptyRow], [Row | Board], NewBoard).

addBottomRow([Row | Board], NewBoard):-
    length(Row, RowLength),
    getNewRow(RowLength, NewEmptyRow),
    append([Row | Board], [NewEmptyRow], NewBoard).

addLeftColumn([], []).
addLeftColumn([Row | Board], [NewRow | NewBoard]):-
    append([empty-empty], Row, NewRow),
    addLeftColumn(Board, NewBoard).

addRightColumn([], []).
addRightColumn([Row | Board], [NewRow | NewBoard]):-
    append(Row, [empty-empty], NewRow),
    addRightColumn(Board, NewBoard).
    
%---- Remove Cells ----%

removeTopRow([TopRow | Board], Board).

removeBottomRow([TopRow | OldBoard], NewBoard) :-
    removeBottomRowAux(OldBoard, NewBoard, TopRow).
 
removeBottomRowAux([], [], _).
removeBottomRowAux([X1|Xs], [X0|Ys], X0) :-
    removeBottomRowAux(Xs, Ys, X1).


removeLeftColumn(OldBoard, NewBoard):-
    length(OldBoard, ColNumber),
    removeLeftColumnAux(OldBoard, NewBoard, ColNumber).

removeLeftColumnAux(_, _, 0).
removeLeftColumnAux([Row | Board], [NewRow | NewBoard], N):-
    removeTopRow(Row, NewRow),      % removes left cell in row
    N1 is N-1,
    removeLeftColumnAux(Board, NewBoard, N1).


removeRightColumn(OldBoard, NewBoard):-
    length(OldBoard, ColNumber),
    removeRightColumnAux(OldBoard, NewBoard, ColNumber).

removeRightColumnAux(_, _, 0).
removeRightColumnAux([Row | Board], [NewRow | NewBoard], N):-
    removeBottomRow(Row, NewRow),      % removes right cell in row
    N1 is N-1,
    removeRightColumnAux(Board, NewBoard, N1).

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
