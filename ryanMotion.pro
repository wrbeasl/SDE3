printRow([]) :-
   nl.

printRow([A|B]) :-
   write(A),
   write(' '),
   printRow(B).

printImage([]) :-
   nl.

printImage([X|Y]) :-
   printRow(X),
   printImage(Y).

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

rowmask([], [], [], [], []) :- !.

rowmask([_|I1T], [I2H|I2T], [D1H|D1T], [M1H|M1T], [M2H|M2T]) :-
   D1H > 0,
   M1H is 0,
   M2H is I2H,
   rowmask(I1T, I2T, D1T, M1T, M2T),
   !.

rowmask([I1H|I1T], [_|I2T], [D1H|D1T], [M1H|M1T], [M2H|M2T]) :-
   D1H < 0,
   M1H is I1H,
   M2H is 0,
   rowmask(I1T, I2T, D1T, M1T, M2T),
   !.

rowmask([_|I1T], [_|I2T], [D1H|D1T], [M1H|M1T], [M2H|M2T]) :-
   D1H =:= 0,
   M1H is 0,
   M2H is 0,
   rowmask(I1T, I2T, D1T, M1T, M2T),
   !.

mask([], [], [], [], []) :- !.

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

sumRow([], X) :-
   X is 0.

sumRow([H|T], Sum) :-
   sumRow(T, Val),
   Sum is (H + Val).

sumImage([], X) :-
   X is 0.

sumImage([H|T], Sum) :-
   sumRow(H, Row),
   sumImage(T, Rest),
   Sum is (Row + Rest).

motion(I1, I2, _, _) :-
   not(isDiff(I1, I2)),
   write('***** No Motion in This Case *****'),
   nl,
   !.

motion(I1, I2, Moti, Motj) :-
   isDiff(I1, I2),
   diffIm(I1, I2, Diff),
   mask(I1, I2, Diff, I1M, I2M),
   sumImage(I1M, Sum1),
   sumImage(I2M, Sum2),
   centImCol(I1M, 1, C1),
   centImCol(I2M, 1, C2),
   centImRow(I1M, 1, R1),
   centImRow(I2M, 1, R2),
   Motj is (R2/Sum2 - R1/Sum1),
   Moti is (C2/Sum2 - C1/Sum1),
   !.