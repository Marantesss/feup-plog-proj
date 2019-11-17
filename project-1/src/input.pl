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

readOption(Option):-
    write('> Insert your option: '),
    read(ReadOption),
    (
        % option is valid
        (
            validateOption(ReadOption),
            Option = ReadOption
        );
        % or try again
        (
            write('ERROR: Please enter option again.'), nl,
            readOption(Option)  
        )
    ).

validateOption(1). % Player vs Player
validateOption(2). % Player vs Computer
validateOption(3). % Computer vs Player
validateOption(4). % Computer vs Computer
validateOption(0). % Exit

%---------------------------------------------------%
%---------------- PLAYER MOVEMENTS -----------------%
%---------------------------------------------------%

% --- Pieces --- %

readPiece(Piece):-
    write('> Piece Name: '),
    read(ReadPiece),
    (
        % piece is valid
        (
            validPiece(ReadPiece),
            Piece = ReadPiece
        );
        % or try again
        (
            write('ERROR: Please enter Piece name again.'), nl,
            readPiece(Piece)  
        )
    ).

% --- Columns --- %

readCol(Board, ColNum):-
    write('> Column Number: '),
    read(ReadColNum),
    (
        % col is valid
        (
            validateColNum(Board, ReadColNum),
            ColNum = ReadColNum
        );
        % or try again
        (
            write('ERROR: Please enter Column number again.'), nl,
            readCol(Board, ColNum)
        )
    ).

validateColNum([Row | Board], ColNum):-
    length(Row, RowLenght),
    between(1, RowLenght, ColNum).

% --- Rows --- %

readRow(Board, RowNum):-
    write('> Row letter: '),
    read(RowLet),
    (
        % row is valid
        (
            validateRowNum(Board, RowLet, ReadRowNum),
            RowNum = ReadRowNum
        );
        % or try again
        (
            write('ERROR: Please enter Row letter again.'), nl,
            readRow(Board, RowNum)
        )
    ).

validateRowNum(Board, RowLet, RowNum):-
    letter(RowNum, RowLet),
    length(Board, ColLenght),
    between(1, ColLenght, RowNum).
    
