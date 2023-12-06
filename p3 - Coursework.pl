generator3(N):-
    between(1000, 1000000, N),
    X is integer(sqrt(N)),
    N is X * X.

tester3():-
    
    
x_generator3(N) :-
  	x_generator3_loop(
        [ 1024 , 9409 , 23716 , 51529
    	, 123904 , 185761 , 868624 , 962361
    	, 982081 , 1000000 ] , 0 , N ).

x_generator3_loop( [] , C , C ) .
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
