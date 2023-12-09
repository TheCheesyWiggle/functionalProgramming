main(N):-
    x_generator4(N).

generator4(X) :-
    X = [0,1,2,3,4,5,6,7,8,9],
    % generate combinations up to 4 digits
    
    % generate permutations
    
    % Remove leading zeros
    
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

% Works
prime(2).
prime(3).
prime(P):- 
    P > 3, P mod 2 =\= 0,
    \+ hasFactor(P, 3).

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
