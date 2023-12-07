main(N):-
    x_generator3(N).

generator3(N):-
    between(1000, 1000000, N),
    X is integer(sqrt(N)),
    N is X * X.

tester3(N):-
   	% Convert the number to a list of digits, Ensure all digits are different
    digits(N,X),
    nodups(X),
    % Last digit is equal to the number of digits
    length_list(X, Len),
 	elementAtIndex(Len-1, X, Last),
    Last =:= Len,
    % Last-but-one digit is odd
    Z is Len-2,
   	elementAtIndex(Z, X, LastButOne),
    1 =:= LastButOne mod 2,
    % One of the digits is zero
    member(0, X),
    % Second, third, and last-but-one digits are exact multiples of the first digit
	elementAtIndex(1, X, X1),
    0 =:= X1 mod Last,
    elementAtIndex(2, X, X2),
    0 =:= X2 mod Last,
    0 =:= LastButOne mod Last.
    
elementAtIndex(0, [X|_], X).
elementAtIndex(Index, [_|Tail], Element) :-
    Index > 0,
    NewIndex is Index - 1,
    elementAtIndex(NewIndex, Tail, Element).

digits(N , [N]) :-
    N < 10.

digits(N, W):-
    N >= 10,
    div_mod(N, 10, D, M),
    digits(D, R),
    append(R, [M], W).
% works
nub([],[]).
nub([X|XS], [X|W]):-
    \+ member(X, XS),
    nub(XS, W).

nub([X|XS],W):-
    member(X, XS),
    nub( XS, W).

nodups([],[]).
nodups(X):-
    nub(X,Z),
    length_list(X, Len1),
    length_list(Z, Len2),
    Len1 \= Len2.

length_list( [] , 0 ).
length_list( [ _ | T ] , N ):-
  length_list( T , W ),
  N is W + 1.



div_mod(A, B, D, M):-
    D is A div B,
    M is A mod B.

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
