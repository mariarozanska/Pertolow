(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkRicci`*)


(* :Title: Zakrzywienie czasoprzestrzeni *)

(* :Context: mrkRicci` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
symbole Christoffela
tensor Riemanna
tensor Ricciego
skalar Ricciego
pochodna kowariantna
*)

(* :Copyright: *)

(* :Package Version: 1.1 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 09.08.2016
    Version 1.1, 18.05.2017:
      - pochodna kowariantna wektora wi\:0105zki stycznej r\[OAcute]wnie\:017c z dolnymi indeksami
*)

(* :Keywords: *)

(* :Requirements: - *)

(* :Sources: *)

(* :Warnings: *)

(* :Limitations: 
pochodna kowariantna: dwukrotna pochodna kowariantna funkcji, pochodna kowariantna wektora wi\:0105zki stycznej
*)

(* :Discussion: 
- indeksy nale\:017cy podawa\[CAcute] od 0
- w tensorze metrycznym perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P
*)


BeginPackage["mrkRicci`"];

symbol::usage="symbol[\[Mu],\[Nu],\[Rho],g,x,r:0]: 
\[Mu] - indeks g\[OAcute]rny, \[Nu] i \[Rho] - indeksy dolne (uwaga! indeksy nale\:017cy podawa\[CAcute] od 0), 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: pojedynczy symbol Christoffela: \!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Nu]\[Rho]\)\), \(\[Mu]\)]\)=\!\(\*FractionBox[\(1\), \(2\)]\)\!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Sigma]\)]\)(\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Rho]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Sigma]\[Nu]\)]\)+\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Sigma]\[Rho]\)]\)-\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Sigma]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Nu]\[Rho]\)]\))";
symboleTot::usage="symboleTot[g,x]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny; 
wyj\:015bcie: tablica z wszystkimi symbolami Christoffela (bez konkretnego rz\:0119du): \!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Nu]\[Rho]\)\), \(\[Mu]\)]\)=\!\(\*FractionBox[\(1\), \(2\)]\)\!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Sigma]\)]\)(\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Rho]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Sigma]\[Nu]\)]\)+\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Sigma]\[Rho]\)]\)-\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Sigma]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Nu]\[Rho]\)]\))";
symbole::usage="symbole[g,x,r:0]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P); 
wyj\:015bcie: tablica z wszystkimi symbolami Christoffela: \!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Nu]\[Rho]\)\), \(\[Mu]\)]\)=\!\(\*FractionBox[\(1\), \(2\)]\)\!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Sigma]\)]\)(\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Rho]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Sigma]\[Nu]\)]\)+\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Sigma]\[Rho]\)]\)-\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Sigma]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Nu]\[Rho]\)]\))";

riemannT::usage="riemannT[\[Alpha],\[Beta],\[Gamma],\[Delta],g,x,r:0]: 
\[Alpha] - g\[OAcute]rny indeks, \[Beta], \[Gamma] i \[Delta] - dolne indeksy (uwaga! indeksy nale\:017cy podawa\[CAcute] od 0), 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: pojedyncza sk\[LSlash]adowa tensora Riemanna: \!\(\*SubsuperscriptBox[\(R\), \(\(\\\ \)\(\[Beta]\[Gamma]\[Delta]\)\), \(\[Alpha]\)]\)=\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Gamma]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Delta]\)\), \(\[Alpha]\)]\)-\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Delta]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Gamma]\)\), \(\[Alpha]\)]\)+\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Delta]\)\), \(\[Mu]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Mu]\[Gamma]\)\), \(\[Alpha]\)]\)-\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Gamma]\)\), \(\[Mu]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Mu]\[Delta]\)\), \(\[Alpha]\)]\)";
riemannTTTot::usage="riemannTTTot[g,x]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: tensor Riemanna (bez konkretnego rz\:0119du): \!\(\*SubsuperscriptBox[\(R\), \(\(\\\ \)\(\[Beta]\[Gamma]\[Delta]\)\), \(\[Alpha]\)]\)=\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Gamma]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Delta]\)\), \(\[Alpha]\)]\)-\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Delta]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Gamma]\)\), \(\[Alpha]\)]\)+\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Delta]\)\), \(\[Mu]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Mu]\[Gamma]\)\), \(\[Alpha]\)]\)-\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Gamma]\)\), \(\[Mu]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Mu]\[Delta]\)\), \(\[Alpha]\)]\)";
riemannTT::usage="riemannTT[g,x,r:0]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: tensor Riemanna: \!\(\*SubsuperscriptBox[\(R\), \(\(\\\ \)\(\[Beta]\[Gamma]\[Delta]\)\), \(\[Alpha]\)]\)=\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Gamma]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Delta]\)\), \(\[Alpha]\)]\)-\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Delta]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Gamma]\)\), \(\[Alpha]\)]\)+\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Delta]\)\), \(\[Mu]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Mu]\[Gamma]\)\), \(\[Alpha]\)]\)-\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Beta]\[Gamma]\)\), \(\[Mu]\)]\)\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Mu]\[Delta]\)\), \(\[Alpha]\)]\)";

ricciT::usage="ricciT[\[Chi],\[Psi],g,x,r:0]: 
\[Chi] i \[Psi] - dolne indeksy (uwaga! indeksy nale\:017cy podawa\[CAcute] od 0), 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: pojedyncza sk\[LSlash]adowa tensora Ricciego: \!\(\*SubscriptBox[\(R\), \(\[Chi]\[Psi]\)]\)=\!\(\*SubsuperscriptBox[\(R\), \(\(\\\ \)\(\[Chi]\[Lambda]\[Psi]\)\), \(\[Lambda]\)]\)";
ricciTTTot::usage="ricciTTTot[g,x]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: kowariantny tensor Ricciego (bez konkretnego rz\:0119du): \!\(\*SubscriptBox[\(R\), \(\[Chi]\[Psi]\)]\)=\!\(\*SubsuperscriptBox[\(R\), \(\(\\\ \)\(\[Chi]\[Lambda]\[Psi]\)\), \(\[Lambda]\)]\)";
ricciTT::usage="ricciTT[g,x,r:0]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: kowariantny tensor Ricciego: \!\(\*SubscriptBox[\(R\), \(\[Chi]\[Psi]\)]\)=\!\(\*SubsuperscriptBox[\(R\), \(\(\\\ \)\(\[Chi]\[Lambda]\[Psi]\)\), \(\[Lambda]\)]\)";

ricciSTot::usage="ricciSTot[g,x]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: skalar Ricciego (bez konkretnego rz\:0119du): R=\!\(\*SuperscriptBox[\(g\), \(\[Alpha]\[Beta]\)]\)\!\(\*SubscriptBox[\(R\), \(\[Alpha]\[Beta]\)]\)";
ricciS::usage="ricciS[g,x,r:0]: 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: skalar Ricciego: R=\!\(\*SuperscriptBox[\(g\), \(\[Alpha]\[Beta]\)]\)\!\(\*SubscriptBox[\(R\), \(\[Alpha]\[Beta]\)]\)";

pochodnaKowariantnaDwukrotnaf::usage="pochodnaKowariantnaDwukrotnaf[f,\[Nu],\[Mu],g,x]: 
f - funkcja, 
\[Nu] i \[Mu] - kolejne indeksy, wzgl\:0119dem kt\[OAcute]rych liczona ma by\[CAcute] pochodna (uwaga! indeksy nale\:017cy podawa\[CAcute] od 0), 
g - tensor metryczny, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: dwukrotna pochodna kowariantna funkcji: \!\(\*SubscriptBox[\(f\), \(\(;\)\(\[Nu]\)\(;\)\(\[Mu]\)\)]\)=\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\)\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\)f-\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(\[Nu]\[Mu]\)\), \(\[Lambda]\)]\)\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Lambda]\)]\)f";
pochodnaKowariantnaAbsolutna::usage="pochodnaKowariantnaAbsolutna[A,\[Mu],g,x,d:False]: 
A - wektor zale\:017cny od wsp\[OAcute]\[LSlash]rz\:0119dnych czasoprzestrzennych, 
\[Mu] - wsp\[OAcute]\[LSlash]rz\:0119dna czasoprzestrzenna, wzgl\:0119dem kt\[OAcute]rej liczona ma by\[CAcute] pochodna (uwaga! podana ma by\[CAcute] nazwa), 
g - tensor metryczny (przestrzeni stycznej), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
d - czy A jest z dolnymi indeksami;
wyj\:015bcie: pochodna kowariantna wektora wi\:0105zki stycznej (czasoprzestrzenna pochodna kowariantna, dzia\[LSlash]aj\:0105ca na czasoprzestrzeni zale\:017cnych wektor\[OAcute]w stycznych i ich pochodnych): \!\(\*SubscriptBox[\(D\), \(\[Mu]\)]\)\!\(\*SuperscriptBox[\(A\), \(I\)]\)=\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\)\!\(\*SuperscriptBox[\(A\), \(I\)]\)+\!\(\*SubsuperscriptBox[\(\[CapitalGamma]\), \(\(\\\ \)\(JK\)\), \(I\)]\)\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\)\!\(\*SuperscriptBox[\(\[Phi]\), \(J\)]\)\!\(\*SuperscriptBox[\(A\), \(K\)]\)";

Begin["`Private`"];


(* ::Section:: *)
(*Symbole Christoffela*)


(* pojedynczy symbol Christoffela: \[CapitalGamma]^\[Mu]_\[Nu]\[Rho]=1/2g^\[Mu]\[Sigma](\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Rho]\)]g_\[Sigma]\[Nu]\)+\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]g_\[Sigma]\[Rho]\)-\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Sigma]\)]g_\[Nu]\[Rho]\)) *)
symbolTot[\[Mu]_,\[Nu]_,\[Rho]_,g_,x_]:=symbolTot[\[Mu],\[Nu],\[Rho],g,x]= Block[{max},(max=Dimensions[g][[1]]-1;
Sum[Inverse[g][[\[Mu]+1,\[Sigma]+1]](D[g[[\[Sigma]+1,\[Nu]+1]],x[[\[Rho]+1]]]+D[g[[\[Sigma]+1,\[Rho]+1]],x[[\[Nu]+1]]]-D[g[[\[Nu]+1,\[Rho]+1]],x[[\[Sigma]+1]]]),{\[Sigma],0,max}]/2)]

(* pojedynczy symbol Christoffela w rz\:0119dzie r w perturbacjach *)
symbol[\[Mu]_,\[Nu]_,\[Rho]_,g_,x_,r_:0]:=symbol[\[Mu],\[Nu],\[Rho],g,x,r]=Simplify[D[symbolTot[\[Mu],\[Nu],\[Rho],g,x],{Symbol["P"],r}]/.{Symbol["P"]->0}]

(* tablica z wszystkimi symbolami Christoffela *)
symboleTot[g_,x_]:=symboleTot[g,x]= Block[{max},(max=Dimensions[g][[1]]-1;
Table[symbolTot[\[Mu],\[Nu],\[Rho],g,x],{\[Mu],0,max},{\[Nu],0,max},{\[Rho],0,max}])]

(* tablica z wszystkimi symbolami Christoffela w rz\:0119dzie r w perturbacjach *)
symbole[g_,x_,r_:0]:=symbole[g,x,r]= Block[{max},(max=Dimensions[g][[1]]-1;
Table[symbol[\[Mu],\[Nu],\[Rho],g,x,r],{\[Mu],0,max},{\[Nu],0,max},{\[Rho],0,max}])](*/;r\[GreaterEqual]0 && Dimensions[g][[1]]\[Equal]Length[x]*)


(* ::Section:: *)
(*Tensor Riemanna*)


(* pojedyncza sk\[LSlash]adowa tensora Riemanna: R^\[Alpha]_\[Beta]\[Gamma]\[Delta]=\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Gamma]\)]\(\[CapitalGamma]^\[Alpha]_\[Beta]\[Delta]\)\)-\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Delta]\)]\(\[CapitalGamma]^\[Alpha]_\[Beta]\[Gamma]\)\)+\[CapitalGamma]^\[Mu]_\[Beta]\[Delta]*\[CapitalGamma]^\[Alpha]_\[Mu]\[Gamma]-\[CapitalGamma]^\[Mu]_\[Beta]\[Gamma]*\[CapitalGamma]^\[Alpha]_\[Mu]\[Delta] *)
riemannTTot[\[Alpha]_,\[Beta]_,\[Gamma]_,\[Delta]_,g_,x_]:= riemannTTot[\[Alpha],\[Beta],\[Gamma],\[Delta],g,x]=Block[{max,symboleT},(max=Dimensions[g][[1]]-1;
(* tablica z wszystkimi symbolami Christoffela *)
symboleT=symboleTot[g,x];
(* pojedyncza sk\[LSlash]adowa tensora Riemanna *)
D[symboleT[[\[Alpha]+1,\[Beta]+1,\[Delta]+1]],x[[\[Gamma]+1]]]-D[symboleT[[\[Alpha]+1,\[Beta]+1,\[Gamma]+1]],x[[\[Delta]+1]]]+Sum[symboleT[[\[Mu]+1,\[Beta]+1,\[Delta]+1]]*symboleT[[\[Alpha]+1,\[Mu]+1,\[Gamma]+1]]-symboleT[[\[Mu]+1,\[Beta]+1,\[Gamma]+1]]*symboleT[[\[Alpha]+1,\[Mu]+1,\[Delta]+1]],{\[Mu],0,max}])]

(* pojedyncza sk\[LSlash]adowa tensora Riemanna w rz\:0119dzie r w perturbacjach *)
riemannT[\[Alpha]_,\[Beta]_,\[Gamma]_,\[Delta]_,g_,x_,r_:0]:= riemannT[\[Alpha],\[Beta],\[Gamma],\[Delta],g,x,r]=Simplify[D[riemannTTot[\[Alpha],\[Beta],\[Gamma],\[Delta],g,x],{Symbol["P"],r}]/.{Symbol["P"]->0}]

(* tensor Riemanna *)
riemannTTTot[g_,x_]:=riemannTTTot[g,x]=Block[{max},(max=Dimensions[g][[1]]-1;
Table[riemannTTot[\[Alpha],\[Beta],\[Gamma],\[Delta],g,x],{\[Alpha],0,max},{\[Beta],0,max},{\[Gamma],0,max},{\[Delta],0,max}])]

(* tensor Riemanna w rz\:0119dzie r w perturbacjach *)
riemannTT[g_,x_,r_:0]:=riemannTT[g,x,r]=Block[{max},(max=Dimensions[g][[1]]-1;
Table[riemannT[\[Alpha],\[Beta],\[Gamma],\[Delta],g,x,r],{\[Alpha],0,max},{\[Beta],0,max},{\[Gamma],0,max},{\[Delta],0,max}])]


(* ::Section:: *)
(*Tensor Ricciego*)


(* pojedyncza sk\[LSlash]adowa kowariantenego tensora Ricciego: R_\[Chi]\[Psi]=R^\[Lambda]_\[Chi]\[Lambda]\[Psi] *)
ricciTTot[\[Alpha]_,\[Beta]_,g_,x_]:=ricciTTot[\[Alpha],\[Beta],g,x]=Block[{max,riemannTTT},(max=Dimensions[g][[1]]-1;
(* tensor Riemanna *)
riemannTTT=riemannTTTot[g,x];
(* pojedyncza sk\[LSlash]adowa tensora Ricciego *)
Sum[riemannTTT[[\[Lambda]+1,\[Alpha]+1,\[Lambda]+1,\[Beta]+1]],{\[Lambda],0,max}])]

(* pojedyncza sk\[LSlash]adowa tensora Ricciego w rz\:0119dzie r w perturbacjach *)
ricciT[\[Alpha]_,\[Beta]_,g_,x_,r_:0]:=ricciT[\[Alpha],\[Beta],g,x,r]=Simplify[D[ricciTTot[\[Alpha],\[Beta],g,x],{Symbol["P"],r}]/.{Symbol["P"]->0}]

(* kowariantny tensor Ricciego *)
ricciTTTot[g_,x_]:=ricciTTTot[g,x]=Block[{max},(max=Dimensions[g][[1]]-1;
Table[ricciTTot[\[Alpha],\[Beta],g,x],{\[Alpha],0,max},{\[Beta],0,max}])]

(* tensor Ricciego w rz\:0119dzie r w perturbacjach *)
ricciTT[g_,x_,r_:0]:=ricciTT[g,x,r]=Block[{max},(max=Dimensions[g][[1]]-1;
Table[ricciT[\[Alpha],\[Beta],g,x,r],{\[Alpha],0,max},{\[Beta],0,max}])]


(* ::Section:: *)
(*Skalar Ricciego*)


(* skalar Ricciego: R=g^\[Alpha]\[Beta]*R_\[Alpha]\[Beta] *)
ricciSTot[g_,x_]:=ricciSTot[g,x]=Block[{max,ricciTTT},(max=Dimensions[g][[1]]-1;
(* tensor Ricciego *)
ricciTTT=ricciTTTot[g,x];
(* skalar Ricciego *)
Sum[Inverse[g][[\[Alpha]+1,\[Beta]+1]]*ricciTTT[[\[Alpha]+1,\[Beta]+1]],{\[Alpha],0,max},{\[Beta],0,max}])]

(* skalar Ricciego w rz\:0119dzie r w perturbacjach *)
ricciS[g_,x_,r_:0]:=ricciS[g,x,r]=Simplify[D[ricciSTot[g,x],{Symbol["P"],r}]/.{Symbol["P"]->0}]


(* ::Section:: *)
(*Pochodna kowariantna*)


(* dwukrotna pochodna kowariantna funkcji: f_;\[Nu];\[Mu]=\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\(
\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]f\)\)-\[CapitalGamma]^\[Lambda]_\[Nu]\[Mu]*\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Lambda]\)]f\) *)
pochodnaKowariantnaDwukrotnaf[f_,\[Nu]_,\[Mu]_,g_,x_]:=
pochodnaKowariantnaDwukrotnaf[f,\[Nu],\[Mu],g,x]=
Block[{max,symboleT},(max=Dimensions[g][[1]]-1;
(* tablica z wszystkimi symbolami Christoffela *)
symboleT=symboleTot[g,x];
(* dwukrotna pochodna kowariantna funkcji *)
D[D[f,x[[\[Nu]+1]]],x[[\[Mu]+1]]]-Sum[symboleT[[\[Lambda]+1,\[Nu]+1,\[Mu]+1]]*D[f,x[[\[Lambda]+1]]],{\[Lambda],0,max}])]


(* pochodna kowariantna wektora wi\:0105zki stycznej 
(czasoprzestrzenna pochodna kowariantna, dzia\[LSlash]aj\:0105ca na przestrzeni zale\:017cnych wektor\[OAcute]w stycznych i ich pochodnych): 
D_\[Mu](A^I)=\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\(A^I\)\)+\[CapitalGamma]^I_JK*\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\(\[Phi]^J\)\)*A^K lub D_\[Mu](A_I)=\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]A_I\)+\[CapitalGamma]^K_JI*\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\(\[Phi]^J\)\)*A_K *)
pochodnaKowariantnaAbsolutna[A_,\[Mu]_,g_,x_,d_:False]:=
pochodnaKowariantnaAbsolutna[A,\[Mu],g,x,d]=
Block[{max,symboleT},(max=Dimensions[g][[1]]-1;
(* tablica z wszystkimi symbolami Christoffela *)
symboleT=symboleTot[g,x];
(* pochodna kowariantna wektora wi\:0105zki stycznej *)
If[d, Table[(D[A[[I+1]],\[Mu]]-Sum[symboleT[[K+1,J+1,I+1]]*D[x[[J+1]],\[Mu]]*A[[K+1]],{J,0,max},{K,0,max}]),{I,0,max}],
Table[(D[A[[I+1]],\[Mu]]+Sum[symboleT[[I+1,J+1,K+1]]*D[x[[J+1]],\[Mu]]*A[[K+1]],{J,0,max},{K,0,max}]),{I,0,max}]])]


End[];
EndPackage[];
