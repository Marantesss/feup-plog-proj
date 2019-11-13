:-consult('../board_dynamic.pl').
:-consult('../rules.pl').
:-consult('../display.pl').



getPossiblePawnMoves(Board, ColNum-RowNum, Color, PossibleMoves):-
    ColNumLeft is ColNum - 1, ColNumRight is ColNum + 1,
    RowNumUp is RowNum - 1, RowNumDown is RowNum + 1.
    /*
    canMove(Board, ColNum-RowNum, ColNum-RowNumUp, pawn-Color, PossibleMoves),
    canMove(Board, ColNum-RowNum, ColNum-RowNumDown, pawn-Color, PossibleMoves),
    canMove(Board, ColNum-RowNum, ColNumLeft-RowNum, pawn-Color, PossibleMoves),
    canMove(Board, ColNum-RowNum, ColNumRight-RowNum, pawn-Color, PossibleMoves).
    */
% check if new place is available
% remove piece form its place
% place piece in its possible new places
% rearrange board
% check if board is valid    
canMove(Board, NewColNum-NewRowNum, Piece-Color):-
    % check if NewColNum-NewRowNum are inside the board
    % checks if NewCoords are achievable from OldCoords
    getCellCoords(ArrangedBoard, OldColNum-OldRowNum, Piece-Color),
    isEmptyCellCoords(Board, NewColNum-NewRowNum), % check if coord is empty
    replaceCell(Board, empty-empty, OldColNum-OldRowNum, EmptyBoard), % replace old cell with empty
    replaceCell(EmptyBoard, Piece-Color, NewColNum-NewRowNum, NewBoard), % put piece in new cell
    rearrangeBoard(NewBoard, ArrangedBoard), % rearrange board
    getCellCoords(ArrangedBoard, ArrangedColNum-ArrangedRowNum, Piece-Color),
    !,
    \+notAdjacent(ArrangedBoard, ArrangedColNum-ArrangedRowNum), % check if coord has any adjacent pieces
    !,
    isValidBoard(ArrangedBoard).



