main():-
    tester3.

generator3(N):-
    between(1000, 1000000, N),
    X is integer(sqrt(N)),
    N is X * X.

tester3(N):-
   	% Convert the number to a list of digits, Ensure all digits are different
    digits(N,[N1, N2, N3, N4, N5]),
    X1>0, X2>0, X3>0, X4>0, N5>0,
    nodups([N1, N2, N3, N4, N5]),
    % Last digit is equal to the number of digits
    length_list([N1, N2, N3, N4, N5], NumDigits),
    N5 =:= NumDigits,
 
    % Last-but-one digit is odd
    
    % One of the digits is zero
    member(0,[N1, N2, N3, N4, N5]).
    % Second, third, and last-but-one digits are exact multiples of the first digit



digits(N,[N]) :-
    N < 10.

digits(N, W):-
    N >= 10,
    div_mod(N, 10, D, M),
    digits(D, R),
    append(R, [M], W).

digits(N, W):-
    N >= 100,
    div_mod(N, 100, D, M),
    digits(D, R),
    append(R, [M], W).

    
nub([],[]).
nub([X|XS], [X|W]):-
    \+ member(X, XS),
    nub(XS, W).

nub([X|XS],W):-
    member(X, XS),
    nub( XS, W).

length_list( [] , 0 ).
length_list( [ _ | T ] , N ):-
  length_list( T , W ),
  N is W + 1.
    
nodups([],[]).
nodups(X):-
    length_list(X) \= length_list(nub(X)).
    
   
x_generator3(N) :-
  	x_generator3_loop(
        [ 1024 , 9409 , 23716 , 51529
    	, 123904 , 185761 , 868624 , 962361
    	, 982081 , 1000000 ] , 0 , N ).

x_generator3_loop([] , C , C ) .
x_generator3_loop([T|TS], C, N):-
  	generator3(T),
  	C1 is C+1,
	x_generator3_loop(TS, C1, N ).
x_generator3_loop([ _ |TS], C, N ):-
	x_generator3_loop(TS, C, N).

x_tester3( N ):-
x_tester3_loop(
	[ 123056 , 128036 , 139076 , 142076
    , 148056 , 159076 , 173096 , 189036
    , 193056 , 198076 ] , 0 , N ).

x_tester3_loop([], C, C).
x_tester3_loop( [ T | TS ] , C , N ):-
	tester3( T ),
	C1 is C + 1 ,
x_tester3_loop(TS, C1, N).
