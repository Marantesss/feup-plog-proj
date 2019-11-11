:-consult('../board_dynamic.pl').
:-consult('../rules.pl').


getPossiblePawnMoves(Board, ColNum-RowNum, Color, PossibleMoves):-
    ColNumLeft is ColNum - 1, ColNumRight is ColNum + 1,
    RowNumUp is RowNum - 1, RowNumDown is RowNum + 1,
    canMove(Board, ColNum-RowNum, ColNum-RowNumUp, pawn-Color, PossibleMoves),
    canMove(Board, ColNum-RowNum, ColNum-RowNumDown, pawn-Color, PossibleMoves),
    canMove(Board, ColNum-RowNum, ColNumLeft-RowNum, pawn-Color, PossibleMoves),
    canMove(Board, ColNum-RowNum, ColNumRight-RowNum, pawn-Color, PossibleMoves).


% check if new place is available
% remove piece form its place
% place piece in its possible new places
% rearrange board
% check if board is valid    
canMove(Board, OldColNum-OldRowNum, NewColNum-NewRowNum, Piece-Color, [ColNum-RowNum | PossibleMoves]):-
    canPlace(Board, NewColNum-NewRowNum),
    replaceCell(Board, empty-empty, OldColNum-OldRowNum, EmptyBoard),
    replaceCell(EmptyBoard, Piece-Color, NewColNum-NewRowNum, NewBoard),
    rearrangeBoard(NewBoard, ArrangedBoard),
    isValidBoard(ArrangedBoard).

canMove(Board, OldColNum-OldRowNum, NewColNum-NewRowNum, Piece-Color, PossibleMoves).
