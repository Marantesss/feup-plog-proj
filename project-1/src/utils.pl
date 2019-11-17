:-use_module(library(lists)).
:-use_module(library(between)).

% Pieces
translate(king, 'k').
translate(queen, 'q').
translate(bishop, 'b').
translate(tower, 't').
translate(horse, 'h').
translate(pawn, 'p').
translate(empty, '.').

validPiece(pawn).
validPiece(king).
validPiece(queen).
validPiece(horse).
validPiece(bishop).
validPiece(tower).

% Color
translate(black, 'B').
translate(white, 'W').

getOpposingColor(white, black).
getOpposingColor(black, white).

% numbers to letters
letter(1, a).
letter(2, b).
letter(3, c).
letter(4, d).
letter(5, e).
letter(6, f).
% error
letter(_, z).

%---------------------------------------------------%
%-------------- Aux Matrix Predicates --------------%
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

%---------------------------------------------------%
%-------------- Aux List Predicates ----------------%
%---------------------------------------------------%

splitList(List, [], StartIndex, EndIndex):-
    StartIndex > EndIndex.

splitList(List, [Elem | NewList], StartIndex, EndIndex):-
    nth1(StartIndex, List, Elem),
    N is StartIndex + 1,
    splitList(List, NewList, N, EndIndex).

replace([_ | Tail], 1, Rep, [Rep | Tail]).
replace([Head | Tail], Index, Rep, [Head | Rest]):-
    Index > 1,
    PrevIndex is Index - 1,
    replace(Tail, PrevIndex, Rep, Rest).
