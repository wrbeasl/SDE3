print_assignment([Course,Section,TA]) :- 
			write(TA), write(' is assigned to '), write(Course),
			write(', Section '), write(Section).

no_overlap(A,B,C,D) :- 
			((A >= D);
			 (B =< C)), !.

no_conflict(Aday,Astart,Astop,Sday,Sstart,Sstop) :-
			(no_overlap(Astart,Astop,Sstart,Sstop);
			Aday \= Sday), !.

no_conflict_all_unavailable(_Aday,_Astart,_Astop,[ ]).
no_conflict_all_unavailable(Aday,Astart,Astop,Unavailable_List) :- 
			[Hlist|Tlist] = Unavailable_List,
			[Sday,Sstart,Sstop] = Hlist,
			no_conflict(Aday,Astart,Astop,Sday,Sstart,Sstop),
			no_conflict_all_unavailable(Aday,Astart,Astop,Tlist),!.

assign(Aneed,Aresource,Partial_Assign) :-
			[Course_Name,Section,Day,Ts,Tf] = Aneed,
			[Student_Name,Capabilities,Unavailable] = Aresource,
			[Head_Capabilities|Tail_Capabilities] = Capabilities,
			no_conflict_all_unavailable(Day,Ts,Tf,Unavailable),
			(Course_Name == Head_Capabilities;
			assign(Aneed,[Student_Name,Tail_Capabilities,Unavailable],Partial_Assign)),
			[Course_Name,Section,Student_Name] = Partial_Assign, !. 

course_solution(_Aneed,[ ],Assignment) :-
			Assignment=[none,none,none],
			true.
course_solution(Aneed,Resources,Assignment) :-
			[Head_Resource|Tail_Resources] = Resources,
			(assign(Aneed,Head_Resource,Assignment);
			course_solution(Aneed,Tail_Resources,Assignment)), !,
			true.

remove_student(_StudentName,[ ],Revised_Resources) :-
			Revised_Resources = [ ],
			true.			
remove_student(StudentName,Resources,Revised_Resources) :-
			[Head_Resource|Tail_Resources] = Resources,
			[Name,_Capabilities,_Unavailable] = Head_Resource,
			((StudentName == Name,
			remove_student(StudentName,Tail_Resources,Revised_Resources));
			([Head_Revised|Tail_Revised] = Revised_Resources,
			Head_Revised = Head_Resource,
			remove_student(StudentName,Tail_Resources,Tail_Revised))),!.

overall_solution([ ],_Resources,Solution) :- 
			Solution = [ ],
			true.
overall_solution(Needs, Resources, Solution) :-
			([Head_Need|Tail_Needs] = Needs,
			[Head_Solution|Tail_Solutions] = Solution,
			course_solution(Head_Need,Resources,Head_Solution),
			[_Course_Name,_Section,StudentName] = Head_Solution,
			remove_student(StudentName,Resources,Revised_Resources),
			overall_solution(Tail_Needs,Revised_Resources,Tail_Solutions)),!,
			true.