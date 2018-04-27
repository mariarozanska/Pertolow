(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkLagrange`*)


(* :Title: R\[OAcute]wnania ruchu *)

(* :Context: mrkLagrange` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
g\:0119sto\:015b\[CAcute] lagran\:017cjanu
macierz masy
tensor energii-p\:0119du
r\[OAcute]wnania ruchu
wyznaczanie r\[OAcute]\:017cnych wielko\:015bci z r\[OAcute]wna\:0144 ruchu
*)

(* :Copyright: *)

(* :Package Version: 1.6 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 18.08.2016
    Version 1.1, 23.03.2017:
      - macierz masy i baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy
    Version 1.2, 27.04.2017:
      - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku
    Version 1.3, 02.05.2017:
      - uwzgl\:0119dniona kolejno\:015b\[CAcute] przy testowaniu bazy wektor\[OAcute]w w\[LSlash]asnych
    Version 1.4, 18.05.2017:
      - macierz masy liczona ze wzoru z artyku\[LSlash]u arXiv:0801.1085v2 (D. Langlois, S. Renaux-Petel)
    Version 1.5, 08.08.2017:
      - mo\:017cliwo\:015b\[CAcute] zamiany parametru Hubble'a w macierzy i bazie masy na liczb\:0119 e-powi\:0119ksze\:0144
    Version 1.6, 31.01.2018:
      - zmienne {\[Sigma]'[t], \[Sigma]''[t]}
*)

(* :Keywords: *)

(* :Requirements: 
"mrkUzyteczny`", "VariationalMethods`", "mrkRicci`"
*)

(* :Sources: *)

(* :Warnings: 
bazaMasy[]: kolejno\:015b\[CAcute] wektor\[OAcute]w w\[LSlash]asnych macierzy masy jest wg warto\:015bci w\[LSlash]asnych - nale\:017ca\[LSlash]oby jeszcze sprawdzi\[CAcute] zgodno\:015b\[CAcute] z kolejno\:015bci\:0105 p\[OAcute]l;
			przez uproszczenia bardzo wolno mo\:017ce dzia\[LSlash]a\[CAcute] dla skomplikownaych potencja\[LSlash]\[OAcute]w (lepiej wtedy u\:017cy\[CAcute] Orthogonalize)
bazaMasyTest[]: czy kolejno\:015b\[CAcute] wektor\[OAcute]w w\[LSlash]asnych macierzy masy b\:0119dzie zawsze prawid\[LSlash]owa? (za\[LSlash]o\:017cono, \:017ce najwi\:0119ksze warto\:015bci w macierzy wektor\[OAcute]w w\[LSlash]asnych wyst\:0119puj\:0105 na diagonali);
*)

(* :Limitations:
g\:0119sto\:015b\[CAcute] lagran\:017cjanu/tensor energii-p\:0119du/r\[OAcute]wnania ruchu/macierz masy: dla \[ScriptCapitalL]=F(X,\[Phi]^I), gdzie I=N - liczba p\[OAcute]l skalarnych, X=-(1/2)G_IJ*g^\[Mu]\[Nu]*\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\(\[Phi]^I\)\)\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\(\[Phi]^J\)\) - cz\[LSlash]on kinetyczny
 *)

(* :Discussion: 
- w tensorze metrycznym perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P
- w lagran\:017cjanie cz\[LSlash]on kinetyczny musi by\[CAcute] oznaczony przez XK i potencja\[LSlash] przez V[Sequence@@pola]
*)


BeginPackage["mrkLagrange`", {"VariationalMethods`","mrkUzyteczny`","mrkRicci`"}];

lagrangianO::usage="lagrangianO[g,x,pola,fG,La]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola];
wyj\:015bcie: lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {pola, metryka w przestrzeni p\[OAcute]l, cz\[LSlash]on kinetyczny, lagran\:017cjan}";
lagrangian::usage="lagrangian[g,x,pola,fG,La,r:0]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: g\:0119sto\:015b\[CAcute] lagran\:017cjanu: \[ScriptCapitalL]=F(X,\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\)), gdzie I=N - liczba p\[OAcute]l skalarnych, X=-\!\(\*FractionBox[\(1\), \(2\)]\)\!\(\*SubscriptBox[\(G\), \(IJ\)]\)\!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\)\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\)\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\)\!\(\*SuperscriptBox[\(\[Phi]\), \(J\)]\) - cz\[LSlash]on kinetyczny";

macierzMasy::usage="macierzMasy[g,x,pola,fG,La,O:True]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
O - czy wyrazi\[CAcute] parametr Hubble'a za pomoc\:0105 liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: macierz masy (kwadrat)";
bazaMasy::usage="bazaMasy[g,x,pola,fG,La,O:True]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
O - czy wyrazi\[CAcute] parametr Hubble'a za pomoc\:0105 liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: ortonormalna baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy w przestrzeni p\[OAcute]l zorientowana kanonicznie (uwaga! wektory s\:0105 u\[LSlash]o\:017cone wierszami)";
bazaMasyTest::usage="bazaMasyTest[g,x,pola,fG,La,rozwiazania0,t,fun,param]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
rozwiazania0 - lista rozwi\:0105za\:0144 dla p\[OAcute]l i ich pochodnych, znalezionych z r\[OAcute]wna\:0144 dla t\[LSlash]a (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`rozwiazanieTlo),
t - czas,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
wyj\:015bcie: ortonormalna baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy w przestrzeni p\[OAcute]l zorientowana kanonicznie w danej chwili t (uwaga! wektory s\:0105 u\[LSlash]o\:017cone wierszami)";

energiipeduTddTot::usage="energiipeduTddTot[g,x,pola,fG,La]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola];
wyj\:015bcie: tensor energii-p\:0119du z dwoma dolnymi indeksami dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\)) (bez konkretnego rz\:0119du)";
energiipeduTdd::usage="energiipeduTdd[g,x,pola,fG,La,r:0]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: tensor energii-p\:0119du z dwoma dolnymi indeksami dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\))";
energiipeduTgdTot::usage="energiipeduTgdTot[g,x,pola,fG,La]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola];
wyj\:015bcie: tensor energii-p\:0119du z pierwszym indeksem g\[OAcute]rnym, a drugim dolnym dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\)) (bez konkretnego rz\:0119du)";
energiipeduTgd::usage="energiipeduTgd[g,x,pola,fG,La,r:0]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: tensor energii-p\:0119du z pierwszym indeksem g\[OAcute]rnym, a drugim dolnym dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\))";

ruchuR::usage="ruchuR[g,x,pola,fG,La,n,r:0]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
n - numer pola, dla kt\[OAcute]rego ma zosta\[CAcute] znalezione r\[OAcute]wnanie ruchu, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: r\[OAcute]wnanie ruchu dla pola skalarnego dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\))";
ruchuRN::usage="ruchuRN[g,x,pola,fG,La,r:0]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: r\[OAcute]wnania ruchu dla wszystkich p\[OAcute]l skalarnych dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\))";

predkoscDzwiekuEf::usage="predkoscDzwiekuEf[g,x,pola,fG,La]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola];
wyj\:015bcie: efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku";

ddpolaN0::usage="ddpolaN0[x,pola,rr0]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l,
rr0 - r\[OAcute]wnania ruchu dla t\[LSlash]a;
wyj\:015bcie: lista podstawie\:0144 drugich pochodnych p\[OAcute]l skalarnych wyznaczonych z ich r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a";

dsigma::usage="dsigma[g,x,pola,fG,La]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola];
wyj\:015bcie: pomocnicze zmienne {\[Sigma]'[t], \[Sigma]''[t]} z podstwionym parametrem Hubble'a";

Begin["`Private`"];


(* ::Section:: *)
(*Pomocnicze definicje*)


(* lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje *)
lagrangianO[g_,x_,pola_,fG_,La_]:=lagrangianO[g,x,pola,fG,La]=
Block[{max,lpol,polao,Go,Xo,Lao},(
max=Dimensions[g][[1]]-1; lpol=Length[pola];
(* lista p\[OAcute]l - pola podzielone na t\[LSlash]o i perturbacje *)
polao=Table[pola[[I]]@@pola[[I]][Sequence@@x[[1]]]+ToExpression["\[Delta]"<>ToString[pola[[I]]]][Sequence@@x]*Symbol["P"],{I,1,lpol}];
(* metryka w przestrzeni p\[OAcute]l - podzia\[LSlash] na t\[LSlash]o i perturbacje *)
Go=fG/.Table[pola[[I]]->polao[[I]],{I,1,lpol}];
(* cz\[LSlash]on kinetyczny - podzia\[LSlash] na t\[LSlash]o i perturbacje *)
Xo=Simplify[-Sum[Go[[I,J]]*Sum[Inverse[g][[\[Mu]+1,\[Nu]+1]]*D[polao[[I]],x[[\[Mu]+1]]]*D[polao[[J]],x[[\[Nu]+1]]],{\[Mu],0,max},{\[Nu],0,max}],{I,1,lpol},{J,1,lpol}]/2];
(* lagran\:017cjan - podzia\[LSlash] na t\[LSlash]o i perturbacje *) 
Lao=La/.{Symbol["XK"]->Xo,Sequence@@Table[pola[[I]]->polao[[I]],{I,1,lpol}]};
{polao,Go,Xo,Lao})]

(* lista zmiennych z polami, kt\[OAcute]re zale\:017c\:0105 od wszystkich wsp\[OAcute]\[LSlash]rz\:0119dnych *)
lagrangianR[g_,x_,pola_,fG_,La_]:=lagrangianR[g,x,pola,fG,La]=
Block[{max,lpol,polar,Gr,Xr,Lar},(
max=Dimensions[g][[1]]-1; lpol=Length[pola];
(* lista p\[OAcute]l - pola zale\:017c\:0105 od wszystkich wsp\[OAcute]\[LSlash]rz\:0119dnych *)
polar=Table[pola[[I]]@@pola[[I]][Sequence@@x],{I,1,lpol}];
(* metryka w przestrzeni p\[OAcute]l - pola zale\:017c\:0105 od wszystkich wsp\[OAcute]\[LSlash]rz\:0119dnych *)
Gr=fG/.Table[pola[[I]]->polar[[I]],{I,1,lpol}];
(* cz\[LSlash]on kinetyczny - pola zale\:017c\:0105 od wszystkich wsp\[OAcute]\[LSlash]rz\:0119dnych *)
Xr=Simplify[-Sum[Gr[[I,J]]*Sum[Inverse[g][[\[Mu]+1,\[Nu]+1]]*D[polar[[I]],x[[\[Mu]+1]]]*D[polar[[J]],x[[\[Nu]+1]]],{\[Mu],0,max},{\[Nu],0,max}],{I,1,lpol},{J,1,lpol}]/2];
(* lagran\:017cjan - pola zale\:017c\:0105 od wszystkich wsp\[OAcute]\[LSlash]rz\:0119dnych *) 
Lar=La/.{Symbol["XK"]->Xr,Sequence@@Table[pola[[I]]->polar[[I]],{I,1,lpol}]};
{polar,Gr,Xr,Lar})]


(* ::Section:: *)
(*G\:0119sto\:015b\[CAcute] lagran\:017cjanu*)


(* lagran\:017cjan: \[ScriptCapitalL]=F(X,\[Phi]^I), gdzie I=N - liczba p\[OAcute]l skalarnych, X=-(1/2)Subscript[G, IJ]g^\[Mu]\[Nu]\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]
\*SuperscriptBox[\(\[Phi]\), \(I\)]\)\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]
\*SuperscriptBox[\(\[Phi]\), \(J\)]\) - cz\[LSlash]on kinetyczny *)
lagrangian[g_,x_,pola_,fG_,La_,r_:0]:=lagrangian[g,x,pola,fG,La,r]=
Block[{Lao},( 
(* lagran\:017cjan - podzia\[LSlash] na t\[LSlash]o i perturbacje *) 
Lao=lagrangianO[g,x,pola,fG,La][[4]];
(* lagran\:017cjan w rz\:0119dzie r w perturbacjach *)
Simplify[D[Lao,{Symbol["P"],r}]/.{Symbol["P"]->0}])]


(* ::Section:: *)
(*Macierz masy*)


(*(* macierz masy dla lagran\:017cjanu: \[ScriptCapitalL]=F(X,\[Phi]^I), gdzie I=N - liczba p\[OAcute]l skalarnych, X=-(1/2)Subscript[G, IJ]g^\[Mu]\[Nu]\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]
\*SuperscriptBox[\(\[Phi]\), \(I\)]\)\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]
\*SuperscriptBox[\(\[Phi]\), \(J\)]\) - cz\[LSlash]on kinetyczny *)
macierzMasy[g_,x_,pola_,fG_,La_,O_:True]:=
macierzMasy[g,x,pola,fG,La,O]=
Block[{podstHN,La2,dpola,mm},( 
(* podstawienie parametru Hubble'a *)
podstHN=mrkUzyteczny`zastapienieHN[x];

(* lagran\:017cjan w drugim rz\:0119dzie w perturbacjach *) 
La2=lagrangian[g,x,pola,fG,La,2];

(* ======== nale\:017cy podstawi\[CAcute] perturbacje metryki ============ *)

(* liniowe perturbacje p\[OAcute]l *)
dpola=D[lagrangianO[g,x,pola,fG,La][[1]],Symbol["P"]]/.Symbol["P"]->0;

(* macierz masy *)
mm=Symmetrize[Normal[CoefficientArrays[-Expand[La2],dpola]][[3]]]//Normal;
mm /. podstHN)]*)


(* macierz masy dla lagran\:017cjanu: \[ScriptCapitalL]=F(X,\[Phi]^I), gdzie I=N - liczba p\[OAcute]l skalarnych, X=-(1/2)Subscript[G, IJ]g^\[Mu]\[Nu]\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]
\*SuperscriptBox[\(\[Phi]\), \(I\)]\)\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]
\*SuperscriptBox[\(\[Phi]\), \(J\)]\) - cz\[LSlash]on kinetyczny *)
macierzMasy[g_,x_,pola_,fG_,La_,O_:True]:=
macierzMasy[g,x,pola,fG,La,O]=
Block[{lpol,polao,Go,Xo,Lao,dpolao,dpolaoT,dXo,dXP,ddXP,cs,dcs,
RT,Dpola,rr0,ddpola,podstH,podstHN,mm},(
lpol=Length[pola];
(* pola, tensor metryczny w przestrzeni p\[OAcute]l, cz\[LSlash]on kinetyczny i lagran\:017cjan (t\[LSlash]o) *)
{polao,Go,Xo,Lao}=lagrangianO[g,x,pola,fG,La] /. {Symbol["P"]->0};
dpolao=D[polao,x[[1]]];
dpolaoT=Go.dpolao;
dXo=D[Xo,x[[1]]];

(* pochodna lagran\:017cjanu po cz\[LSlash]onie kinetycznym *)
dXP=D[La,Symbol["XK"]] /. {Symbol["XK"]->Xo};
ddXP=D[La,{Symbol["XK"],2}] /. {Symbol["XK"]->Xo};

(* efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku *)
cs=predkoscDzwiekuEf[g,x,pola,fG,La];
dcs=D[cs,x[[1]]];

(* tensor Riemanna w przestrzeni p\[OAcute]l z pierwszym indeksem g\[OAcute]rnym *)
RT=mrkRicci`riemannTT[Go,polao,0];

(* pochodna kowariantna wektora wi\:0105zki stycznej z dolnym indeksem *)
Dpola=mrkRicci`pochodnaKowariantnaAbsolutna[dpolaoT,x[[1]],Go,polao,True];

(* r\[OAcute]wnania ruchu dla t\[LSlash]a *)
rr0=ruchuRN[g,x,pola,fG,La,0];
(* wyznaczenie drugich pochodnych p\[OAcute]l z ich r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
ddpola=ddpolaN0[x,pola,rr0];

(* podstawienie parametru Hubble'a *)
podstH=mrkUzyteczny`podstawienieH[x];
podstHN=If[O, mrkUzyteczny`zastapienieHN[x], {}];

(* (efektywna) macierz masy - wz\[OAcute]r (34) z artyku\[LSlash]u arXiv:0801.1085v2 (D. Langlois, S. Renaux-Petel) *)
mm=Expand[Table[
	(-mrkRicci`pochodnaKowariantnaDwukrotnaf[Lao,J-1,I-1,Go,polao]) +
	(-dXP*Sum[Go[[I,M]]*RT[[M,K,L,J]]*dpolao[[K]]*dpolao[[L]], {M,1,lpol}, {K,1,lpol}, {L,1,lpol}]) +
	Xo*dXP*(D[dXP,polao[[J]]]*dpolaoT[[I]] + D[dXP,polao[[I]]]*dpolaoT[[J]])/Symbol["H"][x[[1]]] +
	dpolaoT[[I]]*dpolaoT[[J]]*(-Xo*dXP^3/(cs*Symbol["H"][x[[1]]])^2 + dcs*dXP^2/(cs^3*Symbol["H"][x[[1]]]) + 
		(-3*dXP^2*(1+1/cs^2)/2) - dXP*(1+1/cs^2)*(ddXP*dXo + Sum[D[dXP,polao[[K]]]*dpolao[[K]], {K,1,lpol}])/Symbol["H"][x[[1]]]) +
	(-dXP^2*(1+1/cs^2)*(dpolaoT[[I]]*Dpola[[J]] + dpolaoT[[J]]*Dpola[[I]])/(2*Symbol["H"][x[[1]]])),
{I,1,lpol}, {J,1,lpol}] /. ddpola /. podstH /. podstHN];
mm)]


(* ortonormalna baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
bazaMasy[g_,x_,pola_,fG_,La_,O_:True]:=
(*bazaMasy[g,x,pola,fG,La,O]=*)
Block[{Go,podstHN,M2,Mbaza,wart},(
(* tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje *)
{Go}=Take[lagrangianO[g,x,pola,fG,La],{2}];
(* podstawienie parametru Hubble'a *)
podstHN=If[O, mrkUzyteczny`zastapienieHN[x], {}];

(* macierz masy pierwotnych perturbacji *)
M2=macierzMasy[g,x,pola,fG,La,False];

(* baza - wektory w\[LSlash]asne macierzy masy *)
Print[TimeObject[Now]," Baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy"];
(* ============ kolejno\:015b\[CAcute] wektor\[OAcute]w wg warto\:015bci w\[LSlash]asnych - nale\:017ca\[LSlash]oby jeszcze sprawdzi\[CAcute] zgodno\:015b\[CAcute] z kolejno\:015bci\:0105 p\[OAcute]l ============\[Equal] *)
{wart,Mbaza}=Eigensystem[M2, Cubics->True, Quartics->True];

(* ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
(*Orthogonalize[Mbaza]; (* nie uwzgl\:0119dnia metryki i nie upraszcza *)
mrkUzyteczny`orientacjaKanoniczna[Mbaza,Go] /. podstHN)]*)
(* ======= to strasznie wolno dzia\[LSlash]a - w zasadzie nie dzia\[LSlash]a - przez obecno\:015b\[CAcute] Simplify ========== *)
{wart, mrkUzyteczny`ortonormalnaBaza[Mbaza,Go]} /. podstHN)]
(*{wart, Orthogonalize[Mbaza,Go]} /. podstHN)]*)


(* ortonormalna baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy w przestrzeni p\[OAcute]l zorientowana kanonicznie w danej chwili t *)
bazaMasyTest[g_,x_,pola_,fG_,La_,rozwiazania0_,t_,fun_:{},param_:{}]:=
(*bazaMasyTest[g,x,pola,fG,La,rozwiazania0,t,fun,param]=*)
Block[{lpol,Go,podstHN,M2,wart,Mbaza,kolejnosc},(
lpol=Length[pola];
(* podstawienie parametru Hubble'a *)
podstHN=mrkUzyteczny`zastapienieHN[x];
(* tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje *)
{Go}=Take[lagrangianO[g,x,pola,fG,La],{2}] /. {Symbol["P"]->0} /. podstHN;
Go=Go /. fun /. param /. x[[1]]->t/.
	(rozwiazania0/.x[[1]]->t/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]));

(* macierz masy pierwotnych perturbacji w danej chwili t *)
M2=macierzMasy[g,x,pola,fG,La] /. fun /. param /. x[[1]]->t /.
	(rozwiazania0/.x[[1]]->t/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]));
(*Print["Macierz masy: ", SetPrecision[M2,3]];*)
	
(* baza - wektory w\[LSlash]asne macierzy masy *)
{wart,Mbaza}=Eigensystem[M2];

(* uwaga! Eigensystem sortuje wektory i warto\:015bci w\[LSlash]asne malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania warto\:015bci, 
za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
kolejnosc = Flatten[Ordering[Abs[#],-1] &/@ Mbaza];
wart = Range[lpol] /. MapThread[#1->#2 &, {kolejnosc, wart}];
(*Print["Warto\:015bci w\[LSlash]asne macierzy masy: ", SetPrecision[wart,3]];*)
Mbaza = Range[lpol] /. MapThread[#1->#2 &, {kolejnosc, Mbaza}];

(* ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
Mbaza=mrkUzyteczny`ortonormalnaBaza[Mbaza,Go];

(*Print["Macierz  Gm: ", SetPrecision[Go.Mbaza,3]];
Print["Macierz  Gmt: ", SetPrecision[Go.Transpose[Mbaza],3]];
Print["Macierz  mG: ", SetPrecision[Mbaza.Go,3]];
Print["Macierz  mGmt: ", SetPrecision[Mbaza.Go.Transpose[Mbaza],3]];
Print["Macierz  mGmt: ", SetPrecision[Transpose[Mbaza].Go.Mbaza,3]];*)

Mbaza)]


(* ::Section:: *)
(*Tensor energii-p\:0119du*)


(* tensor energii-p\:0119du z dwoma dolnymi indeksami dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\[Phi]^I) *)
energiipeduTddTot[g_,x_,pola_,fG_,La_]:=energiipeduTddTot[g,x,pola,fG,La]=
Block[{max,lpol,polao,Go,Xo,Lao},(
max=Dimensions[g][[1]]-1; lpol=Length[pola];
(* lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje *)
{polao,Go,Xo,Lao}=lagrangianO[g,x,pola,fG,La];
(* tensor energii-p\:0119du z dwoma dolnymi indeksami *)
Table[((D[La,Symbol["XK"]]/.{Symbol["XK"]->Xo,Sequence@@Table[pola[[I]]->polao[[I]],{I,1,lpol}]})Sum[Go[[I,J]]D[polao[[I]],x[[\[Mu]+1]]]D[polao[[J]],x[[\[Nu]+1]]],{I,1,lpol},{J,1,lpol}]+g[[\[Mu]+1,\[Nu]+1]]*Lao),{\[Mu],0,max},{\[Nu],0,max}])]

(* tensor energii-p\:0119du w rz\:0119dzie r w perturbacjach z dwoma dolnymi indeksami dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\[Phi]^I) *)
energiipeduTdd[g_,x_,pola_,fG_,La_,r_:0]:=energiipeduTdd[g,x,pola,fG,La,r]=
Simplify[D[energiipeduTddTot[g,x,pola,fG,La],{Symbol["P"],r}]/.{Symbol["P"]->0}]

(* tensor energii-p\:0119du z pierwszym indeksem g\[OAcute]rnym, a drugim dolnym dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\[Phi]^I) *)
energiipeduTgdTot[g_,x_,pola_,fG_,La_]:=energiipeduTgdTot[g,x,pola,fG,La]=
Block[{max,mTddT},(
max=Dimensions[g][[1]]-1;
(* tensor energii-p\:0119du z dwoma dolnymi indeksami *)
mTddT=energiipeduTddTot[g,x,pola,fG,La];
(* tensor energii-p\:0119du z pierwszym indeksem g\[OAcute]rnym, a drugim dolnym *)
Table[Sum[(Inverse[g][[\[Mu]+1,\[Lambda]+1]]*mTddT[[\[Lambda]+1,\[Nu]+1]]),{\[Lambda],0,max}], {\[Mu],0,max} , {\[Nu],0,max}])]

(* tensor energii-p\:0119du w rz\:0119dzie r w perturbacjach z pierwszym indeksem g\[OAcute]rnym, a drugim dolnym dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\[Phi]^I) *)
energiipeduTgd[g_,x_,pola_,fG_,La_,r_:0]:=energiipeduTgd[g,x,pola,fG,La,r]=
Simplify[D[energiipeduTgdTot[g,x,pola,fG,La],{Symbol["P"],r}]/.{Symbol["P"]->0}]


(* ::Section:: *)
(*R\[OAcute]wnania ruchu*)


(* r\[OAcute]wnanie ruchu pola skalarnego dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\[Phi]^I) *)
ruchuRTot[g_,x_,polar_,Lar_]:=ruchuRTot[g,x,polar,Lar]=EulerEquations[Sqrt[-Det[g]]*Lar,polar,x]

(* r\[OAcute]wnanie ruchu pola skalarnego dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\[Phi]^I) w rz\:0119dzie r w perturbacjach *)
ruchuR[g_,x_,pola_,fG_,La_,n_,r_:0]:=ruchuR[g,x,pola,fG,La,n,r]=
Block[{max,lpol,polar,Gr,Xr,Lar,perturbacjep,zz,col,col2,rrn,coef,lhs,rhs},(
max=Dimensions[g][[1]]; lpol=Length[pola];
(* lista zmiennych z polami zale\:017c\:0105cymi od wszystkich wsp\[OAcute]\[LSlash]rz\:0119dnych *)
{polar,Gr,Xr,Lar}=lagrangianR[g,x,pola,fG,La];
(* lista nazw perturbacji p\[OAcute]l *)
perturbacjep=mrkUzyteczny`perturbacjeNazwy["\[Delta]",pola];
(* wektor zamiany zmiennych: \[Phi] \[Rule] \[Phi][#1]+d\[Phi][#1,...]*P *)
zz=Table[pola[[J]]->(Evaluate[pola[[J]][#1]+perturbacjep[[J]][Sequence@@Table[ToExpression["#"<>ToString[i]],{i,1,max}]]*Symbol["P"]]&),{J,1,lpol}];
(* wektor p\[OAcute]l i ich pochodnych, wed\[LSlash]ug kt\[OAcute]rych b\:0119d\:0105 grupowane wyrazy - 
najpierw wed\[LSlash]ug pola n, dla kt\[OAcute]rego szukane jest r\[OAcute]wnanie ruchu, potem w kolejno\:015bci p\[OAcute]l *)
col=mrkUzyteczny`grupowanie[pola,n];
(* wektor perturbacji p\[OAcute]l i ich pochodnych, wed\[LSlash]ug kt\[OAcute]rych b\:0119d\:0105 grupowane wyrazy *)
col2=mrkUzyteczny`grupowanie[perturbacjep,n];
(* r\[OAcute]wnania ruchu; dziel\:0119 przez czynnik, stoj\:0105cy przy \[Phi]({n}^(2,0,...))[t,...] *)
Print[TimeObject[Now]," R\[OAcute]wnania ruchu w rz\:0119dzie ",r];
rrn=Simplify[Thread[ruchuRTot[g,x,polar,Lar][[n]]*g[[1,1]]/(Sqrt[-Det[g]]),Equal], Element[___,Reals]];
Collect[D[mrkUzyteczny`wspolczynnik1Row[rrn,D[polar[[n]],{x[[1]],2}]] /. zz, {Symbol["P"],r}] /.
	{Symbol["P"]->0}, If[r==0,col,Join[col2,col]], Expand])]


(* r\[OAcute]wnania ruchu dla wszystkich p\[OAcute]l skalarnych dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\[Phi]^I) w rz\:0119dzie r w perturbacjach *) 
ruchuRN[g_,x_,pola_,fG_,La_,r_:0]:=ruchuRN[g,x,pola,fG,La,r]=
Table[ruchuR[g,x,pola,fG,La,J,r],{J,1,Length[pola]}]//Flatten


(* efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku *)
predkoscDzwiekuEf[g_,x_,pola_,fG_,La_]:=predkoscDzwiekuEf[g,x,pola,fG,La]=
Block[{cs,xk},(
(* efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku *)
cs=Sqrt[D[La,Symbol["XK"]]/(D[La,Symbol["XK"]]+2*Symbol["XK"]*D[La,{Symbol["XK"],2}])];
(* podstawienie cz\[LSlash]onu kinetycznego *)
xk=Take[lagrangianO[g,x,pola,fG,La],{3}] /. {Symbol["P"]->0};
cs /. {Symbol["XK"]->xk})]


(* ::Section:: *)
(*Wyznaczanie r\[OAcute]\:017cnych wielko\:015bci z r\[OAcute]wna\:0144 ruchu*)


(* wyznaczenie drugich pochodnych p\[OAcute]l z ich r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\[Phi]^I) *)
ddpolaN0[x_,pola_,rr0_]:=ddpolaN0[x,pola,rr0]=
Block[{lpol},(lpol=Length[pola];
(* lista podstawie\:0144 drugich pochodnych p\[OAcute]l *)
Table[Solve[rr0[[K]],pola[[K]]''[x[[1]]]][[1,1]],{K,1,lpol}])]


(* \[Sigma]'[t] i \[Sigma]''[t] z postawionym parametrem Hubble'a *)
dsigma[g_,x_,pola_,fG_,La_]:=dsigma[g,x,pola,fG,La]=
Block[{Xo,rr0,ddpola,d\[Sigma],dd\[Sigma]},(
(* cz\[LSlash]on kinetyczny *)
Xo=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{3}] /. {Symbol["P"]->0};

(* r\[OAcute]wnania ruchu dla t\[LSlash]a *)
rr0=ruchuRN[g,x,pola,fG,La,0];
(* lista podstawie\:0144 drugich pochodnych p\[OAcute]l *)
ddpola=ddpolaN0[x,pola,rr0];

(* pomocnicza zmienna \[Sigma]'[t] i jej pochodna *)
d\[Sigma]=Sqrt[2*Xo];
dd\[Sigma]=D[d\[Sigma], x[[1]]] /. ddpola;
Simplify[Flatten[{d\[Sigma],dd\[Sigma]} /. mrkUzyteczny`podstawienieH[x]]])]


End[];
EndPackage[];
