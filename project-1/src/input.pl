:-consult('utils.pl').

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
    