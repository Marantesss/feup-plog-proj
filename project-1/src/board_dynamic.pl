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
checkTopRow(Board):-
    !,
    isEmptyRow(Board, 1),
    !,
    isEmptyRow(Board, 2).

% remove
checkTop(Board, TopBoard):-
    checkTopRow(Board),
    removeTopRow(Board, TopBoard).

% add
checkTop(Board, TopBoard):-
    \+isEmptyRow(Board, 1),
    addTopRow(Board, TopBoard).

% do nothing
checkTop(Board, Board).

% ---- BOT ---- %
checkBotRow(Board):-
    length(Board, RowNum),
    ActRowNum is RowNum - 1,
    !,
    isEmptyRow(Board, RowNum),
    !,
    isEmptyRow(Board, ActRowNum).

% remove
checkBot(Board, BotBoard):-
    checkBotRow(Board),
    removeBottomRow(Board, BotBoard).

% add
checkBot(Board, BotBoard):-
    length(Board, RowNum),
    \+isEmptyRow(Board, RowNum),
    addBottomRow(Board, BotBoard).

% do nothing
checkBot(Board, Board).

% ---- LEFT ---- %
checkLeftColumns(Board):-
    !,
    isEmptyColumn(Board, 1),
    !,
    isEmptyColumn(Board, 2).

% remove
checkLeft(Board, LeftBoard):-
    checkLeftColumns(Board),
    removeLeftColumn(Board, LeftBoard).

% add
checkLeft(Board, LeftBoard):-
    \+isEmptyColumn(Board, 1),
    addLeftColumn(Board, LeftBoard).

% do nothing
checkLeft(Board, Board).

% ---- RIGHT ---- %
checkRightColumns(Board):-
    nth1(1, Board, Row),
    length(Row, ColNum),
    ActColNum is ColNum - 1,
    !,
    isEmptyColumn(Board, ColNum),
    !,
    isEmptyColumn(Board, ActColNum).

% remove
checkRight(Board, RightBoard):-
    checkRightColumns(Board),
    removeRightColumn(Board, RightBoard).

% add
checkRight([Row | Board], RightBoard):-
    length(Row, ColNum),
    \+isEmptyColumn([Row | Board], ColNum),
    addRightColumn([Row | Board], RightBoard).

% do nothing
checkRight(Board, Board).

%---------------------------------------------------%
%----------------- Aux Predicados ------------------%
%---------------------------------------------------%

getCol([], _, []).
getCol([Row | Board], N, [Piece-Color | Col]):-
    nth1(N, Row, Piece-Color),
    getCol(Board, N, Col).

getRow(Board, N, Col):-
    nth1(N, Board, Col).

% ---- get diagonal /> ----
getDiagonalRight(Board, StartColNum-StartRowNum, EndColNum-EndRowNum, []):-
    StartColNum > EndColNum.

getDiagonalRight(Board, StartColNum-StartRowNum, EndColNum-EndRowNum, [Piece-Color | Diagonal]):-
    NextCol is StartColNum + 1,
    NextRow is StartRowNum - 1,
    getDiagonalRight(Board, NextCol-NextRow, EndColNum-EndRowNum, Diagonal),
    getCell(Board, StartColNum-StartRowNum, Piece-Color).

% ---- get diagonal \> ----
getDiagonalLeft(Board, StartColNum-StartRowNum, EndColNum-EndRowNum, []):-
    StartColNum > EndColNum.

getDiagonalLeft(Board, StartColNum-StartRowNum, EndColNum-EndRowNum, [Piece-Color | Diagonal]):-
    NextCol is StartColNum + 1,
    NextRow is StartRowNum + 1,
    getDiagonalLeft(Board, NextCol-NextRow, EndColNum-EndRowNum, Diagonal),
    getCell(Board, StartColNum-StartRowNum, Piece-Color).

% ---- piece is not on the board
getCellRow([], ReturnRow, Cell):-
    ReturnRow = [].
% ---- piece is in board
getCellRow([Row | _], ReturnRow, Cell):-
    member(Cell, Row),
    ReturnRow = Row.

% ---- gets cell coordinates when cell is known.
getCellRow([Row | Board], ReturnRow, Cell):-
    getCellRow(Board, ReturnRow, Cell).

getCellCoords(Board, ColNum-RowNum, Cell):-
    getCellRow(Board, Row, Cell),
    nth1(RowNum, Board, Row), % get row number
    nth1(ColNum, Row, Cell). % get column number
    
% ---- piece is not on the board
getCellCoords(Board, 0-0, Cell).

% ---- gets cell when cell coordinates are known.

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

isEmptyCellCoords(Board, ColNum-RowNum):-
    getCell(Board, ColNum-RowNum, Cell),
    isEmptyCell(Cell).

isEmptyRowAux([]).
isEmptyRowAux([Cell | Row]):-
    !,
    isEmptyCell(Cell),
    isEmptyRowAux(Row).

isEmptyRow(Board, RowNum):-
    nth1(RowNum, Board, Row),
    isEmptyRowAux(Row).

isEmptyColumn([], ColNum).
isEmptyColumn([Row | Board], ColNum):-
    nth1(ColNum, Row, Cell),
    !,
    isEmptyCell(Cell),
    isEmptyColumn(Board, ColNum).

% ---- Add Rows, Cols and Cells ----%

getNewRow(1, [empty-empty]).
getNewRow(2, [empty-empty, empty-empty]).
getNewRow(3, [empty-empty, empty-empty, empty-empty]).
getNewRow(4, [empty-empty, empty-empty, empty-empty, empty-empty]).
getNewRow(5, [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]).
getNewRow(6, [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]).
getNewRow(7, [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]).

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


removeLeftColumn([], []).
removeLeftColumn([Row | Board], [NewRow | NewBoard]):-
    removeTopRow(Row, NewRow),      % removes left cell in row
    removeLeftColumn(Board, NewBoard).


removeRightColumn([], []).
removeRightColumn([Row | Board], [NewRow | NewBoard]):-
    removeBottomRow(Row, NewRow),      % removes right cell in row
    removeRightColumn(Board, NewBoard, N1).
