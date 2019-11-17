:-use_module(library(lists)).
:-use_module(library(between)).

% Pieces
translate(king, 'k').
translate(queen, 'q').
translate(bishop, 'b').
translate(tower, 't').
translate(horse, 'h').
translate(pawn, 'p').
translate(empty, '.').

validPiece(pawn).
validPiece(king).
validPiece(queen).
validPiece(horse).
validPiece(bishop).
validPiece(tower).

% Color
translate(black, 'B').
translate(white, 'W').

getOpposingColor(white, black).
getOpposingColor(black, white).

% numbers to letters
letter(1, a).
letter(2, b).
letter(3, c).
letter(4, d).
letter(5, e).
letter(6, f).
% error
letter(_, z).

splitList(List, [], StartIndex, EndIndex):-
    StartIndex > EndIndex.

splitList(List, [Elem | NewList], StartIndex, EndIndex):-
    nth1(StartIndex, List, Elem),
    N is StartIndex + 1,
    splitList(List, NewList, N, EndIndex).
