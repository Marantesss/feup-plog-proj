:-include('board_arrange.pl').

% placement
placePiece(Board, Piece, ColNum-RowLet, NewBoard):-
    isEmptyCellCoords(Board, ColNum-RowLet), % check if coords are allowed TODO -> check if placemente is allowed
    replaceCell(Board, Piece, ColNum-RowLet, RepBoard), % place piece
    rearrangeBoard(RepBoard, NewBoard). % rearrange board

% movement

