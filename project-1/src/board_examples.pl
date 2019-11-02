:-use_module(library(lists)).

initialBoard([
    [empty-empty, empty-empty, empty-empty],
    [empty-empty, king-black, empty-empty],
    [empty-empty, king-white, empty-empty],
    [empty-empty, empty-empty, empty-empty]
]).

intermediateBoard([
    [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty],
    [empty-empty, empty-empty, empty-empty, bishop-black, empty-empty],
    [empty-empty, tower-black, king-black, tower-white, empty-empty],
    [empty-empty, empty-empty, king-white, empty-empty, empty-empty],
    [empty-empty, queen-white, horse-black, empty-empty, empty-empty],
    [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]
]).

finalBoard([
    [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty, empty-empty],
    [empty-empty, empty-empty, queen-black, empty-empty, empty-empty, empty-empty],
    [empty-empty, tower-black, king-black, tower-white, bishop-black, empty-empty],
    [empty-empty, empty-empty, king-white, empty-empty, empty-empty, empty-empty],
    [empty-empty, queen-white, horse-black, horse-white, empty-empty, empty-empty],
    [empty-empty, empty-empty, empty-empty, empty-empty, empty-empty, empty-empty]
]).