:-consult('rules.pl').

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

getPossibleMoves(Board, Piece-Color, PossibleMoves):-
    getCellCoords(Board, ColNum-RowNum, Piece-Color),
    getPossibleMoves(Board, Piece-Color, ColNum-RowNum, PossibleMoves).

% ---- Piece not yet placed in the board ---- %
getPossibleMoves(Board, Piece-Color, 0-0, PossibleMoves):-
    write('Piece not in board'), nl.

% ---- King's possible moves ---- %
getPossibleMoves(Board, king-Color, ColNum-RowNum, PossibleMoves):-
    write('this is king'), nl.

% ---- Queen's possible moves ---- %
getPossibleMoves(Board, queen-Color, ColNum-RowNum, PossibleMoves).

% ---- Bishop's possible moves ---- %
getPossibleMoves(Board, bishop-Color, ColNum-RowNum, PossibleMoves).

% ---- Tower's possible moves ---- %
getPossibleMoves(Board, tower-Color, ColNum-RowNum, PossibleMoves).

% ---- Horse's possible moves ---- %
getPossibleMoves(Board, horse-Color, ColNum-RowNum, PossibleMoves).

% ---- Pawn's possible moves ---- %
getPossibleMoves(Board, pawn-Color, ColNum-RowNum, PossibleMoves).