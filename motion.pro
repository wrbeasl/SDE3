/*


CPSC 3520
Summer 2, 2014
Software Development Exercise #1
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

centImRow([],0) :- fail.
sumImRow([], Acc, Acc) :- fail.
sumImRow([Im1R|Im1T], StartJ, Sum) :-
	/*write(StartJ), write(' '),write(Sum), write(' '),*/
	Index is StartJ+1,
	SubTotal is Im1R * Index,
	sumImRow(Im1T, Index, SubTotal),
	Sum is Sum.

centImRow([Im1R|Im1T], StartJ, CIR) :-
	sumImRow(Im1R, StartJ, CIR),
	centImRow(Im1T, StartJ, CIR1),
	CIR is CIR1.

centImCol([],0) :- fail.

centImCol([Im1R|Im1T], StartI, CIS) :-
	/*write(Im1R),*/
	write(StartI),
	cenImCol(ImIT, StartI, CIS).


motion([],[],_,_) :- fail, !.

motion(Image1, Image2,_,_) :-
	not(isDiff(Image1, Image2)),
	write('***** No Motion in This Case *****'),
	nl,
	! .

motion(Image1, Image2, Moti, Motj) :-
	diffIm(Image1, Image2, Diff),
	mask(Image1, Image2, Diff, M1, M2),
	centImRow(M1, R1, C1),
	centImCol(M2, R2, C2),
	Moti is (R2 - R1),
	Motj is (C2 - C1).
