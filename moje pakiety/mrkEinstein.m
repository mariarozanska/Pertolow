(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkEinstein`*)


(* :Title: R\[OAcute]wnania pola *)

(* :Context: mrkEinstein` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
to\:017csamo\:015b\[CAcute] Bianchi
r\[OAcute]wnania pola
wyznaczanie r\[OAcute]\:017cnych wielko\:015bci z r\[OAcute]wna\:0144 pola
*)

(* :Copyright: *)

(* :Package Version: 1.0 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 15.08.2016
*)

(* :Keywords: *)

(* :Requirements: 
"mrkUzyteczny`", "mrkRicci`" 
*)

(* :Sources: *)

(* :Warnings: 
dHubble0[]: funkcja bierze wynik z funkcji Solve[[1,1]], czy mo\:017ce si\:0119 zdarzy\[CAcute] inaczej skonstruowane rozwi\:0105zanie?
*)

(* :Limitations:
r\[OAcute]wnania pola: w teorii f(R)
 *)

(* :Discussion: 
- indeksy nale\:017cy podawa\[CAcute] od 0
- w tensorze metrycznym i tensorze energii-p\:0119du perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P
- czynnik skali w tensorze metrycznym musi by\[CAcute] oznaczony przez a
- skalar Ricciego musi by\[CAcute] oznaczony przez rr[Sequence@@x]
- potencja\[LSlash] w tensorze energii-p\:0119du musi by\[CAcute] oznaczony przez V

- parametr Hubble'a jest oznaczany przez H
*)


BeginPackage["mrkEinstein`",{"mrkUzyteczny`","mrkRicci`"}];

bianchiR::usage="bianchiR[mT,\[Nu],g,x,r:0]: 
mT - tensor energii-p\:0119du z pierwszym indeksem g\[OAcute]rnym, a drugim dolnym (nie w konkretnym rz\:0119dzie - mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`energiipeduTgdTot), 
\[Nu] - numer r\[OAcute]wnania (uwaga! indeks nale\:017cy podawa\[CAcute] od 0), 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
r - rz\:0105d w perturbacjach (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: to\:017csamo\:015b\[CAcute] Bianchi (zasada zachowania energii w OTW): \!\(\*SubsuperscriptBox[\(T\), \(\(\\\ \)\(\[Nu]; \[Mu]\)\), \(\[Mu]\)]\)=0";

polaR::usage="polaR[mT,fR,\[Mu],\[Nu],g,x,r:0,dd:True]: 
mT - tensor energii-p\:0119du z dwoma dolnymi indeksami (nie w konkretnym rz\:0119dzie - mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`energiipeduTgdTot), 
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
\[Mu] i \[Nu] - indeksy (uwaga! indeksy nale\:017cy podawa\[CAcute] od 0), 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
r - rz\:0105d w perturbacjach (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
dd - True oznacza, \:017ce oba indeksy s\:0105 dolne, a False, \:017ce \[Mu] jest g\[OAcute]rny i \[Nu] dolny;
wyj\:015bcie: r\[OAcute]wnanie pola w teorii f(R) (\!\(\*SubscriptBox[\(\[ScriptCapitalL]\), \(g\)]\)=f(R)): f'(R)\!\(\*SubscriptBox[\(R\), \(\[Mu]\[Nu]\)]\)-\!\(\*FractionBox[\(1\), \(2\)]\)f(R)\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)-(f'(R)\!\(\*SubscriptBox[\()\), \(\(;\)\(\[Nu]\)\(;\)\(\[Mu]\)\)]\)+\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)(f'(R)\!\(\*SubsuperscriptBox[\()\), \(\(\\\ \\\ \)\(\(;\)\(\[Alpha]\)\)\), \(\(;\)\(\[Alpha]\)\)]\)=\!\(\*SubscriptBox[\(T\), \(\[Mu]\[Nu]\)]\) (uwaga! konwencja 8\[Pi]G=\!\(\*SubsuperscriptBox[\(M\), \(Pl\), \(-2\)]\)=1)";

Hubble2::usage="Hubble2[r000,x]: 
r000 - r\[OAcute]wnania pola 00 dla t\[LSlash]a (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: kwadrat parametru Hubble'a wyznaczony z r\[OAcute]wnania pola 00 dla t\[LSlash]a";

dHubble0::usage="dHubble0[r000,r110,x]: 
r000 - r\[OAcute]wnania pola 00 dla t\[LSlash]a (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
r110 - r\[OAcute]wnania pola 11 dla t\[LSlash]a, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: podstawienie pochodnej parametru Hubble'a wyznaczonej z sumy r\[OAcute]wna\:0144 pola 00 i 11 dla t\[LSlash]a";

potencjalV0::usage="potencjalV0[r000,x]: 
r000 - r\[OAcute]wnania pola 00 dla t\[LSlash]a (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: podstawienie potencja\[LSlash]u wyznaczonego z r\[OAcute]wnania pola 00 dla t\[LSlash]a";

Begin["`Private`"];


(* ::Section:: *)
(*To\:017csamo\:015b\[CAcute] Bianchi*)


(* to\:017csamo\:015b\[CAcute] Bianchi (zasada zachowania energii w OTW): T^\[Mu]_\[Nu];\[Mu]=0 *)
bianchiR[mT_,\[Nu]_,g_,x_,r_:0]:=bianchiR[mT,\[Nu],g,x,r]=
Block[{max,symboleT,mTD},(max=Dimensions[g][[1]]-1;
(* tablica z wszystkimi symbolami Christoffela *)
symboleT=mrkRicci`symboleTot[g,x];
(* pochodna kowariantna tensora energii-p\:0119du *)
mTD=D[Sum[D[mT[[\[Mu]+1,\[Nu]+1]],x[[\[Mu]+1]]]+Sum[symboleT[[\[Mu]+1,\[Alpha]+1,\[Mu]+1]]*mT[[\[Alpha]+1,\[Nu]+1]]-symboleT[[\[Alpha]+1,\[Nu]+1,\[Mu]+1]]*mT[[\[Mu]+1,\[Alpha]+1]],{\[Alpha],0,max}],{\[Mu],0,max}],{Symbol["P"],r}]/.{Symbol["P"]->0};
(* to\:017csamo\:015b\[CAcute] Bianchi *)
Simplify[mTD==0])]


(* ::Section:: *)
(*R\[OAcute]wnania pola*)


(* r\[OAcute]wnanie pola w teorii f(R): f'(R)R_\[Mu]\[Nu]-(1/2)f(R)g_\[Mu]\[Nu]-(f'(R))_;\[Nu];\[Mu]+g_\[Mu]\[Nu]*(f'(R))^;\[Alpha]_;\[Alpha]=T_\[Mu]\[Nu] (uwaga! konwencja 8\[Pi]G=M_Pl^(-2)=1) *)
polaRddTot[mT_,fR_,\[Mu]_,\[Nu]_,g_,x_]:=polaRddTot[mT,fR,\[Mu],\[Nu],g,x]=
Block[{max,ffR,ricciTTT,ricciST},(max=Dimensions[g][[1]]-1;
(* pochodna funkcji f(R) *)
ffR=D[fR,Symbol["rr"][Sequence@@x]];
(* tensor Ricciego *)
ricciTTT=mrkRicci`ricciTTTot[g,x];
(* skalar Ricciego *)
ricciST=mrkRicci`ricciSTot[g,x];
(* r\[OAcute]wnanie pola *)
((ffR*ricciTTT[[\[Mu]+1,\[Nu]+1]]-fR*g[[\[Mu]+1,\[Nu]+1]]/2-mrkRicci`pochodnaKowariantnaDwukrotnaf[ffR,\[Nu],\[Mu],g,x]+g[[\[Mu]+1,\[Nu]+1]]*Sum[Inverse[g][[\[Alpha]+1,\[Beta]+1]]*mrkRicci`pochodnaKowariantnaDwukrotnaf[ffR,\[Beta],\[Alpha],g,x],{\[Alpha],0,max},{\[Beta],0,max}])/.{Symbol["rr"][Sequence@@x]->ricciST})==mT[[\[Mu]+1,\[Nu]+1]])]

(* r\[OAcute]wnanie pola w teorii f(R) w rz\:0119dzie r w perturbacjach *)
polaR[mT_,fR_,\[Mu]_,\[Nu]_,g_,x_,r_:0,dd_:True]:=polaR[mT,fR,\[Mu],\[Nu],g,x,r,dd]=
Block[{max,rownanie},(max=Dimensions[g][[1]]-1;
(* czy r\[OAcute]wnanie z dwoma dolnymi indeksami, czy z jednym g\[OAcute]rnym i jednym dolnym *)
Print[TimeObject[Now]," R\[OAcute]wnanie pola ",\[Mu],\[Nu]," w rz\:0119dzie ",r];
rownanie=If[dd, polaRddTot[mT,fR,\[Mu],\[Nu],g,x], Thread[Sum[Thread[(Inverse[g][[\[Mu]+1,\[Lambda]+1]]*polaRddTot[mT,fR,\[Lambda],\[Nu],g,x]),Equal],{\[Lambda],0,max}],Equal]];
(* r\[OAcute]wnanie pola w rz\:0119dzie r w perturbacjach *)
Simplify[(D[rownanie,{Symbol["P"],r}]/.{Symbol["P"]->0})])]


(* ::Section:: *)
(*Wyznaczanie r\[OAcute]\:017cnych wielko\:015bci z r\[OAcute]wna\:0144 pola*)


(* wyznaczenie kwadratu parametru Hubble'a z r\[OAcute]wnania Friedmanna dla t\[LSlash]a w teorii f(R) *)
Hubble2[r000_,x_]:=Hubble2[r000,x]=
Block[{podstawienieHubble,r00},( 
(* podstawienie parametru Hubble'a *)
podstawienieHubble=mrkUzyteczny`podstawienieH[x];
(* r\[OAcute]wnanie 00 dla t\[LSlash]a (r\[OAcute]wnanie Friedmanna) *)
r00=r000/.podstawienieHubble;
(* kwadrat parametru Hubble'a *)
Solve[r00,Symbol["H"][x[[1]]]][[1]][[1,2]]^2)]


(* wyznaczenie pochodnej parametru Hubble'a z sumy r\[OAcute]wna\:0144 pola 00 i 11 dla t\[LSlash]a w teorii f(R) *)
dHubble0[r000_,r110_,x_]:=dHubble0[r000,r110,x]=
Block[{podstawienieHubble,r00,r11},( 
(* podstawienie parametru Hubble'a *)
podstawienieHubble=mrkUzyteczny`podstawienieH[x];
(* r\[OAcute]wnanie 00 dla t\[LSlash]a (r\[OAcute]wnanie Friedmanna) *)
r00=r000/.podstawienieHubble;
(* r\[OAcute]wnanie 11 dla t\[LSlash]a *)
r11=r110/.D[podstawienieHubble,x[[1]]]/.podstawienieHubble;
(* podstawienie pochodnej parametru Hubble'a *)
(*===================== TO MO\:017bE STWARZA\[CapitalCAcute] KIEDY\:015a PROBLEM ???!!!=============================== *)
{Solve[r00 && r11,{Symbol["H"]'[x[[1]]],Symbol["H"][x[[1]]]}][[1,1]]})]


(* wyznaczenie potencja\[LSlash]u z r\[OAcute]wnania Friedmanna dla t\[LSlash]a w teorii f(R) *)
potencjalV0[r000_,x_]:=potencjalV0[r000,x]=
Block[{podstawienieHubble,r00,potencjal},( 
(* podstawienie parametru Hubble'a *)
podstawienieHubble=mrkUzyteczny`podstawienieH[x];
(* r\[OAcute]wnanie 00 dla t\[LSlash]a (r\[OAcute]wnanie Friedmanna) *)
r00=r000/.podstawienieHubble;
(* znalezienie oznaczenia potencja\[LSlash]u *)
potencjal=Cases[r00,Symbol["V"][___],Infinity]//Union;
(* podstawienie potencja\[LSlash]u *)
Solve[r00,potencjal]//Flatten)]


End[];
EndPackage[];
