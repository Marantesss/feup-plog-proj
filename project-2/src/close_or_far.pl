:- consult('generator.pl').
:- consult('solver.pl').
:- consult('display.pl').

play(Size):-
    % generate random puzzle with given size
    generate_random_puzzle(Size, PuzzleBoard),
    % print puzzle
    print_board(PuzzleBoard),
    % replace 0's with _
    replace_zeros_matrix(PuzzleBoard, SolutionBoard),
    % solve puzzle
    solve_puzzle(SolutionBoard, SolverRuntime),
    % print solved puzzle
    print_board(SolutionBoard),
    % print runtime
    format(' > Solver runtime: ~3d s~n', [SolverRuntime]).


