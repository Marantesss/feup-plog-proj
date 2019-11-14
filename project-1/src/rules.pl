:- consult('board_dynamic.pl').

%---------------------------------------------------%
%----------------- Main 'functions' ----------------%
%---------------------------------------------------%

canPlace(Board, ColNum-RowNum):-
    isEmptyCellCoords(Board, ColNum-RowNum), % check if coord is empty
    \+notAdjacent(Board, ColNum-RowNum). % check if coord has any adjacent SAME COLOR pieces

canMove(Board, NewColNum-NewRowNum, Piece-Color):-
    isInsideBoard(Board, NewColNum-NewRowNum), % check if NewColNum-NewRowNum are inside the board
    getCellCoords(Board, OldColNum-OldRowNum, Piece-Color),
    isEmptyCellCoords(Board, NewColNum-NewRowNum), % check if coord is empty
    canPieceMove(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum), % checks if NewCoords are achievable from OldCoords
    replaceCell(Board, empty-empty, OldColNum-OldRowNum, EmptyBoard), % replace old cell with empty
    replaceCell(EmptyBoard, Piece-Color, NewColNum-NewRowNum, NewBoard), % put piece in new cell
    rearrangeBoard(NewBoard, ArrangedBoard), % rearrange board
    getCellCoords(ArrangedBoard, ArrangedColNum-ArrangedRowNum, Piece-Color),
    !,
    \+notAdjacent(ArrangedBoard, ArrangedColNum-ArrangedRowNum), % check if coord has any adjacent pieces
    !,
    isValidBoard(ArrangedBoard). % check if final board is empty

%---------------------------------------------------%
%------------------ Piece's Rules ------------------%
%---------------------------------------------------%

% king can move just like pawn + move in diagonals
validKingTranslation(1, 0).
validKingTranslation(1, 1).
canPieceMove(Board, king-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (validKingTranslation(DistX, DistY); validKingTranslation(DistX, DistY)).

% horse can move in L's
validHorseTranslation(2, 1).
canPieceMove(Board, horse-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (validHorseTranslation(DistX, DistY); validHorseTranslation(DistX, DistY)).

% pawn can move up, down, left or right
validPawnTranslation(1, 0).
canPieceMove(Board, pawn-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (validPawnTranslation(DistX, DistY); validPawnTranslation(DistX, DistY)).

% queen can move like bishop + tower
canPieceMove(Board, queen-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (
        validTowerTranslation(DistX, DistY); validTowerTranslation(DistX, DistY); % tower-like translation
        validBishopTranslation(DistX, DistY); validBishopTranslation(DistX, DistY)  % bishop-like translation
    ).

% bishop can diagonaly an arbitrary number of cells
validBishopTranslation(X, X).
canPieceMove(Board, bishop-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (validBishopTranslation(DistX, DistY); validBishopTranslation(DistX, DistY)).

% tower can move up, down, left or right an arbitrary number of cells
validTowerTranslation(0, X).
canPieceMove(Board, tower-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (validTowerTranslation(DistX, DistY); validTowerTranslation(DistX, DistY)).

% ---- Aux Functions ---- %

notAdjacent([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | Board], NumRows),
    ColNum > 1, RowNum > 1,
    ColNum < NumCols, RowNum < NumRows,
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,
    isEmptyCellCoords([Row | Board], ColNum-RowNumUpper),       % upper
    isEmptyCellCoords([Row | Board], ColNumRight-RowNum),       % right
    isEmptyCellCoords([Row | Board], ColNum-RowNumLower),       % lower
    isEmptyCellCoords([Row | Board], ColNumLeft-RowNum),        % left
    isEmptyCellCoords([Row | Board], ColNumRight-RowNumLower),  % lower-right
    isEmptyCellCoords([Row | Board], ColNumRight-RowNumUpper),  % upper-right
    isEmptyCellCoords([Row | Board], ColNumLeft-RowNumLower),   % lower-left
    isEmptyCellCoords([Row | Board], ColNumLeft-RowNumUpper).   % upper-left

isInsideBoard([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | Board], NumRows),
    ColNum >= 1, RowNum >= 1,
    ColNum =< NumCols, RowNum =< NumRows.

% DOES NOT WORK FOR ALL CASES
% all the pieces are touching one another if the board has no empty rols or cols besides the boarders
isValidBoard([Row | Board]):-
    % test if rows are empty
    length([Row | Board], RowNum), ActualRowNum is RowNum - 1,
    isValidBoardRows([Row | Board], ActualRowNum),
    % test if cols are empty
    length(Row, ColNum), ActualColNum is ColNum - 1,
    isValidBoardCols([Row | Board], ActualColNum),
    % check board size
    RowNum < 7, ColNum < 7.

isValidBoardCols(_, 1).
isValidBoardCols(Board, ColNum):-
    \+isEmptyColumn(Board, ColNum),
    NextColNum is ColNum - 1,
    isValidBoardCols(Board, NextColNum).

isValidBoardRows(_, 1).
isValidBoardRows(Board, RowNum):-
    \+isEmptyRow(Board, RowNum),
    NextRowNum is RowNum - 1,
    isValidBoardRows(Board, NextRowNum).

