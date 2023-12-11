main(N):-
    x_generator4(N).

% Check if a number is prime
is_prime(2):- !.
is_prime(3):- !.
is_prime(N):-
    integer(N),
    N > 3,
    N mod 2 =\= 0,
    \+ has_factor(N, 3).

% Helper predicate to check if a number has a factor
has_factor(N, Factor) :-
    N mod Factor =:= 0.
has_factor(N, Factor) :-
    Factor * Factor < N,
    NextFactor is Factor + 2,
    has_factor(N, NextFactor).

% Generate arrangements of the digits that form prime numbers
arrangements(Digits, Result) :-
    generate_combinations(Digits, Combos),
    permutation(Combos, Perm),
    check_prime_runs(Perm, Result).

% Check if runs of digits form prime numbers
check_prime_runs([], []).
check_prime_runs([H | T], [Run | Rest]) :-
    run_from_list([H | T], Run, Remaining),
    is_prime_list(Run),
    check_prime_runs(Remaining, Rest).

% Extract a run of digits from the list
run_from_list([], [], []).
run_from_list([H | T], [H | Run], Remaining) :-
    run_from_list(T, Run, Remaining).
run_from_list([H1, H2 | T], [H1], [H2 | T]):- H1 =\= H2.

% Check if all numbers in the list form prime numbers
is_prime_list([]).
is_prime_list([H | T]) :-
    is_prime(H),
    is_prime_list(T).

% Base case: removing elements from an empty list results in an empty list
leading_zeros([], _, []).

% If the element to be removed is the head of the list, skip it and recurse on the tail
leading_zeros([X|Tail], X, Result) :-
    leading_zeros(Tail, X, Result).

% If the element to be removed is not the head, keep the head and recurse on the tail
leading_zeros([Head|Tail], X, [Head|Result]) :-
    dif(Head, X), 
    leading_zeros(Tail, X, Result).

% Generate prime arrangements
generator4(Result) :-
    Digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    arrangements(Digits, Result).
% Generate Combinations
combinations(_, 0, []).
combinations([X|Xs], N, [X|Ys]) :-
    N > 0,
    N1 is N - 1,
    combinations(Xs, N1, Ys).
combinations([_|Xs], N, Ys) :-
    N > 0,
    combinations(Xs, N, Ys).

% Helper predicate for generating combinations of different lengths
generate_combinations(List, Result) :-
    between(1, 4, Length),
    combinations(List, Length, Result).

list_to_number([], 0).
list_to_number([D|Digits], Num):- 
    list_to_number(Digits, RestNum), Num is D + RestNum * 10.


% Works
prime(2).
prime(3).
prime(P):- 
    P > 3, P mod 2 =\= 0,
    \+ hasFactor(P, 3).
% Works
hasFactor(N, F):- N mod F =:= 0.
hasFactor(N, F):- 
    F * F < N, 
    F2 is F + 2, 
    hasFactor(N, F2).

tester4(XS):- 
    % remove smallest prime
    % Decending order
    % Validate the set
    discard_smallest_prime(XS, Discarded), 
    descending_order(Discarded, Desc), 
    validSet(Desc).

discard_smallest_prime([[_|T]|Rest], [T|Rest]).
descending_order(List, Desc):- 
    flatten(List, Flat), 
    reverse(Flat, Desc).

validSet([]).
validSet([H|T]):- 
    isCube(H), 
    validSet(T).

% Works
isCube(N):- 
    N >= 0, 
    X is round(N^(1/3)), 
    N =:= X*X*X.

x_generator4(N):-
	x_generator4_loop(
        [ [[9 ,6 ,7] ,[4 ,0 ,1] ,[2 ,8 ,3] ,[5]]
        , [[9 ,8 ,3] ,[6 ,0 ,1] ,[5] ,[4 ,7] ,[2]]
        , [[9 ,8 ,3] ,[6 ,7] ,[4 ,2 ,0 ,1] ,[5]]
        , [[9 ,8 ,5 ,1] ,[2] ,[4 ,3] ,[6 ,0 ,7]]
        , [[9 ,8 ,5 ,1] ,[2] ,[3] ,[6 ,0 ,4 ,7]]
        , [[9 ,8 ,5 ,1] ,[2] ,[7] ,[4 ,6 ,0 ,3]]
        , [[8 ,9] ,[7] ,[6 ,0 ,1] ,[2 ,5 ,4 ,3]]
        , [[8 ,9] ,[7] ,[5 ,6 ,3] ,[4 ,0 ,2 ,1]]
        , [[8 ,9] ,[5] ,[4 ,7] ,[6 ,0 ,1] ,[3] ,[2]]
        , [[3] ,[5] ,[6 ,0 ,7] ,[2] ,[4 ,1] ,[8 ,9]] ] , 0 , N ).

x_generator4_loop( [] , C , C ).
x_generator4_loop( [ T | TS ] , C , N ):-
  generator4( T ),
  C1 is C + 1 ,
  x_generator4_loop( TS , C1 , N ).
x_generator4_loop( [ _ | TS ] , C , N ) :-
	x_generator4_loop( TS , C , N ).

x_tester4( N ):-
  x_tester4_loop(
    [ [[8 ,2 ,7] ,[6 ,1] ,[5 ,3] ,[4 ,0 ,9]]
    , [[8 ,2 ,7] ,[6 ,1] ,[4 ,0 ,9] ,[5 ,3]]
    , [[8 ,2 ,7] ,[5 ,3] ,[6 ,1] ,[4 ,0 ,9]]
    , [[8 ,2 ,7] ,[4 ,0 ,9] ,[6 ,1] ,[5 ,3]]
    , [[6 ,1] ,[8 ,2 ,7] ,[4 ,0 ,9] ,[5 ,3]]
    , [[6 ,1] ,[4 ,0 ,9] ,[5 ,3] ,[8 ,2 ,7]]
    , [[5 ,3] ,[6 ,1] ,[4 ,0 ,9] ,[8 ,2 ,7]]
    , [[5 ,3] ,[4 ,0 ,9] ,[6 ,1] ,[8 ,2 ,7]]
    , [[4 ,0 ,9] ,[5 ,3] ,[8 ,2 ,7] ,[6 ,1]]
    , [[4 ,0 ,9] ,[8 ,2 ,7] ,[6 ,1] ,[5 ,3]] ] , 0 , N ).

x_tester4_loop( [] , C , C ).
x_tester4_loop( [ T | TS ] , C , N ):-
  	tester4( T ) ,
  	C1 is C + 1 ,
	x_tester4_loop( TS , C1 , N ).
x_tester4_loop( [ _ | TS ] , C , N ):-
	x_tester4_loop( TS , C , N ).
