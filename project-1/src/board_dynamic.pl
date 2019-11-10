:-use_module(library(lists)).
:-consult('utils.pl').

%---------------------------------------------------%
%----------------- MAIN FUNCTION  ------------------%
%--------- add and remove rows and/or cols ---------%
%---------------------------------------------------%

rearrangeBoard(Board, NewBoard):-
    checkTop(Board, TopBoard), % add or remove top row
    checkBot(TopBoard, BotBoard), % add or remove bot row
    checkLeft(BotBoard, LeftBoard), % add or remove left row
    checkRight(LeftBoard, NewBoard). % add or remove right row

%---------------------------------------------------%
%----- REMOVE WHEN EMPTY / ADD WHEN NOT EMPTY ------%
%---------------------------------------------------%

% ---- TOP ---- %

% remove
checkTop(Board, TopBoard):-
    isEmptyRow(Board, 2),
    !,
    removeTopRow(Board, TopBoard).

% add
checkTop(Board, TopBoard):-
    \+isEmptyRow(Board, 1),
    !,
    addTopRow(Board, TopBoard).

% do nothing
checkTop(Board, Board).

% ---- BOT ---- %

% remove
checkBot(Board, BotBoard):-
    length(Board, RowNum),
    ActRowNum is RowNum - 1,
    isEmptyRow(Board, ActRowNum),
    !,
    removeBottomRow(Board, BotBoard).

% add
checkBot(Board, BotBoard):-
    length(Board, RowNum),
    \+isEmptyRow(Board, RowNum),
    !,
    addBottomRow(Board, BotBoard).

% do nothing
checkBot(Board, Board).

% ---- LEFT ---- %

% remove
checkLeft(Board, LeftBoard):-
    isEmptyColumn(Board, 2),
    !,
    removeLeftColumn(Board, LeftBoard).

% add
checkLeft(Board, LeftBoard):-
    \+isEmptyColumn(Board, 1),
    !,
    addLeftColumn(Board, LeftBoard).

% do nothing
checkLeft(Board, Board).

% ---- RIGHT ---- %

% remove
checkRight([Row | Board], RightBoard):-
    length(Row, ColNum),
    ActColNum is ColNum - 1,
    isEmptyColumn([Row | Board], ActColNum),
    !,
    removeRightColumn([Row | Board], RightBoard).

% add
checkRight([Row | Board], RightBoard):-
    length(Row, ColNum),
    \+isEmptyColumn([Row | Board], ColNum),
    !,
    addRightColumn([Row | Board], RightBoard).

% do nothing
checkRight(Board, Board).

%---------------------------------------------------%
%----------------- Aux Predicados ------------------%
%---------------------------------------------------%

getCell(Board, ColNum-RowNum, Cell):-
    nth1(RowNum, Board, Row), % get row
    nth1(ColNum, Row, Cell). % get cell

replaceCell(Board, NewCell, ColNum-RowNum, NewBoard):-
    nth1(RowNum, Board, Row), % get row
    replace(Row, ColNum, NewCell, NewRow), % replace cell in row
    replace(Board, RowNum, NewRow, NewBoard). % replace row in board

replace([_ | Tail], 1, Rep, [Rep | Tail]).
replace([Head | Tail], Index, Rep, [Head | Rest]):-
    Index > 1,
    PrevIndex is Index - 1,
    replace(Tail, PrevIndex, Rep, Rest).

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
