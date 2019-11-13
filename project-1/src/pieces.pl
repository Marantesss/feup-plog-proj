:-consult('board_dynamic.pl').

%---------------------------------------------------%
%----------------- Piece Placement -----------------%
%---------------------------------------------------%

placePiece(Board, Piece-Color, ColNum-RowNum, NewBoard):-
    isEmptyCellCoords(Board, ColNum-RowNum), % check if coords are allowed TODO -> check if placement is allowed
    replaceCell(Board, Piece-Color, ColNum-RowNum, RepBoard), % place piece
    rearrangeBoard(RepBoard, NewBoard). % rearrange board

%---------------------------------------------------%
%----------------- Piece Movement ------------------%
%---------------------------------------------------%

movePiece(Board, Piece-Color, ColNum-RowNum, NewBoard):-
    % check if new coords are allowed, can move from old-cords to new-cords
    replaceCell(Board, Piece-Color, ColNum-RowNum, RepBoard), % place piece
    rearrangeBoard(RepBoard, NewBoard). % rearrange board

