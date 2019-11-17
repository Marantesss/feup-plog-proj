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

checkQueensTrapped(Board, NewBoard):-
    checkWhiteQueenTrapped(Board, WhiteBoard),
    checkBlackQueenTrapped(WhiteBoard, NewBoard).

checkWhiteQueenTrapped(Board, NewBoard):-
    isQueenTrapped(Board, white),
    getCellCoords(Board, ColNum-RowNum, queen-white),
    replaceCell(Board, empty-empty, ColNum-RowNum, NewBoard).
checkWhiteQueenTrapped(Board, Board).

checkBlackQueenTrapped(Board, NewBoard):-
    isQueenTrapped(Board, black),
    getCellCoords(Board, ColNum-RowNum, queen-black),
    replaceCell(Board, empty-empty, ColNum-RowNum, NewBoard).
checkBlackQueenTrapped(Board, Board).

game_over(Board, Winner):-
    isKingTrapped(Board, white),
    isKingTrapped(Board, black),
    Winner = draw.

game_over(Board, Winner):-
    isKingTrapped(Board, white),
    Winner = black.

game_over(Board, Winner):-
    isKingTrapped(Board, black),
    Winner = white.

declareGameOver(white):-
    write('Player white wins!'), nl.

declareGameOver(black):-
    write('Player black wins!'), nl.

declareGameOver(draw):-
    write('It is a draw'), nl. 

gameLoop(Board, Player1, Player2):-
    whitePlayerTurn(Board, Player1, NewBoard),
    checkQueensTrapped(NewBoard, NewWhiteBoard), % check if queens need to be removed
    printBoard(NewWhiteBoard),
    (
        % game over
        (
            game_over(NewWhiteBoard, Winner), declareGameOver(Winner)
        );
        % if not, continue playing
        (
            blackPlayerTurn(NewWhiteBoard, Player2, FinalBoard),
            checkQueensTrapped(FinalBoard, FinalBlackBoard), % check if queens need to be removed
            printBoard(FinalBlackBoard),
            (
                % game over
                (
                    game_over(FinalBlackBoard, Winner), declareGameOver(Winner)
                );
                % if not continue playing
                (
                    gameLoop(FinalBlackBoard, Player1, Player2)
                )
            )
        )
    ).

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
move(Board, Piece-Color, 0-0, NewColNum-NewRowNum, NewBoard):-
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
            move(Board, NewPiece-Color, NewOldColNum-NewOldRowNum, NewNewColNum-NewNewRowNum, NewBoard)
        )
    ).

% movement
move(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard):-
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
            move(Board, NewPiece-Color, NewOldColNum-NewOldRowNum, NewNewColNum-NewNewRowNum, NewBoard)
        )
    ).


bot_move(Board, Level, Piece-Color, 0-0, NewColNum-NewRowNum, NewBoard):-
    placePiece(Board, Piece-Color, NewColNum-NewRowNum, NewBoard).

bot_move(Board, Level, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard):-
    movePiece(Board, Piece-Color, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard).

whitePlayerTurn(Board, player, NewBoard):-
    nl, write('-------- PLAYER WHITE --------'), nl, nl,
    readGameInput(Board, Piece, NewColNum-NewRowNum),
    getCellCoords(Board, OldColNum-OldRowNum, Piece-white),
    move(Board, Piece-white, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard).

whitePlayerTurn(Board, computer, NewBoard):-
    nl, write('-------- COMPUTER WHITE --------'), nl, nl,
    sleep(1),
    choose_move(Board, 1, Piece-white, OldColNum-OldRowNum, NewColNum-NewRowNum),
    bot_move(Board, 1, Piece-white, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard).

blackPlayerTurn(Board, player, NewBoard):-
    nl, write('-------- PLAYER BLACK --------'), nl, nl,
    readGameInput(Board, Piece, NewColNum-NewRowNum),
    getCellCoords(Board, OldColNum-OldRowNum, Piece-black),
    move(Board, Piece-black, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard).

blackPlayerTurn(Board, computer, NewBoard):-
    nl, write('-------- COMPUTER BLACK --------'), nl, nl,
    sleep(1),
    choose_move(Board, 1, Piece-black, OldColNum-OldRowNum, NewColNum-NewRowNum),
    bot_move(Board, 1, Piece-black, OldColNum-OldRowNum, NewColNum-NewRowNum, NewBoard).

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