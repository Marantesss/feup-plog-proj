:- consult('utils.pl').
:- use_module(library(random)).

pieceList([king, queen, bishop, horse, tower, pawn]).

% ---- random AI ---- %

makeRandomPlay(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    pickRandomPiece(Board, Piece-Color, OldColNum-OldRowNum),
    pickRandomMove(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum).

pickRandomPiece(Board, Piece-Color, OldColNum-OldRowNum):-
    pieceList(PieceList),
    random_member(Piece, PieceList),
    getCellCoords(Board, OldColNum-OldRowNum, Piece-Color).

pickRandomMove(Board, Piece-Color, 0-0, NewColNum-NewRowNum):-
    getPossiblePlaces(Board, Piece-Color, PossibleMoves),
    random_member(NewColNum-NewRowNum, PossibleMoves).
    
pickRandomMove(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    getPossibleMoves(Board, Piece-Color, PossibleMoves),
    random_member(NewColNum-NewRowNum, PossibleMoves).
