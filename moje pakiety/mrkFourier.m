(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkFourier`*)


(* :Title: R\[OAcute]wnania dla sk\[LSlash]adowych fourierowskich *)

(* :Context: mrkFourier` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
r\[OAcute]wnania dla sk\[LSlash]adowych fourierowskich
wyznaczanie r\[OAcute]\:017cnych wielko\:015bci z r\[OAcute]wna\:0144 dla sk\[LSlash]adowych fourierowskich 
*)

(* :Copyright: *)

(* :Package Version: 1.1 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 18.08.2016
    Version 1.1, 08.08.2017
      - poprawienie postaci wyprowadzanych r\[OAcute]wna\:0144 dla sk\[LSlash]adowych fourierowskich
*)

(* :Keywords: *)

(* :Requirements: 
"mrkUzyteczny`"
*)

(* :Sources: *)

(* :Warnings: *)

(* :Limitations: *)

(* :Discussion: 
- nazwy sk\[LSlash]adowych fourierowskich s\:0105 tworzone przez dodanie na ko\:0144cu kw
*)


BeginPackage["mrkFourier`",{"mrkUzyteczny`"}];

perturbacjekw::usage="perturbacjekw[perturbacje]: 
perturbacje - lista nazw perturbacji;
wyj\:015bcie: oznaczenia perturbacji dla sk\[LSlash]adowych fourierowskich utworzone przez dodanie kw na ko\:0144cu ka\:017cdej nazwy";

rownaniakw::usage="rownaniakw[x,rownania,r]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
rownania - lista rowna\:0144, kt\[OAcute]re maj\:0105 zosta\[CAcute] zapisane za pomoc\:0105 sk\[LSlash]adowych fourierowskich, 
r - rz\:0105d r\[OAcute]wna\:0144 w perturbacjach (uwaga! rz\:0105d musi by\[CAcute] taki sam dla wszystkich podanych r\[OAcute]wna\:0144);
wyj\:015bcie: r\[OAcute]wnania dla sk\[LSlash]adowych fourierowskich";

perturbacjaMetrykiLG::usage="perturbacjaMetrykiLG[rownanie011kw,rownanie001kw,perturbacjamkw,x]:
rownanie011kw - r\[OAcute]wnanie pola 01 dla sk\[LSlash]adowych fourierowskich w pierwszym rz\:0119dzie w perturbacjach,
rownanie001kw - r\[OAcute]wnanie pola 00 dla sk\[LSlash]adowych fourierowskich w pierwszym rz\:0119dzie w perturbacjach,
perturbacjamkw - nazwa sk\[LSlash]adowej fourierowskiej pertubacji metryki (uwaga! metryka musi by\[CAcute] zapisana w longitudinal gauge),
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: lista podstawie\:0144 pochodnej perturbacji metryki i perturbacji metryki, stoj\:0105cej przy kwadracie wektora falowego (dla metryki w longitudinal gauge)";

Begin["`Private`"];


(* ::Section:: *)
(*Pomocnicze funkcje*)


(* nazwy perturbacji dla sk\[LSlash]adowych fourierowskich (tworzone przez dodanie "kw" na ko\:0144cu ka\:017cdej nazwy) *)
perturbacjekw[perturbacje_]:=perturbacjekw[perturbacje]=Map[ToString[#]<>"kw" &, perturbacje]


(* lista zmiennych, s\[LSlash]u\:017c\:0105ca przej\:015bciu do sk\[LSlash]adowych fourierowskich; 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, listaPerturbacji - lista nazw perturbacji w uk\[LSlash]adzie {{per1,per2,...}, {per1kw,per2kw,...}};
wyj\:015bcie: {lista przej\:015bcia, podstawienie kwadratu wektora falowego, cz\:0119\:015b\[CAcute] przestrzenna sk\[LSlash]adowej fourierowskiej} *)
przejscieSkladoweFourierowskie[x_,listaPerturbacji_]:=
przejscieSkladoweFourierowskie[x,listaPerturbacji]=
Block[{max,wektorkw,kw2,czescPrzestrzenna,przejscieF},(max=Length[x];
(* wsp\[OAcute]\[LSlash]poruszaj\:0105cy si\:0119 wektor falowy kw={k1,k2,...} *)
wektorkw=Table[ToExpression["k"<>ToString[i-1]],{i,2,max}];
(* podstawienie kwadratu wektora falowego jako sumy kwadrat\[OAcute]w jego wsp\[OAcute]\[LSlash]rz\:0119dnych *)
kw2={wektorkw[[max-1]]^2->(-Sum[wektorkw[[i]]^2,{i,1,max-2}]+Symbol["kw"]^2)};
(* cz\:0119\:015b\[CAcute] przestrzenna perturbacji w rozk\[LSlash]adzie na sk\[LSlash]adowe fourierowskie *)
czescPrzestrzenna=Exp[I*Sum[wektorkw[[i-1]]*ToExpression[x[[i]]],{i,2,max}]];
(* przej\:015bcie do sk\[LSlash]adowych fourierowskich *)
przejscieF=Table[
	listaPerturbacji[[1]][[j]]->(Evaluate[listaPerturbacji[[2]][[j]][#1]*Exp[I*Sum[wektorkw[[i-1]]*ToExpression["#"<>ToString[i]],{i,2,max}]]] &),
	{j,1,Length[listaPerturbacji[[1]]]}];
(* lista zmiennych, s\[LSlash]u\:017c\:0105ca przej\:015bciu do sk\[LSlash]adowych fourierowskich *)
{przejscieF,kw2,czescPrzestrzenna})]


(* ::Section:: *)
(*R\[OAcute]wnania dla sk\[LSlash]adowych fourierowskich*)


(* r\[OAcute]wnania dla sk\[LSlash]adowych fourierowskich *)
rownaniakw[x_,rownania_,r_]:=rownaniakw[x,rownania,r]=
Block[{lrow,przejscieF,kw2,czescPrzestrzenna,listaPerturbacji,listaPerturbacjikw},(
lrow=Length[rownania];
(* nazwy perturbacji wyst\:0119puj\:0105ce w podanych r\[OAcute]wnaniach *)
listaPerturbacji=Table[mrkUzyteczny`perturbacjeObiekt[rownania[[i]],x],{i,1,lrow}]//Flatten//Union;
(* nazwy perturbacji dla sk\[LSlash]adowych fourierowskich *)
listaPerturbacjikw=perturbacjekw[listaPerturbacji];
(* lista zmiennych, s\[LSlash]u\:017c\:0105ca przej\:015bciu do sk\[LSlash]adowych fourierowskich *)
{przejscieF,kw2,czescPrzestrzenna}=przejscieSkladoweFourierowskie[x,{listaPerturbacji,listaPerturbacjikw}];
(* r\[OAcute]wnania dla sk\[LSlash]adowych fourierowskich w rz\:0119dzie r w perturbacjach *)
Table[Collect[Simplify[Thread[((rownania[[i]]/.przejscieF/.kw2)/(czescPrzestrzenna^r)),Equal]],
	mrkUzyteczny`grupowanie[listaPerturbacjikw,i],Expand],{i,1,lrow}])]


(* ::Section:: *)
(*Wyznaczanie r\[OAcute]\:017cnych wielko\:015bci z r\[OAcute]wna\:0144 dla sk\[LSlash]adowych fourierowskich*)


(* lista podstawie\:0144 pierwszej pochodnej po czasie perturbacji metryki i perturbacji metryki, stoj\:0105cej przy kwadracie wektora falowego dla metryki w longitudinal gauge *)
perturbacjaMetrykiLG[rownanie011kw_,rownanie001kw_,perturbacjamkw_,x_]:=
perturbacjaMetrykiLG[rownanie011kw,rownanie001kw,perturbacjamkw,x]=
Block[{dperm,perm,kwper},(
(* wyznaczenie pierwszej pochodnej po czasie perturbacji metryki z r\[OAcute]wnania pola 01 w pierwszym rz\:0119dzie w perturbacjach *)
dperm=Solve[rownanie011kw, perturbacjamkw'[x[[1]]]]//Flatten;
(* wyznaczenie perturbacji metryki (stoj\:0105cej przy kwadracie wektora falowego) z r\[OAcute]wnania pola 00 w pierwszym rz\:0119dzie w perturbacjach *)
(*===================== TO MO\:017bE STWARZA\[CapitalCAcute] KIEDY\:015a PROBLEM ???!!!=============================== *)
perm={perturbacjamkw[x[[1]]]->Solve[Expand[rownanie001kw/.dperm]//.{(Symbol["kw"]^2*perturbacjamkw[x[[1]]])->kwper},kwper][[1,1,2]]/Symbol["kw"]^2};
(* lista podstawie\:0144 *)
{dperm,perm})]


End[];
EndPackage[];
