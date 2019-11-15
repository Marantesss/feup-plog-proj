% Pieces
translate(king, 'k').
translate(queen, 'q').
translate(bishop, 'b').
translate(tower, 't').
translate(horse, 'h').
translate(pawn, 'p').
translate(empty, '.').

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
