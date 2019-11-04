:-include('board_view.pl').

%---------------------------------------------------%
%----------------- MAIN FUNCTION  ------------------%
%--------- add and remove rows and/or cols ---------%
%---------------------------------------------------%

rearrangeBoard(Board, NewBoard):-
    cleanBoardRemove(Board, RemoveBoard),
    cleanBoardAdd(RemoveBoard, NewBoard).

rearrangeBoard(Board, NewBoard):-
    cleanBoardRemove(Board, RemoveBoard).

rearrangeBoard(Board, NewBoard):-
    cleanBoardAdd(Board, NewBoard).

%---------------------------------------------------%
%--------------- REMOVE WHEN EMPTY  ----------------%
%---------------------------------------------------%

% TOP, BOT, LEFT and RIGHT
cleanBoardRemove(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    length(TopBoard, RowNum), ActRowNum is RowNum - 1, isEmptyRow(TopBoard, ActRowNum), removeBottomRow(TopBoard, BotBoard), % remove bottom row
    isEmptyColumn(BotBoard, 2), removeLeftColumn(BotBoard, [Row | LeftBoard]), % remove left column
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | LeftBoard], ActColNum), removeRightColumn([Row | LeftBoard], NewBoard). % remove right column

% TOP, BOT and LEFT
cleanBoardRemove(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    length(TopBoard, RowNum), ActRowNum is RowNum - 1, isEmptyRow(TopBoard, ActRowNum), removeBottomRow(TopBoard, BotBoard), % remove bottom row
    isEmptyColumn(BotBoard, 2), removeLeftColumn(BotBoard, NewBoard). % remove left column

% TOP, BOT and RIGHT
cleanBoardRemove(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    length(TopBoard, RowNum), ActRowNum is RowNum - 1, isEmptyRow(TopBoard, ActRowNum), removeBottomRow(TopBoard, [Row | BotBoard]), % remove bottom row
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | BotBoard], ActColNum), removeRightColumn([Row | BotBoard], NewBoard). % remove right column

% BOT, LEFT and RIGHT
cleanBoardRemove(Board, NewBoard):-
    length(Board, RowNum), ActRowNum is RowNum - 1, isEmptyRow(Board, ActRowNum), removeBottomRow(Board, BotBoard), % remove bottom row
    isEmptyColumn(BotBoard, 2), removeLeftColumn(BotBoard, [Row | LeftBoard]), % remove left column
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | LeftBoard], ActColNum), removeRightColumn([Row | LeftBoard], NewBoard). % remove right column

% TOP, LEFT and RIGHT
cleanBoardRemove(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    isEmptyColumn(TopBoard, 2), removeLeftColumn(TopBoard, [Row | LeftBoard]), % remove left column
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | LeftBoard], ActColNum), removeRightColumn([Row | LeftBoard], NewBoard). % remove right column

% TOP and BOT
cleanBoardRemove(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    length(TopBoard, RowNum), ActRowNum is RowNum - 1, isEmptyRow(TopBoard, ActRowNum), removeBottomRow(TopBoard, NewBoard). % remove bottom row

% TOP and LEFT
cleanBoardRemove(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, TopBoard), % remove top row
    isEmptyColumn(TopBoard, 2), removeLeftColumn(TopBoard, NewBoard). % remove left column

% TOP and RIGHT
cleanBoardRemove(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, [Row | TopBoard]), % remove top row
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | TopBoard], ActColNum), removeRightColumn([Row | TopBoard], NewBoard). % remove right column

% BOT and LEFT
cleanBoardRemove(Board, NewBoard):-
    length(Board, RowNum), ActRowNum is RowNum - 1, isEmptyRow(Board, ActRowNum), removeBottomRow(Board, BotBoard), % remove bottom row
    isEmptyColumn(BotBoard, 2), removeLeftColumn(BotBoard, NewBoard). % remove left column

% BOT and RIGHT
cleanBoardRemove(Board, NewBoard):-
    length(Board, RowNum), ActRowNum is RowNum - 1, isEmptyRow(Board, ActRowNum), removeBottomRow(Board, [Row | BotBoard]), % remove bottom row
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | BotBoard], ActColNum), removeRightColumn([Row | BotBoard], NewBoard). % remove right column

% LEFT and RIGHT
cleanBoardRemove(Board, NewBoard):-
    isEmptyColumn(Board, 2), removeLeftColumn(Board, [Row | LeftBoard]), % remove left column
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | LeftBoard], ActColNum), removeRightColumn([Row | LeftBoard], NewBoard). % remove right column

% TOP
cleanBoardRemove(Board, NewBoard):-
    isEmptyRow(Board, 2), removeTopRow(Board, NewBoard). % remove top row

% BOT
cleanBoardRemove(Board, NewBoard):-
    length(Board, RowNum), ActRowNum is RowNum - 1, isEmptyRow(Board, ActRowNum), removeBottomRow(Board, NewBoard). % remove bottom row

% LEFT
cleanBoardRemove(Board, NewBoard):-
    isEmptyColumn(Board, 2), removeLeftColumn(Board, NewBoard). % remove left column

% RIGHT
cleanBoardRemove([Row | Board], NewBoard):-
    length(Row, ColNum), ActColNum is ColNum - 1, isEmptyColumn([Row | Board], ActColNum), removeRightColumn([Row | Board], NewBoard). % remove right column


%---------------------------------------------------%
%--------------- ADD WHEN NOT EMPTY  ---------------%
%---------------------------------------------------%

% TOP, BOT, LEFT and RIGHT
cleanBoardAdd(Board, NewBoard):-
    \+isEmptyRow(Board, 1), addTopRow(Board, TopBoard), % add top row
    length(TopBoard, RowNum), \+isEmptyRow(TopBoard, RowNum), addBottomRow(TopBoard, BotBoard), % add bottom row
    \+isEmptyColumn(BotBoard, 1), addLeftColumn(BotBoard, [Row | LeftBoard]), % add left column
    length(Row, ColNum), \+isEmptyColumn([Row | LeftBoard], ColNum), addRightColumn([Row | LeftBoard], NewBoard). % add right column

% TOP, BOT and LEFT
cleanBoardAdd(Board, NewBoard):-
    \+isEmptyRow(Board, 1), addTopRow(Board, TopBoard), % add top row
    length(TopBoard, RowNum), \+isEmptyRow(TopBoard, RowNum), addBottomRow(TopBoard, BotBoard), % add bottom row
    \+isEmptyColumn(BotBoard, 1), addLeftColumn(BotBoard, NewBoard). % add left column

% TOP, BOT and RIGHT
cleanBoardAdd(Board, NewBoard):-
    \+isEmptyRow(Board, 1), addTopRow(Board, TopBoard), % add top row
    length(TopBoard, RowNum), \+isEmptyRow(TopBoard, RowNum), addBottomRow(TopBoard, [Row | BotBoard]), % add bottom row
    length(Row, ColNum), \+isEmptyColumn([Row | BotBoard], ColNum), addRightColumn([Row | BotBoard], NewBoard). % add right column

% BOT, LEFT and RIGHT
cleanBoardAdd(Board, NewBoard):-
    length(Board, RowNum), \+isEmptyRow(Board, RowNum), addBottomRow(Board, BotBoard), % add bottom row
    \+isEmptyColumn(BotBoard, 1), addLeftColumn(BotBoard, [Row | LeftBoard]), % add left column
    length(Row, ColNum), \+isEmptyColumn([Row | LeftBoard], ColNum), addRightColumn([Row | LeftBoard], NewBoard). % add right column

% TOP, LEFT and RIGHT
cleanBoardAdd(Board, NewBoard):-
    \+isEmptyRow(Board, 1), addTopRow(Board, TopBoard), % add top row
    \+isEmptyColumn(TopBoard, 1), addLeftColumn(TopBoard, [Row | LeftBoard]), % add left column
    length(Row, ColNum), \+isEmptyColumn([Row | LeftBoard], ColNum), addRightColumn([Row | LeftBoard], NewBoard). % add right column

% TOP and BOT
cleanBoardAdd(Board, NewBoard):-
    \+isEmptyRow(Board, 1), addTopRow(Board, TopBoard), % add top row
    length(TopBoard, RowNum),\+isEmptyRow(TopBoard, RowNum), addBottomRow(TopBoard, NewBoard). % add bottom row

% TOP and LEFT
cleanBoardAdd(Board, NewBoard):-
    \+isEmptyRow(Board, 1), addTopRow(Board, TopBoard), % add top row
    \+isEmptyColumn(TopBoard, 1), addLeftColumn(TopBoard, NewBoard). % add left column

% TOP and RIGHT
cleanBoardAdd(Board, NewBoard):-
    \+isEmptyRow(Board, 1), addTopRow(Board, [Row | TopBoard]), % add top row
    length(Row, ColNum), \+isEmptyColumn([Row | TopBoard], ColNum), addRightColumn([Row | TopBoard], NewBoard). % add right column

% BOT and LEFT
cleanBoardAdd(Board, NewBoard):-
    length(Board, RowNum), \+isEmptyRow(Board, RowNum), addBottomRow(Board, BotBoard), % add bottom row
    \+isEmptyColumn(BotBoard, 1), addLeftColumn(BotBoard, NewBoard). % add left column

% BOT and RIGHT
cleanBoardAdd(Board, NewBoard):-
    length(Board, RowNum), \+isEmptyRow(Board, RowNum), addBottomRow(Board, [Row | BotBoard]), % add bottom row
    length(Row, ColNum), \+isEmptyColumn([Row | BotBoard], ColNum), addRightColumn([Row | BotBoard], NewBoard). % add right column

% LEFT and RIGHT
cleanBoardAdd(Board, NewBoard):-
    \+isEmptyColumn(Board, 1), addLeftColumn(Board, [Row | LeftBoard]), % add left column
    length(Row, ColNum), \+isEmptyColumn([Row | LeftBoard], ColNum), addRightColumn([Row | LeftBoard], NewBoard). % add right column

% TOP
cleanBoardAdd(Board, NewBoard):-
    \+isEmptyRow(Board, 1), addTopRow(Board, NewBoard). % add top row

% BOT
cleanBoardAdd(Board, NewBoard):-
    length(Board, RowNum), \+isEmptyRow(Board, RowNum), addBottomRow(Board, NewBoard). % add bottom row

% LEFT
cleanBoardAdd(Board, NewBoard):-
    \+isEmptyColumn(Board, 1), addLeftColumn(Board, NewBoard). % add left column

% RIGHT
cleanBoardAdd([Row | Board], NewBoard):-
    length(Row, ColNum), \+isEmptyColumn([Row | Board], ColNum), addRightColumn([Row | Board], NewBoard). % add right column


% ---- Aux Functions ---- %

% letters to numbers for top row
rowNumber('A', 1).
rowNumber('B', 2).
rowNumber('C', 3).
rowNumber('D', 4).
rowNumber('E', 5).
rowNumber('F', 6).


getCell(Board, ColNum-RowLet, Cell):-
    rowNumber(RowLet, RowNum), % get row number
    nth1(RowNum, Board, Row), % get row
    nth1(ColNum, Row, Cell). % get cell

% ---- Empty Conditions ---- %

isEmptyCell(empty-empty).

isEmptyCellCoords(Board, ColNum-RowLet):-
    getCell(Board, ColNum-RowLet, Cell),
    isEmptyCell(Cell).

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

% ---- Add Rows, Cols and Cells ----%

getNewRow(1, [empty-empty]).
getNewRow(2, [empty-empty, empty-empty]).
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
