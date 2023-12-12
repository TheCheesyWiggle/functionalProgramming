main(N):-
    generator4(N).

generator4(N):-
    gen_primes(S,N).

gen_primes(S,N):-
    D = [9,8,7,6,5,4,3,2,1,0],
    combo_of_size(D,S,C),
    perm(C,P),
    leading_zero(P),
    reverse(P,R),
    list_to_number(R,N),
    is_prime(N)
    
%next_largest_prime
%
% Works
combos([], []).
combos([Head|Tail], [Head|Combo]) :-
    combos(Tail, Combo).
combos([_|Tail], Combo) :-
    combos(Tail, Combo).

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
combo_of_size(List, Size, Combo) :-
    Size > 0,
    Size =< 4, 
    append(_, [Head|Tail], List),
    Size1 is Size - 1,
    combo_of_size(Tail, Size1, SubCombo),
    Combo = [Head|SubCombo].
