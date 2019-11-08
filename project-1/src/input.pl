:-include('utils.pl').

%---------------------------------------------------%
%------------------ MENU OPTIONS -------------------%
%---------------------------------------------------%

readOption.

validateOption.

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


