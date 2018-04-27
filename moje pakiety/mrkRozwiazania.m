(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkRozwiazania`*)


(* :Title: Rozwi\:0105zania r\[OAcute]wna\:0144 ruchu *)

(* :Context: mrkRozwiazania` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
przybli\:017cenie powolnego toczenia
t\[LSlash]o
perturbacje
*)
 
(* :Copyright: *)

(* :Package Version: 1.2 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 19.08.2016
    Version 1.1, 10.04.2017
      - poprawienie warto\:015bci pocz\:0105tkowych dla perturbacji
      - umo\:017cliwienie obliczania t\[LSlash]a i perturbacji dla innej pocz\:0105tkowej liczby e-powi\:0119ksze\:0144
      - dodanie wzmocnienia i wyznaczania czasu, odpowiadaj\:0105cego danej liczbie e-powi\:0119ksze\:0144
      - rozdzielenie widm i korelacji
      - testowanie warto\:015bci liczby falowej
      - widma dla konkretnych przebieg\[OAcute]w
    Version 1.2, 10.08.2017
      - uwzgl\:0119dnienie obliczania czasu konforomengo w rozwi\:0105zaniach dla t\[LSlash]a
      - mo\:017cliwo\:015b\[CAcute] policzenia widma do normalizacji dla r\[OAcute]\:017cnych perturbacji
*)

(* :Keywords: *)

(* :Requirements: 
"mrkEinstein`"
*)

(* :Sources: *)

(* :Warnings: 
*)

(* :Limitations:
*)

(* :Discussion: 
- w tensorze metrycznym i tensorze energii-p\:0119du perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P
- czynnik skali w tensorze metrycznym musi by\[CAcute] oznaczony przez a
*)



BeginPackage["mrkRozwiazania`",{"mrkEinstein`"}];

parametrEpsilon::usage="parametrEpsilon[r000,r110,x]: 
r000 - r\[OAcute]wnania pola 00 dla t\[LSlash]a (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
r110 - r\[OAcute]wnania pola 11 dla t\[LSlash]a, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: parametr powolnego toczenia \[Epsilon]=-H'[t]/H[t\!\(\*SuperscriptBox[\(]\), \(2\)]\)";

wartosciPoczatkoweTlo::usage="wartosciPoczatkoweTlo[pola,x,rownania0,eps,Nf,wp,wsp]: 
pola - lista nazw p\[OAcute]l, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rownania0 - lista r\[OAcute]wna\:0144 ruchu t\[LSlash]a i r\[OAcute]wnania pola 00 w zerowym rz\:0119dzie w perturbacjach (uwaga! musz\:0105 by\[CAcute] podstawione wszystkie funkcje i parametry), 
eps - parametr powolnego toczenia \[Epsilon] (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`parametrEpsilon),
Nf - \:017c\:0105dana liczba e-powi\:0119ksze\:0144, 
wp - warto\:015bci pocz\:0105tkowe w formie {wp_pola} (w\[OAcute]wczas warto\:015bci pocz\:0105tkowe pr\:0119dko\:015bci zostan\:0105 znalezione z przybli\:017cenia powolnego toczenia) lub {{wp_pola},{wp_dpola}}, 
wsp - lista wsp\[OAcute]\[LSlash]czynnik\[OAcute]w, o kt\[OAcute]re maj\:0105 si\:0119 zmienia\[CAcute] warto\:015bci pocz\:0105tkowe w formie {wsp_pola} lub {{wsp_pola},{wsp_dpola}};
wyj\:015bcie: warto\:015bci pocz\:0105tkowe dla zadanej liczby e-powi\:0119ksze\:0144 w formie {{{wp_pola},{wp_dpola}}, ca\[LSlash]kowita liczba e-powi\:0119ksze\:0144, ko\:0144cowy czas}";

rozwiazanieTlo::usage="rozwiazanieTlo[pola,x,rownania0,tf,wp,N0,konf:False,ti:0]: 
pola - lista nazw p\[OAcute]l, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rownania0 - lista r\[OAcute]wna\:0144 ruchu t\[LSlash]a i r\[OAcute]wnania pola 00 w zerowym rz\:0119dzie w perturbacjach (uwaga! musz\:0105 by\[CAcute] podstawione wszystkie funkcje i parametry), 
tf - ko\:0144cowa warto\:015b\[CAcute] czasu kosmicznego,
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144,
konf - czy wyznacza\[CAcute] te\:017c czas konforemny,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu kosmicznego;
wyj\:015bcie: lista rozwi\:0105za\:0144 dla t\[LSlash]a w formie {rozwi\:0105zania dla p\[OAcute]l, pierwszych pochodnych p\[OAcute]l, liczby e-powi\:0119ksze\:0144 i jej pochodnej}";

czasN::usage="czasN[x,rozwiazania0N,efolds]:
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0N - rozwi\:0105zanie dla liczby e-powi\:0119ksze\:0144 i jej pochodnej uzyskane z r\[OAcute]wna\:0144 dla t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn), 
efolds - warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144, dla kt\[OAcute]rej ma zosta\[CAcute] znaleziony czas;
wyj\:015bcie: podstawienie czasu, odpowiadaj\:0105cego danej liczbie e-powi\:0119ksze\:0144";

wektorFalowy::usage="wektorFalowy[x,rozwiazania0N,efolds]:
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0N - rozwi\:0105zanie dla liczby e-powi\:0119ksze\:0144 i jej pochodnej uzyskane z r\[OAcute]wna\:0144 dla t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn), 
efolds - warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144, dla kt\[OAcute]rej ma zosta\[CAcute] znaleziona warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0119cego si\:0119 wektora falowego w okolicy przekraczania promienia Hubble'a (N=0): k=aH;
wyj\:015bcie: warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego w momencie przekraczania promienia Hubble'a: k=aH (przyj\:0119to \!\(\*SubscriptBox[\(a\), \(0\)]\)=Exp(\!\(\*SubscriptBox[\(N\), \(0\)]\)), wi\:0119c a=Exp(N))";

wektorFalowyTest::usage="wektorFalowyTest[x,rozwiazania0N,efolds]:
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0N - rozwi\:0105zanie dla liczby e-powi\:0119ksze\:0144 i jej pochodnej uzyskane z r\[OAcute]wna\:0144 dla t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn), 
efolds - warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144, dla kt\[OAcute]rej ma zosta\[CAcute] znaleziona warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0119cego si\:0119 wektora falowego w okolicy przekraczania promienia Hubble'a (N=0): k=aH;
wyj\:015bcie: warto\:015bci wsp\[OAcute]\[LSlash]poruszaj\:0105cej si\:0119 liczby falowej dla N=0 i podanego N w momencie przekraczania promienia Hubble'a: k=aH (przyj\:0119to \!\(\*SubscriptBox[\(a\), \(0\)]\)=Exp(\!\(\*SubscriptBox[\(N\), \(0\)]\)), wi\:0119c a=Exp(N))";

wartosciPoczatkowePert::usage="wartosciPoczatkowePert[lpol,x,rozwiazania0N,lw:-1,N0P:-8]: 
lpol - liczba p\[OAcute]l, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny (uwaga! czas kosmiczny musi by\[CAcute] oznaczony przez t, natomiast czas konforemny przez dowolny inny symbol),
rozwiazania0N - rozwi\:0105zanie dla liczby e-powi\:0119ksze\:0144 uzyskane z r\[OAcute]wna\:0144 dla t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn), 
lw - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`wektorFalowy) - je\:017celi lw=-1, to podstawiany jest symbol kw,
N0P - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: zestawy warto\:015bci pocz\:0105tkowych perturbacji wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego) dla wszystkich przebieg\[OAcute]w w formie {zestawy_wp,zestawy_dwp} (przyj\:0119to normalizacj\:0119 a=1 w momencie wychodzenia za horyzont, wi\:0119c a=Exp(N))";

rozwiazaniePert::usage="rozwiazaniePert[perturbacjekw,x,rownaniaPkw,kw,rozwiazania0,tf,wpP,N0P:-8]: 
perturbacjekw - lista nazw perturbacji, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rownaniaPkw - lista r\[OAcute]wna\:0144 ruchu dla sk\[LSlash]adowych fourierowskich perturbacji (uwaga! musz\:0105 by\[CAcute] podstawione wszystkie funkcje i parametry, a wektor falowy musi by\[CAcute] oznaczony przez kw), 
kw - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`wektorFalowy),
rozwiazania0 - lista rozwi\:0105za\:0144 dla p\[OAcute]l i ich pochodnych, parametru Hubble'a i liczby e-powi\:0119ksze\:0144 znalezionych z r\[OAcute]wna\:0144 dla t\[LSlash]a (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`rozwiazanieTlo),
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
wpP - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`wartosciPoczatkowePert),
N0P - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(1\)]\),...},{\!\(\*SubscriptBox[\(Q1\), \(2\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...}";

rozwiazaniePertk::usage="rozwiazaniePertk[perturbacjekw,x,rownaniaPkw,rozwiazania0,tf,wpP,N0P:-8]: 
perturbacjekw - lista nazw perturbacji, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rownaniaPkw - lista r\[OAcute]wna\:0144 ruchu dla sk\[LSlash]adowych fourierowskich perturbacji (uwaga! musz\:0105 by\[CAcute] podstawione wszystkie funkcje i parametry, a wektor falowy musi by\[CAcute] oznaczony przez kw),
rozwiazania0 - lista rozwi\:0105za\:0144 dla p\[OAcute]l i ich pochodnych, parametru Hubble'a i liczby e-powi\:0119ksze\:0144 znalezionych z r\[OAcute]wna\:0144 dla t\[LSlash]a (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`rozwiazanieTlo),
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
wpP - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`wartosciPoczatkowePert),
N0P - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji z liczb\:0105 falow\:0105 jako parametrem (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(1\)]\),...},{\!\(\*SubscriptBox[\(Q1\), \(2\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...}";

przejscieQQ::usage="przejscieQQ[x,rozwiazaniaP,baza,Go:{},fun:{},param:{}]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazaniaP - rozwi\:0105zania dla perturbacji dla dowolnej liczby przebieg\[OAcute]w w formie {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(1\)]\),...},{\!\(\*SubscriptBox[\(Q1\), \(2\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...} (uwaga! to musz\:0105 by\[CAcute] same rozwi\:0105zania, a nie lista podstawie\:0144),
baza - baza (w wierszach wektory, odpowiadaj\:0105ce kolejnym polom),
Go - tensor metryczny w przestrzeni p\[OAcute]l w pierwszym rz\:0119dzie w perturbacjach,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
wyj\:015bcie: lista perturbacji w nowej bazie: {{Q1_1,Q1_2,...},{Q2_1,Q2_2,...},...} (bez podstawie\:0144 rozwi\:0105za\:0144 dla t\[LSlash]a)";

przejscieQ\[ScriptCapitalR]\[ScriptCapitalS]::usage="przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x,Xo,rozwiazaniaP,Ebaza:{},Go:{},fun:{},param:{}]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
Xo - cz\[LSlash]on kinetyczny z podzia\[LSlash]em na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P) (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
rozwiazaniaP - rozwi\:0105zania dla perturbacji dla dowolnej liczby przebieg\[OAcute]w w formie {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(1\)]\),...},{\!\(\*SubscriptBox[\(Q1\), \(2\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...} (uwaga! to musz\:0105 by\[CAcute] same rozwi\:0105zania, a nie lista podstawie\:0144),
Ebaza - baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkIzoKrzywizna`bazaFreneta) - je\:017celi nie zostanie podana, rozwiazaniaP zostan\:0105 jedynie przemno\:017cone przez (H(t)/\[Sigma]'(t)),
Go - tensor metryczny w przestrzeni p\[OAcute]l w pierwszym rz\:0119dzie w perturbacjach,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
wyj\:015bcie: lista rozwi\:0105za\:0144 dla niezmienniczej wzgl\:0119dem cechowania perturbacji krzywizny \[ScriptCapitalR]=(H(t)/\[Sigma]'(t))Q\[Sigma] i zrenormalizowanej perturbacji izokrzywizny \[ScriptCapitalS]=(H(t)/\[Sigma]'(t))Qs (perturbacja \[Delta]s jest automatycznie niezmiennicza wzgl\:0119dem cechowania) dla wszystkich przebieg\[OAcute]w: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} (bez podstawie\:0144 rozwi\:0105za\:0144 dla t\[LSlash]a)";

normalizacjaWidmaKorelacje::usage="normalizacjaWidmaKorelacje[x,La,Xo,cs,rozwiazania0,efolds,fun:{},param:{},Twidm:'R']: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
Xo - cz\[LSlash]on kinetyczny z podzia\[LSlash]em na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P) (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
cs - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`predkoscDzwiekuEf),
rozwiazania0 - lista rozwi\:0105za\:0144 dla p\[OAcute]l i ich pochodnych, parametru Hubble'a i liczby e-powi\:0119ksze\:0144 znalezionych z r\[OAcute]wna\:0144 dla t\[LSlash]a (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`rozwiazanieTlo),
efolds - liczba e-powi\:0119ksze\:0144 w momencie przekraczania promienia Hubble'a,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
Twidm - dla jakiej perturbacji ma zosta\[CAcute] policzone widmo: 'R' - niezmiennicza perturbacja krzywizny \[ScriptCapitalR], 'Q' - perturbacja krzywizny Q\[Sigma], 'u' - wsp\[OAcute]\[LSlash]poruszaj\:0105ca si\:0119 perturbacja krzywizny u\[Sigma];
wyj\:015bcie: normalizacja - adiabatyczne widmo dla jednego pola skalarnego policzone w momencie przekraczania promienia Hubble'a";

normalizacjaWidmaKorelacjet::usage="normalizacjaWidmaKorelacjek[x,La,Xo,cs,rozwiazania0,kw,\[Tau]f,fun:{},param:{}]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
Xo - cz\[LSlash]on kinetyczny z podzia\[LSlash]em na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P) (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
cs - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`predkoscDzwiekuEf),
rozwiazania0 - lista rozwi\:0105za\:0144 dla p\[OAcute]l i ich pochodnych, parametru Hubble'a i liczby e-powi\:0119ksze\:0144 znalezionych z r\[OAcute]wna\:0144 dla t\[LSlash]a (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`rozwiazanieTlo),
kw - liczba falowa,
\[Tau]f - ko\:0144cowa warto\:015b\[CAcute] czasu konforemnego,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
wyj\:015bcie: normalizacja - adiabatyczne widmo dla jednego pola skalarnego zale\:017cne od czasu";

widmaRozw::usage="widmaRozw[rozwiazaniaP,kw,norm:1]: 
rozwiazaniaP - rozwi\:0105zania dla perturbacji dla dowolnej liczby przebieg\[OAcute]w w formie {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q1\), \(2\)]\),...},{\!\(\*SubscriptBox[\(Q2\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...} (uwaga! to musz\:0105 by\[CAcute] same rozwi\:0105zania, a nie lista podstawie\:0144),
kw - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, dla kt\[OAcute]rego zosta\[LSlash]y znalezione rozwi\:0105zania - je\:017celi kw=-1, to podstawiany jest symbol kk,
norm - normalizacja (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`normalizacjaWidma);
wyj\:015bcie: widma mocy perturbacji {PQ=\!\(\*SuperscriptBox[\(kw\), \(3\)]\)(Abs[\!\(\*SubscriptBox[\(Q\), \(i\)]\)\!\(\*SuperscriptBox[\(]\), \(2\)]\))/2\[Pi], PQ=\!\(\*SuperscriptBox[\(kw\), \(3\)]\)(Abs[\!\(\*SubscriptBox[\(Q\), \(1\)]\)\!\(\*SuperscriptBox[\(]\), \(2\)]\)+Abs[\!\(\*SubscriptBox[\(Q\), \(2\)]\)\!\(\*SuperscriptBox[\(]\), \(2\)]\)+...)/2\[Pi]"; 

korelacjeRozw::usage="korelacjeRozw[rozwiazaniaP,kw,norm:1]: 
rozwiazaniaP - rozwi\:0105zania dla perturbacji dla dowolnej liczby przebieg\[OAcute]w w formie {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q1\), \(2\)]\),...},{\!\(\*SubscriptBox[\(Q2\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...} (uwaga! to musz\:0105 by\[CAcute] same rozwi\:0105zania, a nie lista podstawie\:0144),
kw - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, dla kt\[OAcute]rego zosta\[LSlash]y znalezione rozwi\:0105zania - je\:017celi kw=-1, to podstawiany jest symbol kk,
norm - normalizacja (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`normalizacjaWidma);
wyj\:015bcie: korelacje CQ1Q2=\!\(\*SuperscriptBox[\(kw\), \(3\)]\)Abs[(Conjugate[\!\(\*SubscriptBox[\(Q1\), \(1\)]\)]*\!\(\*SubscriptBox[\(Q2\), \(1\)]\)+Conjugate[\!\(\*SubscriptBox[\(Q1\), \(2\)]\)]*\!\(\*SubscriptBox[\(Q2\), \(2\)]\)+...)]/2\[Pi]";

korelacjeURozw::usage="korelacjeURozw[widma,korelacje]: 
widma - widma w kolejno\:015bci: {P\[ScriptCapitalR],P\[ScriptCapitalS]1,P\[ScriptCapitalS]2,...} (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`widma),
korelacje - korelacje w kolejno\:015bci: {C\[ScriptCapitalR]\[ScriptCapitalS]1,C\[ScriptCapitalR]\[ScriptCapitalS]2,...,C\[ScriptCapitalS]1\[ScriptCapitalS]2,...} (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`korelacje);
wyj\:015bcie: wzgl\:0119dne korelacje CUQ1Q2=Abs[CQ1Q2]/Sqrt[PQ1*PQ2] (ich warto\:015bci mieszcz\:0105 si\:0119 mi\:0119dzy 0 a 1)";

indeksn::usage="indeksn[x,widma1,widma2,kw1,kw2,tf,rozwiazania0]:
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
widma1 - widma perturbacji dla kw1 (bez podstawionych warto\:015bci dla t\[LSlash]a),
widma2 - widma perturbacji dla kw2 (bez podstawionych warto\:015bci dla t\[LSlash]a),
kw1 - warto\:015b\[CAcute] wektora falowego, dla kt\[OAcute]rego zosta\[LSlash]o znalezione widmaR1,
kw2 - warto\:015b\[CAcute] wektora falowego, dla kt\[OAcute]rego zosta\[LSlash]o znalezione widmaR2 (uwaga! warto\:015b\[CAcute] ta musi by\[CAcute] bliska warto\:015bco kw1),
tf - ko\:0144cowy czas,
rozwiazania0 - lista rozwi\:0105za\:0144 dla p\[OAcute]l i ich pochodnych, znalezionych z r\[OAcute]wna\:0144 dla t\[LSlash]a (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`rozwiazanieTlo);
wyj\:015bcie: warto\:015bci indeksu spektralnego n_s";

wzmocnienie::usage="wzmocnienie[x,widma,tf,rozwiazania0]:
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
widma - widma perturbacji krzywizny i izokrzywizny (bez podstawionych warto\:015bci dla t\[LSlash]a),
tf - ko\:0144cowy czas,
rozwiazania0 - lista rozwi\:0105za\:0144 dla p\[OAcute]l i ich pochodnych, znalezionych z r\[OAcute]wna\:0144 dla t\[LSlash]a (mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkRozwiazania`rozwiazanieTlo);
wyj\:015bcie: ko\:0144cowa warto\:015b\[CAcute] widma perturbacji krzywizny";

Begin["`Private`"];


(* ::Section:: *)
(*Przybli\:017cenie powolnego toczenia*)


(* parametr powolnego toczenia \[Epsilon]=-H'[t]/H[t]^2 *)
parametrEpsilon[r000_,r110_,x_]:=parametrEpsilon[r000,r110,x]=
Block[{hh2,dhh},(
(* kwadrat parametru Hubble'a *)
hh2=mrkEinstein`Hubble2[r000,x];
(* pochodna parametru Hubble'a po czasie *)
dhh=mrkEinstein`dHubble0[r000,r110,x][[1,2]];
(* parametr powolnego toczenia \[Epsilon] *)
-dhh/hh2)]


(* warto\:015bci pocz\:0105tkowe pr\:0119dko\:015bci p\[OAcute]l znajdowane z przybli\:017cenia powolnego toczenia;
pola - nazwy p\[OAcute]l, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
rownania0 - kolejno r\[OAcute]wnania ruchu t\[LSlash]a i r\[OAcute]wnanie Friedmanna dla r=0 (uwaga! we wszystkich r\[OAcute]wnaniach musi by\[CAcute] podstawiony parametr Hubble'a H i wsp\[OAcute]\[LSlash]rz\:0119dna x[[1]]=t), 
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l;
wyj\:015bcie: lista podanych warto\:015bci pocz\:0105tkowych p\[OAcute]l i pr\:0119dko\:015bci p\[OAcute]l znalezionych z przybli\:017cenia powolnego toczenia w formie {{wp},{dwp}} *)
wpSlowRoll[pola_,x_,rownania0_,wp_]:=wpSlowRoll[pola,x,rownania0,wp]=
Block[{lpol,slowrollrr,slowrollrF,rownania0sr,szukane,rozwsr},(lpol=Length[pola];
(* warto\:015bci pocz\:0105tkowe dla r\[OAcute]wna\:0144 ruchu w przybli\:017ceniu powolnego toczenia *)
slowrollrr=MapThread[{#1''[x[[1]]]->0, #1[x[[1]]]->#2} &,{pola,wp}]//Flatten;
(* warto\:015bci pocz\:0105tkowe dla r\[OAcute]wnania Friedmanna w przybli\:017ceniu powolnego toczenia *)
slowrollrF=MapThread[{#1'[x[[1]]]->0, #1[x[[1]]]->#2} &,{pola,wp}]//Flatten;

(* r\[OAcute]wnania dla podanych warto\:015bci pocz\:0105tkowych w przybli\:017ceniu powolnego toczenia *)
rownania0sr=Join[Take[rownania0,lpol]/.slowrollrr,Take[rownania0,-1]/.slowrollrF,{Symbol["H"][x[[1]]]>0}];
(* szukane *)
szukane=Join[Map[#'[x[[1]]] &,pola],{Symbol["H"][x[[1]]]}];
(* rozwi\:0105zanie r\[OAcute]wna\:0144 *)
rozwsr=Solve[Rationalize[rownania0sr],szukane,Reals]//N;

(* ============= czy dobrze, \:017ce zawsze bior\:0119 pierwsze? ===================== *)
(* lista warto\:015bci pocz\:0105tkowych pr\:0119dko\:015bci p\[OAcute]l *)
{wp,Table[rozwsr[[1,J,2]],{J,1,lpol}]})]


(* ::Section:: *)
(*T\[LSlash]o*)


(* znajdowanie warto\:015bci poczatkowych dla konkretnej liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a *)
wartosciPoczatkoweTlo[pola_,x_,rownania0_,eps_,Nf_,wp_,wsp_]:=Block[
{lpol,sr,wprob,wartp,start,tf,efolds,row0,podstH,data,datai,rozw},(lpol=Length[pola];
(* sprawdzenie czy warto\:015bci pocz\:0105tkowe pr\:0119dko\:015bci maj\:0105 zosta\[CAcute] znalezione z przybli\:017cenia powolnego toczenia *)
sr=If[Length[Cases[wp,{___},1]]==0,True,False];

(* podstawienie parametru Hubble'a z r\[OAcute]wnania Friedmanna do r\[OAcute]wna\:0144 ruchu p\[OAcute]l *)
podstH=Solve[rownania0[[lpol+1]],Symbol["H"][x[[1]]]][[2]];
row0=Take[rownania0,lpol]/.podstH;

(* szukanie warto\:015bci pocz\:0105tkowych dla danej liczby e-powi\:0119ksze\:0144 *)
Catch[Do[
(* warto\:015bci pocz\:0105tkowe *)
wprob=If[sr,MapThread[#1+#2*i &,{wp,wsp}],{MapThread[#1+#2*i &,{wp[[1]],wsp[[1]]}],MapThread[#1+#2*i &,{wp[[2]],wsp[[2]]}]}];
(* warto\:015bci pocz\:0105tkowe pr\:0119dko\:015bci p\[OAcute]l znajdowane z przybli\:017cenia powolnego toczenia *)
wartp=If[sr,wpSlowRoll[pola,x,rownania0,wprob],wprob];
(* warunki pocz\:0105tkowe *)
start=Join[MapThread[#1[0.]==#2 &,{pola,wartp[[1]]}],MapThread[#1'[0.]==#2 &,{pola,wartp[[2]]}],{Symbol["nn"][0.]==0.}];
Print[start];

(* rozwi\:0105zywanie r\[OAcute]wna\:0144 t\[LSlash]a w zerowym rz\:0119dzie w perturbacjach - znalezienie ko\:0144cowej liczby e-powi\:0119ksze\:0144 i ko\:0144cowego czasu *)
datai=If[i==0,data=First[NDSolve`ProcessEquations[{Union[row0,{Symbol["nn"]'[x[[1]]]==podstH[[1,2]]}],
	WhenEvent[eps>1,{tf=x[[1]],efolds=Symbol["nn"][x[[1]]],"StopIntegration"}],Sequence@@start},{},x[[1]],
	(*WhenEvent[Evaluate[Symbol["nn"][x[[1]]]>Nf],{tf=x[[1]],efolds=Symbol["nn"][x[[1]]],"StopIntegration"}],Sequence@@start},{},x[[1]],*)
	(*MaxSteps->Infinity, MaxStepSize->0.001]],*)
	Method -> {"StiffnessSwitching", Method -> {"ExplicitRungeKutta", Automatic}}, MaxSteps->Infinity]],

	(*Method->{"ExplicitRungeKutta","DifferenceOrder"->4},StartingStepSize->1/1000]],*)
	First[NDSolve`Reinitialize[data, start]]];
NDSolve`Iterate[datai, 10^10];
Print[efolds];

(* branie pierwszych warto\:015bci pocz\:0105tkowych, daj\:0105cych podan\:0105 liczb\:0119 e-powi\:0119ksze\:0144 z zadan\:0105 dok\[LSlash]adno\:015bci\:0105 *)
If[Abs[efolds-Nf]<0.05,(Speak["Znalezione"]; Throw[Round[{wartp,efolds,tf},10^-24]]),{}],
{i,0,10}]])]


(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a *)
rozwiazanieTlo[pola_,x_,rownania0_,tf_,wp_,N0_,konf_:False,ti_:0.]:=
rozwiazanieTlo[pola,x,rownania0,tf,wp,N0,konf,ti]=
Block[{szukane,start,row0,podstH,lpol,rownn,rozw0},(lpol=Length[pola];
(* szukane i warunki pocz\:0105tkowe *)
If[konf, 
	(szukane=Join[Map[#[x[[1]]] &,pola],Map[#'[x[[1]]] &,pola],{Symbol["nn"][x[[1]]],Symbol["nn"]'[x[[1]]],Symbol["\[Tau]"][x[[1]]]}];
	start=Join[MapThread[#1[ti]==#2 &,{pola,wp[[1]]}],MapThread[#1'[ti]==#2 &,{pola,wp[[2]]}],{Symbol["nn"][ti]==N0,Symbol["\[Tau]"][ti]==0.}]//Rationalize;),
	
	(szukane=Join[Map[#[x[[1]]] &,pola],Map[#'[x[[1]]] &,pola],{Symbol["nn"][x[[1]]],Symbol["nn"]'[x[[1]]]}];
	start=Join[MapThread[#1[ti]==#2 &,{pola,wp[[1]]}],MapThread[#1'[ti]==#2 &,{pola,wp[[2]]}],{Symbol["nn"][ti]==N0}]//Rationalize;)];

(* podstawienie parametru Hubble'a z r\[OAcute]wnania Friedmanna do r\[OAcute]wna\:0144 ruchu p\[OAcute]l *)
podstH=Solve[rownania0[[lpol+1]],Symbol["H"][x[[1]]]][[2]];
row0=Take[rownania0,lpol]/.podstH;
 
(* rozwi\:0105zywanie r\[OAcute]wna\:0144 t\[LSlash]a w zerowym rz\:0119dzie w perturbacjach dla wybranych warunk\[OAcute]w pocz\:0105tkowych *)
(*Print[TimeObject[Now]," Rozwi\:0105zania dla t\[LSlash]a"];*)
rownn=If[konf, {Symbol["nn"]'[x[[1]]]==podstH[[1,2]],Symbol["\[Tau]"]'[x[[1]]]==Exp[-Symbol["nn"][x[[1]]]]},
	{Symbol["nn"]'[x[[1]]]==podstH[[1,2]]}];
rozw0=NDSolve[{Union[row0,rownn],Sequence@@start},szukane,{x[[1]],ti,tf}, 
	Method -> {"StiffnessSwitching", Method -> {"ExplicitRungeKutta", Automatic}}, WorkingPrecision->24, MaxSteps->Infinity][[1]];
	(*, WorkingPrecision\[Rule]24*)
rozw0)]


(* ::Section:: *)
(*Perturbacje*)


(* podstawienie czasu, odpowiadaj\:0105cego danej liczbie e-powi\:0119ksze\:0144 *)
czasN[x_,rozwiazania0N_,efolds_]:=
czasN[x,rozwiazania0N,efolds]=
Block[{t0,tf,Nt,N,midt,ti,midN},(
{t0,tf}=(rozwiazania0N[[1,2]]/.x[[1]]->"Domain")[[1]];
Nt=(Symbol["nn"][x[[1]]]/.rozwiazania0N)[[0]];

N=Round[efolds,0.001];

If[N == Round[Nt[t0],0.001], {x[[1]]->t0},
	(midt[ts_,te_]:=ts + (te - ts)/2.;
	Catch[Do[	
		ti = midt[t0,tf];
		midN = Round[Nt[ti], 0.001];
		If[N == midN, Throw[{x[[1]]->ti}]];
		If[midN < N, 
			(t0=ti;),
			(tf=ti;)],
	{i, 100000}]])]
)]


(*(* podstawienie czasu, odpowiadaj\:0105cego danej liczbie falowej *)
czask[x_,rozwiazania0N_,kw_]:=
(*czask[x,rozwiazania0N,kw]=*)
(*Chop[Solve[(Exp[Symbol["nn"][x[[1]]]]Symbol["nn"]'[x[[1]]]/.rozwiazania0N)\[Equal]kw,x[[1]], WorkingPrecision->5][[1]]]*)

Block[{t0,tf,Nt,dNt,listat,listakt,dokl,k},(
{t0,tf}=(rozwiazania0N[[1,2]]/.x[[1]]->"Domain")[[1]];
Nt=(Symbol["nn"][x[[1]]]/.rozwiazania0N)[[0]];
dNt=(Symbol["nn"]'[x[[1]]]/.rozwiazania0N)[[0]];
(*listat=Range[t0,tf,tf*10^(-5)];
listakt=Map[{Exp[Nt[#]]*dNt[#],#} &,listat];*)	
dokl=RealDigits[kw][[2]];
(*Catch[Map[If[Round[kw,10^(dokl)*0.1]==Round[#[[1]],10^(dokl)*0.1],Throw[{x[[1]]->#[[2]]}]] &, listakt]])]*)

k=Round[kw,10^(dokl)*0.1];

Catch[Do[If[k==Round[Exp[Nt[i]]*dNt[i],10^(dokl)*0.1],Throw[{x[[1]]->i}]], {i,t0,tf,tf*10^(-7)}]])]*)


(* wsp\[OAcute]\[LSlash]poruszaj\:0105cy si\:0119 wektor falowy w momencie przekraczania promienia Hubble'a: k=aH=e^N*N'(t);
przyj\:0119to a_0=Exp(N_0), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
wektorFalowy[x_,rozwiazania0N_,efolds_]:=wektorFalowy[x,rozwiazania0N,efolds]=
Block[{punkt},(
(* czas, odpowiadaj\:0105cy danej liczbie e-powi\:0119ksze\:0144 *)
punkt=czasN[x,rozwiazania0N,efolds];
(* warto\:015b\[CAcute] wektora falowego w momencie przekraczania promienia Hubble'a *)
Exp[Symbol["nn"][x[[1]]]]Symbol["nn"]'[x[[1]]]/.rozwiazania0N/.punkt)]


(* wsp\[OAcute]\[LSlash]poruszaj\:0105cy si\:0119 wektor falowy w momencie przekraczania promienia Hubble'a: k=aH=e^N*N'(t);
przyj\:0119to a_0=Exp(N_0), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
wektorFalowyTest[x_,rozwiazania0N_,efolds_]:=
(*wektorFalowyTest[x,rozwiazania0N,efolds]=*)
Block[{k1,k2},(
(* liczba falowa dla N=0 *)
k1=wektorFalowy[x,rozwiazania0N,0.];
(* liczba falowa dla podanego N *)
k2=wektorFalowy[x,rozwiazania0N,efolds];
(* liczby falowe w momencie przekraczania promienia Hubble'a dla r\[OAcute]\:017cnych N *)
{k1,k2,k1-k2,k2/k1})]


(* warto\:015bci pocz\:0105tkowe perturbacji wewn\:0105trz promienia Hubble'a - pr\[OAcute]\:017cnia typu Minkowskiego: 
Q0=Exp[-i*kw*\[Tau]]/(a(t)*Sqrt[2*kw]), gdzie \[Tau] - czas konformeny i t - czas kosmiczny; 
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) oraz \[Tau]_i=0 *)
wartosciPoczatkowePert[lpol_,x_,rozwiazania0N_,lw_:-1,N0P_:-8]:=
wartosciPoczatkowePert[lpol,x,rozwiazania0N,lw,N0P]=
Block[{punkt,wp,wpN,dwp,dwpN,tau0,dN0P,dtau0},(
(* czas, odpowiadaj\:0105cy pocz\:0105tkowej liczbie e-powi\:0119ksze\:0144 *)
punkt=czasN[x,rozwiazania0N,N0P];

(* warto\:015b\[CAcute] pocz\:0105tkowa pertrubacji - p\[OAcute]\:017cnia typu Minkowskiego; przyj\:0119to \[Tau]_i=0 *) 
wp=If[lw==-1, Exp[-N0P]/Sqrt[2*Symbol["kw"]], 
	Exp[-N0P]/Sqrt[2*lw]];	
(* zestawy warto\:015bci pocz\:0105tkowych perturbacji dla wszystkich przebieg\[OAcute]w {{wp,0,0,...},{0,wp,0,...},...} *)
wpN=Table[Insert[Table[0.,lpol-1],wp,I],{I,1,lpol}]/.rozwiazania0N/.punkt;

(* warto\:015b\[CAcute] pocz\:0105tkowa pochodnej perturbacji - pochodna po czasie kosmicznym *)
dN0P=Symbol["nn"]'[x[[1]]]/.rozwiazania0N/.punkt;
dwp=If[lw==-1, Exp[-N0P](-I*Symbol["kw"]*Exp[-N0P]-dN0P)/Sqrt[2*Symbol["kw"]], 
	Exp[-N0P](-I*lw*Exp[-N0P]-dN0P)/Sqrt[2*lw]];
(* zestawy warto\:015bci pocz\:0105tkowych pochodnych perturbacji dla wszystkich przebieg\[OAcute]w {{dwp,0,0,...},{0,dwp,0,...},...} *)
dwpN=Table[Insert[Table[0.,lpol-1],dwp,I],{I,1,lpol}];

(* zestawy warto\:015bci pocz\:0105tkowych {zestawy_wp,zestawy_dwp} *)
{wpN,dwpN})]


(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji *)
rozwiazaniePert[pertkw_,x_,rownaniaPkw_,kw_,rozwiazania0_,tf_,wpP_,N0P_:-8]:=
rozwiazaniePert[pertkw,x,rownaniaPkw,kw,rozwiazania0,tf,wpP,N0P]=
Block[{t0P,podstHN,lprzebiegow,szukane,start,rowN,rozw,data,datai},(lprzebiegow=Length[wpP[[1]]];
(* czas, odpowiadaj\:0105cy pocz\:0105tkowej liczbie e-powi\:0119ksze\:0144 *)
t0P=Rationalize[czasN[x,rozwiazania0,N0P][[1,2]],10^(-24)];
(* podstawienie parametru Hubble'a H[t]=nn'[t] *)
podstHN=mrkUzyteczny`zastapienieHN[x][[1]];

(* szukane *)
szukane=Map[#[x[[1]]] &, pertkw];
(* warunki pocz\:0105tkowe *)
start=Table[Join[MapThread[#1[t0P]==#2 &,{pertkw,wpP[[1,J]]}],MapThread[#1'[t0P]==#2 &,{pertkw,wpP[[2,J]]}]],{J,1,lprzebiegow}];
(* r\[OAcute]wnania z podstawionym wektorem falowym *)
rowN=rownaniaPkw/.{Symbol["kw"]->kw, Symbol["a"][x[[1]]]->Exp[Symbol["nn"][x[[1]]]], podstHN}/.rozwiazania0;

(* rozwi\:0105zania dla perturbacji *)
(*Print[TimeObject[Now]," Rozwi\:0105zania dla perturbacji"];*)
(*rozw=Table[NDSolveValue[{rowN,Sequence@@start[[J]]},szukane,{x[[1]],t0P,tf},MaxSteps->Infinity,MaxStepSize->0.01],{J,1,lprzebiegow}];*)
rozw=Reap[Do[
	datai=If[i==1,data=First[NDSolve`ProcessEquations[{rowN,Sequence@@start[[i]]},szukane,x[[1]],
						Method -> {"StiffnessSwitching", Method -> {"ExplicitRungeKutta", Automatic}}, MaxSteps->Infinity]], 
		First[NDSolve`Reinitialize[data, start[[i]]]]];
	NDSolve`Iterate[datai, tf];
	Sow[NDSolve`ProcessSolutions[datai]],
	{i,1,lprzebiegow}]][[2,1]];
rozw=Table[Map[#[[2]] &, rozw[[i]]], {i,1,lprzebiegow}];
rozw)]


(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji z liczba falow\:0105 jako parametrem *)
rozwiazaniePertk[pertkw_,x_,rownaniaPkw_,rozwiazania0_,tf_,wpP_,N0P_:-8]:=
rozwiazaniePertk[pertkw,x,rownaniaPkw,rozwiazania0,tf,wpP,N0P]=
Block[{t0P,podstHN,lprzebiegow,szukane,start,rowN,rozw,data,datai},(
lprzebiegow=Length[wpP[[1]]];
(* czas, odpowiadaj\:0105cy pocz\:0105tkowej liczbie e-powi\:0119ksze\:0144 *)
t0P=czasN[x,rozwiazania0,N0P][[1,2]];
(* podstawienie parametru Hubble'a H[t]=nn'[t] *)
podstHN=mrkUzyteczny`zastapienieHN[x][[1]];

(* szukane *)
szukane=pertkw;
(* warunki pocz\:0105tkowe *)
start=Table[Join[MapThread[#1[t0P]==#2 &,{pertkw,wpP[[1,J]]}],MapThread[#1'[t0P]==#2 &,{pertkw,wpP[[2,J]]}]],{J,1,lprzebiegow}];
(* r\[OAcute]wnania z podstawionym wektorem falowym *)
rowN=rownaniaPkw/.{Symbol["a"][x[[1]]]->Exp[Symbol["nn"][x[[1]]]], podstHN}/.rozwiazania0;

(* rozwi\:0105zania dla perturbacji *)
(*Print[TimeObject[Now]," Rozwi\:0105zania dla perturbacji"];*)
(*rozw=Table[ParametricNDSolveValue[{Sequence@@rowN,Sequence@@start[[J]]},Sequence@@szukane,{x[[1]],t0P,tf},{Symbol["kw"]},*)
rozw=Table[ParametricNDSolve[{Sequence@@rowN,Sequence@@start[[J]]},szukane,{x[[1]],t0P,tf},{Symbol["kw"]},
	Method -> {"StiffnessSwitching", Method -> {"ExplicitRungeKutta", Automatic}}, MaxSteps->Infinity],
	{J,1,lprzebiegow}];
rozw=Map[Table[#[[i,2]][Symbol["kk"]][x[[1]]],{i,Range[Length[#]]}] &, rozw];
rozw)]


(* lista rozwi\:0105za\:0144 dla perturbacji w nowej bazie dla wszystkich przebieg\[OAcute]w: {{Q1_1,Q1_2,...},{Q2_1,Q2_2,...},...} *)
przejscieQQ[rozwiazaniaP_,baza_,Go_,fun_:{},param_:{}]:=
przejscieQQ[rozwiazaniaP,baza,Go,fun,param]=
Block[{lpol,lprzebiegow},(
(*lpol=Length[rozwiazaniaP[[1]]]; lprzebiegow=Length[rozwiazaniaP];*)
(* perturbacje w nowej bazie *)
Print[TimeObject[Now]," Perturbacje w nowej bazie"];
(*Table[(Go.baza[[i]].rozwiazaniaP[[k]]),{i,1,lpol},{k,1,lprzebiegow}]/.fun/.param)]*)
baza.Go.Transpose[rozwiazaniaP]/.fun/.param)]


(* lista rozwi\:0105za\:0144 dla perturbacji krzywizny i izokrzywizny dla wszystkich przebieg\[OAcute]w: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...};
niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny \[ScriptCapitalR]=(H(t)/\[Sigma]'(t))Q\[Sigma] i 
zrenormalizowana perturbacja izokrzywizny \[ScriptCapitalS]=(H(t)/\[Sigma]'(t))Qs (perturbacja \[Delta]s jest automatycznie niezmiennicza wzgl\:0119dem cechowania) *)
przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x_,Xo_,rozwiazaniaP_,Ebaza_:{},Go_:{},fun_:{},param_:{}]:=
przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x,Xo,rozwiazaniaP,Ebaza,Go,fun,param]=
Block[{lpol,lprzebiegow,d\[Sigma]},(
(*lpol=Length[rozwiazaniaP[[1]]]; lprzebiegow=Length[rozwiazaniaP];*)
(* pomocnicza zmienna *)
d\[Sigma]=Sqrt[2*(Xo/.Symbol["P"]->0)]; 
(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
(*Print[TimeObject[Now]," Perturbacje \[ScriptCapitalR] i \[ScriptCapitalS]"];*)
(*If[Ebaza=={},Table[(Symbol["nn"]'[x[[1]]]/d\[Sigma])rozwiazaniaP[[k,i]],{i,1,lpol},{k,1,lprzebiegow}],
	Table[(Symbol["nn"]'[x[[1]]]/d\[Sigma])(Go.Ebaza[[i]].rozwiazaniaP[[k]]),{i,1,lpol},{k,1,lprzebiegow}]]/.fun/.param)]*)
If[Ebaza=={},(Symbol["nn"]'[x[[1]]]/d\[Sigma])*Transpose[rozwiazaniaP],
	(Symbol["nn"]'[x[[1]]]/d\[Sigma])*Ebaza.Go.Transpose[rozwiazaniaP]] /. fun /. param)]


(* normalizacja - adiabatyczne widmo dla jednego pola skalarnego policzone w momencie przekraczania promienia Hubble'a (m=0, de Sitter) *)
normalizacjaWidmaKorelacje[x_,La_,Xo_,cs_,rozwiazania0_,efolds_,fun_:{},param_:{},Twidm_:"R"]:=
normalizacjaWidmaKorelacje[x,La,Xo,cs,rozwiazania0,efolds,fun,param,Twidm]=
Block[{d\[Sigma],punkt,LaX,norm},(
(* czas w momencie przekraczania promienia Hubble'a; przyj\:0119to normalizacj\:0119 a=1 dla N=0 *)
punkt=czasN[x,rozwiazania0,efolds];

(* pochodna lagran\:017cjanu po cz\[LSlash]onie kinetycznym *)
LaX=D[La,Symbol["XK"]] /. Symbol["XK"]->Xo /. Symbol["P"]->0;

(* normalizacja *)
Which[Twidm=="R", 
	((* pomocnicza zmienna *)
	d\[Sigma]=Sqrt[2*(Xo/.Symbol["P"]->0)];
	norm=Symbol["nn"]'[x[[1]]]^4/(4*Pi^2*d\[Sigma]^2*cs*LaX));,
	Twidm=="Q",
	norm=Symbol["nn"]'[x[[1]]]^2/(4*Pi^2*cs*LaX);,
	Twidm=="u",
	norm=Symbol["nn"]'[x[[1]]]^2*Exp[2*Symbol["nn"][x[[1]]]]/(4*Pi^2*cs^3);];
norm /. fun /. param /. rozwiazania0 /. punkt)]


(* normalizacja - widmo perturbacji krzywizny dla jednego pola skalarnego (m=0, de Sitter) *)
normalizacjaWidmaKorelacjet[x_,La_,Xo_,cs_,rozwiazania0_,kw_,\[Tau]f_,fun_:{},param_:{}]:=
normalizacjaWidmaKorelacjet[x,La,Xo,cs,rozwiazania0,kw,\[Tau]f,fun,param]=
Block[{tf,d\[Sigma],LaX},(
(* pomocnicza zmienna *)
d\[Sigma]=Sqrt[2*(Xo/.Symbol["P"]->0)];
(* pochodna lagran\:017cjanu po cz\[LSlash]onie kinetycznym *)
LaX=D[La,Symbol["XK"]] /. Symbol["XK"]->Xo /. Symbol["P"]->0;
(* normalizacja *)
Symbol["nn"]'[x[[1]]]^2*cs*(kw^2+1/(cs*(Symbol["\[Tau]"][x[[1]]]-\[Tau]f))^2)/(4*Pi^2*d\[Sigma]^2*Exp[2*Symbol["nn"][x[[1]]]]*LaX)/.fun/.param/.rozwiazania0
(*Symbol["nn"]'[x[[1]]]^2*cs*(kw^2+1/(cs*(Symbol["\[Tau]"][x[[1]]]-\[Tau]f+10^(-7)))^2)/(4*Pi^2*d\[Sigma]^2*Exp[2*Symbol["nn"][x[[1]]]]*LaX)/.fun/.param/.rozwiazania0*)
)]


(* widma mocy perturbacji PQ=kw^3(Abs[Q_1]^2+Abs[Q_2]^2+...)/2\[Pi]^2 *)
widmaRozw[rozwiazaniaP_,kw_,norm_:1]:=widmaRozw[rozwiazaniaP,kw,norm]=
Block[{lpol,wsp},(lpol=Length[rozwiazaniaP];
(* wsp\[OAcute]\[LSlash]czynnik *)
wsp=If[kw==-1, Symbol["kk"]^3/(2*Pi^2*norm), kw^3/(2*Pi^2*norm)];

(* widma mocy: {{{P\[ScriptCapitalR]1,P\[ScriptCapitalR]2,...},{P\[ScriptCapitalS]11,P\[ScriptCapitalS]12,...},...}, {P\[ScriptCapitalR]tot,P\[ScriptCapitalS]1tot,P\[ScriptCapitalS]2tot,...}} *)
(*Print[TimeObject[Now]," Widma"];*)
{Abs[rozwiazaniaP]^2,
Table[Total[Abs[rozwiazaniaP[[i]]]^2],{i,1,lpol}]}*wsp)]


(* korelacje CQ1Q2=k^3Abs[(Conjugate[Q1_1]*Q2_1+Conjugate[Q1_2]*Q2_2+...)]/2\[Pi] *)
korelacjeRozw[rozwiazaniaP_,kw_,norm_:1]:=korelacjeRozw[rozwiazaniaP,kw,norm]=
Block[{wsp,parypert,lpar},(
(* wsp\[OAcute]\[LSlash]czynnik *)
wsp=If[kw==-1, Symbol["kk"]^3/(2*Pi^2*norm), kw^3/(2*Pi^2*norm)];

(* pary perturbacji: {{{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...}},{{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]21,\[ScriptCapitalS]22,...}},...} *)
parypert=Subsets[rozwiazaniaP,{2}];
lpar=Length[parypert];
(* korelacje: {C\[ScriptCapitalR]\[ScriptCapitalS]1,C\[ScriptCapitalR]\[ScriptCapitalS]2,...,C\[ScriptCapitalS]1\[ScriptCapitalS]2,...} *)
Print[TimeObject[Now]," Korelacje"];
Table[Abs[(Conjugate[parypert[[i,1]]].parypert[[i,2]])*wsp],{i,1,lpar}])]


(* wzgl\:0119dne korelacje CUQ1Q2=Abs[CQ1Q2]/Sqrt[PQ1*PQ2];
widma w kolejno\:015bci: {P\[ScriptCapitalR],P\[ScriptCapitalS]1,P\[ScriptCapitalS]2,...} i korelacje w kolejno\:015bci: {C\[ScriptCapitalR]\[ScriptCapitalS]1,C\[ScriptCapitalR]\[ScriptCapitalS]2,...,C\[ScriptCapitalS]1\[ScriptCapitalS]2,...} *)
korelacjeURozw[widma_, korelacje_]:=korelacjeURozw[widma,korelacje]=
Block[{parywidma,lkor},(lkor=Length[korelacje];
(* pary widm mocy: {{P\[ScriptCapitalR],P\[ScriptCapitalS]1},{P\[ScriptCapitalR],P\[ScriptCapitalS]2},...} *)
parywidma=Subsets[widma,{2}];
(* korelacje wzgl\:0119dne *)
Print[TimeObject[Now]," Korelacje wzgl\:0119dne"];
Table[Abs[korelacje[[i]]]/Sqrt[parywidma[[i,1]]parywidma[[i,2]]],{i,1,lkor}])]


(* indeks spektralny n_s *)
indeksn[x_,widma1_,widma2_,kw1_,kw2_,tf_,rozwiazania0_]:=indeksn[x,widma1,widma2,kw1,kw2,tf,rozwiazania0]=
1+(kw1/(widma1))*((widma2-widma1)/(kw2-kw1))/.x[[1]]->tf/.(rozwiazania0/.x[[1]]->tf/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))


(* wzmocnienie perturbacji - ko\:0144cowa warto\:015b\[CAcute] widma mocy perturbacji krzywizny i izokrzywizny *)
wzmocnienie[x_,widma_,tf_,rozwiazania0_]:=wzmocnienie[x,widma,tf,rozwiazania0]=
widma/.x[[1]]->tf/.(rozwiazania0/.x[[1]]->tf/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))


End[];
EndPackage[];
