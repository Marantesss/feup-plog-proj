:-consult('board_examples.pl').
:-consult('display.pl').
:-consult('pieces.pl').
:-consult('rules.pl').
:-consult('input.pl').
:-consult('bot.pl').

echek:-
    menu,
    gameLoop.

menu:-
    printMenu,
    readOption.

% placement
play(Board, Piece-Color, 0-0, NewColNum-NewRowNum, NewBoard):-
    getPossiblePlaces(Board, Piece-Color, PossibleMoves),
    (
        % either move is valid
        (
            trace,
            member(NewColNum-NewRowNum, PossibleMoves),
            placePiece(Board, Piece-Color, NewColNum-NewRowNum, NewBoard),
            notrace
        );
        % or try again
        (
            write('ERROR: Invalid move'), nl,
            readGameInput(Board, NewPiece, NewNewColNum-NewNewRowNum),
            getCellCoords(Board, NewOldColNum-NewOldRowNum, NewPiece-Color),
            play(Board, NewPiece-Color, NewOldColNum-NewOldRowNum, NewNewColNum-NewNewRowNum, NewBoard)
        )
    ).

% placing pawn gives you an extra move

% movement
play(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard):-
    getPossibleMoves(Board, Piece-Color, PossibleMoves),
    (
        % either move is valid
        (
            trace,
            member(NewColNum-NewRowNum, PossibleMoves),
            movePiece(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard),
            notrace,
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
    nl, write('-------- COMPUTER WHITE --------'), nl, nl,
    makeRandomPlay(Board, Piece-white, OldColNum-OldRowNum, NewColNum-NewRowNum),
    play(Board, Piece-white, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard).

blackPlayerTurn(Board, person, NewBoard):-
    nl, write('-------- PLAYER BLACK --------'), nl, nl,
    readGameInput(Board, Piece, NewColNum-NewRowNum),
    getCellCoords(Board, OldColNum-OldRowNum, Piece-black),
    play(Board, Piece-black, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard),
    printBoard(NewBoard).

blackPlayerTurn(Board, computer, NewBoard):-
    nl, write('-------- COMPUTER BLACK --------'), nl, nl,
    makeRandomPlay(Board, Piece-black, OldColNum-OldRowNum, NewColNum-NewRowNum),
    play(Board, Piece-black, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard).


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


/*
test:-
    play(
            [
                [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty],
                [empty-empty, empty-empty, empty-empty, bishop-black, empty-empty],
                [empty-empty, tower-black, king-black, tower-white, empty-empty],
                [empty-empty, empty-empty, king-white, empty-empty, empty-empty],
                [empty-empty, queen-white, horse-white, empty-empty, empty-empty],
                [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]
            ],
            tower-black,
            2-3,
            2-1,
            NB
    ),
    printBoard(NB).
*/
