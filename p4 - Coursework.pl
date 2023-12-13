main(N):-
    x_generator4(N).

generator4(N):-
    gen_run([1,2,3,4,5,6,7,8,9,0],N).


remove_subset([], List, List).

remove_subset([SubsetH|SubsetT], List, Result) :-
    select(SubsetH, List, UpdatedList),
    remove_subset(SubsetT, UpdatedList, Result).


gen_run([],[]).
gen_run(Digits,[Prime|More]):-
    gen_primes(Digits,Prime),
    remove_subset(Prime,Digits,NewDigits),
    gen_run(NewDigits, More).
    

% Works
gen_primes(Digits,List):-
    all_combos(Digits,Combos),
    perm(Combos,Perm),
    leading_zero(Perm),
    reverse(Perm,Reverse),
    list_to_number(Reverse,Num),
    is_prime(Num),
    digits(Num,List).

%works
digits(N , [N]):-
    N < 10.
% works
digits(N, W):-
    N >= 10,
    div_mod(N, 10, D, M),
    digits(D, R),
    append(R, [M], W).
%works
div_mod(A, B, D, M):-
    D is A div B,
    M is A mod B.

leading_zero([]).
leading_zero([X|_]):-
    X \= 0.

% Output is in reverese order
list_to_number([], 0).
list_to_number([D|Digits], Num):- 
    list_to_number(Digits, RestNum), 
    Num is RestNum * 10 + D.

% Works
is_prime(2).
is_prime(3).
is_prime(P):- 
    P > 3, P mod 2 =\= 0,
    \+ has_factor(P, 3).
% Works
has_factor(N, F):- N mod F =:= 0.
has_factor(N, F):- 
    F * F < N, 
    F2 is F + 2, 
    has_factor(N, F2).
    
% Works
perm([], []).
perm(List, [X|Perm]) :-
    select(X, List, Rest),
    perm(Rest, Perm).

% Works
combo_of_size(_, 0, []).
combo_of_size(List, S, Combo) :-
    S > 0,
    S =< 4, 
    append(_, [H|T], List),
    S1 is S - 1,
    combo_of_size(T, S1, SubCombo),
    Combo = [H|SubCombo].

all_combos(D,L):-
    between(1, 4, S), 
    combo_of_size(D, S, L).


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
x_generator4_loop( [ _ | TS ] , C , N ):-
	x_generator4_loop( TS , C , N ).
