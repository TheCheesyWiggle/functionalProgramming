main(N):-
    x_generator4(N).

generator4(X) :-
    X1 = [0,1,2,3,4,5,6,7,8,9],
    % generate combinations up to 4 digits
    combosOfSize([1,2,3,4,5,6,7,8,9,0],2,X2),
    combosOfSize([1,2,3,4,5,6,7,8,9,0],2,X3),
    combosOfSize([1,2,3,4,5,6,7,8,9,0],2,X4),
    % generate permutations (not necessary to gen for X1)
    perm(X2, PX2),
    perm(X3, PX3),
    perm(X4, PX4),
    % Remove leading zeros
    leadingZeros(X1,ZerosX1),
    leadingZeros(PX2,ZerosX2),
    leadingZeros(PX3,ZerosX3),
    leadingZeros(PX4,ZerosX4),
    flatten([ZerosX1, ZerosX2, ZerosX3, ZerosX4], X),
    % Filter primes
    validPrimeSet(X).

validPrimeSet([]).
validPrimeSet([H|T]):- 
    list_to_number(H, Num), 
    prime(Num), 
    validPrimeSet(T).

list_to_number([], 0).
list_to_number([D|Digits], Num):- 
    list_to_number(Digits, RestNum), Num is D + RestNum * 10.

leadingZeros([H|T], [H|T_no_zeros]):-
    H \= 0,
    T_no_zeros = T.
leadingZeros([0|T], T_no_zeros):-
    (T, T_no_zeros).
    

% Works
combos([], []).
combos([Head|Tail], [Head|Combo]) :-
    combos(Tail, Combo).
combos([_|Tail], Combo) :-
    combos(Tail, Combo).

% Works
perm([], []).
perm(List, [X|Perm]) :-
    select(X, List, Rest),
    perm(Rest, Perm).

% Works
%concat([], List2, List3, List4, Result) :-
%    concat(List2, List3, List4, Result).
%concat([Head|Tail1], List2, List3, List4, [Head|Result]) :-
%    concat(Tail1, List2, List3, List4, Result).

%concat([], List3, List4, Result) :-
%    concat(List3, List4, Result).
%concat([Head|Tail1], List3, List4, [Head|Result]) :-
%    concat(Tail1, List3, List4, Result).

%concat([], List2, Result) :- Result = List2.
%concat([Head|Tail1], List2, [Head|Result]) :-
%    concat(Tail1, List2, Result).

% Works
combosOfSize(_, 0, []).
combosOfSize(List, Size, Combo) :-
    Size > 0,
    Size =< 4, 
    append(_, [Head|Tail], List),
    Size1 is Size - 1,
    combosOfSize(Tail, Size1, SubCombo),
    Combo = [Head|SubCombo].

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
    discard_smallest_prime(XS, Discarded), 
    descending_order(Discarded, Desc), 
    valiSet(Desc).

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
