(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkIzoKrzywizna`*)


(* :Title: R\[OAcute]wnania ruchu dla sk\[LSlash]adowych krzywizny i izokrzywizny *)

(* :Context: mrkIzoKrzywizna` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
baza Freneta i macierz masy w bazie Freneta
r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich krzywizny i izokrzywizny
*)

(* :Copyright: *)

(* :Package Version: 1.3 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 14.08.2016
    Version 1.1, 04.04.2017
      - testowa baza Freneta
      - macierz masy po przej\:015bciu do bazy Freneta
      - wsp\[OAcute]\[LSlash]czynniki oddzia\[LSlash]ywania mi\:0119dzy perturbacjami
    Version 1.2, 02.05.2017
      - kwadraty efektywnych mas zamienione na efektywn\:0105 macierz masy
    Version 1.3, 08.08.2017
      - zast\:0119powanie parametru Hubble'a przez liczb\:0119 e-powi\:0119ksze\:0144
      - poprawa znajdowania r\[OAcute]wna\:0144 dla krzywizny i izokrzywizny
*)

(* :Keywords: *)

(* :Requirements: 
"mrkUzyteczny`", "mrkRicci`", "mrkFourier`"
*)

(* :Sources: *)

(* :Warnings: 
bazaFreneta[]: gdyby co\:015b by\[LSlash]o nie tak z mrkUzyteczny`ortonormalnaBaza (np. z powodu nieprzewidzianej postaci rozwi\:0105zania), to jest tam drugi algorytm - nieco wolniejszy, ale na pewno prawid\[LSlash]owy
ruchuRNAEkw[]: czy kolejno\:015b\[CAcute] podstawie\:0144 b\:0119dzie zawsze prawid\[LSlash]owa?, zastanowi\[CAcute] si\:0119 czy znajdowanie s{i}' w og\[OAcute]le jest potrzebne???
*)

(* :Limitations:
r\[OAcute]wnania ruchu: 
	w pierwszym rz\:0119dzie w perturbacjach \[Rule] nale\:017cy zmieni\[CAcute] znajdowanie potencja\[LSlash]\[OAcute]w do r+1
	do dw\[OAcute]ch p\[OAcute]l \[Rule] dla trzech zbyt skomplikowane wychodz\:0105 wektory bazowe, wi\:0119c i pochodne potencja\[LSlash]\[OAcute]w, zatem nie mo\:017ce wyznaczy\[CAcute] starych potencja\[LSlash]\[OAcute]w
 *)

(* :Discussion: 
- w tensorze metrycznym perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P
- czynnik skali w tensorze metrycznym musi by\[CAcute] oznaczony przez a
- w lagran\:017cjanie cz\[LSlash]on kinetyczny musi by\[CAcute] oznaczony przez XK i potencja\[LSlash] przez V[Sequence@@pola]
- skalar Ricciego musi by\[CAcute] oznaczony przez rr[Sequence@@x]

- sk\[LSlash]adowe fourierowskie krzywizny i izokrzywizny s\:0105 oznaczane przez Q\[Sigma]kw,Qs1kw,Qs2kw,... dla zmiennych Mukhanova-Sasakiego i \[Delta]\[Sigma]kw,\[Delta]s1kw,\[Delta]s2kw,... dla pierwotnych zmiennych
- parametr Hubble'a jest oznaczany przez H
- liczba e-powi\:0119ksze\:0144 jest oznaczona przez nn
*)


BeginPackage["mrkIzoKrzywizna`",{"mrkUzyteczny`","mrkRicci`","mrkFourier`"}];

perturbacjeRSkw::usage="perturbacjeRSkw[pola,MS]: 
pola - lista nazw p\[OAcute]l,
MS - True, gdy nowe zmienne s\:0105 tworzone ze zmiennych Mukhanova-Sasakiego;
wyj\:015bcie: lista nazw sk\[LSlash]adowych fourierowskich perturbacji krzywizny i izokrzywizny: Q\[Sigma]kw,Qs1kw,Qs2kw,... dla zmiennych Mukhanova-Sasakiego i \[Delta]\[Sigma]kw,\[Delta]s1kw,\[Delta]s2kw,... dla pierwotnych zmiennych";

bazaPierwotna::usage="bazaPierwotna[listao,dd\[Phi]N0,x,O:True]: 
listao - lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {pola, tensor metryczny w przestrzeni p\[OAcute]l} (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
dd\[Phi]N0 - podstawienia drugich pochodnych pierwotnych p\[OAcute]l (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`ddpolaN0),
O - czy wyrazi\[CAcute] parametr Hubble'a za pomoc\:0105 liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: baza pierwotna - nieortonormalna baza bez ustalonej orientacji: Fi1(I)=\[Phi](I)'[t], FiN(I)=Dt^(N-1)\[Phi](I)'[t]";

bazaFreneta::usage="bazaFreneta[listao,dd\[Phi]N0,x,O:True]: 
listao - lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {pola, tensor metryczny w przestrzeni p\[OAcute]l} (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
dd\[Phi]N0 - podstawienia drugich pochodnych pierwotnych p\[OAcute]l (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`ddpolaN0),
O - czy wyrazi\[CAcute] parametr Hubble'a za pomoc\:0105 liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie: E\[Sigma] - wektor adiabatyczny, r\[OAcute]wnoleg\[LSlash]y do wektora pr\:0119dko\:015bci, Es(i) - wektory rozpinaj\:0105ce entropow\:0105 podprzestrze\:0144, kt\[OAcute]ra jest ortogonalna do adiabatycznego kierunku, Es1 - wektor r\[OAcute]wnoleg\[LSlash]y do sk\[LSlash]adowej przyspieszenia prostopad\[LSlash]ej do wektora pr\:0119dko\:015bci ('poprzeczne przyspieszenie') (uwaga! wektory s\:0105 u\[LSlash]o\:017cone wierszami)";

bazaFrenetaTest::usage="bazaFrenetaTest[listao,dd\[Phi]N0,x,rozwiazania0,t,fun,param]: 
listao - lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {pola, tensor metryczny w przestrzeni p\[OAcute]l} (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
dd\[Phi]N0 - podstawienia drugich pochodnych pierwotnych p\[OAcute]l (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`ddpolaN0),
rozwiazania0 - lista rozwi\:0105za\:0144 dla p\[OAcute]l i ich pochodnych, znalezionych z r\[OAcute]wna\:0144 dla t\[LSlash]a (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`rozwiazanieTlo),
t - czas,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
wyj\:015bcie: baza Freneta w danej chwili t - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie: E\[Sigma] - wektor adiabatyczny, r\[OAcute]wnoleg\[LSlash]y do wektora pr\:0119dko\:015bci, Es(i) - wektory rozpinaj\:0105ce entropow\:0105 podprzestrze\:0144, kt\[OAcute]ra jest ortogonalna do adiabatycznego kierunku, Es1 - wektor r\[OAcute]wnoleg\[LSlash]y do sk\[LSlash]adowej przyspieszenia prostopad\[LSlash]ej do wektora pr\:0119dko\:015bci ('poprzeczne przyspieszenie') (uwaga! wektory s\:0105 u\[LSlash]o\:017cone wierszami)";

bazaFrenetaParametry::usage="bazaFrenetaParametry[x,Fibaza,dd\[Phi]N0,O:True]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
Fibaza - baza Freneta (lista list),
dd\[Phi]N0 - podstawienia drugich pochodnych pierwotnych p\[OAcute]l (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`ddpolaN0),
O - czy wyrazi\[CAcute] parametr Hubble'a za pomoc\:0105 liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: lista pr\:0119dko\:015bci k\:0105towych, parametryzuj\:0105cych ewolucj\:0119 czasow\:0105 bazy Freneta";

macierzMasyBaza::usage="macierzMasyBaza[masa,Fibaza]: 
masa - macierz masy,
Fibaza - baza Freneta (lista list) (uwaga! wektory musz\:0105 by\[CAcute] u\[LSlash]o\:017cone wierszami),
wyj\:015bcie: macierz masy dla zmiennych Q\[Sigma] i Qs(i) dla prostej trajektorii";

macierzMasyEf::usage="macierzMasyEf[masaBF,dkaty]: 
masaB - macierz masy w bazie Freneta,
dkaty - pr\:0119dko\:015bci k\:0105towe, parametryzuj\:0105ce ewolucj\:0119 czasow\:0105 bazy Freneta (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkIzoKrzywizna`bazaFrenetaParametry),
wyj\:015bcie: efektywna macierz masy dla zmiennych Q\[Sigma] i Qs(i) (dla zakrzywionej trajektorii)";

podstawieniaRS::usage="";

zamianadV::usage="zamianadV[x,polas,polan,Vs,Vn,Ebaza,listad]:
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
polas - lista nazw starych p\[OAcute]l, 
polan - lista nazw nowych p\[OAcute]l, 
Vs - nazwa starego potencja\[LSlash]u,
Vn - nazwa nowgo potencja\[LSlash]u,
Ebaza - baza, do kt\[OAcute]rej ma zosta\[CAcute] przeprowadzona zamiana,
listad - lista list pochodnych, dla kt\[OAcute]rych ma zosta\[CAcute] przeprowadzona zamiana, np. {{2,0,0},{1,0,1}};
wyj\:015bcie: lista w formie {wzory na nowe pochodne, podstawienia starych pochodnych}";

ruchuRNAEkw::usage="ruchuRNAEkw[pola,listao,Ebaza,x,rownaniaNkw,dd\[Phi]N0,MS:True,r:1,zamianaV:False]: 
pola - lista nazw p\[OAcute]l, 
listao - lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {tensor metryczny w przestrzeni p\[OAcute]l, cz\[LSlash]on kinetyczny} (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO), 
Ebaza - baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkIzoKrzywizna`bazaFreneta), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
rownaniaNkw - r\[OAcute]wnania ruchu (uwaga! w r\[OAcute]wnaniach i dd\[Phi]N0 musi by\[CAcute] podstawiony parametr Hubble'a oznaczony przez H - mo\:017cna to zrobi\[CAcute], korzystaj\:0105c z mrkUzyteczny`podstawienieH),
dd\[Phi]N0 - podstawienia drugich pochodnych pierwotnych p\[OAcute]l (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`ddpolaN0),
MS - True, gdy r\[OAcute]wnania ruchu s\:0105 dla zmiennych Mukhanova-Sasakiego, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
zamianaV - czy potencja\[LSlash] jest oznaczony przez V;
wyj\:015bcie: r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich perturbacji krzywizny (adiabatycznej) i izokrzywizny (entropowych) (uwaga! r\[OAcute]wnanie t\[LSlash]a wy\[LSlash]\:0105cznie w kierunku adiabatycznym)";

ruchuRNAEkwO::usage="ruchuRNAEkwO[pola,Go,Ebaza,x,rownaniaNkw,dd\[Phi]N0,MS:True,r:1]: 
pola - lista nazw p\[OAcute]l, 
Go - tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO), 
Ebaza - baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkIzoKrzywizna`bazaFreneta), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
rownaniaNkw - r\[OAcute]wnania ruchu (uwaga! w r\[OAcute]wnaniach i dd\[Phi]N0 musi by\[CAcute] podstawiony parametr Hubble'a oznaczony przez H - mo\:017cna to zrobi\[CAcute], korzystaj\:0105c z mrkUzyteczny`podstawienieH),
dd\[Phi]N0 - podstawienia drugich pochodnych pierwotnych p\[OAcute]l (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`ddpolaN0),
MS - True, gdy r\[OAcute]wnania ruchu s\:0105 dla zmiennych Mukhanova-Sasakiego, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich perturbacji krzywizny (adiabatycznej) i izokrzywizny (entropowych) - tylko zamiana p\[OAcute]l (uwaga! r\[OAcute]wnanie t\[LSlash]a wy\[LSlash]\:0105cznie w kierunku adiabatycznym)";

wspRNAEkw::usage="wspRNAEkw[pola,Go,Ebaza,x,rownaniaNkw,dd\[Phi]N0,MS:True,r:1]: 
pola - lista nazw p\[OAcute]l, 
Go - tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO), 
Ebaza - baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkIzoKrzywizna`bazaFreneta), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
rownaniaNkw - r\[OAcute]wnania ruchu (uwaga! w r\[OAcute]wnaniach i dd\[Phi]N0 musi by\[CAcute] podstawiony parametr Hubble'a oznaczony przez H - mo\:017cna to zrobi\[CAcute], korzystaj\:0105c z mrkUzyteczny`podstawienieH),
dd\[Phi]N0 - podstawienia drugich pochodnych pierwotnych p\[OAcute]l (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`ddpolaN0),
MS - True, gdy r\[OAcute]wnania ruchu s\:0105 dla zmiennych Mukhanova-Sasakiego, 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: lista wsp\[OAcute]\[LSlash]czynnik\[OAcute]w oddzia\[LSlash]ywania mi\:0119dzy perturbacjami krzywizny i izokrzywizny w formie {{C_\[Sigma]s1, C_\[Sigma]s2, ...}, {C_s1\[Sigma], C_s1s2, ...}, ...}";

Begin["`Private`"];


(* ::Section:: *)
(*Pomocnicze funkcje*)


(* lista nazw sk\[LSlash]adowych fourierowskich perturbacji krzywizny i izokrzywizny *)
perturbacjeRSkw[pola_,MS_]:=perturbacjeRSkw[pola,MS]=
Block[{lpol,zmaen,pertae},(lpol=Length[pola];
(* lista nazw nowych zmiennych: \[Sigma] (adiabatyczna - krzywizny), s1,s2,... (entropowe - izokrzywizny) *)
zmaen=Join[{Symbol["\[Sigma]"]},Table[ToExpression["s"<>ToString[J]],{J,1,lpol-1}]];
(* lista nazw sk\[LSlash]adowych fourierowskich perturbacji nowych zmiennych *)
pertae=If[MS, mrkUzyteczny`perturbacjeNazwy["Q",zmaen], mrkUzyteczny`perturbacjeNazwy["\[Delta]",zmaen]];
mrkFourier`perturbacjekw[pertae])]


(* ::Section:: *)
(*Baza Freneta*)


(* pierwotna baza - Fi1(I)=\[Phi](I)'[t], FiN(I)=Dt^(N-1)\[Phi](I)'[t] (baza N wektor\[OAcute]w - wielko\:015bci z g\[OAcute]rnymi indeksami),
nieortonormalna, bez ustalonej orientacji *)
bazaPierwotna[listao_,dd\[Phi]N0_,x_,O_:True]:=bazaPierwotna[listao,dd\[Phi]N0,x,O]=
Block[{lpol,polao,Go,podstHN,Prob,PNb,Pbaza},(
(* lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {pola, tensor metryczny w przestrzeni p\[OAcute]l} *)
{polao,Go}=listao/.{Symbol["P"]->0};
lpol=Length[polao];
(* podstawienie parametru Hubble'a *)
podstHN=If[O, mrkUzyteczny`zastapienieHN[x], {}];

(*Print[TimeObject[Now]," Baza Pierwotna"];*)
(* pierwotna baza - Fi1(I)=\[Phi](I)'[t], FiN(I)=Dt^(N-1)\[Phi](I)'[t] (baza N wektor\[OAcute]w - wielko\:015bci z g\[OAcute]rnymi indeksami) *)
Pbaza=(Prob=D[polao,x[[1]]]; PNb={Prob}; 
	Do[Prob=mrkRicci`pochodnaKowariantnaAbsolutna[Prob,x[[1]],Go,polao]/.dd\[Phi]N0; 
		AppendTo[PNb,Prob],{n,2,lpol}]; 
	Simplify[PNb]);
Pbaza /. podstHN)]


(* ortonormalna baza E={E\[Sigma],Es1,Es2,...} w przestrzeni p\[OAcute]l zorientowana kanonicznie;
E\[Sigma] - wektor adiabatyczny, r\[OAcute]wnoleg\[LSlash]y do wektora pr\:0119dko\:015bci, 
Es(i) - wektory rozpinaj\:0105ce entropow\:0105 podprzestrze\:0144, kt\[OAcute]ra jest ortogonalna do adiabatycznego kierunku, 
Es1 - wektor r\[OAcute]wnoleg\[LSlash]y do sk\[LSlash]adowej przyspieszenia prostopad\[LSlash]ej do wektora pr\:0119dko\:015bci ("poprzeczne przyspieszenie") *)
bazaFreneta[listao_,dd\[Phi]N0_,x_,O_:True]:=
bazaFreneta[listao,dd\[Phi]N0,x,O]=
Block[{Go,podstHN,Fibaza},(
(* tensor metryczny w przestrzeni p\[OAcute]l *)
Go=listao[[2]]/.{Symbol["P"]->0};
(* podstawienie parametru Hubble'a *)
podstHN=If[O, mrkUzyteczny`zastapienieHN[x], {}];

Print[TimeObject[Now]," Baza Freneta"];
(* pierwotna baza - Fi1(I)=\[Phi](I)'[t], FiN(I)=Dt^(N-1)\[Phi](I)'[t] (baza N wektor\[OAcute]w - wielko\:015bci z g\[OAcute]rnymi indeksami) *)
Fibaza=bazaPierwotna[listao,dd\[Phi]N0,x,False];

(* ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *) 
mrkUzyteczny`ortonormalnaBaza[Fibaza,Go] /. podstHN)]


(* ortonormalna baza E={E\[Sigma],Es1,Es2,...} w przestrzeni p\[OAcute]l zorientowana kanonicznie w danej chwili t;
E\[Sigma] - wektor adiabatyczny, r\[OAcute]wnoleg\[LSlash]y do wektora pr\:0119dko\:015bci, 
Es(i) - wektory rozpinaj\:0105ce entropow\:0105 podprzestrze\:0144, kt\[OAcute]ra jest ortogonalna do adiabatycznego kierunku, 
Es1 - wektor r\[OAcute]wnoleg\[LSlash]y do sk\[LSlash]adowej przyspieszenia prostopad\[LSlash]ej do wektora pr\:0119dko\:015bci ("poprzeczne przyspieszenie") *)
bazaFrenetaTest[listao_,dd\[Phi]N0_,x_,rozwiazania0_,t_,fun_:{},param_:{}]:=
(*bazaFrenetaTest[listao,dd\[Phi]N0,x,rozwiazania0,t,fun,param]=*)
Block[{Go,podstHN,Fibaza},(
(* podstawienie parametru Hubble'a *)
podstHN=mrkUzyteczny`zastapienieHN[x];
(* lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {pola, tensor metryczny w przestrzeni p\[OAcute]l} *)
Go=listao[[2]]/.{Symbol["P"]->0} /. podstHN;
(*Go=Go /. fun /. param /. x[[1]]->t/.
	(rozwiazania0/.x[[1]]->t/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]));*)

(* pierwotna baza - Fi1(I)=\[Phi](I)'[t], FiN(I)=Dt^(N-1)\[Phi](I)'[t] (baza N wektor\[OAcute]w - wielko\:015bci z g\[OAcute]rnymi indeksami) *)
Fibaza=bazaPierwotna[listao,dd\[Phi]N0,x];
(*Fibaza=Simplify[Fibaza /. fun /. param /. x[[1]]->t/.
	(rozwiazania0/.x[[1]]->t/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];*)

(* ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *) 
(*mrkUzyteczny`ortonormalnaBaza[Fibaza,Go])]*)
mrkUzyteczny`ortonormalnaBaza[Fibaza,Go]/.fun/.param/.x[[1]]->t/.
	(rozwiazania0/.x[[1]]->t/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200])))]


(* lista pr\:0119dko\:015bci k\:0105towych, parametryzuj\:0105cych ewolucj\:0119 czasow\:0105 bazy Freneta *)
bazaFrenetaParametry[x_,Fibaza_,dd\[Phi]N0_,O_:True]:=
bazaFrenetaParametry[x,Fibaza,dd\[Phi]N0,O]=
Block[{lparam,podstHN,parametry,rown,c1,c2},(
lparam=Length[Fibaza]-1;
(* podstawienie parametru Hubble'a *)
podstHN=If[O, mrkUzyteczny`zastapienieHN[x], {}];

(* F_1'(t) = -\[Theta]_1'(t)F_2(t), F_n'(t) = \[Theta]_(n-1)'(t)F_(n-1)(t) - \[Theta]_n'(t)F_(n+1)(t) *)
Print[TimeObject[Now]," Pr\:0119dko\:015bci k\:0105towe bazy"];
parametry=Reap[c1=-D[Fibaza[[1,1]],x[[1]]]/Fibaza[[2,1]]; Sow[c1];
	Do[rown={D[Fibaza[[i,1]],x[[1]]]==c1*Fibaza[[i-1,1]]-c2*Fibaza[[i+1,1]]};
		c1=Solve[rown,c2][[1,1,2]];
		Sow[c1],{i,2,lparam}]][[2,1]];
		
(* lista parametr\[OAcute]w *)
parametry /. dd\[Phi]N0 /. podstHN)]


(* macierz masy dla zmiennych Q\[Sigma] i Qs(i) dla prostej trajektorii *)
macierzMasyBaza[masa_,Fibaza_]:=macierzMasyBaza[masa,Fibaza]=
Block[{},(
(* macierz masy w nowej bazie - wiersze odpowiadaj\:0105 danym polom, dlatego B.M.(B)^T *)
Print[TimeObject[Now]," Macierz masy w bazie Freneta"];
Fibaza.masa.Transpose[Fibaza])]
(*Table[Sum[Fibaza[[i,I]]masa[[I,J]]Fibaza[[j,J]],{I,1,lpol},{J,1,lpol}],{i,1,lpol},{j,1,Length[Fibaza]}])]*)


(* efektywna macierz masy dla zmiennych Q\[Sigma] i Qs(i) (dla zakrzywionej trajektorii) *)
macierzMasyEf[masaBF_,dkaty_]:=macierzMasyEf[masaBF,dkaty]=
Block[{lpol,masa},(lpol=Length[masaBF];
masa=masaBF;

(* zmiana wyraz\[OAcute]w diagonalnych *)
Print[TimeObject[Now]," Efektywna macierz masy"];
masa[[1,1]]=masa[[1,1]]-dkaty[[1]]^2;
Do[masa[[i,i]]=masa[[i,i]]-dkaty[[i-1]]^2-dkaty[[i]]^2, {i,2,lpol-1}];
masa[[lpol,lpol]]=masa[[lpol,lpol]]-dkaty[[lpol-1]]^2;

(* efektywna macierz masy *)
masa)]


(* ::Section:: *)
(*R\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich krzywizny i izokrzywizny*)


(* podstawienia zmiennych krzywizny i izokrzywizny oraz podstawienia pierwotnych/MS perturbacji wyra\:017conych przez perturbacje krzywizny i izokrzywizny *)
podstawieniaRS[pola_,Go_,Ebaza_,x_,dd\[Phi]N0_,MS_:True]:=
(*podstawieniaRS[pola,Go,Ebaza,x,dd\[Phi]N0,MS]=*)
Block[{lpol,isPrzestrzenPol,perturbacjep,perturbacjeae,perturbacjeaen,d\[Sigma]sN,dtd\[Sigma]sN,dttd\[Sigma]sN,d\[Phi]\[Sigma]sN,dtd\[Phi]\[Sigma]sN,dttd\[Phi]\[Sigma]sN},(
lpol=Length[pola];

(* iloczyn skalarny w przestrzeni p\[OAcute]l *)
isPrzestrzenPol[v1_,v2_]:=mrkUzyteczny`iloczynSkalarnyG[Go,v1,v2];

(* lista nazw sk\[LSlash]adowych fourierowskich perturbacji p\[OAcute]l *)
perturbacjep=(perturbacjep=If[MS, mrkUzyteczny`perturbacjeNazwy["Q",pola], mrkUzyteczny`perturbacjeNazwy["\[Delta]",pola]]; 
	perturbacjep=mrkFourier`perturbacjekw[perturbacjep]; Map[#[x[[1]]] &, perturbacjep]);

(* lista nazw sk\[LSlash]adowych fourierowskich nowych zmiennych *)
perturbacjeaen=perturbacjeRSkw[pola,MS];
perturbacjeae=Map[#[x[[1]]] &,perturbacjeaen];

(* definicje sk\[LSlash]adowych fourierowskich nowych zmiennych - rozk\[LSlash]ad perturbacji p\[OAcute]l na kierunek adiabatyczny i kierunki entropowe:
\[Delta]\[Sigma]=G_IJ*E_\[Sigma]^I*Q\[Phi]^J - perturbacje r\[OAcute]wnoleg\[LSlash]e do wektora pr\:0119dko\:015bci (jednorodnych trajektorii) w przestrzeni p\[OAcute]l,
\[Delta]s{i}=G_IJ*E_s{i}^I*Q\[Phi]^J - perturbacje prostopad\[LSlash]e *)
d\[Sigma]sN=Table[isPrzestrzenPol[Ebaza[[I]],perturbacjep],{I,1,lpol}];
d\[Sigma]sN=MapThread[#1->#2 &, {perturbacjeae,d\[Sigma]sN}];
(* pierwsze i drugie pochodne po czasie *)
dtd\[Sigma]sN=D[d\[Sigma]sN,x[[1]]]/.dd\[Phi]N0;
dttd\[Sigma]sN=D[dtd\[Sigma]sN,x[[1]]]/.dd\[Phi]N0;

(* wyznaczenie sk\[LSlash]adowych fourierowskich perturbacji pierwotnych/MS p\[OAcute]l z nowych zmiennych *)
d\[Phi]\[Sigma]sN=Simplify[Solve[Table[d\[Sigma]sN[[J,2]]==perturbacjeae[[J]],{J,1,lpol}],perturbacjep][[1]]];
(* wyra\:017cenie pierwszych i drugich pochodnych po czasie sk\[LSlash]adowych fourierowskich pierwotnych/MS perturbacji przez pochodne perturbacji krzywizny i izokrzywizny *)
dtd\[Phi]\[Sigma]sN=D[d\[Phi]\[Sigma]sN,x[[1]]]/.dd\[Phi]N0;
dttd\[Phi]\[Sigma]sN=D[dtd\[Phi]\[Sigma]sN,x[[1]]]/.dd\[Phi]N0;

(* {{podstwienia zmiennych krzywizny i izokrzywizny}, {podstwienia perturbacji pierwotnych/MS i ich pierwszych i drugich pochodnych}} *)
{{d\[Sigma]sN,dtd\[Sigma]sN,dttd\[Sigma]sN},{d\[Phi]\[Sigma]sN,dtd\[Phi]\[Sigma]sN,dttd\[Phi]\[Sigma]sN}})]


(* zamiana pochodnych potencja\[LSlash]u zapisanego w jednych zmiennych w inne *)
zamianadV[x_,polas_,polan_,Vs_,Vn_,Ebaza_,listad_]:=zamianadV[x,polas,polan,Vs,Vn,Ebaza,listad]=
Block[{lpol,len,dvvn,dd,dvvs,polast,polant,rown,szukane,rozw},(lpol=Length[polas]; len=Length[listad];
(* stare i nowe zmienne (argumenty potencja\[LSlash]u), zale\:017c\:0105ce od czasu *)
polast=Map[#[x[[1]]] &,polas];
polant=Map[#[x[[1]]] &,polan];

(* pierwsze i drugie pochodne potencja\[LSlash]u zale\:017cnego od {\[Sigma][t],s1[t],s2[t],...} (baza zale\:017cy od czasu - kierunki \[Sigma],s1,s2,... zmieniaj\:0105 si\:0119 w czasie) *)
(* ===================== nale\:017cy zmieni\[CAcute] wyznaczanie pochodnych dla wy\:017cszych rz\:0119d\[OAcute]w i mo\:017ce wi\:0119kszej ilo\:015bci p\[OAcute]l? ============================ *)
(* pochodne potencja\[LSlash]\[OAcute]w, np. V\[Sigma]s,\[Sigma]=E^I\[Sigma]V,I i V\[Sigma]s,\[Sigma]s=E^I\[Sigma]E^JsV,IJ *)
dvvn=Table[Derivative[Sequence@@listad[[i]]][Symbol["vvn"]][Sequence@@polant]=
	(dd=Table[Table[Position[listad[[i]],j],{j}]//Flatten,{j,1,Max[listad]}];
	If[Length[dd[[1]]]==1, Sum[Ebaza[[dd[[1,1]],I]]D[Symbol[Vs][Sequence@@polast],polast[[I]]],{I,1,lpol}],
		(dd=dd//Flatten; 
		Sum[Ebaza[[dd[[1]],I]]Ebaza[[dd[[2]],J]]D[D[Symbol[Vs][Sequence@@polast],polast[[I]]],polast[[J]]],{I,1,lpol},{J,1,lpol}])]),
	{i,1,Length[listad]}];

Print[TimeObject[Now]," Pochodne potencja\[LSlash]u w zmiennych \[Sigma] i s"];
(* wyra\:017cenie pochodnych potencja\[LSlash]\[OAcute]w zale\:017cnych od pierwotnych p\[OAcute]l przez pochodne nowych potencja\[LSlash]\[OAcute]w zale\:017cnych od \[Sigma],s1,s2,... *)
rown=Table[Derivative[Sequence@@listad[[i]]][Symbol["vvn"]][Sequence@@polant]==Derivative[Sequence@@listad[[i]]][Symbol[Vn]][Sequence@@polant],{i,1,len}];
szukane=Table[Derivative[Sequence@@listad[[i]]][Symbol[Vs]][Sequence@@polast],{i,1,len}];
rozw={};
dvvs=TimeConstrained[dvvs=Reap[Do[rown=rown/.rozw; rozw=Solve[rown[[i]],szukane]; rozw=If[rozw=={},{},rozw[[1]]]; Sow[rozw],{i,1,len}]][[2,1]]; 
     Table[dvvs[[i]]//.Flatten[Drop[dvvs,{1,i}]],{i,1,len}]//Flatten, 180, {}];
(* {wzory na nowe pochodne, podstawienia starych pochodnych} *)
{dvvn,dvvs})]


(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych adiabatycznej i entropowych *)
ruchuRNAEkw[pola_,listao_,Ebaza_,x_,rownaniaNkw_,dd\[Phi]N0_,MS_:True,r_:1,zamianaV_:False]:=
ruchuRNAEkw[pola,listao,Ebaza,x,rownaniaNkw,dd\[Phi]N0,MS,r,zamianaV]=
Block[{lpol,Go,Xo,isPrzestrzenPol,perturbacjep,perturbacjeae,perturbacjeaen,zmae,zmaen,d\[Sigma]sN,d\[Sigma]2,dtt\[Sigma],dtt\[Phi]1,
warunek,dvv\[Sigma]s,listd,dsdvv\[Sigma]s,pozycje,dV\[Phi]\[Sigma]s,dtsN,d\[Phi]\[Sigma]sN,dtd\[Phi]\[Sigma]sN,dttd\[Phi]\[Sigma]sN,rrd\[Sigma]s},(
lpol=Length[pola];
(* lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {tensor metryczny w przestrzeni p\[OAcute]l, cz\[LSlash]on kinetyczny} *)
{Go,Xo}=listao;
(* iloczyn skalarny w przestrzeni p\[OAcute]l *)
isPrzestrzenPol[v1_,v2_]:=mrkUzyteczny`iloczynSkalarnyG[Go,v1,v2];

(* lista nazw sk\[LSlash]adowych fourierowskich perturbacji p\[OAcute]l *)
perturbacjep=(perturbacjep=If[MS, mrkUzyteczny`perturbacjeNazwy["Q",pola], mrkUzyteczny`perturbacjeNazwy["\[Delta]",pola]]; 
	perturbacjep=mrkFourier`perturbacjekw[perturbacjep]; Map[#[x[[1]]] &,perturbacjep]);
(* lista nazw nowych zmiennych: \[Sigma] (adiabatyczna - krzywizny), s1,s2,... (entropowe - izokrzywizny) *)
zmaen=Join[{Symbol["\[Sigma]"]},Table[ToExpression["s"<>ToString[J]],{J,1,lpol-1}]];
zmae=Map[#[x[[1]]] &,zmaen];
(* lista nazw sk\[LSlash]adowych fourierowskich nowych zmiennych *)
perturbacjeaen=perturbacjeRSkw[pola,MS];
perturbacjeae=Map[#[x[[1]]] &,perturbacjeaen];

(* definicje sk\[LSlash]adowych fourierowskich nowych zmiennych - rozk\[LSlash]ad perturbacji p\[OAcute]l na kierunek adiabatyczny i kierunki entropowe:
\[Delta]\[Sigma]=G_IJ*E_\[Sigma]^I*Q\[Phi]^J - perturbacje r\[OAcute]wnoleg\[LSlash]e do wektora pr\:0119dko\:015bci (jednorodnych trajektorii) w przestrzeni p\[OAcute]l,
\[Delta]s{i}=G_IJ*E_s{i}^I*Q\[Phi]^J - perturbacje prostopad\[LSlash]e *)
d\[Sigma]sN=Table[isPrzestrzenPol[Ebaza[[I]],perturbacjep],{I,1,lpol}];

(* podstawienia z pomocnicz\:0105 zmienn\:0105 \[Sigma][t] (\[Sigma] nie jest polem skalarnym): \[Sigma]'[t]=Sqrt[2X] *)
(* \[Sigma]'[t]>0 *)
warunek=(D[zmae[[1]],x[[1]]]>0);
(* (fi{i}'[t]) \[Rule] \[Sigma]'[t]^2 *)
d\[Sigma]2={Expand[(2*Xo/.{Symbol["P"]->0})]->zmaen[[1]]'[x[[1]]]^2};
(* \[Sigma]''[t] \[Rule] (\[Sigma]'[t],fi{i}'[t]) *)
dtt\[Sigma]=Simplify[Simplify[{zmaen[[1]]''[x[[1]]]->D[Sqrt[2Xo/.{Symbol["P"]->0}],x[[1]]]}/.dd\[Phi]N0]/.d\[Sigma]2,warunek];
(* fi1''[t] \[Rule] (\[Sigma]'[t],\[Sigma]''[t],fi{i}'[t],fi{i}''[t] i\[NotEqual]1) *)
dtt\[Phi]1=Simplify[Solve[{zmaen[[1]]''[x[[1]]]==D[Sqrt[2Xo/.{Symbol["P"]->0}],x[[1]]]},pola[[1]]''[x[[1]]]][[1]]/.d\[Sigma]2,warunek];

(* poni\:017csze zamiany zostan\:0105 wykorzystane, je\:017celi w lagran\:017cjanie potencja\[LSlash] oznaczono przez V *)
If[zamianaV,(					
	(* lista mo\:017cliwych pochodnych potencja\[LSlash]u *)
	listd=Select[Tuples[Range[0,r+1],lpol],0<Total[#]<=(r+1) &];
	(* pochodne potencja\[LSlash]\[OAcute]w w nowych zmiennych, np. V\[Sigma]s,\[Sigma]=E^I\[Sigma]V,I i V\[Sigma]s,\[Sigma]s=E^I\[Sigma]E^JsV,IJ oraz
	wyra\:017cenie pochodnych potencja\[LSlash]\[OAcute]w zale\:017cnych od pierwotnych p\[OAcute]l przez pochodne nowych potencja\[LSlash]\[OAcute]w zale\:017cnych od \[Sigma],s1,s2,... *)
	{dvv\[Sigma]s,dV\[Phi]\[Sigma]s}=zamianadV[x,pola,zmaen,"V","V\[Sigma]s",Ebaza,listd];

	(* lista pierwszych pochodnych *)
	dsdvv\[Sigma]s=(pozycje=Position[listd,{poz__}/;Total[{poz}]==1]//Flatten; dvv\[Sigma]s[[pozycje]]);
	(* ===================== czy podstawienia b\:0119d\:0105 zawsze w dobrej kolejno\:015bci? ============================= *)
	(* ===================== czy ta zamiana w og\[OAcute]le jest potrzebna??? ======================= *)
	(* wyznaczenie s{i}'[t] z pochodnej po czasie V\[Sigma]s[\[Sigma][t],s1[t],s2[t],...],i 
	(wybieram V\[Sigma]s,i , bo wiem, \:017ce s{i}'[t] stoi przy V\[Sigma]s,ii , a chc\:0119, \:017ceby si\:0119 \[LSlash]adnie poskraca\[LSlash]o) *)
	dtsN=Table[Simplify[
		Solve[(D[dsdvv\[Sigma]s[[I-1]],x[[1]]]/.dd\[Phi]N0/.dV\[Phi]\[Sigma]s)==D[D[Symbol["V\[Sigma]s"][Sequence@@zmae],zmae[[I]]],x[[1]]],D[zmae[[I]],x[[1]]]][[1]]],
		{I,2,lpol}]//Flatten;),
	(dV\[Phi]\[Sigma]s={}; dtsN={};)];

Print[TimeObject[Now]," R\[OAcute]wnania ruchu dla sk\[LSlash]adowych krzywizny i izokrzywizny"];
(* ===================== czy podstawienia b\:0119d\:0105 zawsze w dobrej kolejno\:015bci? ============================= *)
If[r==0,
(* r\[OAcute]wnanie ruchu t\[LSlash]a w kierunku adiabatycznym *)
(rrd\[Sigma]s=Simplify[Simplify[
	Thread[Sum[Thread[Sum[(Go/.{Symbol["P"]->0})[[J,K]]*Ebaza[[1,K]],{K,1,lpol}]*rownaniaNkw[[J]],Equal],
	{J,1,lpol}],Equal]/.dtt\[Phi]1/.dd\[Phi]N0/.dV\[Phi]\[Sigma]s]/.d\[Sigma]2,warunek];
Collect[mrkUzyteczny`wspolczynnik1Row[rrd\[Sigma]s,D[zmae[[1]],{x[[1]],2}]],
	mrkUzyteczny`grupowanie[zmaen,1],Expand]),

((* wyznaczenie sk\[LSlash]adowych fourierowskich perturbacji pierwotnych/MS p\[OAcute]l z nowych zmiennych *)
d\[Phi]\[Sigma]sN=Solve[Table[d\[Sigma]sN[[J]]==perturbacjeae[[J]],{J,1,lpol}],perturbacjep][[1]];
(* wyra\:017cenie pierwszych i drugich pochodnych po czasie sk\[LSlash]adowych fourierowskich pierwotnych/MS perturbacji przez pochodne perturbacji krzywizny i izokrzywizny *)
dtd\[Phi]\[Sigma]sN=D[d\[Phi]\[Sigma]sN,x[[1]]]/.dd\[Phi]N0/.dtt\[Sigma]/.dV\[Phi]\[Sigma]s;
dttd\[Phi]\[Sigma]sN=D[dtd\[Phi]\[Sigma]sN,x[[1]]]/.dd\[Phi]N0/.dtt\[Sigma]/.dV\[Phi]\[Sigma]s;

(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich perturbacji krzywizny i izokrzywizny *)
Table[(rrd\[Sigma]s=Simplify[Simplify[Collect[Thread[Sum[Thread[
		Sum[(Go/.{Symbol["P"]->0})[[J,K]]*Ebaza[[n,K]],{K,1,lpol}]*(rownaniaNkw[[J]]/.dttd\[Phi]\[Sigma]sN/.dtd\[Phi]\[Sigma]sN/.d\[Phi]\[Sigma]sN/.dV\[Phi]\[Sigma]s/.dtsN),Equal],{J,1,lpol}],Equal],
		mrkUzyteczny`grupowanie[perturbacjeaen,n],Simplify] /. d\[Sigma]2, warunek],d\[Sigma]2[[1,1]]==d\[Sigma]2[[1,2]]]; 
	Refine[Collect[Refine[Collect[mrkUzyteczny`wspolczynnik1Row[rrd\[Sigma]s,D[perturbacjeae[[n]],{x[[1]],2}]],
		mrkUzyteczny`grupowanie[Flatten[{perturbacjeaen,Symbol["V\[Sigma]s"]}],n],Simplify] /. d\[Sigma]2, warunek],
		mrkUzyteczny`grupowanie[perturbacjeaen,n], Expand] /. d\[Sigma]2,
		warunek]),{n,1,lpol}])]
)]


(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych adiabatycznej i entropowych - tylko zamiana p\[OAcute]l (wersja do oblicze\:0144) *)
ruchuRNAEkwO[pola_,Go_,Ebaza_,x_,rownaniaNkw_,dd\[Phi]N0_,MS_:True,r_:1]:=
ruchuRNAEkwO[pola,Go,Ebaza,x,rownaniaNkw,dd\[Phi]N0,MS,r]=
Block[{lpol,podstHN,isPrzestrzenPol,perturbacjep,perturbacjeae,perturbacjeaen,zmae,zmaen,
d\[Sigma]sN,d\[Phi]\[Sigma]sN,dtd\[Phi]\[Sigma]sN,dttd\[Phi]\[Sigma]sN,rrd\[Sigma]s},(
lpol=Length[pola];
(* podstawienie parametru Hubble'a *)
podstHN=mrkUzyteczny`zastapienieHN[x];
(* iloczyn skalarny w przestrzeni p\[OAcute]l *)
isPrzestrzenPol[v1_,v2_]:=mrkUzyteczny`iloczynSkalarnyG[Go,v1,v2];

(* lista nazw sk\[LSlash]adowych fourierowskich perturbacji p\[OAcute]l *)
perturbacjep=(perturbacjep=If[MS, mrkUzyteczny`perturbacjeNazwy["Q",pola], mrkUzyteczny`perturbacjeNazwy["\[Delta]",pola]]; 
	perturbacjep=mrkFourier`perturbacjekw[perturbacjep]; Map[#[x[[1]]] &, perturbacjep]);
(* lista nazw nowych zmiennych: \[Sigma] (adiabatyczna - krzywizny), s1,s2,... (entropowe - izokrzywizny) *)
zmaen=Join[{Symbol["\[Sigma]"]},Table[ToExpression["s"<>ToString[J]],{J,1,lpol-1}]];
zmae=Map[#[x[[1]]] &,zmaen];
(* lista nazw sk\[LSlash]adowych fourierowskich nowych zmiennych *)
perturbacjeaen=perturbacjeRSkw[pola,MS];
perturbacjeae=Map[#[x[[1]]] &,perturbacjeaen];

(* definicje sk\[LSlash]adowych fourierowskich nowych zmiennych - rozk\[LSlash]ad perturbacji p\[OAcute]l na kierunek adiabatyczny i kierunki entropowe:
\[Delta]\[Sigma]=G_IJ*E_\[Sigma]^I*Q\[Phi]^J - perturbacje r\[OAcute]wnoleg\[LSlash]e do wektora pr\:0119dko\:015bci (jednorodnych trajektorii) w przestrzeni p\[OAcute]l,
\[Delta]s{i}=G_IJ*E_s{i}^I*Q\[Phi]^J - perturbacje prostopad\[LSlash]e *)
d\[Sigma]sN=Table[isPrzestrzenPol[Ebaza[[I]],perturbacjep],{I,1,lpol}];

Print[TimeObject[Now]," R\[OAcute]wnania ruchu dla sk\[LSlash]adowych krzywizny i izokrzywizny (O)"];
If[r==0,
(* r\[OAcute]wnanie ruchu t\[LSlash]a w kierunku adiabatycznym *)
(rrd\[Sigma]s=Simplify[Thread[
	Sum[Thread[Sum[(Go/.{Symbol["P"]->0})[[J,K]]*Ebaza[[1,K]],{K,1,lpol}]*rownaniaNkw[[J]],Equal],{J,1,lpol}],Equal]/.dd\[Phi]N0];
Collect[mrkUzyteczny`wspolczynnik1Row[rrd\[Sigma]s,D[zmae[[1]],{x[[1]],2}]],
	mrkUzyteczny`grupowanie[zmaen,1],Expand]),
	
((* wyznaczenie sk\[LSlash]adowych fourierowskich perturbacji pierwotnych/MS p\[OAcute]l z nowych zmiennych *)
d\[Phi]\[Sigma]sN=Simplify[Solve[Table[d\[Sigma]sN[[J]]==perturbacjeae[[J]],{J,1,lpol}],perturbacjep][[1]]];
(* wyra\:017cenie pierwszych i drugich pochodnych po czasie sk\[LSlash]adowych fourierowskich pierwotnych/MS perturbacji przez pochodne perturbacji krzywizny i izokrzywizny *)
dtd\[Phi]\[Sigma]sN=D[d\[Phi]\[Sigma]sN,x[[1]]]/.dd\[Phi]N0;
dttd\[Phi]\[Sigma]sN=D[dtd\[Phi]\[Sigma]sN,x[[1]]]/.dd\[Phi]N0;

(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich perturbacji krzywizny i izokrzywizny *)
Table[(rrd\[Sigma]s=Collect[Thread[Sum[Thread[
		Sum[(Go/.{Symbol["P"]->0})[[J,K]]*Ebaza[[n,K]],{K,1,lpol}]*(rownaniaNkw[[J]]/.dttd\[Phi]\[Sigma]sN/.dtd\[Phi]\[Sigma]sN/.d\[Phi]\[Sigma]sN),Equal],{J,1,lpol}],Equal],
		mrkUzyteczny`grupowanie[perturbacjeaen,n],Simplify];
	Collect[mrkUzyteczny`wspolczynnik1Row[rrd\[Sigma]s,D[perturbacjeae[[n]],{x[[1]],2}]],
		mrkUzyteczny`grupowanie[perturbacjeaen,n],Expand]),{n,1,lpol}])] /.podstHN
)]


(* lista wsp\[OAcute]\[LSlash]czynnik\[OAcute]w oddzia\[LSlash]ywania mi\:0119dzy perturbacjami krzywizny i izokrzywizny *)
wspRNAEkw[pola_,Go_,Ebaza_,x_,rownaniaNkw_,dd\[Phi]N0_,MS_:True,r_:1]:=
wspRNAEkw[pola,Go,Ebaza,x,rownaniaNkw,dd\[Phi]N0,MS,r]=
Block[{lpol,rowN,pert,gl,zmienne},(lpol=Length[pola];
(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich perturbacji krzywizny i izokrzywizny *)
rowN=ruchuRNAEkwO[pola,Go,Ebaza,x,rownaniaNkw,dd\[Phi]N0,MS,r];

(* lista sk\[LSlash]adowych fourierowskich perturbacji *)
pert=perturbacjeRSkw[pola,MS];
pert=Map[#[x[[1]]] &, pert];

Print[TimeObject[Now]," Wsp\[OAcute]\[LSlash]czynniki oddzia\[LSlash]ywania"];
(* lista wsp\[OAcute]\[LSlash]czynnik\[OAcute]w oddzia\[LSlash]ywania w formie {{C_\[Sigma]s1, C_\[Sigma]s2, ...}, {C_s1\[Sigma], C_s1s2, ...}, ...} *)
Reap[Do[
	gl=D[pert[[i]],{x[[1]],2}];
	zmienne=Delete[pert,i];
	Sow[mrkUzyteczny`wspolczynnikiRow[rowN[[i]],gl,zmienne]],
{i,1,lpol}]][[2,1]]
)]


End[];
EndPackage[];
