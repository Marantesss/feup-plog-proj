:-include('utils.pl').

%---------------------------------------------------%
%------------------ MENU OPTIONS -------------------%
%---------------------------------------------------%

readOption.

%---------------------------------------------------%
%---------------- PLAYER MOVEMENTS -----------------%
%---------------------------------------------------%

% --- Columns and Rows --- %

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
    readRow(Board, ColNum).

readRow(Board, RowNum):-
    write('> Row letter: '),
    read(RowLet),
    letter(RowNum, RowLet)
    validateColNum(Board, RowNum).

validateRowNum(Board, RowNum):-
    RowNum > 0,
    length(Board, ColLenght),
    RowNum =< RowLenght.

validateRowNum(Board, RowNum):-
    write('ERROR: Please enter Row letter again.'), nl,
    readRow(Board, RowNum).


