(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkProdukcjaCzastek`*)


(* :Title: Produkcja cz\:0105stek *)

(* :Context: mrkProdukcjaCzastek` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji
liczba obsadze\:0144
rozwi\:0105zania z uwzgl\:0119dnieniem produkcji cz\:0105stek
*)

(* :Copyright: *)

(* :Package Version: 1.1 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 26.04.2017
    Version 1.1, 21.07.2017
      - g\:0119sto\:015b\[CAcute] energii wyprodukowanych cz\:0105stek dla danego czasu
      - rozwi\:0105zania dla t\[LSlash]a z uwzgl\:0119dnieniem produkcji cz\:0105stek 
*)

(* :Keywords: *)

(* :Requirements: 
"mrkUzyteczny`", "mrkRozwiazania`"
*)

(* :Sources: *)

(* :Warnings: 
*)

(* :Limitations:
*)

(* :Discussion: 
- liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn
- czynnik skali w tensorze metrycznym musi by\[CAcute] oznaczony przez a
- liczba falowa musi by\[CAcute] oznaczona przez kk

- parametr Hubble'a jest oznaczany przez H
*)



BeginPackage["mrkProdukcjaCzastek`",{"mrkUzyteczny`","mrkRozwiazania`"}];

ruchuRNukw::usage="ruchuRNukw[x,La,Xo,rownaniaRNkw]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
Xo - cz\[LSlash]on kinetyczny z polami podzielonymi na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P; mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
rownaniaRNkw - r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich perturbacji (uwaga! parametr Hubble'a musi by\[CAcute] oznaczony przez H, za\:015b czynnik skali przez a);
wyj\:015bcie: r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji: u(\[Tau])=a(\[Tau])*Q\[Phi](\[Tau])";

przejscieQu::usage="przejscieQu[x,La,Xo,rozwiazaniaP,fun:{},param:{}]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
Xo - cz\[LSlash]on kinetyczny z polami podzielonymi na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P; mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
rozwiazaniaP - rozwi\:0105zania dla perturbacji dla dowolnej liczby przebieg\[OAcute]w w formie {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(1\)]\),...},{\!\(\*SubscriptBox[\(Q1\), \(2\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...} (uwaga! to musz\:0105 by\[CAcute] same rozwi\:0105zania, a nie lista podstawie\:0144),
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
wyj\:015bcie: lista rozwi\:0105za\:0144 dla wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji krzywizny (\!\(\*SubscriptBox[\(u\), \(\[Sigma]\)]\)(\[Tau])=a(\[Tau])*(\!\(\*SqrtBox[SubscriptBox[\(P\), \(\(,\)\(X\)\)]]\)/\!\(\*SubscriptBox[\(c\), \(s\)]\))*\!\(\*SubscriptBox[\(Q\), \(\[Sigma]\)]\)(\[Tau])) i izokrzywizny (\!\(\*SubscriptBox[\(u\), \(s\)]\)(\[Tau])=a(\[Tau])*\!\(\*SqrtBox[SubscriptBox[\(P\), \(\(,\)\(X\)\)]]\)*\!\(\*SubscriptBox[\(Q\), \(s\)]\)(\[Tau])) dla wszystkich przebieg\[OAcute]w: {{\!\(\*SubscriptBox[\(u\), \(\[Sigma]1\)]\),\!\(\*SubscriptBox[\(u\), \(\[Sigma]2\)]\),...},{\!\(\*SubscriptBox[\(u\), \(s11\)]\),\!\(\*SubscriptBox[\(u\), \(s12\)]\),...},...}";

liczbaObsadzen::usage="liczbaObsadzen[x,La,Xo,Lao,baza,masy,rozwiazaniaPk,dd\[Phi]N0,fun:{},param:{},FT:True]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
Xo - cz\[LSlash]on kinetyczny z polami podzielonymi na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P; mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
Lao - lagran\:017cjan z polami podzielonymi na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P; mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
baza - baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy,
masy - lista warto\:015bci w\[LSlash]asnych macierzy masy - kwadraty mas,
rozwiazaniaPk - rozwi\:0105zania dla perturbacji z liczb\:0105 falow\:0105 jako parametrem dla dowolnej liczby przebieg\[OAcute]w w formie {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(1\)]\),...},{\!\(\*SubscriptBox[\(Q1\), \(2\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...} (uwaga! to musz\:0105 by\[CAcute] same rozwi\:0105zania, a nie lista podstawie\:0144),
dd\[Phi]N0 - podstawienia drugich pochodnych pierwotnych p\[OAcute]l (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`ddpolaN0),
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
FT - czy ma zosta\[CAcute] zastosowane przybli\:017cenie szybkiego zakr\:0119tu (zaniedbanie ekspansji Wszech\:015bwiata na zakr\:0119cie);
wyj\:015bcie: lista liczb obsadze\:0144 kolejnych stan\[OAcute]w w\[LSlash]asnych";

gestoscEnergiiCzastek::usage="gestoscEnergiiCzastek[x,Lao,masy,lobsadzenk,fun:{},param:{}]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
Lao - lagran\:017cjan z polami podzielonymi na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P; mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
masy - lista mas,
lobsadzenk - lista liczb obsadze\:0144, odpowiadaj\:0105cych kolejnym masom (bez podstawienia konkretnego modu; uwaga! liczba falowa musi by\[CAcute] oznaczona przez kk),
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
wyj\:015bcie: g\:0119sto\:015b\[CAcute] energii wyprodukowanych cz\:0105stek zale\:017cna od czasu dla mod\[OAcute]w aH<k<am";

gestoscEnergiiCzastekTest::usage="gestoscEnergiiCzastekTest[x,La,listao,rozwiazania0,rozwiazaniaPk,masa,t0]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
listao - metryka w przestrzeni p\[OAcute]l, cz\[LSlash]on kinetyczny i lagran\:017cjan z polami podzielonymi na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P; mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn), 
rozwiazaniaPk - lista rozwi\:0105za\:0144 dla perturbacji z liczb\:0105 falow\:0105 jako parametrem (uwaga! liczba falowa musi by\[CAcute] oznaczona przez kk),
masa - macierz masy,
t0 - czas kosmiczny, w kt\[OAcute]rym ma zosta\[CAcute] obliczona g\:0119sto\:015b\[CAcute] energii cz\:0105stek;
wyj\:015bcie: g\:0119sto\:015b\[CAcute] energii wyprodukowanych cz\:0105stek w danym czasie dla mod\[OAcute]w aH<k<am";

rozwiazanieTloProdukcjaCzastek::usage="rozwiazanieTloProdukcjaCzastek[pola,x,rruchu0,rpola0,listatf,wp,N0,ti:0]: 
pola - lista nazw p\[OAcute]l, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rruchu0 - lista r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! musz\:0105 by\[CAcute] podstawione wszystkie funkcje i parametry),
rpola0 - r\[OAcute]wnanie pola 00 w zerowym rz\:0119dzie w perturbacjach (uwaga! musz\:0105 by\[CAcute] podstawione wszystkie funkcje i parametry), 
listatf - lista ko\:0144cowych warto\:015b\[CAcute] czasu kosmicznego,
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu kosmicznego;
wyj\:015bcie: rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a z uwzgl\:0119dnieniem produkcji cz\:0105stek (podstawienia funkcji odcinkowych)";

rozwiazanieProdukcjaCzastek::usage="rozwiazanieProdukcjaCzastek[pola,x,rruchu0,rpola0,listatf,wp,N0,ti:0]: 
pola - lista nazw p\[OAcute]l, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rruchu0 - lista r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! musz\:0105 by\[CAcute] podstawione wszystkie funkcje i parametry),
rpola0 - r\[OAcute]wnanie pola 00 w zerowym rz\:0119dzie w perturbacjach (uwaga! musz\:0105 by\[CAcute] podstawione wszystkie funkcje i parametry), 
listatf - lista ko\:0144cowych warto\:015b\[CAcute] czasu kosmicznego,
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu kosmicznego;
wyj\:015bcie: rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a z uwzgl\:0119dnieniem produkcji cz\:0105stek (podstawienia funkcji odcinkowych)";

Begin["`Private`"];


(* ::Section:: *)
(*Sk\[LSlash]adowe fourierowskie wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji*)


(* wsp\[OAcute]\[LSlash]czynniki przej\:015bcia od perturbacji krzywizny i izokrzywizny do wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji: 
{a*(P'(X))^(1/2)/c_s, a*(P'(X))^(1/2)}, gdzie cs - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku, X - cz\[LSlash]on kinetyczny w lagran\:017cjanie P;
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
Xo - cz\[LSlash]on kinetyczny z polami podzielonymi na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P) *)
wspQu[x_,La_,Xo_]:=wspQu[x,La,Xo]=
Symbol["a"][x[[1]]]*{Sqrt[D[La,Symbol["XK"]]+2*Symbol["XK"]*D[La,{Symbol["XK"],2}]], Sqrt[D[La,Symbol["XK"]]]} /. Symbol["XK"]->Xo /. Symbol["P"]->0


(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji: 
u_1(\[Tau])=a(\[Tau])*((P'(X))^(1/2)/c_s)*Q\[Phi](\[Tau]) i u_j(\[Tau])=a(\[Tau])*((P'(X))^(1/2))*Q\[Phi](\[Tau]) dla j=2,3,... *)
ruchuRNukw[x_,La_,Xo_,rownaniaRNkw_]:=
ruchuRNukw[x,La,Xo,rownaniaRNkw]=
Block[{lpol,rowN\[Tau],rowNu,pert,wspPert,wsp},(
lpol=Length[rownaniaRNkw];
(* przej\:015bcie do czasu konforemnego dt \[Rule] a*d\[Tau] - zamiana pierwszych i drugich pochodnych po czasie *)
rowN\[Tau]=rownaniaRNkw /. mrkUzyteczny`zastapienieH[x] /.
	{Derivative[1][z__][x[[1]]]->Derivative[1][z][x[[1]]]/Symbol["a"][x[[1]]],
	Derivative[2][z__][x[[1]]]->Derivative[2][z][x[[1]]]/Symbol["a"][x[[1]]]^2-Derivative[1][z][x[[1]]]Symbol["a"]'[x[[1]]]/Symbol["a"][x[[1]]]^3};

(* nazwy perturbacji *)
pert=Cases[Flatten[Map[Variables[#/.Equal->List] &, rowN\[Tau]]], Derivative[2][z__][x[[1]]]->z];
wspPert=Map[ToExpression["u"<>ToString[#]] &, pert];

Print[TimeObject[Now]," R\[OAcute]wnania ruchu dla zmiennych wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119"];
(* wsp\[OAcute]\[LSlash]czynniki przej\:015bcia: {a*(P'(X))^(1/2)/c_s, a*(P'(X))^(1/2)} *)
wsp=wspQu[x,La,Xo] /. x[[1]]->#1;
(* przej\:015bcie do wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 funkcji falowych u=a*Q *)
(*rowNu=rowN\[Tau] /. Table[pert[[i]]->(Evaluate[wspPert[[i]][#1]/Symbol["a"][#1]] &), {i,1,lpol}];*)
rowNu=rowN\[Tau] /. Flatten[{pert[[1]]->(Evaluate[wspPert[[1]][#1]/wsp[[1]]] &), 
	Table[pert[[i]]->(Evaluate[wspPert[[i]][#1]/wsp[[2]]] &), {i,2,lpol}]}];
	
(* zamiana oznaczenia czasu na czas konforemny *)
rowNu=rowNu /. mrkUzyteczny`podstawienieH[x] /. x[[1]]->Symbol["\[Tau]"];
Table[Collect[mrkUzyteczny`wspolczynnik1Row[rowNu[[i]],wspPert[[i]]''[Symbol["\[Tau]"]]], 
	mrkUzyteczny`grupowanie[wspPert,i], Expand], {i,1,lpol}])]


(* lista rozwi\:0105za\:0144 dla wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji krzywizny i izokrzywizny dla wszystkich przebieg\[OAcute]w: {{uQ\[Sigma]1,uQ\[Sigma]2,...},{uQs11,uQs12,...},...};
dla perturbacji krzywizny u_\[Sigma]=(a*(P'(X))^(1/2)/c_s)*Q\[Sigma] i izokrzywizny u_s=a*(P'(X))^(1/2)*Qs,
gdzie cs - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku, X - cz\[LSlash]on kinetyczny w lagran\:017cjanie P *)
przejscieQu[x_,La_,Xo_,rozwiazaniaP_,fun_:{},param_:{}]:=
przejscieQu[x,La,Xo,rozwiazaniaP,fun,param]=
Block[{wsp,pertu},(
(* wsp\[OAcute]\[LSlash]czynniki przej\:015bcia: {a*(P'(X))^(1/2)/c_s, a*(P'(X))^(1/2)};
przyj\:0119to a_0=Exp(N_0), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
wsp=wspQu[x,La,Xo] /. Symbol["a"][x[[1]]]->Exp[Symbol["nn"][x[[1]]]];

(* wsp\[OAcute]\[LSlash]poruszaj\:0105ce si\:0119 perturbacje *)
pertu=rozwiazaniaP;
pertu=Join[{pertu[[1]]*wsp[[1]]}, Drop[pertu,1]*wsp[[2]]];
pertu /. fun /. param)]


(* ::Section:: *)
(*Liczba obsadze\:0144*)


(* liczba obsadze\:0144 *)
liczbaObsadzen[x_,La_,Xo_,Lao_,baza_,masy_,rozwiazaniaPk_,fun_:{},param_:{},FT_:True]:=
(*liczbaObsadzen[x,La,Xo,Lao,baza,masy,rozwiazaniaPk,fun,param,FT]=*)
Block[{lpol,omd,pertu,wsp\[Beta]},(lpol=Length[masy];
(* diagonalna macierz cz\:0119sto\:015bci \[Omega]^2=k^2 - a''(\[Tau])/a + a^2*m^2 (gdzie: a''(\[Tau])/a=a'(t)^2+a*a''(t)) *)
omd=If[FT, Sqrt[Symbol["kk"]^2*IdentityMatrix[lpol]+Exp[2*Symbol["nn"][x[[1]]]]*DiagonalMatrix[masy]],
	Sqrt[(Symbol["kk"]^2 - (Exp[2*Symbol["nn"][x[[1]]]]*(Symbol["nn"]'[x[[1]]]^2 - (Lao /. Symbol["P"]->0)))/2)*IdentityMatrix[lpol] +
	Exp[2*Symbol["nn"][x[[1]]]]*DiagonalMatrix[masy]]];

(* wsp\[OAcute]\[LSlash]poruszaj\:0105ce si\:0119 perturbacje: {{uQ\[Sigma]1,uQ\[Sigma]2,...},{uQs11,uQs12,...},...} *)	
pertu=przejscieQu[x,La,Xo,rozwiazaniaPk,fun,param];

(* wsp\[OAcute]\[LSlash]czynnik Bogolyubov'a (macierz); w bazie wiersze odpowiadaj\:0105 kolejnym polom, dlatego B.(B')^T *)
Print[TimeObject[Now]," Wsp\[OAcute]\[LSlash]czynnik Bogolyubov'a \[Beta]"];
wsp\[Beta]=If[FT, (Sqrt[omd].pertu-I*Inverse[Sqrt[omd]].(D[pertu,x[[1]]]+(baza.Transpose[D[baza,x[[1]]]]).pertu)*Exp[Symbol["nn"][x[[1]]]])/Sqrt[2.],
	(Sqrt[omd].pertu-I*Inverse[Sqrt[omd]].(D[pertu,x[[1]]]+(baza.Transpose[D[baza,x[[1]]]]).pertu)*Exp[Symbol["nn"][x[[1]]]])/Sqrt[2.]];

(* liczba obsadze\:0144 *)
Diagonal[ConjugateTranspose[wsp\[Beta]].wsp\[Beta]] /. fun /. param )]


(* g\:0119sto\:015b\[CAcute] energii wyprodukowanych cz\:0105stek zale\:017cna od czasu *)
gestoscEnergiiCzastek[x_,Lao_,masy_,lobsadzenk_,fun_:{},param_:{}]:=
(*gestoscEnergiiCzastek[x,Lao,masy,lobsadzenk,fun,param]=*)
Block[{lpol,energie,wyr},(lpol=Length[masy];
(* energie cz\:0105stek *)
energie=Sqrt[(Symbol["kk"]^2 - (Exp[2*Symbol["nn"][x[[1]]]]*(Symbol["nn"]'[x[[1]]]^2 - (Lao /. Symbol["P"]->0)))/2)*IdentityMatrix[lpol] +
	Exp[2*Symbol["nn"][x[[1]]]]*DiagonalMatrix[masy]]; 
(* g\:0119sto\:015bci energii wyprodukowanych cz\:0105stek *)
Print[TimeObject[Now]," G\:0119sto\:015bci energii wyprodukowanych cz\:0105stek"];
wyr=Symbol["kk"]^2*energie*lobsadzenk;
Map[Integrate[wyr[[#]],{kk,Symbol["nn"]'[x[[1]]]*Exp[Symbol["nn"][x[[1]]]],Sqrt[masy[[#]]]*Exp[Symbol["nn"][x[[1]]]]}] &, Range[Length[masy]]] /. fun /. param)]


(* g\:0119sto\:015b\[CAcute] energii wyprodukowanych cz\:0105stek w danym czasie dla mod\[OAcute]w aH<k<am *)
gestoscEnergiiCzastekTest[x_,La_,listao_,rozwiazania0_,rozwiazaniaPk_,masa_,t0_]:=
(*gestoscEnergiiCzastekTest[x,La,listao,rozwiazania0,rozwiazaniaPk,masa,t0]=*)
Block[{lpol,Go,Xo,Lao,rozwt,masat,Gpola,kolejnosc,baza,
pertk,wspQu,wsp,h,bGt0,bGthp,pertu,pertuhp,at0,omdm,omd,cdcT,wsp\[Beta],lobsadzen,wyr,k1,k2},(
lpol=Length[rozwiazaniaPk[[1]]];
{Go,Xo,Lao}=listao;

rozwt[t_]:=rozwt[t]=With[{xt=t}, (rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];
masat[t_]:=masat[t]=With[{xt=t}, (masa /. x[[1]]->xt /. rozwt[xt])];
Gpola[t_]:=Gpola[t]=With[{xt=t}, (Go /. x[[1]]->xt /. rozwt[xt])];

(* uwaga! Eigenvectors sortuje wektory malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania wektor\[OAcute]w, 
za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
kolejnosc=Range[lpol];
baza[t_]:=baza[t]=Block[{wart, wekt, kol, Mbaza, m=masat[t], G=Gpola[t]}, 
	({wart,wekt}=Eigensystem[m];
	kol=Flatten[Ordering[Abs[#],-1] &/@ wekt];
	Mbaza = kolejnosc /. MapThread[#1->#2 &, {kol, wekt}];
	wart = kolejnosc /. MapThread[#1->#2 &, {kol, wart}];  
	{wart, mrkUzyteczny`ortonormalnaBaza[Mbaza,G]})];

(* perturbacje: {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
pertk=Function[t, With[{xt=t}, (rozwiazaniaPk /. x[[1]]->xt)]];
(* wsp\[OAcute]\[LSlash]czynniki przej\:015bcia od perturbacji krzywizny i izokrzywizny do wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji: 
{a*(P'(X))^(1/2)/c_s, a*(P'(X))^(1/2)}, gdzie cs - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku, X - cz\[LSlash]on kinetyczny w lagran\:017cjanie P *)
wspQu=Exp[Symbol["nn"][x[[1]]]]*Join[{Sqrt[D[La,Symbol["XK"]]+2*Symbol["XK"]*D[La,{Symbol["XK"],2}]]}, Table[Sqrt[D[La,Symbol["XK"]]],{i,2,lpol}]] /. Symbol["XK"]->Xo /. Symbol["P"]->0;
wsp=Function[t, With[{xt=t}, (wspQu /. x[[1]]->xt /. rozwt[xt])]];
(* wsp\[OAcute]\[LSlash]poruszaj\:0105ce si\:0119 perturbacje krzywizny i izokrzywizny: {{u\[Sigma]1,u\[Sigma]2,...},{us1,us2,...},...} *)
pertu[t_]:=pertu[t]=With[{xt=t}, wsp[xt]*(baza[xt][[2]].Gpola[xt].Transpose[pertk[xt]])];

(* diagonalna macierz cz\:0119sto\:015bci \[Omega]^2=k^2 - a''(\[Tau])/a + a^2*m^2 (gdzie: a''(\[Tau])/a=a'(t)^2+a*a''(t)) *)
at0=Exp[Symbol["nn"][t0]] /. rozwt[t0];
omd=With[{xt=t0, at2=at0^2}, Sqrt[(Symbol["kk"]^2 - (at2*(Symbol["nn"]'[xt]^2 - (Lao /. Symbol["P"]->0)))/2)*IdentityMatrix[lpol] +
	at2*DiagonalMatrix[baza[xt][[1]]]] /. x[[1]]->xt /. rozwt[xt]];
(* wsp\[OAcute]\[LSlash]czynnik Bogolyubov'a (macierz); w bazie wiersze odpowiadaj\:0105 kolejnym polom, dlatego B.(B')^T *)
h=0.0001;
wsp\[Beta]=With[{en=Sqrt[omd], per=pertu[t0], perh=pertu[t0+h], mb=baza[t0][[2]], mbh=baza[t0+h][[2]], at=at0}, 
	(en.per-I*Inverse[en].((perh-per)/(h) + (mb.Transpose[(mbh-mb)/(h)]).per)*at)/Sqrt[2.]];
(* liczba obsadze\:0144 *)
lobsadzen=With[{wspB=wsp\[Beta]}, Re[Diagonal[wspB.ConjugateTranspose[wspB]]]];

(* g\:0119sto\:015bci energii wyprodukowanych cz\:0105stek dla mod\[OAcute]w aH<k<am *)
Print[TimeObject[Now]," G\:0119sto\:015bci energii wyprodukowanych cz\:0105stek"];
wyr[k_,lp_]:=With[{kw=k, en=Diagonal[omd][[lp]], lo=lobsadzen[[lp]]}, kw^2*en*lo /. Symbol["kk"]->kw /. ek_ /; MemberQ[ek,_Complex,{0}] -> 0];
(*wyr[k_]:=With[{kw=k, en=Diagonal[omd]}, kw^2*en*lobsadzen /. Symbol["kk"]->kw];*)
k1=at0*Symbol["nn"]'[t0] /. rozwt[t0];
(*k2=at0*Sqrt[baza[t0][[1]]];*)
k2=at0*Sqrt[baza[t0][[1]] /. m2_ /; m2<0 -> 0];
Print[SetPrecision[omd/. Symbol["kk"]->k1,5]];
(*Print[SetPrecision[{k1,k2},5]];
Print[wyr[10^(-5),1]];
Print[wyr[10^(-5),2]];
Print[wyr[k2[[2]],2]];
Print[wyr[k2[[1]],1]];*)
(*With[{lim={{Symbol["kk"],k1,k2[[1]]},{Symbol["kk"],k1,k2[[2]]}}},
Map[NIntegrate[wyr[[2]],lim[[2]],MaxPoints\[Rule]2] &, Range[lpol]]]*)
(*Map[((wyr/.Symbol["kk"]\[Rule]k1)+(wyr/.Symbol["kk"]\[Rule]k2[[#]]))*(k2[[#]]-k1)/2 &, Range[lpol]]*)
Map[(wyr[k1,#]+wyr[k2[[#]],#])*(k2[[#]]-k1)/2 &, Range[lpol]])]


(* ::Section:: *)
(*Rozwi\:0105zania z uwzgl\:0119dnieniem produkcji cz\:0105stek*)


(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a z uwzgl\:0119dnieniem produkcji cz\:0105stek *)
rozwiazanieTloProdukcjaCzastek[pola_,x_,Xo_,rruchu0_,rpola0_,listatf_,wp_,N0_,ti_:0.,masa_,Go_,sciezka_:Directory[]]:=
rozwiazanieTloProdukcjaCzastek[pola,x,Xo,rruchu0,rpola0,listatf,wp,N0,ti,masa,Go,sciezka]=
Block[{lzm,lprzedzialow,zmienne,energiek,wsp,wartp,efolds0,rp,rownania0,
t0,tf,rozw,rozw0,gestosci,lhs,rhs,odcinki,funkcje0,
lpol,rozwt,masat,Gpola,kolejnosc,baza,masyt,parametry,dl,h,dteta,znak,tetatot=0.,gtot=0.,gtota3=0.,
fn,plik,totg3,totg,a43t,roznice={},ffff,masa22},(
lpol=Length[pola]; lzm=2*Length[pola]+2; lprzedzialow=Length[listatf];

zmienne={Map[#[x[[1]]] &, pola], Map[#'[x[[1]]] &, pola], Symbol["nn"][x[[1]]]};
(*zmienne={{Map[#[x[[1]]] &, pola], {0., 0.}}, Symbol["nn"][x[[1]]]};*)
energiek=Tuples[Collect[Xo,zmienne[[2]]],1];
wsp=energiek/zmienne[[2]]^2;
(*Print[energiek, wsp];*)

(* warto\:015bci pocz\:0105tkowe dla pierwszego przedzia\[LSlash]u *)
t0=ti;
wartp=wp;
efolds0=N0;
(* przy cz\[LSlash]onie H^2 b\:0119dzie wsp\[OAcute]\[LSlash]czynnik 1,
dzi\:0119ki temu wiadomo, \:017ce nale\:017cy dodawa\[CAcute] \[Rho]/(3a^3) *)
rp=mrkUzyteczny`wspolczynnik1Row[rpola0[[1]],Symbol["H"][x[[1]]]^2];
rownania0=Join[rruchu0,{rp}];


masa22 = Eigenvalues[masa][[2]];
(*Print[masa22];*)


Print[TimeObject[Now]," Rozwi\:0105zania z produkcj\:0105 cz\:0105stek"];
rozw=Reap[Do[
	(* ko\:0144cowa warto\:015b\[CAcute] czasu dla i-tego przedzia\[LSlash]u *)
	tf=Rationalize[listatf[[i]], 10^(-24)];
	
	(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a *)
	rozw0=mrkRozwiazania`rozwiazanieTlo[pola,x,rownania0,tf,wartp,efolds0,False,t0];
		
	If[i!=lprzedzialow,
	If[MemberQ[Range[0,lprzedzialow,500],i],Print[TimeObject[Now],i]];
		
	rozwt[t_]:=rozwt[t]=With[{xt=t}, (rozw0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];
	masat[t_]:=With[{xt=t}, (masa /. x[[1]]->xt /. rozwt[xt])];
	Gpola[t_]:=With[{xt=t}, (Go /. x[[1]]->xt /. rozwt[xt])];

	(* uwaga! Eigenvectors sortuje wektory malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
	w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania wektor\[OAcute]w, 
	za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
	kolejnosc=Range[lpol];
	baza[t_]:=baza[t]=Block[{wekt, Mbaza, m=masat[t], G=Gpola[t]}, 
		(wekt=Eigenvectors[m]; 
		Mbaza = kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wekt}];  
		mrkUzyteczny`ortonormalnaBaza[Mbaza,G])];
		
	(*If[i==1, masyt=Block[{wart, wekt, m=masat[ti]}, 
			({wart,wekt}=Eigensystem[m]; 
			kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wart}])]];*)
			
	masyt=Block[{wart, wekt, m=masat[ti]}, 
			({wart,wekt}=Eigensystem[m]; 
			kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wart}])];

	(* F_1'(t) = -\[Theta]_1'(t)F_2(t), F_n'(t) = \[Theta]_(n-1)'(t)F_(n-1)(t) - \[Theta]_n'(t)F_(n+1)(t) *)
	h=0.0001;	
	parametry[t_]:=Block[{pochodna, c1, c2, rown, mb=baza[t], mbh=baza[t+h]}, 
		pochodna=(mbh-mb)/(h);
		Reap[c1=-(pochodna[[1,1]])/mb[[2,1]]; Sow[c1];
		Do[rown={pochodna[[i,1]]==c1*mb[[i-1,1]]-c2*mb[[i+1,1]]};
			c1=Solve[rown,c2][[1,1,2]];
			Sow[c1],{i,2,lpol-1}]][[2,1]]];


	dl=If[((tf-h)-t0)>20000, ((tf-h)-t0)/1000,((tf-h)-t0)/100];
	(*dteta=First[Total[Table[(parametry[i]+parametry[i+dl])*dl/2,{i,t0,(tf-h)-dl,dl}]]];*)
	(*dteta=First[Sum[(parametry[i]+parametry[i+dl])*dl/2,{i,t0,(tf-h)-dl,dl}]];*)
	(*dteta=First[Total[Reap[Do[Sow[(parametry[i]+parametry[i+dl])*dl/2],{i,t0,(tf-h)-dl,dl}]][[2,1]]]];*)
	(*dteta=(First[Sum[parametry[i], {i,t0+dl, (tf-h)-dl, dl}]] + First[(parametry[t0]+parametry[tf-h])]/2.)*dl;*)
	
	(*dteta=First[(Sum[parametry[i], {i,t0+dl, (tf-h)-dl, dl}] + (parametry[t0]+parametry[tf-h])/2.)*dl];*)
	dteta=First[Sum[(parametry[i]+parametry[i+dl]),{i,t0,(tf-h)-dl,dl}]]*dl/2.;
	
	(*ffff = Interpolation[Reap[Do[Sow[{i, parametry[i][[1]]}],{i,t0,(tf-h),dl}]][[2,1]]];	
	dteta=NIntegrate[ffff[xx], {xx,t0,tf-h}, Method->"InterpolationPointsSubdivision"];*)
	
	
	(*dteta=Total[Reap[(Sow[Sum[parametry[i], {i,t0+dl, (tf-h)-dl, dl}]*dl];Sow[(parametry[t0]+parametry[tf-h])*dl/2.])][[2,1]]][[1]];*)
	
	(*Print[dteta];*)
	tetatot=tetatot+dteta;
	
	(*gestosci=gestoscEnergiiCzastekTest[x,La,listao,rozwiazania0,rozwiazaniaPk,masa,t0];*)
	(*gestosci={10.^(-15), 10.^(-15)};*)
	(*gestosci={masyt[[2]]^2*Sin[dteta]^2/(24*Pi^2), masyt[[2]]^2*Sin[dteta]^2/(16*Pi^2)};*)
	gestosci={masyt[[2]]^2*2*Sin[tetatot]*Cos[tetatot]*dteta/(24*Pi^2), masyt[[2]]^2*2*Sin[tetatot]*Cos[tetatot]*dteta/(16*Pi^2)};
	(*gestosci={(2*10^(-3))^4*2*Sin[tetatot]*Cos[tetatot]*dteta/(24*Pi^2), (2*10^(-3))^4*2*Sin[tetatot]*Cos[tetatot]*dteta/(16*Pi^2)};*)
	(*gestosci={0, masyt[[2]]^2*Sin[dteta]^2/(16*Pi^2)};*)
	
	(*Print["ggg ",gestosci];*)
	
	gtot=gtot+gestosci;
	
	(* warto\:015bci pocz\:0105tkowe = ko\:0144cowe warto\:015bci z i-tego (ostatniego) przedzia\[LSlash]u
	oraz zamiana energii kinetycznej p\[OAcute]l na g\:0119sto\:015b\[CAcute] energii wyprodukowanych cz\:0105stek *)
	t0=tf;	

	{wartp[[1]], efolds0}=Rationalize[{zmienne[[1]],zmienne[[3]]} /. rozw0 /. x[[1]]->t0, 10^(-24)];
	(*znak=If[efolds0<0, -1, 1];*)
	znak=Sign[zmienne[[2,2]] /. rozw0 /. x[[1]]->t0];
	a43t={Exp[4.*Symbol["nn"][x[[1]]]], Exp[3.*Symbol["nn"][x[[1]]]]} /. rozw0 /. x[[1]]->t0;
	(*wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci/Exp[3.*Symbol["nn"][x[[1]]]])/wsp] /. rozw0 /. x[[1]]->t0, 10^(-20)];*)
	(*wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci/a3t)/wsp] /. rozw0 /. x[[1]]->t0, 10^(-24)] /. ek_ /; MemberQ[ek,_Complex,{0}] -> 0;*)
	(*wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci/a43t)/wsp] /. rozw0 /. x[[1]]->t0, 10^(-24)] /. ek_ /; MemberQ[ek,_Complex,{0}] -> 0;*)
	wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci)/wsp] /. rozw0 /. x[[1]]->t0, 10^(-24)] /. ek_ /; MemberQ[ek,_Complex,{0}] -> 0;
	wartp[[2,2]]=wartp[[2,2]]*znak;
	(*Table[If[wartp[[2,i]]==0, gestosci[[i]]=energiek[[i]]*a43t[[i]] /. rozw0 /. x[[1]]->t0;],{i,1,lpol}];*)
	Table[If[wartp[[2,i]]==0, gestosci[[i]]=energiek[[i]] /. rozw0 /. x[[1]]->t0;],{i,1,lpol}];
	
	(*Print["eee ", SetPrecision[energiek/. rozw0 /. x[[1]]->t0,5]];
	Print["wp ", SetPrecision[{wartp, efolds0},3]];*)
	
	
	AppendTo[roznice, N[Flatten[{zmienne /. rozw0 /. x[[1]]->t0, wartp, efolds0}]]];
	
		
	{lhs,rhs}=rp/.{Equal->List};
	(*rp=Rationalize[(lhs==rhs+Total[gestosci]/a3t), 10^(-24)];*)
	(*rp=Rationalize[lhs==rhs+gestosci[[1]]*a43t[[1]]/(3.*Exp[4.*Symbol["nn"][x[[1]]]])+gestosci[[2]]*a43t[[2]]/(3.*Exp[3.*Symbol["nn"][x[[1]]]]), 10^(-24)];*)
	rp=Rationalize[lhs==rhs+gestosci[[1]]*(masa22^2/masyt[[2]]^2)*a43t[[1]]/(3.*Exp[4.*Symbol["nn"][x[[1]]]])+gestosci[[2]]*(masa22^2/masyt[[2]]^2)*a43t[[2]]/(3.*Exp[3.*Symbol["nn"][x[[1]]]]), 10^(-24)];
	rownania0=Join[rruchu0,{rp}];
	
	gtota3=gtota3+gestosci/a43t;
	];
	
	Sow[rozw0],
{i,1,lprzedzialow}]][[2,1]];

Export[FileNameJoin[{sciezka,"rozniceT"<>ToString[lprzedzialow]<>".txt"}], roznice, "Table", "FieldSeparators" -> " "];


(* stworzenie funkcji odcinkowych *)
odcinki=Join[{ti<=x[[1]]<listatf[[1]]}, Table[listatf[[i-1]]<=x[[1]]<listatf[[i]], {i,2,lprzedzialow-1}], 
	{listatf[[lprzedzialow-1]]<=x[[1]]<=listatf[[lprzedzialow]]}];
funkcje0=Table[rozw[[1,i,1]]->Piecewise[MapThread[{#1[[2]],#2} &, {rozw[[All,i]], odcinki}]],{i,1,lzm}];
Print["{ttot, gtot, gtot/a3} ", {tetatot, gtot, gtota3}];

fn=FileNameJoin[{sciezka,StringJoin["gestosci_",ToString[lprzedzialow],".txt"]}];
plik=OpenAppend[fn, PageWidth -> Infinity];
totg3=Total[gtota3];
totg=Total[gtot];
WriteString[plik,"{thetaTot, rhoTot, rhoTotSum, rhoTota , rhoTotaSum} ", AccountingForm[{tetatot, gtot, totg, gtota3, totg3}],"\n"];
Close[plik];
(*Print[zmienne/.funkcje0/.x[[1]]->ti]; 
Print[zmienne/.funkcje0/.x[[1]]->tf];*)
funkcje0)]


warunkiZszyciaPerturbacje[x_,podstLG_,dH_,podstRSMS_,podstMSRS_,dd\[Sigma]_]:=
(*warunkiZszyciaPerturbacje[x,podstLG,dH,podstRSMS,podstMSRS,dd\[Sigma]]=*)
Block[{pertm,podstHN,podstaN,row,wz,wz1,wz2,zmienneQ\[Sigma],
zmienneQs,wz3,wz4},(
pertm=podstLG[[All,1]];

podstHN=mrkUzyteczny`zastapienieHN[x];
podstaN=mrkUzyteczny`zastapienieaN[x];

(* zachowane \[CapitalPhi] i r\[OAcute]wnanie na (\[CapitalPhi], \[CapitalPhi]') *)
(*wz1=podstLG[[1,2]];
wz2=pertm[[1]]-Symbol["H"][x[[1]]]*pertm[[2]]/Symbol["H"]'[x[[1]]]-Symbol["H"][x[[1]]]^2*pertm[[1]]/Symbol["H"]'[x[[1]]]-Symbol["kw"]^2*pertm[[1]]/(3*Symbol["H"]'[x[[1]]]*Symbol["a"][x[[1]]]^2);
(*wz2=pertm[[1]]-Symbol["H"][x[[1]]]*pertm[[2]]/Symbol["H"]'[x[[1]]]-Symbol["H"][x[[1]]]^2*pertm[[1]]/Symbol["H"]'[x[[1]]];*)
wz2=wz2/.podstLG;*)

(* zachowane R i eps*dR *)
(*zmienneQ\[Sigma]=podstRSMS[[All,1,1]];
wz1=Symbol["H"][x[[1]]]*zmienneQ\[Sigma][[1]]/dd\[Sigma][[1]] /. podstRSMS[[All,1]];
wz2=(-Symbol["H"]'[x[[1]]]/Symbol["H"][x[[1]]]^2)(Symbol["H"]'[x[[1]]]*zmienneQ\[Sigma][[1]]/dd\[Sigma][[1]] + 
	Symbol["H"][x[[1]]]*zmienneQ\[Sigma][[2]]/dd\[Sigma][[1]] - Symbol["H"][x[[1]]]*zmienneQ\[Sigma][[1]]*dd\[Sigma][[2]]/dd\[Sigma][[1]]^2) /. podstRSMS[[All,1]];
	
wz={wz1,wz2};*)
	
	
(* zachowane R i S oraz eps*dR i eps*dS *)
(*zmienneQ\[Sigma]=podstRSMS[[All,1,1]];
zmienneQs=podstRSMS[[All,2;;All,1]];
wz1=Symbol["H"][x[[1]]]*zmienneQ\[Sigma][[1]]/dd\[Sigma][[1]] /. podstRSMS[[1,1]];
wz2=(-Symbol["H"]'[x[[1]]]/Symbol["H"][x[[1]]]^2)(Symbol["H"]'[x[[1]]]*zmienneQ\[Sigma][[1]]/dd\[Sigma][[1]] + 
	Symbol["H"][x[[1]]]*zmienneQ\[Sigma][[2]]/dd\[Sigma][[1]] - Symbol["H"][x[[1]]]*zmienneQ\[Sigma][[1]]*dd\[Sigma][[2]]/dd\[Sigma][[1]]^2) /. podstRSMS[[All,1]];
	
wz3=Symbol["H"][x[[1]]]*zmienneQs[[1]]/dd\[Sigma][[1]] /. Flatten[podstRSMS[[1,2;;All]]];
wz4=(-Symbol["H"]'[x[[1]]]/Symbol["H"][x[[1]]]^2)(Symbol["H"]'[x[[1]]]*zmienneQs[[1]]/dd\[Sigma][[1]] + 
	Symbol["H"][x[[1]]]*zmienneQs[[2]]/dd\[Sigma][[1]] - Symbol["H"][x[[1]]]*zmienneQs[[1]]*dd\[Sigma][[2]]/dd\[Sigma][[1]]^2) /. Flatten[podstRSMS[[All,2;;All]]];

wz={wz1,wz2,wz3,wz4};*)

(* zachowane R i \[CapitalPhi] *)
zmienneQ\[Sigma]=podstRSMS[[All,1,1]];
wz1=podstLG[[1,2]];
wz2=Symbol["H"][x[[1]]]*zmienneQ\[Sigma][[1]]/dd\[Sigma][[1]] /. podstRSMS[[All,1]];
	
wz={wz1,wz2};

(* zachowane R i \[CapitalPhi] oraz S i dS *)
(*zmienneQ\[Sigma]=podstRSMS[[All,1,1]];
zmienneQs=podstRSMS[[All,2;;All,1]];
wz1=podstLG[[1,2]];
wz2=Symbol["H"][x[[1]]]*zmienneQ\[Sigma][[1]]/dd\[Sigma][[1]] /. podstRSMS[[1,1]];
	
wz3=Symbol["H"][x[[1]]]*zmienneQs[[1]]/dd\[Sigma][[1]] /. Flatten[podstRSMS[[1,2;;All]]];
wz4=(Symbol["H"]'[x[[1]]]*zmienneQs[[1]]/dd\[Sigma][[1]] + Symbol["H"][x[[1]]]*zmienneQs[[2]]/dd\[Sigma][[1]] - Symbol["H"][x[[1]]]*zmienneQs[[1]]*dd\[Sigma][[2]]/dd\[Sigma][[1]]^2) /. Flatten[podstRSMS[[All,2;;All]]];

wz={wz1,wz2,wz3,wz4};*)

(*Print[wz];*)

(*Print[podstLG];
Print[Simplify[wz/.dH]];*)
(*Print[{podstRSMS,podstMSRS}];*)
(*Print[Simplify[wz/.podstMSRS[[2]]/.podstMSRS[[1]]/.dH]];*)

Simplify[{wz,{podstRSMS,podstMSRS},wz/.podstMSRS[[2]]/.podstMSRS[[1]]}/.dH/.podstHN/.podstaN])]


(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a z uwzgl\:0119dnieniem produkcji cz\:0105stek *)
rozwiazanieProdukcjaCzastek[pola_,pertkw_,x_,La_,listao_,masa_,rruchu0_,rpola0_,rownaniaPkw_,listatf_,wp_,wpP_,N0_,N0P_,kw_,ti_:0.,warunkiP_,sciezka_:Directory[],nazwa_:""]:=
(*rozwiazanieProdukcjaCzastek[pola,pertkw,x,La,listao,masa,rruchu0,rpola0,rownaniaPkw,listatf,wp,wpP,N0,N0P,kw,ti,warunkiP,sciezka,nazwa]=*)
Block[{lpol,lprzebiegow,lzm,lprzedzialow,zmienne,Xo,energiek,wsp,wartp,wartpP,efolds0,efoldsP,rp,rownania0,
fPert,fPertg,t0,tf,rozw,rozw0,rozwP,rozwPg,gestosci,lhs,rhs,odcinki,funkcje0,funkcjeP,
Go,rozwt,masat,Gpola,kolejnosc,baza,masyt,h,parametry,dteta,dl,znak,a3t,tetatot=0.,gtot=0.,gtota3=0.,a43t,
wz,pertS,pertR,pertQMS,szukaneR,rozw0t0,roznice={},rozwiazania0,zmienne0,szukaneS},(
lpol=Length[pola]; lprzebiegow=Length[wpP];
lzm=2*Length[pola]+2; lprzedzialow=Length[listatf];

Go=listao[[1]];

zmienne={Map[#[x[[1]]] &, pola], Map[#'[x[[1]]] &, pola], Symbol["nn"][x[[1]]]};
(*zmienne={{Map[#[x[[1]]] &, pola], {0., 0.}}, Symbol["nn"][x[[1]]]};*)
Xo=listao[[2]];
energiek=Tuples[Collect[Xo,zmienne[[2]]],1];
wsp=energiek/zmienne[[2]]^2;
(*Print[energiek, wsp];*)

(* warto\:015bci pocz\:0105tkowe dla pierwszego przedzia\[LSlash]u *)
t0=ti;
wartp=wp;
efolds0=N0;
efoldsP=N0P;
wartpP=wpP;
(* przy cz\[LSlash]onie H^2 b\:0119dzie wsp\[OAcute]\[LSlash]czynnik 1,
dzi\:0119ki temu wiadomo, \:017ce nale\:017cy dodawa\[CAcute] \[Rho]/(3a^3) *)
rp=mrkUzyteczny`wspolczynnik1Row[rpola0[[1]],Symbol["H"][x[[1]]]^2];
rownania0=Join[rruchu0,{rp}];

If[kw==-1, 
	fPert[roz0_,tk_,warP_,nP_]:=mrkRozwiazania`rozwiazaniePertk[pertkw,x,rownaniaPkw,roz0,tk,warP,nP],
	fPert[roz0_,tk_,warP_,nP_]:=mrkRozwiazania`rozwiazaniePert[pertkw,x,rownaniaPkw,kw,roz0,tk,warP,nP]];

fPertg[roz0_,tk_,warP_,nP_]:=mrkRozwiazania`rozwiazaniePertk[pertkw,x,rownaniaPkw,roz0,tk,warP,nP];


rozwiazania0=rozwiazanieTloProdukcjaCzastek[pola,x,Xo,rruchu0,rpola0,listatf,wp,N0,ti,masa,Go,sciezka];
zmienne0=rozwiazania0[[All,1]];

(*Print[TimeObject[Now]," Rozwi\:0105zania z produkcj\:0105 cz\:0105stek"];*)
rozw=Reap[Do[
	(* ko\:0144cowa warto\:015b\[CAcute] czasu dla i-tego przedzia\[LSlash]u *)
	tf=Rationalize[listatf[[i]], 10^(-24)];
	(*tf=listatf[[i]];*)
	
	(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a *)
	(*rozw0=mrkRozwiazania`rozwiazanieTlo[pola,x,rownania0,tf,wartp,efolds0,False,t0];*)
	rozw0=MapThread[#1->#2 &, {zmienne0, rozwiazania0[[All,2,1,i,1]]}];
	(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji *)
	rozwP=fPert[rozw0,tf,wartpP,efoldsP];
	
	If[i!=lprzedzialow,
	(*If[MemberQ[Join[Range[0,lprzedzialow,100]],i],Print[TimeObject[Now],i]];*)
		
	(*rozwt[t_]:=rozwt[t]=With[{xt=t}, (rozw0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];
	masat[t_]:=With[{xt=t}, (masa /. x[[1]]->xt /. rozwt[xt])];
	Gpola[t_]:=With[{xt=t}, (Go /. x[[1]]->xt /. rozwt[xt])];

	(* uwaga! Eigenvectors sortuje wektory malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
	w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania wektor\[OAcute]w, 
	za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
	kolejnosc=Range[lpol];
	baza[t_]:=baza[t]=Block[{wekt, Mbaza, m=masat[t], G=Gpola[t]}, 
		(wekt=Eigenvectors[m]; 
		Mbaza = kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wekt}];  
		mrkUzyteczny`ortonormalnaBaza[Mbaza,G])];
		
	If[i==1, masyt=Block[{wart, wekt, m=masat[ti]}, 
			({wart,wekt}=Eigensystem[m]; 
			kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wart}])]];

	(* F_1'(t) = -\[Theta]_1'(t)F_2(t), F_n'(t) = \[Theta]_(n-1)'(t)F_(n-1)(t) - \[Theta]_n'(t)F_(n+1)(t) *)
	h=0.0001;
	parametry[t_]:=Block[{pochodna, c1, c2, rown, mb=baza[t], mbh=baza[t+h]}, 
		pochodna=(mbh-mb)/(h);
		Reap[c1=-(pochodna[[1,1]])/mb[[2,1]]; Sow[c1];
		Do[rown={pochodna[[i,1]]==c1*mb[[i-1,1]]-c2*mb[[i+1,1]]};
			c1=Solve[rown,c2][[1,1,2]];
			Sow[c1],{i,2,lpol-1}]][[2,1]]];
	
	dl=If[((tf-h)-t0)>20000, ((tf-h)-t0)/1000,((tf-h)-t0)/100];
	dteta=First[Total[Table[(parametry[i]+parametry[i+dl])*dl/2,{i,t0,(tf-h)-dl,dl}]]];
	(*Print[dteta];*)
	tetatot=tetatot+dteta;
	
	(*gestosci=gestoscEnergiiCzastekTest[x,La,listao,rozwiazania0,rozwiazaniaPk,masa,t0];*)
	(*gestosci={10.^(-15), 10.^(-15)};*)
	(*gestosci={masyt[[2]]^2*Sin[dteta]^2/(24*Pi^2), masyt[[2]]^2*Sin[dteta]^2/(16*Pi^2)};*)
	(*gestosci={masyt[[2]]^2*dteta/(24*Pi^2), masyt[[2]]^2*dteta/(16*Pi^2)};*)
	(*gestosci={0, masyt[[2]]^2*Sin[dteta]^2/(16*Pi^2)};*)
	gestosci={masyt[[2]]^2*2*Sin[tetatot]*Cos[tetatot]*dteta/(24*Pi^2), masyt[[2]]^2*2*Sin[tetatot]*Cos[tetatot]*dteta/(16*Pi^2)};
	(*Print["ggg ",gestosci];*)
	gtot=gtot+gestosci;*)
	
	
	(* warto\:015bci pocz\:0105tkowe = ko\:0144cowe warto\:015bci z i-tego (ostatniego) przedzia\[LSlash]u
	oraz zamiana energii kinetycznej p\[OAcute]l na g\:0119sto\:015b\[CAcute] energii wyprodukowanych cz\:0105stek *)
	t0=tf;
	
	(*{wartp[[1]], efolds0}=Rationalize[{zmienne[[1]],zmienne[[3]]} /. rozw0 /. x[[1]]->t0, 10^(-24)];
	(*znak=If[efolds0<0, -1, 1];*)
	znak=Sign[zmienne[[2,2]] /. rozw0 /. x[[1]]->t0];
	(*wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci/Exp[3.*Symbol["nn"][x[[1]]]])/wsp] /. rozw0 /. x[[1]]->t0, 10^(-20)];*)
	(*a3t=Exp[3.*Symbol["nn"][x[[1]]]] /. rozw0 /. x[[1]]->t0;
	wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci/a3t)/wsp] /. rozw0 /. x[[1]]->t0, 10^(-24)] /. ek_ /; MemberQ[ek,_Complex,{0}] -> 0;
	wartp[[2,2]]=wartp[[2,2]]*znak;
	Do[If[wartp[[2,i]]==0, gestosci[[i]]=energiek[[i]]*a3t;],{i,1,lpol}];*)
	
	
	
	
	a43t={Exp[4.*Symbol["nn"][x[[1]]]], Exp[3.*Symbol["nn"][x[[1]]]]} /. rozw0 /. x[[1]]->t0;
	(*wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci/Exp[3.*Symbol["nn"][x[[1]]]])/wsp] /. rozw0 /. x[[1]]->t0, 10^(-20)];*)
	(*wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci/a3t)/wsp] /. rozw0 /. x[[1]]->t0, 10^(-24)] /. ek_ /; MemberQ[ek,_Complex,{0}] -> 0;*)
	(*wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci/a43t)/wsp] /. rozw0 /. x[[1]]->t0, 10^(-24)] /. ek_ /; MemberQ[ek,_Complex,{0}] -> 0;*)
	wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci)/wsp] /. rozw0 /. x[[1]]->t0, 10^(-24)] /. ek_ /; MemberQ[ek,_Complex,{0}] -> 0;
	wartp[[2,2]]=wartp[[2,2]]*znak;
	(*Table[If[wartp[[2,i]]==0, gestosci[[i]]=energiek[[i]]*a43t[[i]] /. rozw0 /. x[[1]]->t0;],{i,1,lpol}];*)
	Table[If[wartp[[2,i]]==0, gestosci[[i]]=energiek[[i]] /. rozw0 /. x[[1]]->t0;],{i,1,lpol}];
	
	
	
	
	(*Print["eee ", SetPrecision[energiek/. rozw0 /. x[[1]]->t0,5]];
	Print["wp ", SetPrecision[{wartp, efolds0},3]];*)
	efoldsP=efolds0;
		
	{lhs,rhs}=rp/.{Equal->List};
	(*rp=Rationalize[(lhs==rhs+Total[gestosci]/a3t), 10^(-24)];*)
	(*rp=Rationalize[(lhs==rhs+Total[gestosci]/(3.*Exp[3.*Symbol["nn"][x[[1]]]])), 10^(-24)];*)
	(*rp=Rationalize[lhs==rhs+gestosci[[1]]/(3.*Exp[4.*Symbol["nn"][x[[1]]]])+gestosci[[2]]/(3.*Exp[3.*Symbol["nn"][x[[1]]]]), 10^(-24)];*)
	rp=Rationalize[lhs==rhs+gestosci[[1]]*a43t[[1]]/(3.*Exp[4.*Symbol["nn"][x[[1]]]])+gestosci[[2]]*a43t[[2]]/(3.*Exp[3.*Symbol["nn"][x[[1]]]]), 10^(-24)];
	rownania0=Join[rruchu0,{rp}];*)
	
	
	
	{wartp, efolds0}={zmienne[[1;;2]], zmienne[[3]]} /. MapThread[#1->#2 &, {zmienne0, rozwiazania0[[All,2,1,i+1,1]]}] /. x[[1]]->t0;
	efoldsP=efolds0;
	
	
	
	(*wartpP={rozwP, D[rozwP,x[[1]]]} /. x[[1]]->t0;*)
	
	wartpP={};
	Do[
	(* podstawienia rozwi\:0105za\:0144 dla zmiennych MS i ich pochodnych *)
	pertQMS=Join[MapThread[#1->#2 &, {warunkiP[[2,2,1,All,1]],rozwP[[j]]}],MapThread[#1->#2 &, {warunkiP[[2,2,2,All,1]],D[rozwP[[j]],x[[1]]]}]];
	(* warunki zszycia w chwili ko\:0144cowej *)
	wz=warunkiP[[1]]/.rozw0/.pertQMS/.x[[1]]->t0/.Symbol["kw"]->kw;
	(* podstawienia zmiennych Qs, wyra\:017conych przez zmienne MS, w chwili ko\:0144cowej *)
	pertS=Flatten[Drop[Transpose[warunkiP[[2,1]]],1]/.rozw0/.pertQMS/.x[[1]]->t0];
	(* oznaczenia perturbacji krzywiny Q\[Sigma][t] i jej pochodnej w chwili ko\:0144cowej *)
	szukaneR={warunkiP[[2,1,1,1,1]]/.x[[1]]->t0,warunkiP[[2,1,2,1,1]]/.x[[1]]->t0};
	(* podstaienia t\[LSlash]a (p\[OAcute]l i ich pochodnych) w chwili pocz\:0105tkowej (po uwzgl\:0119dnieniu produkcji cz\:0105stek) *)
	rozw0t0=MapThread[(#1/.x[[1]]->t0)->#2 &, {Flatten[Drop[zmienne,-1]],Flatten[wartp]}];
	(* wyznaczenie Q\[Sigma] i Q\[Sigma]' z warunk\[OAcute]w zszycia - perturbacje Qs i Qs' oraz liczba e-powi\:0119ksze\:0144 nn pozostaj\:0105 niezmienione *)
	(* por\[OAcute]wnanie warunk\[OAcute]w zszycia wyra\:017conych przez zmienne MS w chwili ko\:0144cowej z wyra\:017conymi przez zmienne Q\[Sigma]s w chwili pocz\:0105tkowej *)
	pertR=Solve[{wz[[1]]==warunkiP[[3,1]],wz[[2]]==warunkiP[[3,2]]}/.x[[1]]->t0/.Symbol["kw"]->kw/.rozw0t0/.pertS/.(rozw0/.x[[1]]->t0), szukaneR][[1]];
	
	(*szukaneS={warunkiP[[2,1,1,2;;All,1]]/.x[[1]]->t0,warunkiP[[2,1,2,2;;All,1]]/.x[[1]]->t0};*)
	(*szukaneR=Join[szukaneR,szukaneS[[All,1]]];
	pertR=Solve[{wz[[1]]==warunkiP[[3,1]],wz[[2]]==warunkiP[[3,2]],wz[[3,1]]==warunkiP[[3,3,1]],wz[[4,1]]==warunkiP[[3,4,1]]}/.x[[1]]->t0/.Symbol["kw"]->kw/.rozw0t0/.(rozw0/.x[[1]]->t0), szukaneR][[1]];
	pertS=pertR;*)
	(*pertR=Solve[{wz[[1]]==warunkiP[[3,1]],wz[[2]]==warunkiP[[3,2]]}/.x[[1]]->t0/.Symbol["kw"]->kw/.rozw0t0/.(rozw0/.x[[1]]->t0), szukaneR][[1]];
	pertS=Flatten[Map[Solve[{wz[[3,#]]==warunkiP[[3,3,#]],wz[[4,#]]==warunkiP[[3,4,#]]}/.x[[1]]->t0/.Symbol["kw"]->kw/.rozw0t0/.(rozw0/.x[[1]]->t0), szukaneS[[All,#]]][[1]] &, Range[lpol-1]]];*)
	
	(* zmienne MS i ich pochodne, wyra\:017cone przez zmienne Q\[Sigma]s, w chwili pocz\:0105tkowej *)
	AppendTo[wartpP,(warunkiP[[2,2]]/.x[[1]]->t0/.rozw0t0/.pertS/.pertR)[[All,All,2]]];
	
	AppendTo[roznice, N[Flatten[{zmienne /. rozw0 /. x[[1]]->t0, wartp, efolds0, 
		Re[{rozwP[[j]], D[rozwP[[j]],x[[1]]]} /. x[[1]]->t0], Re[wartpP[[j]]], Im[{rozwP[[j]], D[rozwP[[j]],x[[1]]]} /. x[[1]]->t0], Im[wartpP[[j]]],
		Re[Flatten[warunkiP[[2,1,All,1,2]]/.rozw0/.pertQMS/.x[[1]]->t0]], Re[pertR[[All,2]]], Im[Flatten[warunkiP[[2,1,All,1,2]]/.rozw0/.pertQMS/.x[[1]]->t0]], Im[pertR[[All,2]]]}]]],
	{j,1,lprzebiegow}];
	
	
		
	(*wartpP=Rationalize[{rozwP, D[rozwP,x[[1]]]} /. x[[1]]->t0, 10^(-24)];*)
	(*gtota3=gtota3+gestosci/a3t;*)
	
	(*gtota3=gtota3+gestosci/a43t;*)
	];
	
	(*If[i==lprzedzialow, Print[pertR[[1,2]]*(Symbol["nn"]'[x[[1]]]/.rozw0/.x[[1]]->t0)/Sqrt[wartp[[2,1]]^2+wartp[[2,2]]^2]," ",wz]];*)
	
	Sow[{rozw0,rozwP}];,
{i,1,lprzedzialow}]][[2,1]];


Export[FileNameJoin[{sciezka,"rozniceP"<>ToString[lprzedzialow]<>"_"<>nazwa<>".txt"}], roznice, "Table", "FieldSeparators" -> " "];

(* stworzenie funkcji odcinkowych *)
odcinki=Join[{ti<=x[[1]]<listatf[[1]]}, Table[listatf[[i-1]]<=x[[1]]<listatf[[i]], {i,2,lprzedzialow-1}], 
	{listatf[[lprzedzialow-1]]<=x[[1]]<=listatf[[lprzedzialow]]}];
(*funkcje=Table[rozw[[1,i,1]]->Piecewise[MapThread[{#1[[2]],#2} &, {rozw[[All,i]], odcinki}]],{i,1,lzm}];*)
funkcje0=Table[rozw[[1,1,i,1]]->Piecewise[MapThread[{#1[[2]],#2} &, {rozw[[All,1,i]], odcinki}]],{i,1,lzm}];
funkcjeP=Table[Piecewise[MapThread[{#1,#2} &, {rozw[[All,2]][[All,i,j]], odcinki}]],{i,1,lprzebiegow},{j,1,lpol}];
(*Print["{ttot, gtot, gtot/a3} ", {tetatot, gtot, gtota3}];*)
(*Print["fi ", zmienne/.funkcje0/.x[[1]]->ti];
Print["ff ", zmienne/.funkcje0/.x[[1]]->tf];
Print["Pi ", funkcjeP/.{Symbol["kk"]->9.99506222314834350027348138388988`19.893214561681003*^-7, x[[1]]->ti}];
Print["Pf ", funkcjeP/.{Symbol["kk"]->9.99506222314834350027348138388988`19.893214561681003*^-7, x[[1]]->tf-1}];*)
{funkcje0,funkcjeP})]


(*(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a z uwzgl\:0119dnieniem produkcji cz\:0105stek *)
rozwiazanieProdukcjaCzastek[pola_,pertkw_,x_,La_,listao_,masa_,rruchu0_,rpola0_,rownaniaPkw_,listatf_,wp_,wpP_,N0_,N0P_,kw_,ti_:0.]:=
(*rozwiazanieTloProdukcjaCzastek[pola,pertkw,x,La,listao,masa,rruchu0,rpola0,rownaniaPkw,listatf,wp,wpP,N0,N0P,kw,ti]=*)
Block[{lpol,lprzebiegow,lzm,lprzedzialow,zmienne,Xo,energiek,wsp,wartp,wartpP,efolds0,efoldsP,rp,rownania0,
fPert,fPertg,t0,tf,rozw,rozw0,rozwP,rozwPg,gestosci,lhs,rhs,odcinki,funkcje0,funkcjeP},(
lpol=Length[pola]; lprzebiegow=Length[wpP];
lzm=2*Length[pola]+2; lprzedzialow=Length[listatf];

zmienne={Map[#[x[[1]]] &, pola], Map[#'[x[[1]]] &, pola], Symbol["nn"][x[[1]]]};
(*zmienne={{Map[#[x[[1]]] &, pola], {0., 0.}}, Symbol["nn"][x[[1]]]};*)
Xo=listao[[2]];
energiek=Tuples[Collect[Xo,zmienne[[2]]],1];
wsp=energiek/zmienne[[2]]^2;
Print[energiek,wsp];

(* warto\:015bci pocz\:0105tkowe dla pierwszego przedzia\[LSlash]u *)
t0=ti;
wartp=wp;
efolds0=N0;
efoldsP=N0P;
wartpP=wpP;
(* przy cz\[LSlash]onie H^2 b\:0119dzie wsp\[OAcute]\[LSlash]czynnik 1,
dzi\:0119ki temu wiadomo, \:017ce nale\:017cy dodawa\[CAcute] \[Rho]/(3a^3) *)
rp=mrkUzyteczny`wspolczynnik1Row[rpola0[[1]],Symbol["H"][x[[1]]]^2];
rownania0=Join[rruchu0,{rp}];

If[kw==-1, 
	fPert[roz0_,tk_,warP_,nP_]:=mrkRozwiazania`rozwiazaniePertk[pertkw,x,rownaniaPkw,roz0,tk,warP,nP],
	fPert[roz0_,tk_,warP_,nP_]:=mrkRozwiazania`rozwiazaniePert[pertkw,x,rownaniaPkw,kw,roz0,tk,warP,nP]];

fPertg[roz0_,tk_,warP_,nP_]:=mrkRozwiazania`rozwiazaniePertk[pertkw,x,rownaniaPkw,roz0,tk,warP,nP];

rozw=Reap[Do[
	(* ko\:0144cowa warto\:015b\[CAcute] czasu dla i-tego przedzia\[LSlash]u *)
	tf=Rationalize[listatf[[i]], 10^(-20)];
	
	(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a *)
	rozw0=mrkRozwiazania`rozwiazanieTlo[pola,x,rownania0,tf,wartp,efolds0,False,t0];
	(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji *)
	rozwP=fPert[rozw0,tf,wartpP,efoldsP];
	
	If[i!=lprzedzialow,
	(* warto\:015bci pocz\:0105tkowe = ko\:0144cowe warto\:015bci z i-tego (ostatniego) przedzia\[LSlash]u
	oraz zamiana energii kinetycznej p\[OAcute]l na g\:0119sto\:015b\[CAcute] energii wyprodukowanych cz\:0105stek *)
	t0=tf;	
	
	
	(*If[i==1, gestosci={6.391834678860647`*^-18,3.942931720328038`*^-16},*)
	rozwPg=fPertg[rozw0,tf,wartpP,efoldsP];
	gestosci=gestoscEnergiiCzastekTest[x,La,listao,rozw0,rozwPg,masa,t0-0.0001];
	(*gestosci={10.^(-15), 10.^(-15)};*)
	Print["ggg ",gestosci];

	(*wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci/Exp[3.*Symbol["nn"][x[[1]]]])/wsp] /. rozw0 /. x[[1]]->t0, 10^(-20)];*)
	wartp[[2]]=Rationalize[Sqrt[(energiek-gestosci/Exp[3.*Symbol["nn"][x[[1]]]])/wsp] /. rozw0 /. x[[1]]->t0, 10^(-20)] /. ek_ /; MemberQ[ek,_Complex,{0}] -> 0;
	{wartp[[1]], efolds0}=Rationalize[{zmienne[[1]],zmienne[[3]]} /. rozw0 /. x[[1]]->t0, 10^(-20)];
	Print["eee ", SetPrecision[energiek/. rozw0 /. x[[1]]->t0,5]];
	Print["wp ", SetPrecision[{wartp, efolds0},3]];
	efoldsP=efolds0;
		
	{lhs,rhs}=rp/.{Equal->List};
	rp=Rationalize[(lhs==rhs+Total[gestosci]/(3.*Exp[3.*Symbol["nn"][x[[1]]]])), 10^(-20)];
	rownania0=Join[rruchu0,{rp}];
	
	(*wartpP={rozwP, D[rozwP,x[[1]]]} /. x[[1]]->t0;*)
	wartpP=Rationalize[{rozwP, D[rozwP,x[[1]]]} /. x[[1]]->t0, 10^(-20)];
	];
	
	Sow[{rozw0,rozwP}],
{i,1,lprzedzialow}]][[2,1]];

(* stworzenie funkcji odcinkowych *)
odcinki=Join[{ti<=x[[1]]<listatf[[1]]}, Table[listatf[[i-1]]<=x[[1]]<listatf[[i]], {i,2,lprzedzialow-1}], 
	{listatf[[lprzedzialow-1]]<=x[[1]]<=listatf[[lprzedzialow]]}];
(*funkcje=Table[rozw[[1,i,1]]->Piecewise[MapThread[{#1[[2]],#2} &, {rozw[[All,i]], odcinki}]],{i,1,lzm}];*)
funkcje0=Table[rozw[[1,1,i,1]]->Piecewise[MapThread[{#1[[2]],#2} &, {rozw[[All,1,i]], odcinki}]],{i,1,lzm}];
funkcjeP=Table[Piecewise[MapThread[{#1,#2} &, {rozw[[All,2]][[All,i,j]], odcinki}]],{i,1,lprzebiegow},{j,1,lpol}];
Print["fi ", zmienne/.funkcje0/.x[[1]]->ti]; 
Print["ff ", zmienne/.funkcje0/.x[[1]]->tf];
Print["Pf ", funkcjeP/.{Symbol["kk"]->10^(-5), x[[1]]\[Rule]tf-1}];
{funkcje0,funkcjeP})]*)


End[];
EndPackage[];
