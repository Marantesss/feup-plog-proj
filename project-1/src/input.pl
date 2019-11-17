:-consult('utils.pl').

%---------------------------------------------------%
%------------------ GAME OPTIONS -------------------%
%---------------------------------------------------%

readGameInput(Board, Piece, ColNum-RowNum):-
    readPiece(Piece),
    readCol(Board, ColNum),
    readRow(Board, RowNum).
/*
test:-
    readGameInput(
        [
            [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty],
            [empty-empty, empty-empty, empty-empty, bishop-black, empty-empty],
            [empty-empty, tower-black, king-black, tower-white, empty-empty],
            [empty-empty, empty-empty, king-white, empty-empty, empty-empty],
            [empty-empty, queen-white, horse-white, empty-empty, empty-empty],
            [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]
        ],
        Piece, ColNum, RowNum
    ),
    write(Piece), nl,
    write(ColNum), nl,
    write(RowNum), nl.
*/

%---------------------------------------------------%
%------------------ MENU OPTIONS -------------------%
%---------------------------------------------------%

readOption:-
    write('> Insert your option: '),
    read(Input),
    validateOption(Input).

validateOption(1) :-
    write('Player vs Player'), nl,
    readOption.
    /*
    startGame('C','C'),
    mainMenu.
    */

validateOption(2) :-
    write('Player vs PC'), nl,
    readOption.
    /*
    startGame('C','C'),
    mainMenu.
    */

validateOption(3) :-
    write('PC vs PC'), nl,
    readOption.
    /*
    startGame('C','C'),
    mainMenu.
    */
    
validateOption(0) :-
    nl,
    write('Exiting...'),
    nl, nl.

validateOption(_Other) :-
    nl,
    write('ERROR: that option does not exist.'),
    nl, nl,
    readOption.

%---------------------------------------------------%
%---------------- PLAYER MOVEMENTS -----------------%
%---------------------------------------------------%

% --- Pieces --- %

readPiece(Piece):-
    write('> Piece Name: '),
    read(Piece),
    validatePiece(Piece).

validatePiece(pawn).
validatePiece(king).
validatePiece(queen).
validatePiece(horse).
validatePiece(bishop).
validatePiece(tower).
validatePiece(Piece):-
    write('ERROR: Please enter Piece name again.'), nl,
    readPiece(Piece). % Reads piece again when user input fails



% --- Columns --- %

readCol(Board, ColNum):-
    write('> Column Number: '),
    read(ColNum),
    validateColNum(Board, ColNum).

validateColNum([Row | Board], ColNum):-
    ColNum > 0,
    length(Row, RowLenght),
    ColNum =< RowLenght.

validateColNum(Board, ColNum):-
    write('ERROR: Please enter Column number again.'), nl,
    readCol(Board, ColNum). % Reads col again when user input fails

% --- Rows --- %

readRow(Board, RowNum):-
    write('> Row letter: '),
    read(RowLet),
    validateRowNum(Board, RowLet, RowNum).

validateRowNum(Board, RowLet, RowNum):-
    letter(RowNum, RowLet),
    RowNum > 0,
    length(Board, ColLenght),
    RowNum =< ColLenght.

validateRowNum(Board, RowLet, RowNum):-
    write('ERROR: Please enter Row letter again.'), nl,
    readRow(Board, RowNum). % Reads row again when user input fails
    