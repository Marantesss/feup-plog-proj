:-consult('board_examples.pl').
:-consult('display.pl').
:-consult('pieces.pl').
:-consult('rules.pl').
:-consult('input.pl').

echek:-
    menu,
    gameLoop.

menu:-
    printMenu,
    readOption.

% placing pawn gives you an extra move
play(Board, pawn-Color, 0-0, NewColNum-NewRowNum, NewBoard):-
    getPossiblePlaces(Board, pawn-Color, PossiblePlaces),
    (
        % either move is valid
        (
            member(NewColNum-NewRowNum, PossiblePlaces),
            placePiece(Board, pawn-Color, NewColNum-NewRowNum, NewBoard),
            readMovePawnAgain(YesNo),
            movePawnAgain(Board, Color, NewBoard, YesNo)
        );
        % or try again
        (
            write('ERROR: Invalid move'), nl,
            readGameInput(Board, pawn, NewNewColNum-NewNewRowNum),
            getCellCoords(Board, NewOldColNum-NewOldRowNum, pawn-Color),
            play(Board, pawn-Color, NewOldColNum-NewOldRowNum, NewNewColNum-NewNewRowNum, NewBoard)
        )
    ).
    
% the extra move
movePawnAgain(Board, Color, NewBoard, no).
movePawnAgain(Board, Color, NewBoard, yes):-
    readCol(Board, NewColNum),
    readRow(Board, NewRowNum),
    getCellCoords(Board, OldColNum-OldRowNum, pawn-Color),
    play(Board, pawn-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard).


% placement
play(Board, Piece-Color, 0-0, NewColNum-NewRowNum, NewBoard):-
    getPossiblePlaces(Board, Piece-Color, PossibleMoves),
    (
        % either move is valid
        (
            member(NewColNum-NewRowNum, PossibleMoves),
            placePiece(Board, Piece-Color, NewColNum-NewRowNum, NewBoard)
        );
        % or try again
        (
            write('ERROR: Invalid move'), nl,
            readGameInput(Board, NewPiece, NewNewColNum-NewNewRowNum),
            getCellCoords(Board, NewOldColNum-NewOldRowNum, NewPiece-Color),
            play(Board, NewPiece-Color, NewOldColNum-NewOldRowNum, NewNewColNum-NewNewRowNum, NewBoard)
        )
    ).

% movement
play(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard):-
    getPossibleMoves(Board, Piece-Color, PossibleMoves),
    (
        % either move is valid
        (
            member(NewColNum-NewRowNum, PossibleMoves),
            movePiece(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard)
        );
        % or try again
        (
            write('ERROR: Invalid move'), nl,
            readGameInput(Board, NewPiece, NewNewColNum-NewNewRowNum),
            getCellCoords(Board, NewOldColNum-NewOldRowNum, NewPiece-Color),
            play(Board, NewPiece-Color, NewOldColNum-NewOldRowNum, NewNewColNum-NewNewRowNum, NewBoard)
        )
    ).

whitePlayerTurn(Board, person, NewBoard):-
    nl, write('-------- PLAYER WHITE --------'), nl, nl,
    readGameInput(Board, Piece, NewColNum-NewRowNum),
    getCellCoords(Board, OldColNum-OldRowNum, Piece-white),
    play(Board, Piece-white, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard),
    printBoard(NewBoard).

whitePlayerTurn(Board, computer, NewBoard):-
    nl, write('-------- COMPUTER WHITE --------'), nl, nl.
    % bot play

blackPlayerTurn(Board, person, NewBoard):-
    nl, write('-------- PLAYER BLACK --------'), nl, nl,
    readGameInput(Board, Piece, NewColNum-NewRowNum),
    getCellCoords(Board, OldColNum-OldRowNum, Piece-black),
    play(Board, Piece-black, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard),
    printBoard(NewBoard).

blackPlayerTurn(Board, computer, NewBoard):-
    nl, write('-------- COMPUTER BLACK --------'), nl, nl.
    % bot play

startGame(Player1, Player2):-
    initialBoard(InitBoard),
    printBoard(InitBoard),
    gameLoop(InitBoard, Player1, Player2).

gameLoop(Board, Player1, Player2):-
    whitePlayerTurn(Board, Player1, NewBoard),
    (
        %(checkGameState(white, NewBoard), write('\nThanks for playing!\n'));
        (blackPlayerTurn(NewBoard, Player2, FinalBoard),
            (
                %(checkGameState(black, FinalBoard), write('\nThanks for playing!\n'));
                (gameLoop(FinalBoard, Player1, Player2))
            )
        )
    ).
testPawn:-
    play([
            [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty],
            [empty-empty, empty-empty, empty-empty, bishop-black, empty-empty],
            [empty-empty, tower-black, king-black, tower-white, empty-empty],
            [empty-empty, empty-empty, king-white, empty-empty, empty-empty],
            [empty-empty, queen-white, horse-white, empty-empty, empty-empty],
            [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]
        ]  , pawn-white, 0-0, 4-5, NB
        ),
        printBoard(NB).