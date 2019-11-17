:- consult('board_dynamic.pl').

%---------------------------------------------------%
%----------------- Main 'functions' ----------------%
%---------------------------------------------------%

canPlace(Board, ColNum-RowNum, Piece-Color):-
    isInsideBoard(Board, ColNum-RowNum), % check if ColNum-RowNum are inside the board
    isEmptyCellCoords(Board, ColNum-RowNum), % check if coord is empty
    replaceCell(Board, Piece-Color, ColNum-RowNum, NewBoard), % put piece in cell
    rearrangeBoard(NewBoard, ArrangedBoard), % rearrange board
    getCellCoords(ArrangedBoard, ArrangedColNum-ArrangedRowNum, Piece-Color),
    \+notAdjacent(ArrangedBoard, ArrangedColNum-ArrangedRowNum), % check if coord has any adjacent pieces
    notAdjacentOpposingKing(ArrangedBoard, ArrangedColNum-ArrangedRowNum, Color),   % check if coord is adjacent to the Opposing king
    \+notAdjacentSameColorPiece(ArrangedBoard, ArrangedColNum-ArrangedRowNum, Color), % check if coord has any adjacent SAME COLOR pieces
    isValidBoard(ArrangedBoard).

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
    (validKingTranslation(DistX, DistY); validKingTranslation(DistY, DistX)).

% horse can move in L's
validHorseTranslation(2, 1).
canPieceMove(Board, horse-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (validHorseTranslation(DistX, DistY); validHorseTranslation(DistY, DistX)).

% pawn can move up, down, left or right
validPawnTranslation(1, 0).
canPieceMove(Board, pawn-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (validPawnTranslation(DistX, DistY); validPawnTranslation(DistY, DistX)).

% queen can move like bishop + tower
canPieceMove(Board, queen-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (
        validTowerTranslation(DistX, DistY); validTowerTranslation(DistY, DistX); % tower-like translation
        validBishopTranslation(DistX, DistY); validBishopTranslation(DistY, DistX)  % bishop-like translation
    ).

% bishop can move diagonaly an arbitrary number of cells
validBishopTranslation(X, X).
canPieceMove(Board, bishop-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (validBishopTranslation(DistX, DistY); validBishopTranslation(DistY, DistX)).

% tower can move up, down, left or right an arbitrary number of cells
validTowerTranslation(0, X).
canPieceMove(Board, tower-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    DistX is abs(OldColNum - NewColNum),
    DistY is abs(OldRowNum - NewRowNum),
    (validTowerTranslation(DistX, DistY); validTowerTranslation(DistY, DistX)).

% ---- Aux Functions ---- %

notAdjacent([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | Board], NumRows),
    TestedNumRows is NumRows + 1,
    TestedNumCols is NumCols + 1,
    between(2, TestedNumRows, RowNum),
    between(2, TestedNumCols, ColNum),
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

notAdjacentOpposingKing([Row | Board], ColNum-RowNum, Color):-
    length(Row, NumCols), length([Row | Board], NumRows),
    ColNum > 1, RowNum > 1,
    ColNum < NumCols, RowNum < NumRows,
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,

    \+isOpposingKingCellCoords([Row | Board], ColNum-RowNumUpper, Color),       % upper
    \+isOpposingKingCellCoords([Row | Board], ColNumRight-RowNum, Color),       % right
    \+isOpposingKingCellCoords([Row | Board], ColNum-RowNumLower, Color),       % lower
    \+isOpposingKingCellCoords([Row | Board], ColNumLeft-RowNum, Color).       % left

notAdjacentSameColorPiece([Row | Board], ColNum-RowNum, Color):-
    length(Row, NumCols), length([Row | Board], NumRows),
    ColNum > 1, RowNum > 1,
    ColNum < NumCols, RowNum < NumRows,
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,
    
    notSameColorPieceCellCoords([Row | Board], ColNum-RowNumUpper, Color),    % upper
    notSameColorPieceCellCoords([Row | Board], ColNum-RowNumLower, Color),    % lower
    notSameColorPieceCellCoords([Row | Board], ColNumRight-RowNum, Color),    % right
    notSameColorPieceCellCoords([Row | Board], ColNumLeft-RowNum, Color),    % left
    notSameColorPieceCellCoords([Row | Board], ColNumRight-RowNumUpper, Color),    % upper-right
    notSameColorPieceCellCoords([Row | Board], ColNumLeft-RowNumUpper, Color),    % upper-left
    notSameColorPieceCellCoords([Row | Board], ColNumLeft-RowNumLower, Color),    % lower-left
    notSameColorPieceCellCoords([Row | Board], ColNumRight-RowNumLower, Color).    % lower-right

isInsideBoard([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | Board], NumRows),
    between(1, NumRows, RowNum),
    between(1, NumCols, ColNum).

% DOES NOT WORK FOR ALL CASES
% all the pieces are touching one another if the board has no empty rows or cols besides the borders
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

% ---- PLACEMENT ---- %
% ---- Opposing King and Opposing colors Conditions ---- %
isKingCell(king-_).
isOpposingKingCellCoords(Board, ColNum-RowNum, PlayingColor):-
    getCell(Board, ColNum-RowNum, Piece-Color),
    getOpposingColor(PlayingColor, OpposingColor),
    isKingCell(Piece-Color),
    OpposingColor == Color.

notSameColorPieceCellCoords(Board, ColNum-RowNum, PlayingColor):-
    getCell(Board, ColNum-RowNum, Piece-Color),
    PlayingColor \== Color.

% ---- ROYALTY ---- %
% ---- check if king or queen are trapped ---- %

t:-
    trace,
    test.

test:-
    getPlayableBoard(
            [
                [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty, empty-empty],
                [empty-empty, empty-empty, empty-empty, empty-empty, bishop-black, empty-empty],
                [empty-empty, empty-empty, empty-empty, king-black, empty-empty, empty-empty],
                [empty-empty, horse-white, tower-black, empty-empty, tower-white, empty-empty],
                [empty-empty, empty-empty, queen-white, horse-white, king-white, empty-empty],
                [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]
            ],
            PlayableBoard),
    getCellCoords(PlayableBoard, ColNum-RowNum, king-white),
    trace,
    isTrapped(
        PlayableBoard,
        ColNum-RowNum
    ).

% caso geral
isTrapped([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | PlayableBoard], NumRows),
    ColNum > 1, RowNum > 1,
    ColNum < NumCols, RowNum < NumRows,
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,

    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumUpper), % check if upper coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumLower), % check if lower coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumLeft-RowNum), % check if left coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumRight-RowNum). % check if right coord is empty

% ---- SIDES ---- %
% right side
isTrapped([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | PlayableBoard], NumRows),
    write('Cona'), nl,
    RowNum > 1, RowNum < NumRows,
    ColNum =:= NumCols,
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,

    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumUpper), % check if upper coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumLower), % check if lower coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumLeft-RowNum). % check if left coord is empty


% lower side
isTrapped([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | PlayableBoard], NumRows),
    ColNum > 1, ColNum < NumCols,
    RowNum =:= NumRows,
    write('Cona1'), nl,
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,

    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumUpper), % check if upper coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumLeft-RowNum), % check if left coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumRight-RowNum). % check if right coord is empty

% left side
isTrapped([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | PlayableBoard], NumRows),
    ColNum =:= 1, RowNum > 1,
    RowNum < NumRows,
    write('Cona2'), nl,
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,

    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumUpper), % check if upper coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumLower), % check if lower coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumRight-RowNum). % check if right coord is empty

% upper side
isTrapped([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | PlayableBoard], NumRows),
    ColNum > 1, RowNum =:= 1,
    ColNum < NumCols,
    write('Cona3'), nl,
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,

    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumLower), % check if lower coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumLeft-RowNum), % check if left coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumRight-RowNum). % check if right coord is empty

% ----  CORNERS ---- %
% upper right corner
isTrapped([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | PlayableBoard], NumRows),
    ColNum =:= 1, RowNum =:= NumRows,
    write('Cona4'), nl,
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,

    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumLower), % check if lower coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumLeft-RowNum). % check if left coord is empty

% lower right corner
isTrapped([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | Board], NumRows),
    ColNum =:= NumCols, RowNum =:= NumRows,
    RowNumUpper is RowNum - 1,
    ColNumLeft is ColNum - 1,

    \+isEmptyCellCoords([Row | Board], ColNum-RowNumUpper), % check if upper coord is empty
    \+isEmptyCellCoords([Row | Board], ColNumLeft-RowNum). % check if left coord is empty

% lower left corner
isTrapped([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | PlayableBoard], NumRows),
    ColNum =:= NumCols, RowNum =:= 1,
    RowNumUpper is RowNum - 1,
    ColNumRight is ColNum + 1,

    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumUpper), % check if upper coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumRight-RowNum). % check if right coord is empty

% upper left corner
isTrapped([Row | Board], ColNum-RowNum):-
    length(Row, NumCols), length([Row | PlayableBoard], NumRows),
    ColNum =:= 1, RowNum =:= 1,
    RowNumLower is RowNum + 1,
    ColNumRight is ColNum + 1,

    \+isEmptyCellCoords([Row | PlayableBoard], ColNum-RowNumLower), % check if lower coord is empty
    \+isEmptyCellCoords([Row | PlayableBoard], ColNumRight-RowNum). % check if right coord is empty
