isPrime(2).
isPrime(3).
isPrime(N):-
    N > 3, N mod 2 =\= 0,
    \+ has_factor(N, 3).

has_factor(N, F) :- 
    N mod F =:= 0.
has_factor(N, F) :- 
    F * F < N, 
    NF is F + 2, 
    has_factor(N, NF).
