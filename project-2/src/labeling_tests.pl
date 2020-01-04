:- consult('solver.pl').
:- consult('puzzles.pl').

% ==================================================
% Testing Purposes
% See puzzles in file 'puzzles.pl'
% ==================================================
test_solver_6:-
    puzzle_6_1(Board1),
    solve_puzzle(Board1, Runtime1),
    format(' > Puzzle 1 solver runtime: ~3d s~n', [Runtime1]),
    puzzle_6_2(Board2),
    solve_puzzle(Board2, Runtime2),
    format(' > Puzzle 2 solver runtime: ~3d s~n', [Runtime2]),
    puzzle_6_3(Board3),
    solve_puzzle(Board3, Runtime3),
    format(' > Puzzle 3 solver runtime: ~3d s~n', [Runtime3]),
    puzzle_6_4(Board4),
    solve_puzzle(Board4, Runtime4),
    format(' > Puzzle 4 solver runtime: ~3d s~n', [Runtime4]),
    puzzle_6_5(Board5),
    solve_puzzle(Board5, Runtime5),
    format(' > Puzzle 5 solver runtime: ~3d s~n', [Runtime5]),
    puzzle_6_6(Board6),
    solve_puzzle(Board6, Runtime6),
    format(' > Puzzle 6 solver runtime: ~3d s~n', [Runtime6]),
    puzzle_6_7(Board7),
    solve_puzzle(Board7, Runtime7),
    format(' > Puzzle 7 solver runtime: ~3d s~n', [Runtime7]),
    puzzle_6_8(Board8),
    solve_puzzle(Board8, Runtime8),
    format(' > Puzzle 8 solver runtime: ~3d s~n', [Runtime8]),
    puzzle_6_9(Board9),
    solve_puzzle(Board9, Runtime9),
    format(' > Puzzle 9 solver runtime: ~3d s~n', [Runtime9]),
    puzzle_6_10(Board10),
    solve_puzzle(Board10, Runtime10),
    format(' > Puzzle 10 solver runtime: ~3d s~n', [Runtime10]),
    AvgRuntime is (Runtime1 + Runtime2 + Runtime3 + Runtime4 + Runtime5 + Runtime6 + Runtime7 + Runtime8 + Runtime9 + Runtime10) / 10,
    format(' > Average runtime: ~3d s~n', [AvgRuntime]).

test_solver_7:-
    puzzle_7_1(Board1),
    solve_puzzle(Board1, Runtime1),
    format(' > Puzzle 1 solver runtime: ~3d s~n', [Runtime1]),
    puzzle_7_2(Board2),
    solve_puzzle(Board2, Runtime2),
    format(' > Puzzle 2 solver runtime: ~3d s~n', [Runtime2]),
    puzzle_7_3(Board3),
    solve_puzzle(Board3, Runtime3),
    format(' > Puzzle 3 solver runtime: ~3d s~n', [Runtime3]),
    puzzle_7_4(Board4),
    solve_puzzle(Board4, Runtime4),
    format(' > Puzzle 4 solver runtime: ~3d s~n', [Runtime4]),
    puzzle_7_5(Board5),
    solve_puzzle(Board5, Runtime5),
    format(' > Puzzle 5 solver runtime: ~3d s~n', [Runtime5]),
    puzzle_7_6(Board6),
    solve_puzzle(Board6, Runtime6),
    format(' > Puzzle 6 solver runtime: ~3d s~n', [Runtime6]),
    puzzle_7_7(Board7),
    solve_puzzle(Board7, Runtime7),
    format(' > Puzzle 7 solver runtime: ~3d s~n', [Runtime7]),
    puzzle_7_8(Board8),
    solve_puzzle(Board8, Runtime8),
    format(' > Puzzle 8 solver runtime: ~3d s~n', [Runtime8]),
    puzzle_7_9(Board9),
    solve_puzzle(Board9, Runtime9),
    format(' > Puzzle 9 solver runtime: ~3d s~n', [Runtime9]),
    puzzle_7_10(Board10),
    solve_puzzle(Board10, Runtime10),
    format(' > Puzzle 10 solver runtime: ~3d s~n', [Runtime10]),
    AvgRuntime is (Runtime1 + Runtime2 + Runtime3 + Runtime4 + Runtime5 + Runtime6 + Runtime7 + Runtime8 + Runtime9 + Runtime10) / 10,
    format(' > Average runtime: ~3d s~n', [AvgRuntime]).

test_solver_8:-
    puzzle_8_1(Board1),
    solve_puzzle(Board1, Runtime1),
    format(' > Puzzle 1 solver runtime: ~3d s~n', [Runtime1]),
    puzzle_8_2(Board2),
    solve_puzzle(Board2, Runtime2),
    format(' > Puzzle 2 solver runtime: ~3d s~n', [Runtime2]),
    puzzle_8_3(Board3),
    solve_puzzle(Board3, Runtime3),
    format(' > Puzzle 3 solver runtime: ~3d s~n', [Runtime3]),
    puzzle_8_4(Board4),
    solve_puzzle(Board4, Runtime4),
    format(' > Puzzle 4 solver runtime: ~3d s~n', [Runtime4]),
    puzzle_8_5(Board5),
    solve_puzzle(Board5, Runtime5),
    format(' > Puzzle 5 solver runtime: ~3d s~n', [Runtime5]),
    puzzle_8_6(Board6),
    solve_puzzle(Board6, Runtime6),
    format(' > Puzzle 6 solver runtime: ~3d s~n', [Runtime6]),
    puzzle_8_7(Board7),
    solve_puzzle(Board7, Runtime7),
    format(' > Puzzle 7 solver runtime: ~3d s~n', [Runtime7]),
    puzzle_8_8(Board8),
    solve_puzzle(Board8, Runtime8),
    format(' > Puzzle 8 solver runtime: ~3d s~n', [Runtime8]),
    puzzle_8_9(Board9),
    solve_puzzle(Board9, Runtime9),
    format(' > Puzzle 9 solver runtime: ~3d s~n', [Runtime9]),
    puzzle_8_10(Board10),
    solve_puzzle(Board10, Runtime10),
    format(' > Puzzle 10 solver runtime: ~3d s~n', [Runtime10]),
    AvgRuntime is (Runtime1 + Runtime2 + Runtime3 + Runtime4 + Runtime5 + Runtime6 + Runtime7 + Runtime8 + Runtime9 + Runtime10) / 10,
    format(' > Average runtime: ~3d s~n', [AvgRuntime]).

test_solver_9:-
    puzzle_9_1(Board1),
    solve_puzzle(Board1, Runtime1),
    format(' > Puzzle 1 solver runtime: ~3d s~n', [Runtime1]),
    puzzle_9_2(Board2),
    solve_puzzle(Board2, Runtime2),
    format(' > Puzzle 2 solver runtime: ~3d s~n', [Runtime2]),
    puzzle_9_3(Board3),
    solve_puzzle(Board3, Runtime3),
    format(' > Puzzle 3 solver runtime: ~3d s~n', [Runtime3]),
    puzzle_9_4(Board4),
    solve_puzzle(Board4, Runtime4),
    format(' > Puzzle 4 solver runtime: ~3d s~n', [Runtime4]),
    puzzle_9_5(Board5),
    solve_puzzle(Board5, Runtime5),
    format(' > Puzzle 5 solver runtime: ~3d s~n', [Runtime5]),
    puzzle_9_6(Board6),
    solve_puzzle(Board6, Runtime6),
    format(' > Puzzle 6 solver runtime: ~3d s~n', [Runtime6]),
    puzzle_9_7(Board7),
    solve_puzzle(Board7, Runtime7),
    format(' > Puzzle 7 solver runtime: ~3d s~n', [Runtime7]),
    puzzle_9_8(Board8),
    solve_puzzle(Board8, Runtime8),
    format(' > Puzzle 8 solver runtime: ~3d s~n', [Runtime8]),
    puzzle_9_9(Board9),
    solve_puzzle(Board9, Runtime9),
    format(' > Puzzle 9 solver runtime: ~3d s~n', [Runtime9]),
    puzzle_9_10(Board10),
    solve_puzzle(Board10, Runtime10),
    format(' > Puzzle 10 solver runtime: ~3d s~n', [Runtime10]),
    AvgRuntime is (Runtime1 + Runtime2 + Runtime3 + Runtime4 + Runtime5 + Runtime6 + Runtime7 + Runtime8 + Runtime9 + Runtime10) / 10,
    format(' > Average runtime: ~3d s~n', [AvgRuntime]).

test_solver_10:-
    puzzle_10_1(Board1),
    solve_puzzle(Board1, Runtime1),
    format(' > Puzzle 1 solver runtime: ~3d s~n', [Runtime1]),
    puzzle_10_2(Board2),
    solve_puzzle(Board2, Runtime2),
    format(' > Puzzle 2 solver runtime: ~3d s~n', [Runtime2]),
    puzzle_10_3(Board3),
    solve_puzzle(Board3, Runtime3),
    format(' > Puzzle 3 solver runtime: ~3d s~n', [Runtime3]),
    puzzle_10_4(Board4),
    solve_puzzle(Board4, Runtime4),
    format(' > Puzzle 4 solver runtime: ~3d s~n', [Runtime4]),
    puzzle_10_5(Board5),
    solve_puzzle(Board5, Runtime5),
    format(' > Puzzle 5 solver runtime: ~3d s~n', [Runtime5]),
    puzzle_10_6(Board6),
    solve_puzzle(Board6, Runtime6),
    format(' > Puzzle 6 solver runtime: ~3d s~n', [Runtime6]),
    puzzle_10_7(Board7),
    solve_puzzle(Board7, Runtime7),
    format(' > Puzzle 7 solver runtime: ~3d s~n', [Runtime7]),
    puzzle_10_8(Board8),
    solve_puzzle(Board8, Runtime8),
    format(' > Puzzle 8 solver runtime: ~3d s~n', [Runtime8]),
    puzzle_10_9(Board9),
    solve_puzzle(Board9, Runtime9),
    format(' > Puzzle 9 solver runtime: ~3d s~n', [Runtime9]),
    puzzle_10_10(Board10),
    solve_puzzle(Board10, Runtime10),
    format(' > Puzzle 10 solver runtime: ~3d s~n', [Runtime10]),
    AvgRuntime is (Runtime1 + Runtime2 + Runtime3 + Runtime4 + Runtime5 + Runtime6 + Runtime7 + Runtime8 + Runtime9 + Runtime10) / 10,
    format(' > Average runtime: ~3d s~n', [AvgRuntime]).

