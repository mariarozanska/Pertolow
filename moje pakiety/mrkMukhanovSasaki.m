(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkMukhanovSasaki`*)


(* :Title: R\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego *)

(* :Context: mrkMukhanovSasaki` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego
*)

(* :Copyright: *)

(* :Package Version: 1.1 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 18.08.2016
    Version 1.1, 08.08.2017
      - poprawienie postaci wyprowadzanych r\[OAcute]wna\:0144 w zmiennych MS
*)

(* :Keywords: *)

(* :Requirements: 
"mrkUzyteczny`", "mrkFourier`"
*)

(* :Sources: *)

(* :Warnings: 
ruchuRNMSkw[]: oczekiwana perturbacja metryki perm jest wyznaczana z wyrazu przy kw^2, mo\:017ce w jakim\:015b przypadku takie podstawienie nie b\:0119dzie si\:0119 \[LSlash]adnie skraca\[LSlash]o?
*)

(* :Limitations: *)

(* :Discussion: 
- tensor metryczny musi by\[CAcute] zapisany w longitudinal gauge z \[CapitalPhi]=\[CapitalPsi] (brak przestrzennych element\[OAcute]w pozadiagonalnych w tensorze energii-p\:0119du),
  przy czym perturbacja metryki mo\:017ce by\[CAcute] dowolnie oznaczona (ds^2=-(1+2\[CapitalPhi]*P)dt^2+a^2(1-2\[CapitalPhi]*P)dx^2)
- w tensorze metrycznym perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P
- czynnik skali w tensorze metrycznym musi by\[CAcute] oznaczony przez a
- parametr Hubble'a musi by\[CAcute] oznaczony przez H

- sk\[LSlash]adowe fourierowskie zmiennych Mukhanova-Sasakiego s\:0105 oznaczane przez Q{nazwa_pola}kw
*)


BeginPackage["mrkMukhanovSasaki`",{"mrkUzyteczny`","mrkFourier`"}];

ruchuRNMSkw::usage="ruchuRNMSkw[pola,perturbacjamkw,x,rownaniaRNkw,dd\[Phi]N0,dH,V0,dperm,perm]: 
pola - lista nazw p\[OAcute]l, 
perturbacjamkw - nazwa perturbacji metryki (uwaga! tensor metryczny musi by\[CAcute] zapisany w longitudinal gauge i zawiera\[CAcute] czynnik skali oznaczony przez a: \!\(\*SuperscriptBox[\(ds\), \(2\)]\)=-(1+2\[CapitalPhi]*P)\!\(\*SuperscriptBox[\(dt\), \(2\)]\)+\!\(\*SuperscriptBox[\(a\), \(2\)]\)(1-2\[CapitalPhi]*P)\!\(\*SuperscriptBox[\(dx\), \(2\)]\)), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
rownaniaRNkw - r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich pierwotnych zmiennych (uwaga! w r\[OAcute]wnaniach i pozosta\[LSlash]ych argumentach musi by\[CAcute] podstawiony parametr Hubble'a oznaczony przez H - mo\:017cna to zrobi\[CAcute], korzystaj\:0105c z mrkUzyteczny`podstawienieH), 
dd\[Phi]N0 - podstawienia drugich pochodnych pierwotnych p\[OAcute]l (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`ddpolaN0), 
dH - podstawienie pochodnej parametru Hubble'a (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkEinstein`dHubble0), 
dperm - podstawienie pochodnej po czasie sk\[LSlash]adowej fourierowskiej perturbacji metryki (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkFourier`perturbacjaMetrykiLG), 
perm - podstawienie sk\[LSlash]adowej fourierowskiej perturbacji metryki, stoj\:0105cej przy kwadracie wektora falowego (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkFourier`perturbacjaMetrykiLG);
wyj\:015bcie: r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego (niezmienniczych wzgl\:0119dem cechowania) \!\(\*SubscriptBox[\(Q\), \(\[Phi]\)]\)=\[Delta]\[Phi]+\!\(\*FractionBox[\(\[Phi]' \((t)\)\), \(H \((t)\)\)]\)\[CapitalPhi]";

perturbacjeMSkw::usage="perturbacjeMSkw[pola]: 
pola - lista nazw p\[OAcute]l;
wyj\:015bcie: lista nazw sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego: Q{nazwa_pola}kw";

perturbacjaMetrykiMS::usage="";

Begin["`Private`"];


(* ::Section:: *)
(*Pomocnicze funkcje*)


(* lista nazw sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego *)
perturbacjeMSkw[pola_]:=perturbacjeMSkw[pola]=Block[{pertMS},(
pertMS=mrkUzyteczny`perturbacjeNazwy["Q",pola]; 
mrkFourier`perturbacjekw[pertMS])]


(* ::Section:: *)
(*R\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego*)


(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego (niezmienniczych wzgl\:0119dem cechowania): Q\[Phi]=\[Delta]\[Phi]+(\[Phi]'(t)/H(t))\[CapitalPhi] *)
ruchuRNMSkw[pola_,perturbacjamkw_,x_,rownaniaRNkw_,dd\[Phi]N0_,dH_,dperm_,perm_]:=
ruchuRNMSkw[pola,perturbacjamkw,x,rownaniaRNkw,dd\[Phi]N0,dH,dperm,perm]=
Block[{lpol,perturbacjeMS,perturbacjep,QMSN,\[Delta]\[Phi]N,d\[Delta]\[Phi],dd\[Delta]\[Phi],podstH,rowMS},(
lpol=Length[pola];

(* lista nazw sk\[LSlash]adowych fourierowskich perturbacji pierwotnych p\[OAcute]l *)
perturbacjep=(perturbacjep=mrkUzyteczny`perturbacjeNazwy["\[Delta]",pola]; mrkFourier`perturbacjekw[perturbacjep]);
(* lista nazw sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego *)
perturbacjeMS=perturbacjeMSkw[pola];

(* definicje sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego *)
QMSN[x[[1]]]=MapThread[#1[x[[1]]]+#2'[x[[1]]]*perturbacjamkw[x[[1]]]/Symbol["H"][x[[1]]] &, {perturbacjep,pola}];
(* wyznaczenie sk\[LSlash]adowych fourierowskich perturbacji pierwotnych p\[OAcute]l ze zmiennych Mukhanova-Sasakiego *)
\[Delta]\[Phi]N=Table[Solve[perturbacjeMS[[J]][x[[1]]]==QMSN[x[[1]]][[J]],perturbacjep[[J]][x[[1]]]][[1,1]],{J,1,lpol}];
(* wyra\:017cenie pierwszych i drugich pochodnych po czasie sk\[LSlash]adowych fourierowskich pierwotnych perturbacji przez pochodne perturbacji Mukhanova-Sasakiego *)
d\[Delta]\[Phi]=Expand[D[\[Delta]\[Phi]N,x[[1]]]/.Join[dH,dperm,dd\[Phi]N0]/.\[Delta]\[Phi]N];
dd\[Delta]\[Phi]=Expand[D[d\[Delta]\[Phi],x[[1]]]/.Join[dH,dperm,dd\[Phi]N0]/.\[Delta]\[Phi]N];

Print[TimeObject[Now]," R\[OAcute]wnania ruchu dla zmiennych Mukhanova-Sasakiego"];
(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego *)
Table[(rowMS=Simplify[(((Expand[((rownaniaRNkw[[J]]/.Join[d\[Delta]\[Phi],dd\[Delta]\[Phi],dperm])/.\[Delta]\[Phi]N)]/.perm)/.Join[d\[Delta]\[Phi],dd\[Delta]\[Phi],dperm])/.\[Delta]\[Phi]N)];
	Collect[mrkUzyteczny`wspolczynnik1Row[rowMS,D[perturbacjeMS[[J]][x[[1]]],{x[[1]],2}]], 
		mrkUzyteczny`grupowanie[perturbacjeMS,J],Expand]),{J,1,lpol}])]


(* lista podstawie\:0144 pierwszej pochodnej po czasie perturbacji metryki i perturbacji metryki, stoj\:0105cej przy kwadracie wektora falowego dla metryki w longitudinal gauge *)
perturbacjaMetrykiMS[pola_,rownanie001kw_,rownanie011kw_,perturbacjamkw_,x_,dd\[Phi]N0_,dH_,H2_]:=
(*perturbacjaMetrykiMS[pola,rownanie001kw,rownanie011kw,perturbacjamkw,x,dd\[Phi]N0,dH,H2]=*)
Block[{lpol,perturbacjeMS,perturbacjep,QMSN,\[Delta]\[Phi]N,d\[Delta]\[Phi],rowC,perm},(

lpol=Length[pola];

(* lista nazw sk\[LSlash]adowych fourierowskich perturbacji pierwotnych p\[OAcute]l *)
perturbacjep=(perturbacjep=mrkUzyteczny`perturbacjeNazwy["\[Delta]",pola]; mrkFourier`perturbacjekw[perturbacjep]);
(* lista nazw sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego *)
perturbacjeMS=perturbacjeMSkw[pola];

(* definicje sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego *)
QMSN[x[[1]]]=MapThread[#1[x[[1]]]+#2'[x[[1]]]*perturbacjamkw[x[[1]]]/Symbol["H"][x[[1]]] &, {perturbacjep,pola}];
(* wyznaczenie sk\[LSlash]adowych fourierowskich perturbacji pierwotnych p\[OAcute]l ze zmiennych Mukhanova-Sasakiego *)
\[Delta]\[Phi]N=Table[Solve[perturbacjeMS[[J]][x[[1]]]==QMSN[x[[1]]][[J]],perturbacjep[[J]][x[[1]]]][[1,1]],{J,1,lpol}];
(* wyra\:017cenie pierwszych pochodnych po czasie sk\[LSlash]adowych fourierowskich pierwotnych perturbacji przez pochodne perturbacji Mukhanova-Sasakiego *)
d\[Delta]\[Phi]=Expand[D[\[Delta]\[Phi]N,x[[1]]]];

rowC={rownanie001kw,rownanie011kw} /. d\[Delta]\[Phi] /. \[Delta]\[Phi]N /. dd\[Phi]N0;

(* wyznaczenie perturbacji metryki i jej pochodnej *)
perm=Flatten[Solve[rowC, {perturbacjamkw[x[[1]]],perturbacjamkw'[x[[1]]]}]]/.dH;

Simplify[perm])]


End[];
EndPackage[];
