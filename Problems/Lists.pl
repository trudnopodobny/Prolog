% 1.01 (*): Find the last element of a list

% my_last(X,L) :- X is the last element of the list L
%    (element,list) (?,?)

% Note: last(?Elem, ?List) is predefined

my_last(X,[X]).
my_last(X,[_|L]) :- my_last(X,L).

% 1.02 (*): Find the last but one element of a list

% last_but_one(X,L) :- X is the last but one element of the list L
%    (element,list) (?,?)

last_but_one(X,[X,_]).
last_but_one(X,[_,Y|Ys]) :- last_but_one(X,[Y|Ys]).

% 1.03 (*): Find the K'th element of a list.
% The first element in the list is number 1.

% element_at(X,L,K) :- X is the K'th element of the list L
%    (element,list,integer) (?,?,+)

% Note: nth1(?Index, ?List, ?Elem) is predefined

element_at(X,[X|_],1).
element_at(X,[_|L],K) :- K > 1, K1 is K - 1, element_at(X,L,K1).

% 1.04 (*): Find the number of elements of a list.

% my_length(L,N) :- the list L contains N elements
%    (list,integer) (+,?)

% Note: length(?List, ?Int) is predefined

my_length([],0).
my_length([_|L],N) :- my_length(L,N1), N is N1 + 1.

% 1.05 (*): Reverse a list.

% my_reverse(L1,L2) :- L2 is the list obtained from L1 by reversing
%    the order of the elements.
%    (list,list) (?,?)

% Note: reverse(+List1, -List2) is predefined

my_reverse(L1,L2) :- my_rev(L1,L2,[]).

my_rev([],L2,L2) :- !.
my_rev([X|Xs],L2,Acc) :- my_rev(Xs,L2,[X|Acc]).

% 1.06 (*): Find out whether a list is a palindrome
%
% A palindrome can be read forward or backward; e.g. [x,a,m,a,x]

% is_palindrome(L) :- L is a palindrome list
%    (list) (?)

is_palindrome(L) :- reverse(L,L).

% 1.07 (**): Flatten a nested list structure.

% my_flatten(L1,L2) :- the list L2 is obtained from the list L1 by
%    flattening; i.e. if an element of L1 is a list then it is replaced
%    by its elements, recursively.
%    (list,list) (+,?)

% Note: flatten(+List1, -List2) is a predefined predicate

my_flatten(X,[X]) :- \+ is_list(X).
my_flatten([],[]).
my_flatten([X|Xs],Zs) :- my_flatten(X,Y), my_flatten(Xs,Ys), append(Y,Ys,Zs).

% 1.08 (**): Eliminate consecutive duplicates of list elements.

% compress(L1,L2) :- the list L2 is obtained from the list L1 by
%    compressing repeated occurrences of elements into a single copy
%    of the element.
%    (list,list) (+,?)

compress([],[]).
compress([X],[X]).
compress([X,X|Xs],Zs) :- compress([X|Xs],Zs).
compress([X,Y|Ys],[X|Zs]) :- X \= Y, compress([Y|Ys],Zs).

% 1.09 (**):  Pack consecutive duplicates of list elements into sublists.

% pack(L1,L2) :- the list L2 is obtained from the list L1 by packing
%    repeated occurrences of elements into separate sublists.
%    (list,list) (+,?)

pack([],[]).
pack([X|Xs],[Z|Zs]) :- transfer(X,Xs,Ys,Z), pack(Ys,Zs).

% transfer(X,Xs,Ys,Z) Ys is the list that remains from the list Xs
%    when all leading copies of X are removed and transfered to Z

transfer(X,[],[],[X]).
transfer(X,[Y|Ys],[Y|Ys],[X]) :- X \= Y.
transfer(X,[X|Xs],Ys,[X|Zs]) :- transfer(X,Xs,Ys,Zs).

% 1.10 (*):  Run-length encoding of a list

% encode(L1,L2) :- the list L2 is obtained from the list L1 by run-length
%    encoding. Consecutive duplicates of elements are encoded as terms [N,E],
%    where N is the number of duplicates of the element E.
%    (list,list) (+,?)

:- ensure_loaded(p1_09).

encode(L1,L2) :- pack(L1,L), transform(L,L2).

transform([],[]).
transform([[X|Xs]|Ys],[[N,X]|Zs]) :- length([X|Xs],N), transform(Ys,Zs).

% 1.11 (*):  Modified run-length encoding

% encode_modified(L1,L2) :- the list L2 is obtained from the list L1 by
%    run-length encoding. Consecutive duplicates of elements are encoded
%    as terms [N,E], where N is the number of duplicates of the element E.
%    However, if N equals 1 then the element is simply copied into the
%    output list.
%    (list,list) (+,?)

:- ensure_loaded(p1_10).

encode_modified(L1,L2) :- encode(L1,L), strip(L,L2).

strip([],[]).
strip([[1,X]|Ys],[X|Zs]) :- strip(Ys,Zs).
strip([[N,X]|Ys],[[N,X]|Zs]) :- N > 1, strip(Ys,Zs).

% 1.12 (**): Decode a run-length compressed list.

% decode(L1,L2) :- L2 is the uncompressed version of the run-length
%    encoded list L1.
%    (list,list) (+,?)

decode([],[]).
decode([X|Ys],[X|Zs]) :- \+ is_list(X), decode(Ys,Zs).
decode([[1,X]|Ys],[X|Zs]) :- decode(Ys,Zs).
decode([[N,X]|Ys],[X|Zs]) :- N > 1, N1 is N - 1, decode([[N1,X]|Ys],Zs).

% 1.13 (**): Run-length encoding of a list (direct solution)

% encode_direct(L1,L2) :- the list L2 is obtained from the list L1 by
%    run-length encoding. Consecutive duplicates of elements are encoded
%    as terms [N,E], where N is the number of duplicates of the element E.
%    However, if N equals 1 then the element is simply copied into the
%    output list.
%    (list,list) (+,?)

encode_direct([],[]).
encode_direct([X|Xs],[Z|Zs]) :- count(X,Xs,Ys,1,Z), encode_direct(Ys,Zs).

% count(X,Xs,Ys,K,T) Ys is the list that remains from the list Xs
%    when all leading copies of X are removed. T is the term [N,X],
%    where N is K plus the number of X's that can be removed from Xs.
%    In the case of N=1, T is X, instead of the term [1,X].

count(X,[],[],1,X).
count(X,[],[],N,[N,X]) :- N > 1.
count(X,[Y|Ys],[Y|Ys],1,X) :- X \= Y.
count(X,[Y|Ys],[Y|Ys],N,[N,X]) :- N > 1, X \= Y.
count(X,[X|Xs],Ys,K,T) :- K1 is K + 1, count(X,Xs,Ys,K1,T).

% 1.14 (*): Duplicate the elements of a list

% dupli(L1,L2) :- L2 is obtained from L1 by duplicating all elements.
%    (list,list) (?,?)

dupli([],[]).
dupli([X|Xs],[X,X|Ys]) :- dupli(Xs,Ys).

% 1.15 (**): Duplicate the elements of a list agiven number of times

% dupli(L1,N,L2) :- L2 is obtained from L1 by duplicating all elements
%    N times.
%    (list,integer,list) (?,+,?)

dupli(L1,N,L2) :- dupli(L1,N,L2,N).

% dupli(L1,N,L2,K) :- L2 is obtained from L1 by duplicating its leading
%    element K times, all other elements N times.
%    (list,integer,list,integer) (?,+,?,+)

dupli([],_,[],_).
dupli([_|Xs],N,Ys,0) :- dupli(Xs,N,Ys,N).
dupli([X|Xs],N,[X|Ys],K) :- K > 0, K1 is K - 1, dupli([X|Xs],N,Ys,K1).

% 1.16 (**):  Drop every N'th element from a list

% drop(L1,N,L2) :- L2 is obtained from L1 by dropping every N'th element.
%    (list,integer,list) (?,+,?)

drop(L1,N,L2) :- drop(L1,N,L2,N).

% drop(L1,N,L2,K) :- L2 is obtained from L1 by first copying K-1 elements
%    and then dropping an element and, from then on, dropping every
%    N'th element.
%    (list,integer,list,integer) (?,+,?,+)

drop([],_,[],_).
drop([_|Xs],N,Ys,1) :- drop(Xs,N,Ys,N).
drop([X|Xs],N,[X|Ys],K) :- K > 1, K1 is K - 1, drop(Xs,N,Ys,K1).

% 1.17 (*): Split a list into two parts

% split(L,N,L1,L2) :- the list L1 contains the first N elements
%    of the list L, the list L2 contains the remaining elements.
%    (list,integer,list,list) (?,+,?,?)

split(L,0,[],L).
split([X|Xs],N,[X|Ys],Zs) :- N > 0, N1 is N - 1, split(Xs,N1,Ys,Zs).

% 1.18 (**):  Extract a slice from a list

% slice(L1,I,K,L2) :- L2 is the list of the elements of L1 between
%    index I and index K (both included).
%    (list,integer,integer,list) (?,+,+,?)

slice([X|_],1,1,[X]).
slice([X|Xs],1,K,[X|Ys]) :- K > 1,
   K1 is K - 1, slice(Xs,1,K1,Ys).
slice([_|Xs],I,K,Ys) :- I > 1,
   I1 is I - 1, K1 is K - 1, slice(Xs,I1,K1,Ys).

% 1.19 (**): Rotate a list N places to the left

% rotate(L1,N,L2) :- the list L2 is obtained from the list L1 by
%    rotating the elements of L1 N places to the left.
%    Examples:
%    rotate([a,b,c,d,e,f,g,h],3,[d,e,f,g,h,a,b,c])
%    rotate([a,b,c,d,e,f,g,h],-2,[g,h,a,b,c,d,e,f])
%    (list,integer,list) (+,+,?)

:- ensure_loaded(p1_17).

rotate([],_,[]) :- !.
rotate(L1,N,L2) :-
   length(L1,NL1), N1 is N mod NL1, split(L1,N1,S1,S2), append(S2,S1,L2).

% 1.20 (*): Remove the K'th element from a list.
% The first element in the list is number 1.

% remove_at(X,L,K,R) :- X is the K'th element of the list L; R is the
%    list that remains when the K'th element is removed from L.
%    (element,list,integer,list) (?,?,+,?)

remove_at(X,[X|Xs],1,Xs).
remove_at(X,[Y|Xs],K,[Y|Ys]) :- K > 1,
   K1 is K - 1, remove_at(X,Xs,K1,Ys).

% 1.21 (*): Insert an element at a given position into a list
% The first element in the list is number 1.

% insert_at(X,L,K,R) :- X is inserted into the list L such that it
%    occupies position K. The result is the list R.
%    (element,list,integer,list) (?,?,+,?)

:- ensure_loaded(p1_20).

insert_at(X,L,K,R) :- remove_at(X,R,K,L).

% 1.22 (*):  Create a list containing all integers within a given range.

% range(I,K,L) :- I <= K, and L is the list containing all
%    consecutive integers from I to K.
%    (integer,integer,list) (+,+,?)

range(I,I,[I]).
range(I,K,[I|L]) :- I < K, I1 is I + 1, range(I1,K,L).

% 1.23 (**): Extract a given number of randomly selected elements
%    from a list.

% rnd_select(L,N,R) :- the list R contains N randomly selected
%    items taken from the list L.
%    (list,integer,list) (+,+,-)

:- ensure_loaded(p1_20).

rnd_select(_,0,[]).
rnd_select(Xs,N,[X|Zs]) :- N > 0,
    length(Xs,L),
    I is random(L) + 1,
    remove_at(X,Xs,I,Ys),
    N1 is N - 1,
    rnd_select(Ys,N1,Zs).

% 1.24 (*): Lotto: Draw N different random numbers from the set 1..M

% lotto(N,M,L) :- the list L contains N randomly selected distinct
%    integer numbers from the interval 1..M
%    (integer,integer,number-list) (+,+,-)

:- ensure_loaded(p1_22).
:- ensure_loaded(p1_23).

lotto(N,M,L) :- range(1,M,R), rnd_select(R,N,L).

% 1.25 (*):  Generate a random permutation of the elements of a list

% rnd_permu(L1,L2) :- the list L2 is a random permutation of the
%    elements of the list L1.
%    (list,list) (+,-)

:- ensure_loaded(p1_23).

rnd_permu(L1,L2) :- length(L1,N), rnd_select(L1,N,L2).

% 1.26 (**):  Generate the combinations of k distinct objects
%            chosen from the n elements of a list.

% combination(K,L,C) :- C is a list of K distinct elements
%    chosen from the list L

combination(0,_,[]).
combination(K,L,[X|Xs]) :- K > 0,
   el(X,L,R), K1 is K-1, combination(K1,R,Xs).

% Find out what the following predicate el/3 exactly does.

el(X,[X|L],L).
el(X,[_|L],R) :- el(X,L,R).

% 1.27 (**) Group the elements of a set into disjoint subsets.

% Problem a)

% group3(G,G1,G2,G3) :- distribute the 9 elements of G into G1, G2, and G3,
%    such that G1, G2 and G3 contain 2,3 and 4 elements respectively

group3(G,G1,G2,G3) :-
   selectN(2,G,G1),
   subtract(G,G1,R1),
   selectN(3,R1,G2),
   subtract(R1,G2,R2),
   selectN(4,R2,G3),
   subtract(R2,G3,[]).

% selectN(N,L,S) :- select N elements of the list L and put them in
%    the set S. Via backtracking return all posssible selections, but
%    avoid permutations; i.e. after generating S = [a,b,c] do not return
%    S = [b,a,c], etc.

selectN(0,_,[]) :- !.
selectN(N,L,[X|S]) :- N > 0,
   el(X,L,R),
   N1 is N-1,
   selectN(N1,R,S).

% Use el/3 from p1_26:
:- ensure_loaded(p1_26).

% el(X,[X|L],L).
% el(X,[_|L],R) :- el(X,L,R).

% subtract/3 is predefined

% Problem b): Generalization

% group(G,Ns,Gs) :- distribute the elements of G into the groups Gs.
%    The group sizes are given in the list Ns.

group([],[],[]).
group(G,[N1|Ns],[G1|Gs]) :-
   selectN(N1,G,G1),
   subtract(G,G1,R),
   group(R,Ns,Gs).

% 1.28 (**) Sorting a list of lists according to length
%
% a) length sort
%
% lsort(InList,OutList) :- it is supposed that the elements of InList
% are lists themselves. Then OutList is obtained from InList by sorting
% its elements according to their length. lsort/2 sorts ascendingly,
% lsort/3 allows for ascending or descending sorts.
% (list_of_lists,list_of_lists), (+,?)

lsort(InList,OutList) :- lsort(InList,OutList,asc).

% sorting direction Dir is either asc or desc

lsort(InList,OutList,Dir) :-
   add_key(InList,KList,Dir),
   keysort(KList,SKList),
   rem_key(SKList,OutList).

add_key([],[],_).
add_key([X|Xs],[L-p(X)|Ys],asc) :- !,
	length(X,L), add_key(Xs,Ys,asc).
add_key([X|Xs],[L-p(X)|Ys],desc) :-
	length(X,L1), L is -L1, add_key(Xs,Ys,desc).

rem_key([],[]).
rem_key([_-p(X)|Xs],[X|Ys]) :- rem_key(Xs,Ys).

% b) length frequency sort
%
% lfsort (InList,OutList) :- it is supposed that the elements of InList
% are lists themselves. Then OutList is obtained from InList by sorting
% its elements according to their length frequency; i.e. in the default,
% where sorting is done ascendingly, lists with rare lengths are placed
% first, other with more frequent lengths come later.
%
% Example:
% ?- lfsort([[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],L).
% L = [[i, j, k, l], [o], [a, b, c], [f, g, h], [d, e], [d, e], [m, n]]
%
% Note that the first two lists in the Result have length 4 and 1, both
% length appear just once. The third and forth list have length 3 which
% appears, there are two list of this length. And finally, the last
% three lists have length 2. This is the most frequent length.

lfsort(InList,OutList) :- lfsort(InList,OutList,asc).

% sorting direction Dir is either asc or desc

lfsort(InList,OutList,Dir) :-
	add_key(InList,KList,desc),
   keysort(KList,SKList),
   pac(SKList,PKList),
   lsort(PKList,SPKList,Dir),
   flatten(SPKList,FKList),
   rem_key(FKList,OutList).

pac([],[]).
pac([L-X|Xs],[[L-X|Z]|Zs]) :- transf(L-X,Xs,Ys,Z), pac(Ys,Zs).

% transf(L-X,Xs,Ys,Z) Ys is the list that remains from the list Xs
%    when all leading copies of length L are removed and transfered to Z

transf(_,[],[],[]).
transf(L-_,[K-Y|Ys],[K-Y|Ys],[]) :- L \= K.
transf(L-_,[L-X|Xs],Ys,[L-X|Zs]) :- transf(L-X,Xs,Ys,Zs).

test :-
   L = [[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]],
   write('L = '), write(L), nl,
   lsort(L,LS),
   write('LS = '), write(LS), nl,
   lsort(L,LSD,desc),
   write('LSD = '), write(LSD), nl,
   lfsort(L,LFS),
   write('LFS = '), write(LFS), nl.




