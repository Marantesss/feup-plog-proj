:-consult('rules.pl').

getPossiblePlaces(Board, Piece-Color, PossiblePlaces):-
    Goal =
    (        
        between(1, 6, ColNum),
        between(1, 6, RowNum),
        canPlace(Board, ColNum-RowNum, Piece-Color)
    ),
    setof(ColNum-RowNum, Goal, PossibleMoves).

getPossibleMoves(Board, Piece-Color, PossibleMoves):-
    Goal =
    (        
        between(1, 6, ColNum),
        between(1, 6, RowNum),
        canMove(Board, ColNum-RowNum, Piece-Color)
    ),
    setof(ColNum-RowNum, Goal, PossibleMoves).


test:-
    getPossibleMoves([
        [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty],
        [empty-empty, empty-empty, empty-empty, bishop-black, empty-empty],
        [empty-empty, tower-black, king-black, tower-white, empty-empty],
        [empty-empty, empty-empty, king-white, empty-empty, empty-empty],
        [empty-empty, queen-white, horse-black, empty-empty, empty-empty],
        [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]
        ], tower-black, PM),
    write(PM).

