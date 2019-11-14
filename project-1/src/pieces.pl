:-consult('rules.pl').
:-consult(library(between)).

/*
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
*/

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
    