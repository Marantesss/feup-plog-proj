:-consult('utils.pl').
:-consult('display.pl').

%---------------------------------------------------%
%----------------- MAIN FUNCTION  ------------------%
%--------- add and remove rows and/or cols ---------%
%-------------- get the playable area --------------%
%---------------------------------------------------%

rearrangeBoard(Board, NewBoard):-
    checkTop(Board, TopBoard), % add or remove top row
    checkBot(TopBoard, BotBoard), % add or remove bot row
    checkLeft(BotBoard, LeftBoard), % add or remove left row
    checkRight(LeftBoard, NewBoard). % add or remove right row


getPlayableBoard(Board, NewBoard):-
    checkBorderRows(Board, RowBoard),
    checkBorderCols(RowBoard, NewBoard).

checkBorderRows(Board, NewBoard):-
    length(Board, NumRows),
    6 == NumRows,
    removeTopRow(Board, RowBoard),
    removeBottomRow(RowBoard, NewBoard).

checkBorderRows(Board, Board).

checkBorderCols([Row | Board], NewBoard):-
    length(Row, NumCols),
    6 == NumCols,
    removeLeftColumn([Row | Board], ColBoard),
    removeRightColumn(ColBoard, NewBoard).

checkBorderCols(Board, Board).


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
    removeRightColumn(Board, NewBoard).
