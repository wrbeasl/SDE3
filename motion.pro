/*
CPSC 3520
Spring 2015
Software Development Exercise #3
motion.pro
*/

diffEl(X, Y, A) :- A is (Y - X).

diffRow([],[],[]).
diffRow([A|B], [C|D], [X|Y]) :- 
	diffEl(A,C,X),
	diffRow(B,D,Y).

diffIm([],[],[]).
diffIm([[E|F]|G], [[H|I]|J], [[R|S]|T]) :-
	diffEl(E,H,R),
	diffRow(F,I,S),
	diffIm(G,J,T).

printImage([]) :- nl.
printImage([R1|RN]) :- printImage(R1),
	nl, nl,
	printImage(RN).
printImage([X|T]) :- write(X), 
	write(' '), 
	printImage(T). 

check([]).
check([X|Y]) :-
	X =:= 0,
	check(Y).
checkB([]).
checkB([X|Y]) :-
	check(X),
	checkB(Y).


isDiff(Image1, Image2) :-
	diffIm(Image1, Image2, Result),
	not(checkB(Result)).

rowmask([],[],[],_,_).

rowmask([_|Im1T],[Im2H|Im2T],[DifH|DifT],[Mask1H|Mask1T],[Mask2H|Mask2T]) :-
	DifH > 0,
	Mask2H is Im2H,
	Mask1H is 0,
	rowmask(Im1T,Im2T,DifT,Mask1T,Mask2T).

rowmask([Im1H|Im1T],[_|Im2T],[DifH|DifT],[Mask1H|Mask1T],[Mask2H|Mask2T]) :-
	DifH < 0,
	Mask2H is 0,
	Mask1H is Im1H,
	rowmask(Im1T,Im2T,DifT,Mask1T,Mask2T).

rowmask([_|Im1T],[_|Im2T],[DifH|DifT],[Mask1H|Mask1T],[Mask2H|Mask2T]) :-
	DifH =:= 0,
	Mask2H is 0,
	Mask1H is 0,
	rowmask(Im1T,Im2T,DifT,Mask1T,Mask2T).

mask([],[],[],_,_).

mask([Im1R|Im1T],[Im2R|Im2T],[DifR|DifT],[M1R|M1T],[M2R|M2T]) :-
	rowmask(Im1R,Im2R,DifR,M1R,M2R),
	mask(Im1T,Im2T,DifT,M1T,M2T).

centRow([], _, X) :-
   X is 0.

centRow([IH|IT], J, CIR) :-
   Value is (J * IH),
   Index is (J + 1),
   centRow(IT, Index, Val),
   CIR is (Value + Val).


centImRow([], _, X) :-
   X is 0.

centImRow([IH|IT], J, CIR) :-
   centRow(IH, J, Row),
   centImRow(IT, J, Rest),
   CIR is (Row + Rest).

centCol([], _, X) :-
   X is 0.

centCol([IH|IT], J, CIR) :-
   Value is (J * IH),
   centCol(IT, J, Val),
   CIR is (Value + Val).

centImCol([], _, X) :-
   X is 0.

centImCol([IH|IT], J, CIR) :-
   centCol(IH, J, Row),
   Index is (J + 1),
   centImCol(IT, Index, Rest),
   CIR is (Row + Rest).


motion([],[],_,_) :- fail, !.

motion(Image1, Image2,_,_) :-
	not(isDiff(Image1, Image2)),
	write('***** No Motion in This Case *****'),
	nl,
	! .

motion([],[],_,X) :- X is 0.
motion([],[],X,_) :- X is 0.
motion([],[],X,Y) :- X is 0, Y is 0.

motion(Image1, Image2, Moti, Motj) :-
	diffIm(Image1, Image2, Diff),
	mask(Image1, Image2, Diff, M1, M2),
	centImRow(M1, 1, C1), /* j1 */
	centImRow(M2, 1, C2), /* j2 */
	centImCol(M1, 1, C3), /* i1 */
	centImCol(M2, 1, C4), /* i2 */
	write(C1),
	nl,
	write(C2),
	nl,
	write(C3),
	nl,
	write(C4),
	nl,
	Moti is C4-C3,
	Motj is C2-C1
	.
