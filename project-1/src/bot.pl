:- consult('utils.pl').
:- use_module(library(random)).

pieceList([king, queen, bishop, horse, tower, pawn]).

% ---- Level 1 - Random AI ---- %
% ---- Level 2 - Choose closest to the opposite king ---- %

choose_move(Board, Level, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    pickPiece(Board, Level, Piece-Color, OldColNum-OldRowNum),
    pickMove(Board, Level, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum).

pickPiece(Board, 1, Piece-Color, OldColNum-OldRowNum):-
    pieceList(PieceList),
    random_member(Piece, PieceList),
    getCellCoords(Board, OldColNum-OldRowNum, Piece-Color).

pickMove(Board, 1, Piece-Color, 0-0, NewColNum-NewRowNum):-
    valid_places(Board, Piece-Color, PossibleMoves),
    random_member(NewColNum-NewRowNum, PossibleMoves).
    
pickMove(Board, 1, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum):-
    valid_moves(Board, Piece-Color, PossibleMoves),
    random_member(NewColNum-NewRowNum, PossibleMoves).

