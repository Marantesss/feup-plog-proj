:-consult('rules.pl').

movePiece(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard):-
    replaceCell(Board, empty-empty, OldColNum-OldRowNum, RepBoardInt),
    replaceCell(RepBoardInt, Piece-Color, NewColNum-NewRowNum, RepBoardFin),
    rearrangeBoard(RepBoardFin, NewBoard).

placePiece(Board, Piece-Color, ColNum-RowNum, NewBoard):-
    replaceCell(Board, Piece-Color, ColNum-RowNum, RepBoard), % place piece
    rearrangeBoard(RepBoard, NewBoard). % rearrange board

getPossiblePlaces([Row | Board], Piece-Color, PossiblePlaces):-
    length(Row, MaxColNumber),
    length([Row | Board], MaxRowNumber),
    Goal =
    (        
        between(1, MaxColNumber, ColNum),
        between(1, MaxRowNumber, RowNum),
        canPlace(Board, ColNum-RowNum, Piece-Color)
    ),
    setof(ColNum-RowNum, Goal, PossiblePlaces).

getPossibleMoves([Row | Board], Piece-Color, PossibleMoves):-
    length(Row, MaxColNumber),
    length([Row | Board], MaxRowNumber),
    Goal =
    (        
        between(1, MaxColNumber, ColNum),
        between(1, MaxRowNumber, RowNum),
        canMove(Board, ColNum-RowNum, Piece-Color)
    ),
    setof(ColNum-RowNum, Goal, PossibleMoves).