:- use_module(library(lists)).

% translate board atoms into chars
translate(empty, '.').
translate(close, 'C').
translate(far, 'F').

