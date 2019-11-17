:-consult('board_examples.pl').
:-consult('display.pl').
:-consult('pieces.pl').
:-consult('rules.pl').
:-consult('input.pl').
:-consult('bot.pl').

echek:-
    menu(Option),
    startGame(Option).

menu(Option):-
    printMenu,
    readOption(Option).

startGame(1):-
    initialBoard(InitBoard),
    printBoard(InitBoard),
    gameLoop(InitBoard, player, player).

startGame(2):-
    initialBoard(InitBoard),
    printBoard(InitBoard),
    gameLoop(InitBoard, player, computer).

startGame(3):-
    initialBoard(InitBoard),
    printBoard(InitBoard),
    gameLoop(InitBoard, computer, player).

startGame(4):-
    initialBoard(InitBoard),
    printBoard(InitBoard),
    gameLoop(InitBoard, computer, computer).

startGame(0).


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

% placement
move(Board, Piece-Color, 0-0, NewColNum-NewRowNum, NewBoard):-
    getPossiblePlaces(Board, Piece-Color, PossibleMoves),
    (
        % either move is valid
        (
            %trace,
            member(NewColNum-NewRowNum, PossibleMoves),
            placePiece(Board, Piece-Color, NewColNum-NewRowNum, NewBoard)
            %notrace
        );
        % or try again
        (
            write('ERROR: Invalid move'), nl,
            readGameInput(Board, NewPiece, NewNewColNum-NewNewRowNum),
            getCellCoords(Board, NewOldColNum-NewOldRowNum, NewPiece-Color),
            move(Board, NewPiece-Color, NewOldColNum-NewOldRowNum, NewNewColNum-NewNewRowNum, NewBoard)
        )
    ).

% placing pawn gives you an extra move

% movement
move(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard):-
    getPossibleMoves(Board, Piece-Color, PossibleMoves),
    (
        % either move is valid
        (
            member(NewColNum-NewRowNum, PossibleMoves),
            movePiece(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard),
        );
        % or try again
        (
            write('ERROR: Invalid move'), nl,
            readGameInput(Board, NewPiece, NewNewColNum-NewNewRowNum),
            getCellCoords(Board, NewOldColNum-NewOldRowNum, NewPiece-Color),
            move(Board, NewPiece-Color, NewOldColNum-NewOldRowNum, NewNewColNum-NewNewRowNum, NewBoard)
        )
    ).

whitePlayerTurn(Board, player, NewBoard):-
    nl, write('-------- PLAYER WHITE --------'), nl, nl,
    readGameInput(Board, Piece, NewColNum-NewRowNum),
    getCellCoords(Board, OldColNum-OldRowNum, Piece-white),
    move(Board, Piece-white, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard),
    printBoard(NewBoard).

whitePlayerTurn(Board, computer, NewBoard):-
    nl, write('-------- COMPUTER WHITE --------'), nl, nl,
    choose_move(Board, 0, Piece-white, OldColNum-OldRowNum, NewColNum-NewRowNum),
    move(Board, Piece-white, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard),
    printBoard(NewBoard).

blackPlayerTurn(Board, player, NewBoard):-
    nl, write('-------- PLAYER BLACK --------'), nl, nl,
    readGameInput(Board, Piece, NewColNum-NewRowNum),
    getCellCoords(Board, OldColNum-OldRowNum, Piece-black),
    move(Board, Piece-black, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard),
    printBoard(NewBoard).

blackPlayerTurn(Board, computer, NewBoard):-
    nl, write('-------- COMPUTER BLACK --------'), nl, nl,
    choose_move(Board, 0, Piece-black, OldColNum-OldRowNum, NewColNum-NewRowNum),
    move(Board, Piece-black, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard),
    printBoard(NewBoard).


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
