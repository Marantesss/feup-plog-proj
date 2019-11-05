:-include('board_dynamic.pl').

%---------------------------------------------------%
%----------------- Piece Placement -----------------%
%---------------------------------------------------%

placePiece(Board, Piece, ColNum-RowLet, NewBoard):-
    isEmptyCellCoords(Board, ColNum-RowLet), % check if coords are allowed TODO -> check if placement is allowed
    replaceCell(Board, Piece, ColNum-RowLet, RepBoard), % place piece
    rearrangeBoard(RepBoard, NewBoard). % rearrange board

%---------------------------------------------------%
%----------------- Piece Movement ------------------%
%---------------------------------------------------%

