:- consult('board_dynamic.pl').

%---------------------------------------------------%
%------------------ Piece's Rules ------------------%
%---------------------------------------------------%

getPossibleMoves(Board, Piece-Color, PossibleMoves):-
    getCellCoords(Board, ColNum-RowNum, Piece-Color),
    getPossibleMoves(Board, Piece, ColNum-RowNum, PossibleMoves).

% ---- Piece not yet placed in the board ---- %
getPossibleMoves(Board, Piece, 0-0, PossibleMoves):-
    write('Piece not in board'), nl.

% ---- King's possible moves ---- %
getPossibleMoves(Board, king, ColNum-RowNum, PossibleMoves):-
    write('this is king'), nl.

% ---- Queen's possible moves ---- %
getPossibleMoves(Board, queen, ColNum-RowNum, PossibleMoves).

% ---- Bishop's possible moves ---- %
getPossibleMoves(Board, bishop, ColNum-RowNum, PossibleMoves).

% ---- Tower's possible moves ---- %
getPossibleMoves(Board, tower, ColNum-RowNum, PossibleMoves).

% ---- Horse's possible moves ---- %
getPossibleMoves(Board, horse, ColNum-RowNum, PossibleMoves).

% ---- Pawn's possible moves ---- %
getPossibleMoves(Board, pawn, ColNum-RowNum, PossibleMoves).

% ---- Aux Functions ---- %

% The following rules are abouth moving, not placing

% inside board
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

canPlace(Board, ColNum-RowNum):-
    isEmptyCellCoords(Board, ColNum-RowNum), % check if coord is empty
    \+notAdjacent(Board, ColNum-RowNum). % check if coord has any adjacent SAME COLOR pieces

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

%se for rainha ou rei, verificar se tem jogadas possiveis
%se nao: sendo rainha, eh consumida. sendo rei, game over
