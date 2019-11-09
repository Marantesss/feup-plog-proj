:- consult('board_dynamic.pl').

%---------------------------------------------------%
%------------------ Piece's Rules ------------------%
%---------------------------------------------------%

% ---- Aux Functions ---- %

notAdjacent(Board, ColNum-RowNum):-
    RowNumUpper is RowNum - 1,  RowNumLower is RowNum + 1,
    ColNumLeft is ColNum - 1,  ColNumRight is ColNum + 1,
    isEmptyCellCoords(Board, ColNum-RowNumUpper),       % upper
    isEmptyCellCoords(Board, ColNumRight-RowNum),       % right
    isEmptyCellCoords(Board, ColNum-RowNumLower),       % lower
    isEmptyCellCoords(Board, ColNumLeft-RowNum),        % left
    isEmptyCellCoords(Board, ColNumRight-RowNumLower),  % lower-right
    isEmptyCellCoords(Board, ColNumRight-NewRowNum),    % upper-right
    isEmptyCellCoords(Board, ColNumLeft-RowNumLower),   % lower-left
    isEmptyCellCoords(Board, ColNumLeft-NewRowNum).     % upper-left

canPlace(Board, ColNum-RowNum):-
    isEmptyCellCoords(Board, ColNum-RowNum). % check if coord is empty
    % remove a peça


% movement rules

%se for rainha ou rei, verificar se tem jogadas possiveis
%se nao: sendo rainha, eh consumida. sendo rei, game over
canMove.