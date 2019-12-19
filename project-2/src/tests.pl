:-consult('constraints.pl').

% =================================================================
% Testing Purposes
% =================================================================
solve_line(Line):-
    % --- DECISION VARIABLES ---
    % length is already defined by Line
    domain(Line, 0, 2),
    % --- RESTRICTIONS ---
    % ==== 2 occurences of 1 (close) and 2 occurences of 2 (far)
    count(1, Line, #=, 2), count(2, Line, #=, 2),
    % ==== remaining elements are all 0's (empty)
    % get number of cells
    length(Line, NumberOfCells),
    % get number of 0's (number of cells - (number of 1's + number of 2's))
    NumberOfZeros #= NumberOfCells - 4,
    % apply restriction
    count(0, Line, #=, NumberOfZeros),
    % ==== distance between 1's (close) is smaller than 2's (far) in each line
    % get distance between 1's (close)
    get_distance_between_elements(Line, 1, CloseDistance),
    % get distance between 2's (far)
    get_distance_between_elements(Line, 2, FarDistance),
    % apply MAIN restriction
    CloseDistance #< FarDistance,
    % --- LABELING ---
    labeling([], Line).

test_board:-
    puzzle_1(Board),
    solve_line(Board),
    write(Board).

test_line:-
    Line = [2, _, _, _, _, _],
    solve_line(Line),
    write(Line).
