%zad1
symetryczna(L):-  rev(L,L).
rev([_],[_]):-!.
rev([X,Y],[Y,X]):-!.
rev([H|T],X):- rev(T,X1), append(X1,[H],X).

%zad2
parami([],[]):-!.
parami([H1,H2|T],[[H1,H2]|T1]):- parami(T,T1).

%zad3
polowki(L,X,Y):- append(X,Y,L), mylength(X,N), mylength(Y,N).
mylength([],0).
mylength([_|T],N):- mylength(T,N1), N is N1 + 1.

%zad4
sumuj([],0).
sumuj([H|T],N):- sumuj(T,N1), N is N1 + H.

%zad5
ile_dodatnich([],0).
ile_dodatnich([H|T],N):- H >= 0, ile_dodatnich(T,N1), N is N1+1,!.
ile_dodatnich([_|T],N):- ile_dodatnich(T,N).

%zad6
plus_minus([],0).
plus_minus([H|T],N):- H = '+', plus_minus(T,N1), N is N1+1.
plus_minus([H|T],N):- H = '-', plus_minus(T,N1), N is N1-1.

%zad7
wstawiaj([],X,1,[X]).
wstawiaj(L,X,I,Lwy):- rozbij(L,I,LL,LP), append(LL,[X],LL2), append(LL2,LP,Lwy).
rozbij(L,I,X,Y):- append(X,Y,L), mylength(X,N), N is I-1.

%zad8
usuwaj(L,I,L1):- append(L0,L1,L), mylength(L0,I), I>=1.

%zad9
rozdziel([],_,[],[]).
rozdziel([H|T],X,L1,L2):- H<X, rozdziel(T,X,L3,L2), append(L3,[H],L1).
rozdziel([H|T],X,L1,L2):- H>=X, rozdziel(T,X,L1,L4), append(L4,[H],L2).

%zad10
%powiel([],[],[]).
% powiel([H1|T1],[H2|T2],L):- powiel1(H1,H2,X), powiel(T1,T2,L1)append(L1,X,L).
%powiel1(X,1,[X]). powiel1(X,N,L):- powiel1(X,N1,L1),
% append(L1,X,L), N is N1+1.
