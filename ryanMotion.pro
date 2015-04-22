printRow([]) :-
   nl.

printRow([A|B]) :-
   write(A),
   write(' '),
   printRow(B).

printImage([]).

printImage([X|Y]) :-
   printRow(X),
   printImage(Y).


image_1Sample([[1,2,3,4,5],[6,7,8,9,8],[7,6,5,4,3],[2,1,2,3,4]]).

image_2Sample([[9,8,7,6,5],[4,3,2,1,2],[3,4,5,6,7],[8,9,8,7,6]]).

image_3Sample([[9,8,7,6,5],[4,3,2,1,2],[3,4,5,6,7],[8,9,8,7,6]]).

diffImRow([], [], []).

diffImRow([A|B], [C|D], [E|F]) :-
   E is (C-A),
   diffImRow(B,D,F).

diffIm([], [], []).

diffIm([A|B], [C|D], [E|F]) :-
   diffImRow(A, C, E),
   diffIm(B, D, F).

isDiff_row([]).

isDiff_row([A|B]) :-
   A =:= 0,
   isDiff_row(B).

isDiff_image([]).

isDiff_image([A|B]) :-
   isDiff_row(A),
   isDiff_image(B).

isDiff(A, B) :-
   diffIm(A,B,DiffIm),
   not(isDiff_image(DiffIm)).


rowmask([_|I1T], [I2H|I2T], [D1H|D1T], [M1H|M1T], [M2H|M2T]) :-
   D1H > 0,
   M1H is 0,
   M2H is I2H,
   rowmask(I1T, I2T, D1T, M1T, M2T).

rowmask([I1H|I1T], [_|I2T], [D1H|D1T], [M1H|M1T], [M2H|M2T]) :-
   D1H < 0,
   M1H is I1H,
   M2H is 0,
   rowmask(I1T, I2T, D1T, M1T, M2T).

rowmask([_|I1T], [_|I2T], [D1H|D1T], [M1H|M1T], [M2H|M2T]) :-
   D1H =:= 0,
   M1H is 0,
   M2H is 0,
   rowmask(I1T, I2T, D1T, M1T, M2T).

mask([], [], [], _, _).

mask([I1H|I1T], [I2H|I2T], [D1H|D1T], [M1H|M1T], [M2H|M2T]) :-
   rowmask(I1H, I2H, D1H, M1H, M2H),
   mask(I1T, I2T, D1T, M1T, M2T).

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