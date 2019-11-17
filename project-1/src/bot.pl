:- consult('utils.pl').
:- use_module(library(random)).

pieceList([king, queen, bishop, horse, tower, pawn]).

% ---- Level 0 - Random AI ---- %
% ---- Level 1 - Choose closest to the opposite king ---- %

choose_move(Board, Level, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    pickPiece(Board, Level, Piece-Color, OldColNum-OldRowNum),
    pickMove(Board, Level, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum).

pickPiece(Board, 0, Piece-Color, OldColNum-OldRowNum):-
    pieceList(PieceList),
    random_member(Piece, PieceList),
    getCellCoords(Board, OldColNum-OldRowNum, Piece-Color).

pickMove(Board, 0, Piece-Color, 0-0, NewColNum-NewRowNum):-
    getPossiblePlaces(Board, Piece-Color, PossibleMoves),
    random_member(NewColNum-NewRowNum, PossibleMoves).
    
pickMove(Board, 0, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    getPossibleMoves(Board, Piece-Color, PossibleMoves),
    random_member(NewColNum-NewRowNum, PossibleMoves).
