:- consult('board_dynamic.pl').

%---------------------------------------------------%
%------------------ Piece's Rules ------------------%
%---------------------------------------------------%

% ---- Aux Functions ---- %

% inside board
isInsideBoard.

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

% upper boarder
notAdjacent(Board, ColNum-RowNum):-
    RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,
    isEmptyCellCoords(Board, ColNumRight-RowNum),       % right
    isEmptyCellCoords(Board, ColNum-RowNumLower),       % lower
    isEmptyCellCoords(Board, ColNumLeft-RowNum),        % left
    isEmptyCellCoords(Board, ColNumRight-RowNumLower),  % lower-right
    isEmptyCellCoords(Board, ColNumLeft-RowNumLower).   % lower-left

% lower boarder
notAdjacent(Board, ColNum-RowNum):-
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,
    isEmptyCellCoords(Board, ColNum-RowNumUpper),       % upper
    isEmptyCellCoords(Board, ColNumRight-RowNum),       % right
    isEmptyCellCoords(Board, ColNum-RowNumLower),       % lower
    isEmptyCellCoords(Board, ColNumLeft-RowNum),        % left
    isEmptyCellCoords(Board, ColNumRight-RowNumLower),  % lower-right
    isEmptyCellCoords(Board, ColNumRight-RowNumUpper),  % upper-right
    isEmptyCellCoords(Board, ColNumLeft-RowNumLower),   % lower-left
    isEmptyCellCoords(Board, ColNumLeft-RowNumUpper).   % upper-left

canPlace(Board, ColNum-RowNum):-
    isEmptyCellCoords(Board, ColNum-RowNum). % check if coord is empty
    \+notAdjacent(Board, ColNum-RowNum). % check if coord has any adjacent pieces

% movement rules

%se for rainha ou rei, verificar se tem jogadas possiveis
%se nao: sendo rainha, eh consumida. sendo rei, game over
canMove.