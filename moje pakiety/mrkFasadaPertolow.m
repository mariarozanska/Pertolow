(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkFasadaPertolow`*)


(* :Title: Fasada dla projektu Perto\[LSlash]\[OAcute]w *)

(* :Context: mrkFasadaPertolow` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
zapisywanie danych do plik\[OAcute]w
r\[OAcute]wnanie pola
r\[OAcute]wnania ruchu
rozwi\:0105zania r\[OAcute]wna\:0144 ruchu
produkcja cz\:0105stek
*)

(* :Copyright: *)
 
(* :Package Version: 2.0 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 20.08.2016
    Version 1.1, 19.03.2017
      - rozdzielenie rysowania widm i korelacji
      - wydzielenie indeksu spektralnego i dodanie wzmocnienia
      - rysowanie element\[OAcute]w bazy Freneta
    Version 1.2, 10.04.2017
      - zapisywanie r\[OAcute]wna\:0144 i bazy do notebooka i plik\[OAcute]w txt
      - testowa baza Freneta i baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy
      - testowe rysowanie widm dla podanej bazy
      - wsp\[OAcute]\[LSlash]czynniki oddzia\[LSlash]ywania mi\:0119dzy perturbacjami krzywizny i izokrzywizny
      - testowanie warto\:015bci liczby falowej
      - widma dla konkretnych przebieg\[OAcute]w i w zale\:017cno\:015bci od liczby falowej
    Version 1.3, 27.04.2017
      - r\[OAcute]wnania ruchu dla zmiennych wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119
      - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku
    Version 1.4, 09.05.2017
      - poprawienie oraz rozdzielenie rysowania mas i efektywnych mas
      - rysowanie element\[OAcute]w bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy
    Version 1.5, 20.07.2017
      - rysowanie liczb obsadze\:0144
      - testowa g\:0119sto\:015b\[CAcute] energii wyprodukowanych cz\:0105stek
      - pr\:0119dko\:015bci k\:0105towe bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy
    Version 2.0, 08.08.2017
      - macierz masy i lagran\:017cjan
      - przebudowa funkcji do rysowania widm: jedna funkcja do rysowania zale\:017cno\:015bci od N i k, w bazie Freneta lub wektor\[OAcute]w w\[LSlash]asnych macierzy masy, mo\:017cliwo\:015b\[CAcute] uwzgl\:0119dnienia produkcji cz\:0105stek
      - przebudowa funkcji do obliczania indeksu spektralnego: baza Freneta lub wektor\[OAcute]w w\[LSlash]asnych macierzy masy, mo\:017cliwo\:015b\[CAcute] uwzgl\:0119dnienia produkcji cz\:0105stek
      - przebudowa funkcji do rysowania liczb obsadze\:0144: jedna funkcja do rysowania zale\:017cno\:015bci od N i k
      - funkcja do rysowania perturbacji
*)

(* :Keywords: *)

(* :Requirements: 
"mrkUzyteczny`", "mrkEinstein`", "mrkLagrange`", "mrkFourier`", "mrkMukhanovSasaki`", "mrkIzoKrzywizna`", "mrkRozwiazania`", "mrkWykresy`", "mrkProdukcjaCzastek`"
*)

(* :Sources: *)

(* :Warnings:
MukhanovSasakiRownaniakw[]: perturbacja metryki perm jest wyznaczana z wyrazu przy kw^2, mo\:017ce w jakim\:015b przypadku takie podstawienie nie b\:0119dzie si\:0119 \[LSlash]adnie skraca\[LSlash]o?
PerturbacjeRSRownaniakw[]: czy kolejno\:015b\[CAcute] podstawie\:0144 w ruchuRNAEkw[] b\:0119dzie zawsze prawid\[LSlash]owa?
Masy[], WykresyBazaMasy[], LiczbaObsadzenN[], LiczbaObsadzenk[], GestoscEnergiiCzastekTest[], PredkosciKatoweBazaMasy[]: czy kolejno\:015b\[CAcute] wektor\[OAcute]w w\[LSlash]asnych macierzy masy b\:0119dzie zawsze prawid\[LSlash]owa? (za\[LSlash]o\:017cono, \:017ce najwi\:0119ksze warto\:015bci w macierzy wektor\[OAcute]w w\[LSlash]asnych wyst\:0119puj\:0105 na diagonali)
MasyEfektywne[]: czy kolejno\:015b\[CAcute] wektor\[OAcute]w w\[LSlash]asnych macierzy masy b\:0119dzie zawsze prawid\[LSlash]owa? (za\[LSlash]o\:017cono, \:017ce najwi\:0119ksze warto\:015bci w macierzy wektor\[OAcute]w w\[LSlash]asnych wyst\:0119puj\:0105 tam, gdzie w bazie Freneta)
*)

(* :Limitations:
tensor energii-p\:0119du/r\[OAcute]wnania ruchu: dla \[ScriptCapitalL]=F(X,\[Phi]^I), gdzie I=N - liczba p\[OAcute]l skalarnych, X=-(1/2)G_IJ*g^\[Mu]\[Nu]*\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\(\[Phi]^I\)\)\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\(\[Phi]^J\)\) - cz\[LSlash]on kinetyczny
r\[OAcute]wnania pola: w teorii f(R)
r\[OAcute]wnania ruchu dla zmiennej adiabatycznej i entropowych: w pierwszym rz\:0119dzie w perturbacjach, do dw\[OAcute]ch p\[OAcute]l, dla MS=False nie ma podstawienie perturbacji metryki
 *)

(* :Discussion: 
- indeksy nale\:017cy podawa\[CAcute] od 0
- w tensorze metrycznym i tensorze energii-p\:0119du perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P
- czynnik skali w tensorze metrycznym musi by\[CAcute] oznaczony przez a
- w lagran\:017cjanie cz\[LSlash]on kinetyczny musi by\[CAcute] oznaczony przez XK i potencja\[LSlash] przez V[Sequence@@pola]
- skalar Ricciego musi by\[CAcute] oznaczony przez rr[Sequence@@x]
- liczba falowa musi by\[CAcute] oznaczony przez kk

- perturbacje pierwotnych p\[OAcute]l s\:0105 oznaczane przez \[Delta]{nazwa_pola}
- zmienne Mukhanova-Sasakiego s\:0105 oznaczane przez Q{nazwa_pola}
- perturbacje krzywizny i izokrzywizny s\:0105 oznaczane przez Q\[Sigma],Qs1,Qs2,... dla zmiennych Mukhanova-Sasakiego i \[Delta]\[Sigma],\[Delta]s1,\[Delta]s2,... dla pierwotnych zmiennych
- nazwy sk\[LSlash]adowych fourierowskich s\:0105 tworzone przez dodanie na ko\:0144cu kw
- parametr Hubble'a jest oznaczany przez H
*)


BeginPackage["mrkFasadaPertolow`",{"mrkUzyteczny`","mrkEinstein`","mrkLagrange`","mrkFourier`","mrkMukhanovSasaki`","mrkIzoKrzywizna`","mrkRozwiazania`","mrkWykresy`","mrkProdukcjaCzastek`"}];

PlikNb::usage="PlikNb[lista,nazwa,sciezka:Directory[]]: 
lista - lista opis\[OAcute]w i wyra\:017ce\:0144 w formie {{opis, wyra\:017cenie}, ...}, 
nazwa - nazwa pliku,
sciezka - \:015bcie\:017cka do miejsca, gdzie ma zosta\[CAcute] zapisany notebook;
wyj\:015bcie: notebook, zawieraj\:0105cy podane wyra\:017cenia";

PlikTex::usage="PlikTex[pola,lista]: 
pola - lista nazw p\[OAcute]l,
lista - lista wyra\:017ce\:0144;
wyj\:015bcie: string, zawieraj\:0105cy podane wyra\:017cenia w formie latexowej";

PlikTexRownania::usage="PlikTexRownania[pola,lista,nazwa,sciezka:Directory[]]: 
pola - lista nazw p\[OAcute]l,
lista - lista opis\[OAcute]w i wyra\:017ce\:0144 w formie {{opis, wyra\:017cenie}, ...}, 
nazwa - nazwa pliku,
sciezka - \:015bcie\:017cka do miejsca, gdzie ma zosta\[CAcute] zapisany plik txt;
wyj\:015bcie: plik txt, zawieraj\:0105cy podane r\[OAcute]wnania w formie latexowej";

PlikTexBaza::usage="PlikTexBaza[pola,lista,nazwa,sciezka:Directory[]]: 
pola - lista nazw p\[OAcute]l,
lista - lista z opisem i baz\:0105 w formie {opis, baza}, 
nazwa - nazwa pliku,
sciezka - \:015bcie\:017cka do miejsca, gdzie ma zosta\[CAcute] zapisany plik txt;
wyj\:015bcie: plik txt, zawieraj\:0105cy baz\:0119 dla perturbacji krzywizny i izokrzywizny w formie latexowej";

PlikTexTabela::usage="PlikTexTabela[opisy,wartosci,nazwa,sciezka:Directory[]]: 
opisy - lista nag\[LSlash]\[OAcute]wk\[OAcute]w tabeli - wymagane, gdy plik jeszcze nie istnieje,
wartosci - lista warto\:015bci, kt\[OAcute]re maj\:0105 zosta\[CAcute] dopisane do tabeli w formie wiersza (uwaga! warto\:015bci musi by\[CAcute] tyle samo, co kolumn w tabeli), 
nazwa - nazwa pliku,
sciezka - \:015bcie\:017cka do miejsca, gdzie ma zosta\[CAcute] zapisany plik txt;
wyj\:015bcie: plik txt, zawieraj\:0105cy tabel\:0119 w formie latexowej - je\:017celi plik ju\:017c istnieje, dopisywany jest kolejny wiersz (u g\[OAcute]ry pliku znajduje si\:0119 zako\:0144czenie tabeli)";

PolaRownaniekw::usage="PolaRownaniekw[pola,fG,La,fR,\[Mu],\[Nu],g,x,r:0,dd:True]: 
pola - lista nazw p\[OAcute]l (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
\[Mu] i \[Nu] - indeksy (uwaga! indeksy nale\:017cy podawa\[CAcute] od 0), 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
r - rz\:0105d w perturbacjach (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
dd - True oznacza, \:017ce oba indeksy s\:0105 dolne, a False, \:017ce \[Mu] jest g\[OAcute]rny i \[Nu] dolny;
wyj\:015bcie: r\[OAcute]wnanie pola dla sk\[LSlash]adowych fourierowskich w teorii f(R) (\!\(\*SubscriptBox[\(\[ScriptCapitalL]\), \(g\)]\)=f(R)): f'(R)\!\(\*SubscriptBox[\(R\), \(\[Mu]\[Nu]\)]\)-\!\(\*FractionBox[\(1\), \(2\)]\)f(R)\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)-(f'(R)\!\(\*SubscriptBox[\()\), \(\(;\)\(\[Nu]\)\(;\)\(\[Mu]\)\)]\)+\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)(f'(R)\!\(\*SubsuperscriptBox[\()\), \(\(\\\ \\\ \)\(\(;\)\(\[Alpha]\)\)\), \(\(;\)\(\[Alpha]\)\)]\)=\!\(\*SubscriptBox[\(T\), \(\[Mu]\[Nu]\)]\) (uwaga! konwencja 8\[Pi]G=\!\(\*SubsuperscriptBox[\(M\), \(Pl\), \(-2\)]\)=1)";

Lagrangian::usage="Lagrangian[g,x,pola,fG,La,r:0]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
r - rz\:0105d w perturbacjach (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: g\:0119sto\:015b\[CAcute] lagran\:017cjanu: \[ScriptCapitalL]=F(X,\[Phi]^I), gdzie I=N - liczba p\[OAcute]l skalarnych, X=-(1/2)Subscript[G, IJ]g^\[Mu]\[Nu]\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\)\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\)\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\)\!\(\*SuperscriptBox[\(\[Phi]\), \(J\)]\) - cz\[LSlash]on kinetyczny";

RuchuRownaniakw::usage="RuchuRownaniakw[g,x,pola,fG,La,r:0]: 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich wszystkich p\[OAcute]l skalarnych dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\))";

PredkoscDzwiekuEf::usage="predkoscDzwiekuEf[g,x,pola,fG,La]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola];
wyj\:015bcie: efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku";

MacierzMasy::usage="MacierzMasy[g,x,pola,fG,La,O:True]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
O - czy wyrazi\[CAcute] parametr Hubble'a za pomoc\:0105 liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: macierz masy pierwotnych p\[OAcute]l";

MukhanovSasakiRownaniakw::usage="MukhanovSasakiRownaniakw[pola,fG,La,g,x,fR,r:1]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! musi by\[CAcute] zapisany w longitudinal gauge i zawiera\[CAcute] czynnik skali oznaczony przez a: \!\(\*SuperscriptBox[\(ds\), \(2\)]\)=-(1+2\[CapitalPhi])\!\(\*SuperscriptBox[\(dt\), \(2\)]\)+\!\(\*SuperscriptBox[\(a\), \(2\)]\)(1-2\[CapitalPhi])\!\(\*SuperscriptBox[\(dx\), \(2\)]\)), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego (niezmienniczych wzgl\:0119dem cechowania) \!\(\*SubscriptBox[\(Q\), \(\[Phi]\)]\)=\[Delta]\[Phi]+\!\(\*FractionBox[\(\[Phi]' \((t)\)\), \(H \((t)\)\)]\)\[CapitalPhi] dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\!\(\*SuperscriptBox[\(\[Phi]\), \(I\)]\))";

BazaFreneta::usage="BazaFreneta[g,x,pola,fG,La,O:True]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny, 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
O - czy wyrazi\[CAcute] parametr Hubble'a za pomoc\:0105 liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie";

BazaFrenetaTest::usage="BazaFrenetaTest[t,pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},N0:-8]: 
t - czas,
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: baza Freneta w danej chwili t - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie";

WykresyBaza::usage="WykresyBaza[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],N0:-8]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: wykresy element\[OAcute]w bazy Freneta od liczby e-powi\:0119ksze\:0144 (wierszami E_i oraz kolumnami E^i)";

PredkosciKatoweBazy::usage="PredkosciKatoweBazy[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
zakrest->{} - zakres czasu kosmicznego, dla kt\[OAcute]rego ma zosta\[CAcute] narysowany wykres (je\:017celi nie zostanie podany, to zakrest={0,tf});
wyj\:015bcie: wykresy pr\:0119dko\:015bci k\:0105towych, parametryzuj\:0105ce ewolucj\:0119 czasow\:0105 bazy Freneta, w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144";

Masy::usage="Masy[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],N0:-8]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: wykresy kwadrat\[OAcute]w mas w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144: \!\(\*SuperscriptBox[\(m\), \(2\)]\)/\!\(\*SuperscriptBox[\(H\), \(2\)]\)";

MasyEfektywne::usage="MasyEfektywne[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],N0:-8]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: wykresy kwadrat\[OAcute]w efektywnych mas w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144: \!\(\*SuperscriptBox[\(m\), \(2\)]\)/\!\(\*SuperscriptBox[\(H\), \(2\)]\)";

PerturbacjeAERownaniakw::usage="PerturbacjeAERownaniakw[pola,fG,La,g,x,fR,MS:True,r:1,zmianaV:True]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
MS - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego,
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
zmianaV - czy potencja\[LSlash] jest oznaczony przez V;
wyj\:015bcie: r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich krzywizny i izokrzywizny";

WspolczynnikiOddzialywaniaAE::usage="WspolczynnikiOddzialywaniaAE[pola,fG,La,g,x,fR,MS:True,r:1]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
MS - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego,
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: lista wsp\[OAcute]\[LSlash]czynnik\[OAcute]w oddzia\[LSlash]ywania mi\:0119dzy perturbacjami krzywizny i izokrzywizny w formie {{\!\(\*SubscriptBox[\(C\), \(\[Sigma]s1\)]\), \!\(\*SubscriptBox[\(C\), \(\[Sigma]s2\)]\), ...}, {\!\(\*SubscriptBox[\(C\), \(s1\[Sigma]\)]\), \!\(\*SubscriptBox[\(C\), \(s1s2\)]\), ...}, ...}";

WspolporuszajaceRownaniakw::usage="WspolporuszajaceRownaniakw[pola,fG,La,g,x,fR,MS:True,r:1,zmianaV:True]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
MS - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego,
r - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
zmianaV - czy potencja\[LSlash] jest oznaczony przez V;
wyj\:015bcie: r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119: \!\(\*SubscriptBox[\(u\), \(1\)]\)(\[Tau])=a(\[Tau])*(\!\(\*SqrtBox[SubscriptBox[\(P\), \(\(,\)\(X\)\)]]\)/\!\(\*SubscriptBox[\(c\), \(s\)]\))*\!\(\*SubscriptBox[\(Q\), \(1\)]\)(\[Tau]) i \!\(\*SubscriptBox[\(u\), \(j\)]\)(\[Tau])=a(\[Tau])*\!\(\*SqrtBox[SubscriptBox[\(P\), \(\(,\)\(X\)\)]]\)*\!\(\*SubscriptBox[\(Q\), \(j\)]\)(\[Tau]) dla j\[NotEqual]1";

WartosciPoczatkoweTlo::usage="WartosciPoczatkoweTlo[pola,fG,La,g,x,fR,N,wp,wsp,fun:{},param:{}]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
N - \:017c\:0105dana liczba e-powi\:0119ksze\:0144, 
wp - warto\:015bci pocz\:0105tkowe w formie {wp_pola} (w\[OAcute]wczas warto\:015bci pocz\:0105tkowe pr\:0119dko\:015bci zostan\:0105 znalezione z przybli\:017cenia powolnego toczenia) lub {{wp_pola},{wp_dpola}}, 
wsp - lista wsp\[OAcute]\[LSlash]czynnik\[OAcute]w, o kt\[OAcute]re maj\:0105 si\:0119 zmienia\[CAcute] warto\:015bci pocz\:0105tkowe, w formie {wsp_pola} lub {{wsp_pola},{wsp_dpola}}, 
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
wyj\:015bcie: lista, zawieraj\:0105ca warto\:015bci pocz\:0105tkowe dla zadanej liczby e-powi\:0119ksze\:0144, ko\:0144cow\:0105 liczb\:0119 e-powi\:0119ksze\:0144 i czas ko\:0144cowy w formie {{{wp_pola},{wp_dpola}},Nf,tf}";

TrajektorieTlo::usage="TrajektorieTlo[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],N0:-8]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: wykresy trajektorii inflacyjnych w przestrzeni p\[OAcute]l (gdy jedno pole, to wykres pole(N))";

PochodnePol::usage="PochodnePol[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],N0:-8]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: wykresy pochodnych p\[OAcute]l i energii kinetycznej w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144";

WykresyTestoweTlo::usage="WykresyTestoweTlo[funkcje,opisy,pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],N0:-8]: 
funkcje - lista list funkcji z\[LSlash]o\:017conych z rozwi\:0105za\:0144 dla t\[LSlash]a - funkcje z jednej listy b\:0119d\:0105 rysowane na jednym wykresie (np. {{f1,f2},{g1}}), 
opisy - lista opis\[OAcute]w funkcji w formie np. {{nazwaf, {nf1,nf2}}, {nazwag,{ng1}}} - pierwsza warto\:015b\[CAcute] zostanie u\:017cyta do nadania nazwy osi y i pliku, a druga warto\:015b\[CAcute] (lista) do utworzenia legendy (uwaga! opis\[OAcute]w musi by\[CAcute] tyle samo, co funkcji),
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: wyeksportowane wykresy - przekazane funkcje w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144";

BazaMasyTest::usage="BazaMasyTest[t,pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},N0:-8]: 
t - czas,
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: ortonormalna baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy w przestrzeni p\[OAcute]l zorientowana kanonicznie w danej chwili t";

WykresyBazaMasy::usage="WykresyBazaMasy[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],N0:-8]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: wykresy element\[OAcute]w bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy od liczby e-powi\:0119ksze\:0144 (wierszami MB_i oraz kolumnami MB^i)";

PredkosciKatoweBazaMasy::usage="PredkosciKatoweBazaMasy[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
zakrest->{} - zakres czasu kosmicznego, dla kt\[OAcute]rego ma zosta\[CAcute] narysowany wykres (je\:017celi nie zostanie podany, to zakrest={0,tf});
wyj\:015bcie: wykresy pr\:0119dko\:015bci k\:0105towych, parametryzuj\:0105cych ewolucj\:0119 czasow\:0105 bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy, w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144";

CzasN::usage="CzasN[efolds,pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},N0:-8]: 
efolds - liczba e-powi\:0119ksze\:0144, dla kt\[OAcute]rej ma zosta\[CAcute] podany czas,
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: czas kosmiczny t, odpowiadaj\:0105cy podanej liczbie e-powi\:0119ksze\:0144";

Widma::usage="Widma[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH,
norm->'h' - normalizacja;
wyj\:015bcie: wykresy zale\:017cno\:015bci widm mocy perturbacji krzywizny i izokrzywizny PQ=kw^3(Abs[Q_1]^2+Abs[Q_2]^2+...)/2\[Pi] od liczby e-powi\:0119ksze\:0144";

PerturbacjeB::usage="PerturbacjeB[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH,
norm->'h' - normalizacja;
wyj\:015bcie: wykresy zale\:017cno\:015bci perturbacji w podanej bazie od liczby e-powi\:0119ksze\:0144";

WidmaB::usage="WidmaB[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH,
norm->'h' - normalizacja;
wyj\:015bcie: wykresy zale\:017cno\:015bci widm mocy w bazie wektor\[OAcute]w w\[LSlash]asnych macierzy masy PQ=kw^3(Abs[Q_1]^2+Abs[Q_2]^2+...)/2\[Pi] od liczby e-powi\:0119ksze\:0144";

WidmaTest::usage="WidmaTest[baza,pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
baza - baza,
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH;
wyj\:015bcie: wykresy zale\:017cno\:015bci widm mocy perturbacji krzywizny i izokrzywizny PQ=kw^3(Abs[Q_1]^2+Abs[Q_2]^2+...)/2\[Pi] od liczby e-powi\:0119ksze\:0144";

Korelacje::usage="Korelacje[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH,
norm->'h' - normalizacja;
wyj\:015bcie: wykresy zale\:017cno\:015bci korelacji CQ1Q2=k^3Abs[(Conjugate[Q1_1]*Q2_1+Conjugate[Q1_2]*Q2_2+...)]/2\[Pi] od liczby e-powi\:0119ksze\:0144";

KorelacjeWzgledne::usage="KorelacjeWzgledne[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH;
wyj\:015bcie: wykresy zale\:017cno\:015bci wzgl\:0119dnych korelacji CUQ1Q2=Abs[CQ1Q2]/Sqrt[PQ1*PQ2] od liczby e-powi\:0119ksze\:0144";

WektorFalowyTest::usage="WektorFalowyTest[Nkw,pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},N0:-8]: 
Nkw - liczba e-powi\:0119ksze\:0144, dla kt\[OAcute]rej ma zosta\[CAcute] znaleziona liczba falowa,
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
N0 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144;
wyj\:015bcie: lista {k1, k2, k1-k2}, zawieraj\:0105ca liczby falowe, odpowiadaj\:0105ce N=0 i podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH (przyj\:0119to normalizacj\:0119 a=1 (N=0 i \!\(\*SubscriptBox[\(a\), \(0\)]\)=Exp(\!\(\*SubscriptBox[\(N\), \(0\)]\))) w momencie wychodzenia za horyzont, wi\:0119c a=\!\(\*SubscriptBox[\(a\), \(0\)]\)*Exp(N-\!\(\*SubscriptBox[\(N\), \(0\)]\))=Exp(N))";

IndeksSpektralny::usage="IndeksSpektralny[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH,
Nkw2->0.001 - druga warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0) potrzebna do obliczenia indeksu spektralnego n,
norm->'h' - normalizacja;
wyj\:015bcie: lista z warto\:015bciami liczb falowych i indeks\[OAcute]w spektralnych \!\(\*SubscriptBox[\(n\), \(s\)]\) dla perturbacji krzywizny i izokrzywizny: {k_1,k_2,k_1-k_2,n_s}";

IndeksSpektralnyB::usage="IndeksSpektralnyB[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH,
Nkw2->0.001 - druga warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0) potrzebna do obliczenia indeksu spektralnego n,
norm->'h' - normalizacja;
wyj\:015bcie: lista z warto\:015bciami liczb falowych i indeks\[OAcute]w spektralnych \!\(\*SubscriptBox[\(n\), \(s\)]\) dla perturbacji krzywizny i izokrzywizny: {k_1,k_2,k_1-k_2,n_s}";

Wzmocnienie::usage="Wzmocnienie[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH;
wyj\:015bcie: wzmocnienie widma perturbacji krzywizny wzgl\:0119dem widma dla jednego pola";

WzmocnienieB::usage="WzmocnienieB[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH;
wyj\:015bcie: wzmocnienie widma perturbacji krzywizny wzgl\:0119dem widma dla jednego pola";

PredkosciKatoweBazaMasyProdukcjaCzastek::usage="PredkosciKatoweBazaMasyProdukcjaCzastek[pola,fG,La,g,x,fR,wp,listatf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P i czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]), 
wp - warto\:015bci pocz\:0105tkowe w formie {{wp_pola},{wp_dpola}}, 
listatf - czasy, dla kt\[OAcute]rych uwzgl\:0119dniana jest produkcja cz\:0105stek i czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
zakrest->{} - zakres czasu kosmicznego, dla kt\[OAcute]rego ma zosta\[CAcute] narysowany wykres (je\:017celi nie zostanie podany, to zakrest={0,tf});
wyj\:015bcie: wykresy pr\:0119dko\:015bci k\:0105towych, parametryzuj\:0105cych ewolucj\:0119 czasow\:0105 bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy, w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 z uwzgl\:0119dnieniem produkcji cz\:0105stek";

LiczbaObsadzen::usage="LiczbaObsadzen[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
Nkw->0 - warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144 w okolicy przekraczania promienia Hubble'a (N=0): k=aH,
FT->True - czy stosowa\[CAcute] przybli\:017cenie szybkiego zakr\:0119tu,
zakrest->{} - zakres czasu kosmicznego, dla kt\[OAcute]rego ma zosta\[CAcute] narysowany wykres (je\:017celi nie zostanie podany, to zakrest={0,tf});
wyj\:015bcie: wykresy zale\:017cno\:015bci liczb obsadze\:0144 od liczby e-powi\:0119ksze\:0144";

GestoscEnergiiCzastekTest::usage="GestoscEnergiiCzastekTest[pola,fG,La,g,x,fR,wp,tf,fun:{},param:{},sciezka:Directory[],OptionsPattern[]]: 
pola - lista nazw p\[OAcute]l, 
fG - metryka w przestrzeni p\[OAcute]l zapisana bez argument\[OAcute]w przy polach, 
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola], 
g - tensor metryczny (uwaga! czynnik skali musi by\[CAcute] oznaczony przez a), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,  
fR - funkcja skalara Ricciego f(R) (uwaga! R musi by\[CAcute] oznaczone przez rr[Sequence@@x]),
wp - warto\:015bci pocz\:0105tkowe p\[OAcute]l w formie {{wp_pola},{wp_dpola}}, 
tf - czas ko\:0144cowy,
fun - lista podstawie\:0144 funkcji (wyst\:0119puj\:0105cych w lagran\:017cjanie, np. potencja\[LSlash]) w formie funkcji, tzn. zamiast p\[OAcute]l #1,#2,... i na ko\:0144cu &, 
param - lista podstawie\:0144 parametr\[OAcute]w,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
opcjonalne:
N0->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a,
N0P->-8 - pocz\:0105tkowa warto\:015b\[CAcute] liczby e-powi\:0119ksze\:0144 dla perturbacji,
wpP->{} - zestawy warto\:015bci pocz\:0105tkowych dla perturbacji dla wszystkich przebieg\[OAcute]w {zestawy_wp,zestawy_dwp} - je\:017celi nie zostan\:0105 podane, to b\:0119d\:0105 to warto\:015bci wewn\:0105trz promienia Hubble'a (pr\[OAcute]\:017cnia typu Minkowskiego: Q0=Exp[-i*kw*t/a(t)]/(a(t)*Sqrt[2*kw]) dla czasu kosmicznego i Q0=Exp[-i*kw*\[Tau]]/(a(\[Tau])*Sqrt[2*kw]) dla czasu konformenego),
MS->True - True, gdy zmienne krzywizny i izokrzywizny maj\:0105 zosta\[CAcute] zdefiniowane za pomoc\:0105 zmiennych Mukhanova-Sasakiego (uwaga! tzn., \:017ce metryka musi by\[CAcute] w longitudianl gauge),
r->1 - rz\:0105d w perturbacjach (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P),
FT->True - czy stosowa\[CAcute] przybli\:017cenie szybkiego zakr\:0119tu,
t0->0 - czas kosmiczny, w kt\[OAcute]rym ma zosta\[CAcute] obliczona g\:0119sto\:015b\[CAcute] energii cz\:0105stek;
wyj\:015bcie: g\:0119sto\:015bci energii wyprodukowanych w danej chwili t0";

WarunkiZszyciaPerturbacje::usage="";

Begin["`Private`"];


(* ::Section:: *)
(*Zapisywanie danych do plik\[OAcute]w*)


(* tworzenie notebooka *) 
PlikNb[lista_,nazwa_,sciezka_:Directory[]]:=mrkUzyteczny`plikNb[lista,nazwa,sciezka]


(* tworzenie stringa z danymi do latexa *) 
PlikTex[pola_,lista_]:=mrkUzyteczny`plikTex[pola,lista]


(* tworzenie pliku txt z r\[OAcute]wnaniami do latexa *) 
PlikTexRownania[pola_,lista_,nazwa_,sciezka_:Directory[]]:=mrkUzyteczny`plikTexRow[pola,lista,nazwa,sciezka]


(* tworzenie pliku txt z baz\:0105 do latexa *) 
PlikTexBaza[pola_,lista_,nazwa_,sciezka_:Directory[]]:=mrkUzyteczny`plikTexBaza[pola,lista,nazwa,sciezka]


(* tworzenie pliku txt z tabel\:0105 do latexa *)
PlikTexTabela[opisy_,wartosci_,nazwa_,sciezka_:Directory[]]:=mrkUzyteczny`plikTexTabela[opisy,wartosci,nazwa,sciezka]


(* ::Section:: *)
(*R\[OAcute]wnania pola*)


(* r\[OAcute]wnanie pola dla sk\[LSlash]adowych fourierowskich w teorii f(R): f'(R)R_\[Mu]\[Nu]-(1/2)f(R)g_\[Mu]\[Nu]-(f'(R))_;\[Nu];\[Mu]+g_\[Mu]\[Nu]*(f'(R))^;\[Alpha]_;\[Alpha]=T_\[Mu]\[Nu] (uwaga! konwencja 8\[Pi]G=M_Pl^(-2)=1) *)
PolaRownaniekw[pola_,fG_,La_,fR_,\[Mu]_,\[Nu]_,g_,x_,r_:0,dd_:True]:=
PolaRownaniekw[pola,fG,La,fR,\[Mu],\[Nu],g,x,r,dd]=
Block[{mTensor,podstawienieHubble,rowp,rowpkw},(
(* podstawienie parametru Hubble'a *)
podstawienieHubble=mrkUzyteczny`podstawienieH[x];
(* tensor energii-p\:0119du *)
mTensor=mrkLagrange`energiipeduTddTot[g,x,pola,fG,La];
(* r\[OAcute]wnanie pola w teorii f(R) *)
rowp=mrkEinstein`polaR[mTensor,fR,\[Mu],\[Nu],g,x,r,dd];
(* r\[OAcute]wnanie pola dla sk\[LSlash]adowych fourierowskich w teorii f(R) *)
rowpkw=If[r!=0, mrkFourier`rownaniakw[x,{rowp},r], {rowp}];
(* podstawienie parametru Hubble'a do r\[OAcute]wnania pola *)
Simplify[rowpkw/.podstawienieHubble,Symbol["a"][x[[1]]]>0])]


(* ::Section:: *)
(*R\[OAcute]wnania ruchu*)


(* ::Subsection:: *)
(*Pierwotne zmienne*)


(* lagran\:017cjan: \[ScriptCapitalL]=F(X,\[Phi]^I), gdzie I=N - liczba p\[OAcute]l skalarnych, X=-(1/2)Subscript[G, IJ]g^\[Mu]\[Nu]\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]
\*SuperscriptBox[\(\[Phi]\), \(I\)]\)\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]
\*SuperscriptBox[\(\[Phi]\), \(J\)]\) - cz\[LSlash]on kinetyczny *)
Lagrangian[g_,x_,pola_,fG_,La_,r_:0]:=mrkLagrange`lagrangian[g,x,pola,fG,La,r]


(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich wszystkich p\[OAcute]l skalarnych dla lagran\:017cjanu \[ScriptCapitalL]=F(X,\[Phi]^I) *)
RuchuRownaniakw[g_,x_,pola_,fG_,La_,r_:0]:=
RuchuRownaniakw[g,x,pola,fG,La,r]=
Block[{podstawienieHubble,rowr,rowrkw},(
(* podstawienie parametru Hubble'a *)
podstawienieHubble=mrkUzyteczny`podstawienieH[x];
(* r\[OAcute]wnania ruchu *)
rowr=mrkLagrange`ruchuRN[g,x,pola,fG,La,r];
(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich *)
rowrkw=If[r!=0, mrkFourier`rownaniakw[x,rowr,r], rowr];
(* podstawienie parametru Hubble'a do r\[OAcute]wnania pola *)
rowrkw/.podstawienieHubble)]


(* efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku *)
PredkoscDzwiekuEf[g_,x_,pola_,fG_,La_]:=mrkLagrange`predkoscDzwiekuEf[g,x,pola,fG,La]


(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
ddpolaN0f[g_,x_,pola_,fG_,La_]:=
ddpolaN0f[g,x,pola,fG,La]=
Block[{rr0},(
(* r\[OAcute]wnania ruchu dla t\[LSlash]a *)
rr0=RuchuRownaniakw[g,x,pola,fG,La,0];
(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
mrkLagrange`ddpolaN0[x,pola,rr0])]


(* macierz masy pierwotnych p\[OAcute]l *)
MacierzMasy[g_,x_,pola_,fG_,La_,O_:True]:=mrkLagrange`macierzMasy[g,x,pola,fG,La,O]


(* ::Subsection:: *)
(*Zmienne Mukhanova-Sasakiego*)


(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego (niezmienniczych wzgl\:0119dem cechowania): Q\[Phi]=\[Delta]\[Phi]+(\[Phi]'(t)/H(t))\[CapitalPhi] *)
MukhanovSasakiRownaniakw[pola_,fG_,La_,g_,x_,fR_,r_:1]:=
MukhanovSasakiRownaniakw[pola,fG,La,g,x,fR,r]=
Block[{rownaniaRNkw,perturbacjam,perturbacjamkw,dd\[Phi]N0,dH,V0,r000,r110,r001,r011,dperm,perm},(
(* nazwa sk\[LSlash]adowej fourierowskiej perturbacji metryki *)
perturbacjamkw=(perturbacjam=mrkUzyteczny`perturbacjeObiekt[g,x]; mrkFourier`perturbacjekw[perturbacjam][[1]]);

(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich pierwotnych zmiennych *)
rownaniaRNkw=RuchuRownaniakw[g,x,pola,fG,La,r];

(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];

(* r\[OAcute]wnanie pola 00 dla t\[LSlash]a (r\[OAcute]wnanie Friedmanna) *)
r000=PolaRownaniekw[pola,fG,La,fR,0,0,g,x,0,True][[1]];
(* r\[OAcute]wnanie pola 11 dla t\[LSlash]a *)
r110=PolaRownaniekw[pola,fG,La,fR,1,1,g,x,0,True][[1]];

(* podstawienie pochodnej parametru Hubble'a *)
dH=mrkEinstein`dHubble0[r000,r110,x];
(* podstawienie potencja\[LSlash]u *)
V0=mrkEinstein`potencjalV0[r000,x];

(* ograniczenia dla energii i pedu dane s\:0105 przez r\[OAcute]wnania Einsteina *)
(* r\[OAcute]wnanie pola 00 dla sk\[LSlash]adowych fourierowskich w pierwszym rz\:0119dzie w perturbacjach *)
r001=(PolaRownaniekw[pola,fG,La,fR,0,0,g,x,1,True]/.V0)[[1]];
(* r\[OAcute]wnanie pola 01 dla sk\[LSlash]adowych fourierowskich w pierwszym rz\:0119dzie w perturbacjach *)
r011=PolaRownaniekw[pola,fG,La,fR,0,1,g,x,1,True][[1]];

(* wyznaczenie pierwszej pochodnej po czasie perturbacji metryki z r\[OAcute]wnania pola 01
i perturbacji metryki, stoj\:0105cej przy kwadracie wektora falowego, z r\[OAcute]wnania pola 00 *)
{dperm,perm}=mrkFourier`perturbacjaMetrykiLG[r011,r001,perturbacjamkw,x];

(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego *)
mrkMukhanovSasaki`ruchuRNMSkw[pola,perturbacjamkw,x,rownaniaRNkw,dd\[Phi]N0,dH,dperm,perm])]


(* ::Subsection:: *)
(*Zmienna adiabatyczna i entropowe*)


(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
BazaFreneta[g_,x_,pola_,fG_,La_,O_:True]:=
BazaFreneta[g,x,pola,fG,La,O]=
Block[{dd\[Phi]N0,podstHN,listao},(
(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];

(* lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {pola, tensor metryczny w przestrzeni p\[OAcute]l} *)
listao=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],2];

(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
mrkIzoKrzywizna`bazaFreneta[listao,dd\[Phi]N0,x,O])]


(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie w danej chwili t *)
BazaFrenetaTest[t_,pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},N0_:-8.]:=
(*BazaFrenetaTest[t,pola,fG,La,g,x,fR,wp,tf,fun,param,N0]=*)
Block[{dd\[Phi]N0,listao,rozwiazania0},(
(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];
(* lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {pola, tensor metryczny w przestrzeni p\[OAcute]l} *)
listao=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],2];

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];

(* warto\:015bci bazy Freneta w chwili t *)
mrkIzoKrzywizna`bazaFrenetaTest[listao,dd\[Phi]N0,x,rozwiazania0,t,fun,param])]


(* elementy bazy w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 *)
WykresyBaza[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],N0_:-8.]:=
(*WykresyBaza[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,N0]=*)
Block[{rozwiazania0,Ebaza,tytul},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];

(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
Ebaza=BazaFreneta[g,x,pola,fG,La]/.fun/.param;
(*Ebaza=mrkLagrange`bazaMasy[g,x,pola,fG,La][[2]]/.fun/.param;*)

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyBaza[x,rozwiazania0,Ebaza,tytul,sciezka];)]


(* domy\:015blne opcje funkcji PredkosciKatoweBazy *)
Options[PredkosciKatoweBazy]={N0->-8., zakrest->{}};

(* pr\:0119dko\:015bci k\:0105towe, parametryzuj\:0105ce ewolucj\:0119 czasow\:0105 bazy Freneta, w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 *)
PredkosciKatoweBazy[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*PredkosciKatoweBazy[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,OptionValue[N0],OptionValue[zakrest]]=*)
Block[{rozwiazania0,Ebaza,dd\[Phi]N0,dkaty,nazwyzm,t1,t2},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];

(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
Ebaza=BazaFreneta[g,x,pola,fG,La];

(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];

(* lista pr\:0119dko\:015bci k\:0105towych, parametryzuj\:0105cych ewolucj\:0119 czasow\:0105 bazy Freneta *)
dkaty=mrkIzoKrzywizna`bazaFrenetaParametry[x,Ebaza,dd\[Phi]N0]/.fun/.param;
dkaty=dkaty^2;

(* nazwy zmiennych *)
(*nazwyzm=Take[Join[{Superscript[OverDot[Symbol["\[Theta]"]],"2"],Superscript[OverDot[Symbol["\[CurlyPhi]"]],"2"]},
	Table[Subsuperscript[Symbol[OverDot["\[Alpha]"]],ToString[i],"2"],{i,3,Length[dkaty]}]],Length[dkaty]];*)
nazwyzm=Take[Join[{OverDot[Symbol["\[Theta]"]],OverDot[Symbol["\[CurlyPhi]"]]},
	Table[Subscript[Symbol[OverDot["\[Alpha]"]],ToString[i]],{i,3,Length[dkaty]}]],Length[dkaty]];
(* pocz\:0105tkowy czas dla perturbacji *)
{t1,t2}=If[OptionValue[zakrest]=={}, {0,tf}, OptionValue[zakrest]];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyParametrow[x,rozwiazania0,dkaty,nazwyzm,t1,t2,"katy","angular velocities",sciezka];)]


(* domy\:015blne opcje funkcji Masy *)
Options[Masy]={oznaczenia->{}, legenda->{}, tytul->{}, zakrest->{}, gridt->{}};

(* kwadraty mas i efektywnych mas w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 *)
Masy[pola_,fG_,La_,g_,x_,fR_,wp_,listatf_,fun_:{},param_:{},sciezka_:Directory[],N0_:-8.,OptionsPattern[]]:=
(*Masy[pola,fG,La,g,x,fR,wp,listatf,fun,param,sciezka,N0,OptionValue[legenda]]=*)
Block[{lrozw,rozwiazania0,nazwyzm,masa,tytulw,ti,tf},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
lrozw=Length[listatf];
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=Map[If[Length[listatf[[#]]]>1,
	(* z uwzgl\:0119dnieniem produkcji cz\:0105stek *)
	RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,N0,wp,listatf[[#]],-1,N0,{},fun,param,True,1,"","M",False,sciezka],
	(* bez produkcji cz\:0105stek *)
	RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,First[listatf[[#]]],fun,param]] &, Range[lrozw]];
(*rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];*)

(* macierz masy pierwotnych p\[OAcute]l *)
masa=MacierzMasy[g,x,pola,fG,La]/.fun/.param;

(* nazwy zmiennych *)
nazwyzm=If[OptionValue[oznaczenia]=={}, Table[Subscript["\!\(\*
StyleBox[\"M\",\nFontSlant->\"Italic\"]\)",ToString[pola[[i]]]],{i,1,Length[pola]}], OptionValue[oznaczenia]];
(* tytu\[LSlash] wykres\[OAcute]w *)
tytulw=If[OptionValue[tytul]=={}, mrkWykresy`tytulWykresu[param], OptionValue[tytul]];

(* zakresy czas\[OAcute]w *)
{ti,tf}=If[OptionValue[zakrest]=={}, {Table[0., lrozw],listatf[[All,-1]]}, OptionValue[zakrest]];

(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyMasa[x,rozwiazania0,masa,nazwyzm,ti,tf,{},"masa",sciezka,tytulw,OptionValue[legenda],OptionValue[gridt]];)]


(* kwadraty mas i efektywnych mas w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 *)
MasyEfektywne[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],N0_:-8.]:=
(*MasyEfektywne[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,N0]=*)
Block[{rozwiazania0,Ebaza,dd\[Phi]N0,nazwyzm,masa,masaRS,masaRSef,dkaty},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];
(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];

(* macierz masy pierwotnych p\[OAcute]l *)
masa=MacierzMasy[g,x,pola,fG,La];

(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
Ebaza=BazaFreneta[g,x,pola,fG,La];
(* macierz masy w bazie Freneta dla p\[OAcute]l Q\[Sigma] i Qs(i) dla prostych trajektorii *)
masaRS=mrkIzoKrzywizna`macierzMasyBaza[masa,Ebaza];
(* lista pr\:0119dko\:015bci k\:0105towych, parametryzuj\:0105cych ewolucj\:0119 czasow\:0105 bazy Freneta *)
dkaty=mrkIzoKrzywizna`bazaFrenetaParametry[x,Ebaza,dd\[Phi]N0];
(* efektywna macierz masy p\[OAcute]l Q\[Sigma] i Qs(i) dla zakrzywionych trajektorii *)
masaRSef=mrkIzoKrzywizna`macierzMasyEf[masaRS,dkaty]/.fun/.param;

(* nazwy zmiennych *)
nazwyzm=Join[{Subsuperscript["M","eff"<>ToString[Subscript["Q","\[Sigma]"],StandardForm],"2"]},
	Table[Subsuperscript["M","eff"<>ToString[Subscript["Q","s"<>ToString[i]],StandardForm],"2"],{i,1,Length[pola]-1}]];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyMasa[x,rozwiazania0,masaRSef,nazwyzm,Ebaza/.fun/.param,"masaef","effective mass",sciezka];)]


(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennej adiabatycznej i entropowych *)
PerturbacjeAERownaniakw[pola_,fG_,La_,g_,x_,fR_,MS_:True,r_:1,zmianaV_:True]:=
PerturbacjeAERownaniakw[pola,fG,La,g,x,fR,MS,r,zmianaV]=
Block[{listao,Ebaza,rownaniaNkw,dd\[Phi]N0,mbaza},(
(* lista zmiennych z polami podzielonymi na t\[LSlash]o i perturbacje: {tensor metryczny w przestrzeni p\[OAcute]l, cz\[LSlash]on kinetyczny} *)
listao=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2,3}];

(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];

(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
Ebaza=BazaFreneta[g,x,pola,fG,La];

(* ======= do r\[OAcute]wna\:0144 dla pierwotnych p\[OAcute]l nale\:017cy doda\[CAcute] jeszcze co\:015b na perturbacj\:0119 metryki????? ============== *)
(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich pierwotnych/MS zmiennych *)
rownaniaNkw=If[MS && r!=0, MukhanovSasakiRownaniakw[pola,fG,La,g,x,fR,r], RuchuRownaniakw[g,x,pola,fG,La,r]];

(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych adiabatycznej i entropowych *)
(*mrkIzoKrzywizna`ruchuRNAEkwO[pola,listao[[1]],Ebaza,x,rownaniaNkw,dd\[Phi]N0,MS,r]*)
mrkIzoKrzywizna`ruchuRNAEkw[pola,listao,Ebaza,x,rownaniaNkw,dd\[Phi]N0,MS,r,zmianaV])]


(* lista wsp\[OAcute]\[LSlash]czynnik\[OAcute]w oddzia\[LSlash]ywania mi\:0119dzy perturbacjami krzywizny i izokrzywizny *)
WspolczynnikiOddzialywaniaAE[pola_,fG_,La_,g_,x_,fR_,MS_:True,r_:1]:=
WspolczynnikiOddzialywaniaAE[pola,fG,La,g,x,fR,MS,r]=
Block[{Go,dd\[Phi]N0,Ebaza,rownaniaNkw},(
(* nieperturbowany tensor metryczny w przestrzeni p\[OAcute]l *)
{Go}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2}]/.{Symbol["P"]->0};
(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];

(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
Ebaza=BazaFreneta[g,x,pola,fG,La];

(* ======= do r\[OAcute]wna\:0144 dla pierwotnych p\[OAcute]l nale\:017cy doda\[CAcute] jeszcze co\:015b na perturbacj\:0119 metryki????? ============== *)
(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich pierwotnych/MS zmiennych *)
rownaniaNkw=If[MS && r!=0, MukhanovSasakiRownaniakw[pola,fG,La,g,x,fR,r], RuchuRownaniakw[g,x,pola,fG,La,r]];

(* lista wsp\[OAcute]\[LSlash]czynnik\[OAcute]w oddzia\[LSlash]ywania w formie {{C_\[Sigma]s1, C_\[Sigma]s2, ...}, {C_s1\[Sigma], C_s1s2, ...}, ...} *)
mrkIzoKrzywizna`wspRNAEkw[pola,Go,Ebaza,x,rownaniaNkw,dd\[Phi]N0,MS,r])]


(* ::Subsection:: *)
(*Wsp\[OAcute]\[LSlash]poruszaj\:0105ce si\:0119 zmienne*)


(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119: 
u_1(\[Tau])=a(\[Tau])*((P'(X))^(1/2)/c_s)*Q\[Phi](\[Tau]) i u_j(\[Tau])=a(\[Tau])*((P'(X))^(1/2))*Q\[Phi](\[Tau]) dla j=2,3,... *)
WspolporuszajaceRownaniakw[pola_,fG_,La_,g_,x_,fR_,MS_:True,r_:1,zmianaV_:True]:=
WspolporuszajaceRownaniakw[pola,fG,La,g,x,fR,MS,r,zmianaV]=
Block[{Xo,rownaniaAEkw,rownaniaRNkw},(
(* cz\[LSlash]on kinetyczny z polami podzielonymi na t\[LSlash]o i perturbacje *)
Xo=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{3}];

(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych adiabatycznej i entropowych *)
rownaniaAEkw=If[Length[pola]!=1,TimeConstrained[PerturbacjeAERownaniakw[pola,fG,La,g,x,fR,MS,r,zmianaV],600,{}],{}];
(* je\:017celi nie uda\[LSlash]o si\:0119 znale\:017a\[CAcute] r\[OAcute]wna\:0144 dla perturbacji krzywizyny i izokrzywizny,
 to szuka r\[OAcute]wna\:0144 ruchu dla sk\[LSlash]adowych fourierowskich zmiennych Mukhanova-Sasakiego lub pierwotnych *)
rownaniaRNkw=If[rownaniaAEkw=={},
	If[MS && r!=0, MukhanovSasakiRownaniakw[pola,fG,La,g,x,fR,r], RuchuRownaniakw[g,x,pola,fG,La,r]], rownaniaAEkw];
	
(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 u(\[Tau]) *)
mrkProdukcjaCzastek`ruchuRNukw[x,La,Xo,rownaniaRNkw])]


(* ::Section:: *)
(*Rozwi\:0105zania r\[OAcute]wna\:0144 ruchu*)


(* ::Subsection:: *)
(*Warto\:015bci pocz\:0105tkowe*)


(* znajdowanie warto\:015bci poczatkowych dla konkretnej liczby e-powi\:0119ksze\:0144 dla t\[LSlash]a *)
WartosciPoczatkoweTlo[pola_,fG_,La_,g_,x_,fR_,N_,wp_,wsp_,fun_:{},param_:{}]:=
WartosciPoczatkoweTlo[pola,fG,La,g,x,fR,N,wp,wsp,fun,param]=
Block[{r000,r110,eps,rownania0},(
(* r\[OAcute]wnanie pola 00 dla t\[LSlash]a (r\[OAcute]wnanie Friedmanna) *)
r000=PolaRownaniekw[pola,fG,La,fR,0,0,g,x,0,True][[1]];
(* r\[OAcute]wnanie pola 11 dla t\[LSlash]a *)
r110=PolaRownaniekw[pola,fG,La,fR,1,1,g,x,0,True][[1]];
(* parametr powolnego toczenia \[Epsilon] *)
eps=mrkRozwiazania`parametrEpsilon[r000,r110,x]/.fun/.param;

(* r\[OAcute]wnania ruchu t\[LSlash]a i r\[OAcute]wnanie Friedmanna w zerowym rzedzie w perturbacjach *)
rownania0=Join[RuchuRownaniakw[g,x,pola,fG,La,0],{r000}]/.fun/.param;

(* warto\:015bci pocz\:0105tkowe dla danej liczby e-powi\:0119ksze\:0144 *)
mrkRozwiazania`wartosciPoczatkoweTlo[pola,x,rownania0,eps,N,wp,wsp])]


(* ::Subsection:: *)
(*Rozwi\:0105zania dla t\[LSlash]a*)


(* rozwi\:0105zania dla t\[LSlash]a *)
RozwiazanieTlo[pola_,fG_,La_,g_,x_,fR_,N0_,wp_,tf_,fun_:{},param_:{},konf_:False,ti_:0.]:=
RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,konf,ti]=
Block[{r000,rr0,rownania0},(
(* r\[OAcute]wnanie pola 00 dla t\[LSlash]a (r\[OAcute]wnanie Friedmanna) *)
r000=PolaRownaniekw[pola,fG,La,fR,0,0,g,x,0,True];
(* r\[OAcute]wnania ruchu t\[LSlash]a *)
rr0=RuchuRownaniakw[g,x,pola,fG,La,0];

(* r\[OAcute]wnania ruchu t\[LSlash]a i r\[OAcute]wnanie Friedmanna w zerowym rzedzie w perturbacjach *)
rownania0=Join[rr0,r000]/.fun/.param;

(* rozwi\:0105zania r\[OAcute]wna\:0144 *)
mrkRozwiazania`rozwiazanieTlo[pola,x,rownania0,tf,wp,N0,konf,ti])]


(* domy\:015blne opcje funkcji TrajektorieTlo *)
Options[TrajektorieTlo]={N0->-8., zakrest->{}, tytul->{}, legenda->{}};

(* trajektorie inflacyjne w przestrzeni p\[OAcute]l *)
TrajektorieTlo[pola_,fG_,La_,g_,x_,fR_,wp_,listatf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*TrajektorieTlo[pola,fG,La,g,x,fR,wp,listatf,fun,param,sciezka,OptionValue[N0],OptionValue[zakrest],OptionValue[tytul],OptionValue[legenda]]=*)
Block[{lrozw,rozwiazania0,tytulw,ti,tf,rozw},(
lrozw=Length[listatf];
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=Map[If[Length[listatf[[#]]]>1,
	(* z uwzgl\:0119dnieniem produkcji cz\:0105stek *)
	RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,OptionValue[N0],wp,listatf[[#]],-1,OptionValue[N0],{},fun,param,True,1,"","M",False,sciezka],
	(* bez produkcji cz\:0105stek *)
	RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,First[listatf[[#]]],fun,param]] &, Range[lrozw]];
	
(*rozwiazania0=Reap[Do[If[Length[listatf[[i]]]>1,
	(* z uwzgl\:0119dnieniem produkcji cz\:0105stek *)
	(rozw=RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,OptionValue[N0],wp,listatf[[i]],-1,OptionValue[N0],{},fun,param,True,1,"","M",False];
	Sow[rozw];),
	(* bez produkcji cz\:0105stek *)
	(rozw=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,First[listatf[[i]]],fun,param];
	Sow[rozw];)];, 
	{i,1,lrozw}]][[2,1]];*)

(* tytu\[LSlash] wykres\[OAcute]w *)
tytulw=If[OptionValue[tytul]=={}, mrkWykresy`tytulWykresu[param], OptionValue[tytul]];
(* zakresy czasu dla poszczeg\[OAcute]lnych funkcji *)
{ti,tf}=If[OptionValue[zakrest]=={}, {Table[0., lrozw],listatf[[All,-1]]}, OptionValue[zakrest]];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyTlo[pola,x,rozwiazania0,ti,tf,tytulw,OptionValue[legenda],sciezka];)]


(* pochodne p\[OAcute]l w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 *)
PochodnePol[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],N0_:-8.]:=
PochodnePol[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,N0]=
Block[{rozwiazania0,Xo,tytul},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];

(* cz\[LSlash]on kinetyczny *)
{Xo}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{3}]/.{Symbol["P"]->0}/.fun/.param;

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyPochodne[pola,x,Xo,rozwiazania0,tf,tytul,sciezka];)]


(* przekazane wielko\:015bci (z\[LSlash]o\:017cone z rozwi\:0105za\:0144 dla t\[LSlash]a) w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 *)
WykresyTestoweTlo[funkcje_,opisy_,pola_,fG_,La_,g_,x_,fR_,wp_,listatf_,fun_:{},param_:{},sciezka_:Directory[],N0_:-8.]:=
(*WykresyTestoweTlo[funkcje,opisy,pola,fG,La,g,x,fR,wp,listatf,fun,param,sciezka,N0]=*)
Block[{lrozw,rozwiazania0,funN,tytul,\[Tau]t,\[Tau]f,tftot,tk000},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
(*rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,True];*)

lrozw=Length[listatf];
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=Map[If[Length[listatf[[#]]]>1,
	(* z uwzgl\:0119dnieniem produkcji cz\:0105stek *)
	RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,N0,wp,listatf[[#]],-1,N0,{},fun,param,True,1,"","M",False,sciezka],
	(* bez produkcji cz\:0105stek *)
	RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,First[listatf[[#]]],fun,param,False]] &, Range[lrozw]];

tftot = 182804125709550104879300608/59604644775390625;
tk000=578412.8;
(*tk000=1.26833157500000000000000000000000000000425976`24.*^6;*)
\[Tau]t=Symbol["\[Tau]"][x[[1]]] /. RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tftot,fun,param,True];
\[Tau]f=\[Tau]t /. x[[1]]->tftot;
Print[\[Tau]f];
\[Tau]t=\[Tau]t-2*\[Tau]f;
(*\[Tau]t=\[Tau]t-\[Tau]f;*)
Table[AppendTo[rozwiazania0[[i]], Symbol["\[Tau]"][x[[1]]]->\[Tau]t], {i,lrozw}];
Table[rozwiazania0[[i]]=Flatten[Append[rozwiazania0[[i]], {rozwiazania0[[i]],D[rozwiazania0[[i]],x[[1]]]} /. x[[1]]->tk000]], {i,lrozw}];

(*\[Tau]f=Symbol["\[Tau]"][x[[1]]] /. RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,OptionValue[tftot],fun,param,True] /. x[[1]]->OptionValue[tftot];*)
funN=funkcje/.fun/.param;
 
(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyTestoweTlo[funN,x,rozwiazania0,listatf,opisy,tytul,sciezka];)]







(* ortonormalna baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy w przestrzeni p\[OAcute]l zorientowana kanonicznie w danej chwili t *)
BazaMasyTest[t_,pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},N0_:-8.]:=
(*BazaMasyTest[t,pola,fG,La,g,x,fR,wp,tf,fun,param,N0]=*)
Block[{rozwiazania0},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];

(* warto\:015bci bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy w chwili t *)
(* ============ kolejno\:015b\[CAcute] wektor\[OAcute]w wg warto\:015bci w\[LSlash]asnych ============= *)
mrkLagrange`bazaMasyTest[g,x,pola,fG,La,rozwiazania0,t,fun,param])]


(* elementy bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 *)
WykresyBazaMasy[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],N0_:-8.]:=
(*WykresyBazaMasy[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,N0]=*)
Block[{rozwiazania0,Go,masa,tytul},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];

(* tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje *)
{Go}=Take[lagrangianO[g,x,pola,fG,La],{2}]/.{Symbol["P"]->0}/.fun/.param;

(* macierz masy *)
masa=MacierzMasy[g,x,pola,fG,La]/.fun/.param;

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyBazaMasy[x,Go,rozwiazania0,masa,tytul,sciezka];)]


(* domy\:015blne opcje funkcji PredkosciKatoweBazaMasy *)
Options[PredkosciKatoweBazaMasy]={N0->-8., zakrest->{}, tytul->{}, legenda->{}, gridt->{}};

(* pr\:0119dko\:015bci k\:0105towe, parametryzuj\:0105ce ewolucj\:0119 czasow\:0105 bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy, w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 *)
PredkosciKatoweBazaMasy[pola_,fG_,La_,g_,x_,fR_,wp_,listatf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*PredkosciKatoweBazaMasy[pola,fG,La,g,x,fR,wp,listatf,fun,param,sciezka,OptionValue[N0],
	OptionValue[zakrest],OptionValue[tytul],OptionValue[legenda],OptionValue[gridt]]=*)
Block[{lrozw,rozwiazania0,Go,masa,tytulw,ti,tf},(
lrozw=Length[listatf];
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=Map[If[Length[listatf[[#]]]>1,
	(* z uwzgl\:0119dnieniem produkcji cz\:0105stek *)
	RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,OptionValue[N0],wp,listatf[[#]],-1,OptionValue[N0],{},fun,param,True,1,"","M",False,sciezka],
	(* bez produkcji cz\:0105stek *)
	RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,First[listatf[[#]]],fun,param]] &, Range[lrozw]];

(* tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje *)
{Go}=Take[lagrangianO[g,x,pola,fG,La],{2}]/.{Symbol["P"]->0}/.fun/.param;

(* macierz masy *)
masa=MacierzMasy[g,x,pola,fG,La]/.fun/.param;

(* tytu\[LSlash] wykres\[OAcute]w *)
tytulw=If[OptionValue[tytul]=={}, mrkWykresy`tytulWykresu[param], OptionValue[tytul]];
(* zakresy czas\[OAcute]w *)
{ti,tf}=If[OptionValue[zakrest]=={}, {Table[0., lrozw],listatf[[All,-1]]}, OptionValue[zakrest]];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyParametrowBazaMasy[x,Go,rozwiazania0,masa,ti,tf,tytulw,OptionValue[legenda],sciezka,OptionValue[gridt]];)]


(* ortonormalna baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy w przestrzeni p\[OAcute]l zorientowana kanonicznie w danej chwili t *)
CzasN[efolds_,pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},N0_:-8.]:=
(*CzasN[efolds,pola,fG,La,g,x,fR,wp,tf,fun,param,N0]=*)
Block[{rozwiazania0,nn},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];

(* czas dla danej liczby e-powi\:0119ksze\:0144 *)
Reap[Do[nn=efolds[[i]];
	Sow[mrkRozwiazania`czasN[x,rozwiazania0,nn][[1,2]]];,
	{i,1,Length[efolds]}]][[2,1]])]


(* ::Subsection:: *)
(*Rozwi\:0105zania dla perturbacji*)


(* r\[OAcute]wnania i oznaczenia perturbacji *)
RownaniaPerturbacje[pola_,fG_,La_,g_,x_,fR_,MS_:True,r_:1,baza_:""]:=
RownaniaPerturbacje[pola,fG,La,g,x,fR,MS,r,baza]=
Block[{lpol,Go,rownaniaPkw,pertkw,Ebaza,dd\[Phi]N0},(
lpol=Length[pola];
(* tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje oraz cz\[LSlash]on kinetyczny *)
{Go}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2}]/.{Symbol["P"]->0};

(* ======= do r\[OAcute]wna\:0144 dla pierwotnych p\[OAcute]l nale\:017cy doda\[CAcute] jeszcze co\:015b na perturbacj\:0119 metryki????? ============== *)
(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich pierwotnych/MS zmiennych *)
{rownaniaPkw,pertkw}=If[MS && r!=0, {MukhanovSasakiRownaniakw[pola,fG,La,g,x,fR,r], mrkMukhanovSasaki`perturbacjeMSkw[pola]}, 
	{RuchuRownaniakw[g,x,pola,fG,La,r], mrkFourier`perturbacjekw[mrkUzyteczny`perturbacjeNazwy["\[Delta]",pola]]}];
	
If[lpol!=1 && baza!="",(
	Ebaza=Which[
		(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
		baza=="F", BazaFreneta[g,x,pola,fG,La], 
		(* baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie  *)
		baza=="M", mrkLagrange`bazaMasy[g,x,pola,fG,La],
		(* przekazana baza *)
		True, baza];
	(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
	dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];
	(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich zmiennych adiabatycznej i entropowych *)
	{rownaniaPkw,pertkw}={mrkIzoKrzywizna`ruchuRNAEkwO[pola,Go,Ebaza,x,rownaniaPkw,dd\[Phi]N0,MS,r], mrkIzoKrzywizna`perturbacjeRSkw[pola,MS]};)];

{rownaniaPkw,pertkw})]


(* warto\:015bci pocz\:0105tkowe dla perturbacji *)
WartosciPoczatkowePerturbacje[pola_,fG_,La_,g_,x_,fR_,N0_,wp_,tf_,kw_,N0P_,fun_:{},param_:{},baza_:"",perti_:"M"]:=
WartosciPoczatkowePerturbacje[pola,fG,La,g,x,fR,N0,wp,tf,kw,N0P,fun,param,baza,perti]=
Block[{lpol,rozwiazania0,wpPert,listao,dd\[Phi]N0,Ebaza},(
lpol=Length[pola];
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];

(* warto\:015bci pocz\:0105tkowe perturbacji *)
wpPert=Which[
	(* pr\[OAcute]\:017cnia typu Minkowskiego *)
	perti=="M", mrkRozwiazania`wartosciPoczatkowePert[lpol,x,rozwiazania0,kw,N0P]];

wpPert=If[lpol!=1 && baza=="",
	((* pola (t\[LSlash]o) i tensor metryczny w przestrzeni p\[OAcute]l *)
	listao=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{1,2}]/.{Symbol["P"]->0};
	(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
	dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];
	(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
	Ebaza=mrkIzoKrzywizna`bazaFrenetaTest[listao,dd\[Phi]N0,x,rozwiazania0,0,fun,param];
	wpPert.Ebaza),
	wpPert];

wpPert)]


(* rozwi\:0105zania dla niezmienniczej wzgl\:0119dem cechowania perturbacji krzywizny i zrenormalizowanej perturbacji izokrzywizny *)
RozwiazaniePerturbacje[pola_,fG_,La_,g_,x_,fR_,N0_,wp_,tf_,fun_:{},param_:{},kw_,N0P_,wpP_:{},MS_:True,r_:1,baza_:"",perti_:"M"]:=
RozwiazaniePerturbacje[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kw,N0P,wpP,MS,r,baza,perti]=
Block[{lpol,Go,Xo,d\[Sigma],rozwiazania0,rownaniaPkw,pertkw,rozwiazaniaP,Ebaza,wpPert,dd\[Phi]N0,rownaniaNkw},(
lpol=Length[pola];
(* tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje oraz cz\[LSlash]on kinetyczny *)
{Go,Xo}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2,3}]/.{Symbol["P"]->0};

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];

(* r\[OAcute]wnania dla perturbacji i oznaczenia perturbacji *)
{rownaniaPkw,pertkw}=RownaniaPerturbacje[pola,fG,La,g,x,fR,MS,r,baza] /. fun /. param;
	
(* warto\:015bci pocz\:0105tkowe perturbacji *)
wpPert=If[wpP=={}, WartosciPoczatkowePerturbacje[pola,fG,La,g,x,fR,N0,wp,tf,kw,N0P,fun,param,baza,perti], wpP];

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
rozwiazaniaP=If[kw==-1, mrkRozwiazania`rozwiazaniePertk[pertkw,x,rownaniaPkw,rozwiazania0,tf,wpPert,N0P],
	mrkRozwiazania`rozwiazaniePert[pertkw,x,rownaniaPkw,kw,rozwiazania0,tf,wpPert,N0P]];

(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
If[baza=="", rozwiazaniaP, mrkRozwiazania`przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x,Xo,rozwiazaniaP,{},Go,fun,param]])]
(*If[baza\[Equal]"", rozwiazaniaP, mrkRozwiazania`przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x,Xo,rozwiazaniaP,baza,Go,fun,param]])]*)


(* warunki zszycia dla perturbacji *)
WarunkiZszyciaPerturbacje[pola_,fG_,La_,g_,x_,fR_]:=
(*WarunkiZszyciaPerturbacje[pola,fG,La,g,x,fR]=*)
Block[{perturbacjam,perturbacjamkw,dd\[Phi]N0,dH,V0,H2,r000,r110,r001,r011,podstLG,Go,Ebaza,podstRSMS,podstMSRS,dd\[Sigma]},(
(* nazwa sk\[LSlash]adowej fourierowskiej perturbacji metryki *)
perturbacjamkw=(perturbacjam=mrkUzyteczny`perturbacjeObiekt[g,x]; mrkFourier`perturbacjekw[perturbacjam][[1]]);

(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];

(* r\[OAcute]wnanie pola 00 dla t\[LSlash]a (r\[OAcute]wnanie Friedmanna) *)
r000=PolaRownaniekw[pola,fG,La,fR,0,0,g,x,0,True][[1]];
(* r\[OAcute]wnanie pola 11 dla t\[LSlash]a *)
r110=PolaRownaniekw[pola,fG,La,fR,1,1,g,x,0,True][[1]];

(* podstawienie pochodnej parametru Hubble'a *)
dH=mrkEinstein`dHubble0[r000,r110,x];
(* podstawienie potencja\[LSlash]u *)
V0=mrkEinstein`potencjalV0[r000,x];
H2=mrkEinstein`Hubble2[r000,x];

(* ograniczenia dla energii i pedu dane s\:0105 przez r\[OAcute]wnania Einsteina *)
(* r\[OAcute]wnanie pola 00 dla sk\[LSlash]adowych fourierowskich w pierwszym rz\:0119dzie w perturbacjach *)
r001=PolaRownaniekw[pola,fG,La,fR,0,0,g,x,1,True][[1]]/.V0/.dH;
(* r\[OAcute]wnanie pola 01 dla sk\[LSlash]adowych fourierowskich w pierwszym rz\:0119dzie w perturbacjach *)
r011=Thread[PolaRownaniekw[pola,fG,La,fR,0,1,g,x,1,True][[1]]/Symbol["k1"],Equal]/.dH;

(* podstwienia skalarnej perturbacji metryki wyra\:017cone w zmiennych MS: {\[CapitalPhi][t]\[Rule]...,\[CapitalPhi]'[t]\[Rule]...} *)
podstLG=mrkMukhanovSasaki`perturbacjaMetrykiMS[pola,r001,r011,perturbacjamkw,x,dd\[Phi]N0,dH,H2];

(* tensor metryczny w przestrzeni p\[OAcute]l *)
Go=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2}][[1]];
(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
Ebaza=BazaFreneta[g,x,pola,fG,La,True];
(* {{podstaiwnia zmiennych krzywizny i izokrzywizny i ich pierwszych i drugich pochodnych}, {podstwienia perturbacji pierwotnych/MS i ich pierwszych i drugich pochodnych}} *)
{podstRSMS,podstMSRS}=mrkIzoKrzywizna`podstawieniaRS[pola,Go,Ebaza,x,dd\[Phi]N0,True];

(* pomocnicze zmienne \[Sigma]'[t] i \[Sigma]''[t] *)
dd\[Sigma]=mrkLagrange`dsigma[g,x,pola,fG,La];

mrkProdukcjaCzastek`Private`warunkiZszyciaPerturbacje[x,podstLG,dH,Drop[podstRSMS,-1],Drop[podstMSRS,-1],dd\[Sigma]])]


(* rozwi\:0105zania dla t\[LSlash]a z uwzgl\:0119dnieniem produkcji cz\:0105stek *)
RozwiazanieProdukcjaCzastek[pola_,fG_,La_,g_,x_,fR_,N0_,wp_,listatf_,kw_,N0P_,wpP_:{},fun_:{},param_:{},MS_:True,r_:1,baza_:"",perti_:"M",pert_:True,sciezka_:Directory[],nazwa_:""]:=
RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,N0,wp,listatf,kw,N0P,wpP,fun,param,MS,r,baza,perti,pert,sciezka,nazwa]=
Block[{tf,r000,rr0,Go,Xo,Lao,rownaniaPkw,pertkw,wpPert,masa,warunkiP},(
tf=Last[listatf];
(* r\[OAcute]wnanie pola 00 dla t\[LSlash]a (r\[OAcute]wnanie Friedmanna) *)
r000=PolaRownaniekw[pola,fG,La,fR,0,0,g,x,0,True]/.fun/.param;
(* r\[OAcute]wnania ruchu t\[LSlash]a *)
rr0=RuchuRownaniakw[g,x,pola,fG,La,0]/.fun/.param;

(* cz\[LSlash]on kinetyczny *)
{Go,Xo,Lao}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2,4}]/.{Symbol["P"]->0}/.fun/.param;

(* macierz masy *)
masa=MacierzMasy[g,x,pola,fG,La]/.fun/.param;

If[pert,(
(* r\[OAcute]wnania dla perturbacji i oznaczenia perturbacji *)
{rownaniaPkw,pertkw}=RownaniaPerturbacje[pola,fG,La,g,x,fR,MS,r,baza]/.fun/.param;
(* warto\:015bci pocz\:0105tkowe perturbacji *)
wpPert=If[wpP=={}, WartosciPoczatkowePerturbacje[pola,fG,La,g,x,fR,N0,wp,tf,kw,N0P,fun,param,baza,perti], wpP];

warunkiP=WarunkiZszyciaPerturbacje[pola,fG,La,g,x,fR]/.fun/.param;

(* rozwi\:0105zania r\[OAcute]wna\:0144 t\[LSlash]a i perturbacji *)
mrkProdukcjaCzastek`rozwiazanieProdukcjaCzastek[pola,pertkw,x,La,{Go,Xo,Lao},masa,rr0,r000,rownaniaPkw,listatf,wp,wpPert,N0,N0P,kw,0.,warunkiP,sciezka,nazwa]),
((* rozwi\:0105zania r\[OAcute]wna\:0144 t\[LSlash]a *)
mrkProdukcjaCzastek`rozwiazanieTloProdukcjaCzastek[pola,x,Xo,rr0,r000,listatf,wp,N0,0.,masa,Go,sciezka])]




)]


(* normalizacja; zmienna norm: 
"" - brak normalizacji,
"h" - adiabatyczne widmo dla jednego pola, policzone w momencie przekraczania promienia Hubble'a dla Nkw
"t" - adiabatyczne widmo dla jednego pola dla danej liczby falowej kw, zale\:017cne od czasu *)
NormalizacjaWidmaKorelacje[pola_,fG_,La_,g_,x_,fR_,N0_,wp_,tf_,fun_:{},param_:{},kwNorm_:-1,NkwNorm_:0,norm_:"",\[Tau]f_:0.,typNorm_:"R"]:=
NormalizacjaWidmaKorelacje[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kwNorm,NkwNorm,norm,\[Tau]f,typNorm]=
Block[{lpol,konf,rozwiazania0,Xo,cs},(lpol=Length[pola];
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
konf=If[norm=="t", True, False];
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,konf];

(* cz\[LSlash]on kinetyczny *)
Xo=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{3}][[1]]/.{Symbol["P"]->0};
(* efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku *)
cs=PredkoscDzwiekuEf[g,x,pola,fG,La];

(* normalizacja *)
(*Which[lpol==1 || norm=="", 1, *)
Which[norm=="", 1,
	norm=="h", mrkRozwiazania`normalizacjaWidmaKorelacje[x,La,Xo,cs,rozwiazania0,NkwNorm,fun,param,typNorm],
	kwNorm!=-1 && norm=="t", mrkRozwiazania`normalizacjaWidmaKorelacjet[x,La,Xo,cs,rozwiazania0,kwNorm,\[Tau]f,fun,param]])]


(* widma mocy perturbacji krzywizny i izokrzywizny PQ=kw^3(Abs[Q_1]^2+Abs[Q_2]^2+...)/2\[Pi] *)
RozwiazanieWidma[pola_,fG_,La_,g_,x_,fR_,N0_,wp_,tf_,fun_:{},param_:{},kw_,kwNorm_,NkwNorm_,N0P_,wpP_:{},MS_:True,r_:1,norm_:"",\[Tau]f_:0.,baza_:"F",perti_:"M"]:=
RozwiazanieWidma[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kw,kwNorm,NkwNorm,N0P,wpP,MS,r,norm,\[Tau]f,baza,perti]=
Block[{konf,rozwiazaniaRS,normalizacja},(
(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
rozwiazaniaRS=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kw,N0P,wpP,MS,r,baza,perti];
rozwiazaniaRS=If[baza=="", Transpose[rozwiazaniaRS], rozwiazaniaRS];

(* normalizacja *)
normalizacja=NormalizacjaWidmaKorelacje[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kwNorm,NkwNorm,norm,\[Tau]f];
		
(* widma {{{P\[ScriptCapitalR]1,P\[ScriptCapitalR]2,...},{P\[ScriptCapitalS]11,P\[ScriptCapitalS]12,...},...}, {P\[ScriptCapitalR]tot,P\[ScriptCapitalS]1tot,P\[ScriptCapitalS]2tot,...}} *)
mrkRozwiazania`widmaRozw[rozwiazaniaRS,kw,normalizacja])]


(* korelacje CQ1Q2=k^3Abs[(Conjugate[Q1_1]*Q2_1+Conjugate[Q1_2]*Q2_2+...)]/2\[Pi] i wzgl\:0119dne korelacje CUQ1Q2=Abs[CQ1Q2]/Sqrt[PQ1*PQ2] *)
RozwiazanieKorelacje[pola_,fG_,La_,g_,x_,fR_,N0_,wp_,tf_,fun_:{},param_:{},kw_,kwNorm_,NkwNorm_,N0P_,wpP_:{},MS_:True,r_:1,norm_:"",\[Tau]f_:0.,baza_:"F",perti_:"M"]:=
RozwiazanieKorelacje[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kw,kwNorm,NkwNorm,N0P,wpP,MS,r,norm,\[Tau]f,baza,perti]=
Block[{konf,rozwiazaniaRS,normalizacja},(
(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
rozwiazaniaRS=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kw,N0P,wpP,MS,r,baza,perti];
rozwiazaniaRS=If[baza=="", Transpose[rozwiazaniaRS], rozwiazaniaRS];

(* normalizacja *)
normalizacja=NormalizacjaWidmaKorelacje[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kwNorm,NkwNorm,norm,\[Tau]f];

(* korelacje *)
mrkRozwiazania`korelacjeRozw[rozwiazaniaRS,kw,normalizacja])]


(* wzgl\:0119dne korelacje CUQ1Q2=Abs[CQ1Q2]/Sqrt[PQ1*PQ2] *)
RozwiazanieKorelacjeWzgledne[pola_,fG_,La_,g_,x_,fR_,N0_,wp_,tf_,fun_:{},param_:{},kw_,N0P_,wpP_:{},MS_:True,r_:1,baza_:"F",perti_:"M"]:=
RozwiazanieKorelacjeWzgledne[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kw,N0P,wpP,MS,r,baza,perti]=
Block[{widma,korelacje},(
(* widma {P\[ScriptCapitalR],P\[ScriptCapitalS]1,P\[ScriptCapitalS]2,...} *)
widma=RozwiazanieWidma[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kw,0.,0.,N0P,wpP,MS,r,"",0.,baza,perti][[2]];

(* korelacje {C\[ScriptCapitalR]\[ScriptCapitalS]1,C\[ScriptCapitalR]\[ScriptCapitalS]2,...,C\[ScriptCapitalS]1\[ScriptCapitalS]2,...} *)
korelacje=RozwiazanieKorelacje[pola,fG,La,g,x,fR,N0,wp,tf,fun,param,kw,0.,0.,N0P,wpP,MS,r,"",0.,baza,perti];

(* wzgl\:0119dne korelacje *)
mrkRozwiazania`korelacjeURozw[widma,korelacje])]


(* domy\:015blne opcje funkcji Widma *)
Options[Widma]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{"N",0.}, NkwNorm->0., norm->"h", tftot->-1., baza->"F", perti->"M"};

(* zale\:017cno\:015bci widma mocy perturbacji krzywizny i izokrzywizny PQ=kw^3(Abs[Q_1]^2+Abs[Q_2]^2+...)/2\[Pi] od liczby e-powi\:0119ksze\:0144 lub liczby falowej *)
Widma[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*Widma[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],
	OptionValue[Nkw],OptionValue[NkwNorm],OptionValue[norm],OptionValue[tftot],OptionValue[baza],OptionValue[perti]]=*)
Block[{rozwiazania0,\[Tau]f=0.,kwNorm,kw,widma,tytul,ti},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];
If[OptionValue[norm]=="t", 
	\[Tau]f=Symbol["\[Tau]"][x[[1]]] /. RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,OptionValue[tftot],fun,param,True] /. x[[1]]->OptionValue[tftot];];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kwNorm=If[OptionValue[norm]=="t" || MemberQ[{"wsp",""}, OptionValue[Nkw][[1]]], 
	mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[NkwNorm]], 1];

kw=Which[OptionValue[Nkw][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[2]]], 
		 OptionValue[Nkw][[1]]=="kw", OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="wsp", kwNorm*OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="", -1];

(* widma mocy perturbacji *)
widma=RozwiazanieWidma[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,kwNorm,OptionValue[NkwNorm],
	OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],OptionValue[norm],\[Tau]f,OptionValue[baza],OptionValue[perti]];

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
If[kw==-1,
	mrkWykresy`wykresyWidmak[x,rozwiazania0,{widma[[2,1]]},tf,kwNorm,OptionValue[norm],tytul,sciezka,OptionValue[baza]];,
	((* pocz\:0105tkowy czas dla perturbacji *)
	ti=mrkRozwiazania`czasN[x,rozwiazania0,OptionValue[N0P]][[1,2]];
	mrkWykresy`wykresyWidma[x,rozwiazania0,widma[[2]],ti,tf,tytul,sciezka,OptionValue[norm],OptionValue[baza]];
	mrkWykresy`wykresyWidmaPrzebiegi[x,rozwiazania0,widma[[1]],ti,tf,tytul,sciezka,OptionValue[norm],OptionValue[baza]];)];)]


(* domy\:015blne opcje funkcji PerturbacjeB *)
Options[PerturbacjeB]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{"N",0.}, NkwNorm->0., norm->"h", tftot->-1., baza->"F", perti->"M", RS->True, pertu->False};

(* zale\:017cno\:015bci perturbacji w zadanej bazie od liczby e-powi\:0119ksze\:0144 *)
PerturbacjeB[pola_,fG_,La_,g_,x_,fR_,wp_,listatf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*PerturbacjeB[pola,fG,La,g,x,fR,wp,listatf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],
	OptionValue[Nkw],OptionValue[NkwNorm],OptionValue[norm],OptionValue[tftot],OptionValue[baza],OptionValue[perti],OptionValue[RS],OptionValue[pertu]]=*)
Block[{lpol,tf,Go,Xo,rozwiazania0,\[Tau]f=0.,ti,kwNorm,kw,rozwiazaniaP,normalizacja,
masa,tytul,widma,listao,dd\[Phi]N0,Ebaza},(
lpol=Length[pola];
tf=Last[listatf];
(* tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje oraz cz\[LSlash]on kinetyczny *)
{Go,Xo}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2,3}]/.{Symbol["P"]->0}/.fun/.param;

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];
If[OptionValue[norm]=="t", 
	\[Tau]f=Symbol["\[Tau]"][x[[1]]] /. RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,OptionValue[tftot],fun,param,True] /. x[[1]]->OptionValue[tftot];];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kwNorm=If[OptionValue[norm]=="t" || MemberQ[{"wsp",""}, OptionValue[Nkw][[1]]], 
	mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[NkwNorm]], 1];

kw=Which[OptionValue[Nkw][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[2]]], 
		 OptionValue[Nkw][[1]]=="kw", OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="wsp", kwNorm*OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="", -1];

(* pocz\:0105tkowy czas dla perturbacji *)
If[kw!=-1, ti=mrkRozwiazania`czasN[x,rozwiazania0,OptionValue[N0P]][[1,2]];];

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
If[Length[listatf]>1,
	{rozwiazania0,rozwiazaniaP}=RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,OptionValue[N0],wp,listatf,kw,
		OptionValue[N0P],OptionValue[wpP],fun,param,OptionValue[MS],OptionValue[r],"",OptionValue[perti],True,sciezka];,
	rozwiazaniaP=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,
		OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",OptionValue[perti]];];

(* normalizacja *)
normalizacja=NormalizacjaWidmaKorelacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kwNorm,OptionValue[NkwNorm],OptionValue[norm],\[Tau]f];

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
Which[OptionValue[baza]=="M",
	((* macierz masy *)
	masa=MacierzMasy[g,x,pola,fG,La]/.fun/.param;
	If[kw==-1,
		mrkWykresy`wykresyPerturbacjekB[x,La,Go,Xo,rozwiazania0,rozwiazaniaP,masa,tf,kwNorm,normalizacja,
			tytul,sciezka,OptionValue[norm],1,OptionValue[baza],OptionValue[RS],OptionValue[pertu]];,
		mrkWykresy`wykresyPerturbacjeB[x,pola,La,Go,Xo,rozwiazania0,rozwiazaniaP,masa,ti,tf,kw,normalizacja,
			tytul,sciezka,OptionValue[norm],OptionValue[baza],OptionValue[RS],OptionValue[pertu]];];),
		
	OptionValue[baza]=="F",
	((* pola (t\[LSlash]o) i tensor metryczny w przestrzeni p\[OAcute]l *)
	listao=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{1,2}]/.{Symbol["P"]->0};
	(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
	dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];
	(* baza pierwotna *)
	Ebaza=mrkIzoKrzywizna`bazaPierwotna[listao,dd\[Phi]N0,x]/.fun/.param;
	If[kw==-1,
		mrkWykresy`wykresyPerturbacjekB[x,La,Go,Xo,rozwiazania0,rozwiazaniaP,Ebaza,tf,kwNorm,normalizacja,
			tytul,sciezka,OptionValue[norm],1,OptionValue[baza],OptionValue[RS],OptionValue[pertu]];,
		mrkWykresy`wykresyPerturbacjeB[x,pola,La,Go,Xo,rozwiazania0,rozwiazaniaP,Ebaza,ti,tf,kw,normalizacja,
			tytul,sciezka,OptionValue[norm],OptionValue[baza],OptionValue[RS],OptionValue[pertu]];];),
	
	OptionValue[baza]=="",
	If[kw==-1,
		mrkWykresy`wykresyPerturbacjekB[x,La,Go,Xo,rozwiazania0,rozwiazaniaP,{},tf,kwNorm,normalizacja,
			tytul,sciezka,OptionValue[norm],1,OptionValue[baza],OptionValue[RS],OptionValue[pertu]];,
		mrkWykresy`wykresyPerturbacjeB[x,pola,La,Go,Xo,rozwiazania0,rozwiazaniaP,{},ti,tf,kw,normalizacja,
			tytul,sciezka,OptionValue[norm],OptionValue[baza],OptionValue[RS],OptionValue[pertu]];];];	
)]


(* domy\:015blne opcje funkcji WidmaB *)
Options[WidmaB]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{{"N",0.}}, NkwNorm->0., norm->"h", tftot->-1., 
	baza->"F", perti->"M", RS->True, pertu->False, zakrest->{}, gridt->{}, legenda->{}};

(* zale\:017cno\:015bci widma mocy w zadanej bazie PQ=kw^3(Abs[Q_1]^2+Abs[Q_2]^2+...)/2\[Pi] od liczby e-powi\:0119ksze\:0144 lub liczby falowej *)
WidmaB[pola_,fG_,La_,g_,x_,fR_,wp_,listatf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*WidmaB[pola,fG,La,g,x,fR,wp,listatf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],
	OptionValue[Nkw],OptionValue[NkwNorm],OptionValue[norm],OptionValue[tftot],OptionValue[baza],OptionValue[perti],OptionValue[RS],
	OptionValue[pertu],OptionValue[zakrest],OptionValue[gridt],OptionValue[legenda]]=*)
Block[{lpol,lrozw,tf,Go,Xo,rozwiazania0,\[Tau]f=0.,ti,kwNorm,kw,rozwiazaniaP,typNorm,normalizacja,
masa,tytul,rozwiazaniaPT,widma,listao,dd\[Phi]N0,Ebaza,nazwa},(
lpol=Length[pola]; lrozw=Length[listatf];
tf=Max[listatf];
(* tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje oraz cz\[LSlash]on kinetyczny *)
{Go,Xo}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2,3}]/.{Symbol["P"]->0}/.fun/.param;

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];
If[OptionValue[norm]=="t", 
	\[Tau]f=Symbol["\[Tau]"][x[[1]]] /. RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,OptionValue[tftot],fun,param,True] /. x[[1]]->OptionValue[tftot];];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
(*kwNorm=If[OptionValue[norm]=="t" || MemberQ[{"wsp",""}, OptionValue[Nkw][[1]]],*) 
kwNorm=If[OptionValue[norm]=="t" || MemberQ[OptionValue[Nkw][[All,1]], "wsp"] || MemberQ[OptionValue[Nkw][[All,1]], ""], 
	mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[NkwNorm]], 1];

kw=Map[Which[OptionValue[Nkw][[#]][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[#]][[2]]], 
		 OptionValue[Nkw][[#]][[1]]=="kw", OptionValue[Nkw][[#]][[2]],
		 OptionValue[Nkw][[#]][[1]]=="wsp", kwNorm*OptionValue[Nkw][[#]][[2]],
		 OptionValue[Nkw][[#]][[1]]=="", -1] &, Range[lrozw]];

(* pocz\:0105tkowy czas dla perturbacji *)
If[!AllTrue[kw, #==-1 &], ti=mrkRozwiazania`czasN[x,rozwiazania0,OptionValue[N0P]][[1,2]];];

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
{rozwiazania0,rozwiazaniaP}=Transpose[Map[If[Length[listatf[[#]]]>1,
	(* z uwzgl\:0119dnieniem produkcji cz\:0105stek *)
	(nazwa=If[OptionValue[Nkw][[#]][[1]]=="wsp", ToString[NumberForm[OptionValue[Nkw][[#]][[2]],"NumberPoint"->","]], 
			ToString[NumberForm[N[kw/kwNorm], {3,3}, "NumberPoint"->","]]];
	RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,OptionValue[N0],wp,listatf[[#]],kw[[#]],
		OptionValue[N0P],OptionValue[wpP],fun,param,OptionValue[MS],OptionValue[r],"",OptionValue[perti],True,sciezka,nazwa]),
	(* bez produkcji cz\:0105stek *)	
	{RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,First[listatf[[#]]],fun,param],
	RozwiazaniePerturbacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,First[listatf[[#]]],fun,param,kw[[#]],
		OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",OptionValue[perti]]}] &, Range[lrozw]]];

(* normalizacja *)
typNorm=If[OptionValue[norm]=="h", Which[OptionValue[RS], "R", OptionValue[pertu], "u", True, "Q"], ""];
normalizacja=NormalizacjaWidmaKorelacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kwNorm,OptionValue[NkwNorm],OptionValue[norm],\[Tau]f,typNorm];
Print["norm P* ",normalizacja];

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* zakresy czas\[OAcute]w *)
{ti,tf}=If[OptionValue[zakrest]=={}, {Table[If[kw!=-1,ti,0.], lrozw],listatf[[All,-1]]}, OptionValue[zakrest]];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
Which[OptionValue[baza]=="M",
	((* macierz masy *)
	masa=MacierzMasy[g,x,pola,fG,La]/.fun/.param;
	If[AllTrue[kw, #==-1 &],
		mrkWykresy`wykresyWidmakB[x,Go,Xo,rozwiazania0,rozwiazaniaP,masa,tf,kwNorm,normalizacja,
			tytul,sciezka,OptionValue[norm],1,OptionValue[baza]];,
		mrkWykresy`wykresyWidmaB[x,pola,La,Go,Xo,rozwiazania0,rozwiazaniaP,masa,ti,tf,kw,normalizacja,
			tytul,sciezka,OptionValue[norm],OptionValue[baza],OptionValue[RS],OptionValue[pertu],OptionValue[gridt],OptionValue[legenda]];];),
		
	OptionValue[baza]=="F",
	((* pola (t\[LSlash]o) i tensor metryczny w przestrzeni p\[OAcute]l *)
	listao=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{1,2}]/.{Symbol["P"]->0};
	(* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
	dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];
	(* baza pierwotna *)
	Ebaza=mrkIzoKrzywizna`bazaPierwotna[listao,dd\[Phi]N0,x]/.fun/.param;
	If[AllTrue[kw, #==-1 &],
		mrkWykresy`wykresyWidmakB[x,Go,Xo,rozwiazania0,rozwiazaniaP,Ebaza,tf,kwNorm,normalizacja,
			tytul,sciezka,OptionValue[norm],1,OptionValue[baza]];,
		mrkWykresy`wykresyWidmaB[x,pola,La,Go,Xo,rozwiazania0,rozwiazaniaP,Ebaza,ti,tf,kw,normalizacja,
			tytul,sciezka,OptionValue[norm],OptionValue[baza],OptionValue[RS],OptionValue[pertu],OptionValue[gridt],OptionValue[legenda]];];),
	
	OptionValue[baza]=="",
	((* widma {{{PQ11,PQ12,...},{PQ21,PQ22,...},...}, {PQ1tot,PQ2tot,PQ3tot,...}} *)
(*	rozwiazaniaPT=Map[Transpose, rozwiazaniaP];
	widma=Map[mrkRozwiazania`widmaRozw[#,kw,normalizacja] &, rozwiazaniaPT];*)
	If[AllTrue[kw, #==-1 &],
		(*mrkWykresy`wykresyWidmakB[x,rozwiazania0,widma[[2]],tf,kwNorm,OptionValue[norm],tytul,sciezka,OptionValue[baza]];,*)
		mrkWykresy`wykresyWidmakB[x,Go,Xo,rozwiazania0,rozwiazaniaP,{},tf,kwNorm,normalizacja,
			tytul,sciezka,OptionValue[norm],1,OptionValue[baza]];,
		mrkWykresy`wykresyWidmaB[x,pola,La,Go,Xo,rozwiazania0,rozwiazaniaP,{},ti,tf,kw,normalizacja,
			tytul,sciezka,OptionValue[norm],OptionValue[baza],OptionValue[RS],OptionValue[pertu],OptionValue[gridt],OptionValue[legenda]];];)];	
)]


(* domy\:015blne opcje funkcji WidmaTest *)
Options[WidmaTest]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->0.};

(* zale\:017cno\:015bci widma mocy perturbacji krzywizny i izokrzywizny PQ=kw^3(Abs[Q_1]^2+Abs[Q_2]^2+...)/2\[Pi] od liczby e-powi\:0119ksze\:0144 *)
WidmaTest[baza_,pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*WidmaTest[baza,pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],OptionValue[Nkw]]=*)
Block[{lpol,rozwiazania0,kw,Go,Xo,rownaniaPkw,pertkw,wpPert,rozwiazaniaP,rozwiazaniaRS,norm,widma,tytul,ti},(
lpol=Length[pola];
(* tensor metryczny w przestrzeni p\[OAcute]l z polami podzielonymi na t\[LSlash]o i perturbacje oraz cz\[LSlash]on kinetyczny *)
{Go,Xo}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2,3}]/.{Symbol["P"]->0};

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];

(* ========== inaczej zrobi\[CAcute] ten mechanizm - te\:017c liczy\[CAcute], gdy nie ma MS ============= *)
(*(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich pierwotnych/MS zmiennych i nazwy tych perturbacji *)
{rownaniaPkw,pertkw}=If[MS && r!=0, {MukhanovSasakiRownaniakw[pola,fG,La,g,x,fR,r]/.fun/.param, mrkMukhanovSasaki`perturbacjeMSkw[pola]}, 
	{RuchuRownaniakw[g,x,pola,fG,La,r], }];*)
(* r\[OAcute]wnania ruchu dla sk\[LSlash]adowych fourierowskich perturbacji MS i nazwy tych perturbacji *)
{rownaniaPkw,pertkw}={MukhanovSasakiRownaniakw[pola,fG,La,g,x,fR,OptionValue[r]]/.fun/.param, mrkMukhanovSasaki`perturbacjeMSkw[pola]};

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kw=mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw]];
(* warto\:015bci pocz\:0105tkowe perturbacji - je\:017celi nie podano, to s\:0105 przyjmowane jako pr\[OAcute]\:017cnia typu Minkowskiego *)
wpPert=If[OptionValue[wpP]=={}, mrkRozwiazania`wartosciPoczatkowePert[lpol,x,rozwiazania0,kw,OptionValue[N0P]], OptionValue[wpP]];
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
rozwiazaniaP=mrkRozwiazania`rozwiazaniePert[pertkw,x,rownaniaPkw,kw,rozwiazania0,tf,wpPert,OptionValue[N0P]];

(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
rozwiazaniaRS=mrkRozwiazania`przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x,Xo,rozwiazaniaP,baza,Go,fun,param];

(* normalizacja *)
norm=If[lpol==1, 1, mrkRozwiazania`normalizacjaWidmaKorelacje[x,Xo,rozwiazania0,OptionValue[Nkw],fun,param]];
(* widma mocy perturbacji *)
widma=mrkRozwiazania`widmaRozw[rozwiazaniaRS,kw,norm][[2]];

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=ToString[mrkWykresy`tytulWykresu[param]]<>"\nBaza="<>ToString[baza];
(* pocz\:0105tkowy czas dla perturbacji *)
ti=mrkRozwiazania`czasN[x,rozwiazania0,OptionValue[N0P]][[1,2]];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyWidma[x,rozwiazania0,widma,ti,tf,tytul,sciezka,"h"];)]


(* domy\:015blne opcje funkcji Korelacje *)
Options[Korelacje]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{"N",0.}, NkwNorm->0., norm->"h", tftot->-1., perti->"M"};

(* korelacje CQ1Q2=k^3Abs[(Conjugate[Q1_1]*Q2_1+Conjugate[Q1_2]*Q2_2+...)]/2\[Pi] od liczby e-powi\:0119ksze\:0144 *)
Korelacje[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*Korelacje[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],
	OptionValue[Nkw],OptionValue[NkwNorm],OptionValue[norm],OptionValue[tftot],OptionValue[perti]]=*)
Block[{rozwiazania0,\[Tau]f=0.,kwNorm,kw,korelacje,tytul,ti},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];
If[OptionValue[norm]=="t", 
	\[Tau]f=Symbol["\[Tau]"][x[[1]]] /. RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,OptionValue[tftot],fun,param,True] /. x[[1]]->OptionValue[tftot];];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kwNorm=If[OptionValue[norm]=="t" || MemberQ[{"wsp",""}, OptionValue[Nkw][[1]]], 
	mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[NkwNorm]], 1];

kw=Which[OptionValue[Nkw][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[2]]], 
		 OptionValue[Nkw][[1]]=="kw", OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="wsp", kwNorm*OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="", -1];

(* korelacje *)
korelacje=RozwiazanieKorelacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,kwNorm,OptionValue[NkwNorm],
	OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],OptionValue[norm],\[Tau]f,"F",OptionValue[perti]];

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* pocz\:0105tkowy czas dla perturbacji *)
ti=mrkRozwiazania`czasN[x,rozwiazania0,OptionValue[N0P]][[1,2]];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyKorelacje[x,rozwiazania0,korelacje,ti,tf,tytul,sciezka,OptionValue[norm]];)]


(* domy\:015blne opcje funkcji KorelacjeWzgledne *)
Options[KorelacjeWzgledne]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{"N",0.}, perti->"M"};

(* wzgl\:0119dne korelacje CUQ1Q2=Abs[CQ1Q2]/Sqrt[PQ1*PQ2] od liczby e-powi\:0119ksze\:0144 *)
KorelacjeWzgledne[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*KorelacjeWzgledne[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],
	OptionValue[MS],OptionValue[r],OptionValue[Nkw],OptionValue[perti]]=*)
Block[{rozwiazania0,kwNorm,kw,korelacjeU,tytul,ti},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kw=Which[OptionValue[Nkw][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[2]]], 
		 OptionValue[Nkw][[1]]=="kw", OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="", -1];

(* korelacje wzgl\:0119dne *)
korelacjeU=RozwiazanieKorelacjeWzgledne[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,
	OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"F",OptionValue[perti]];

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* pocz\:0105tkowy czas dla perturbacji *)
ti=mrkRozwiazania`czasN[x,rozwiazania0,OptionValue[N0P]][[1,2]];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyKorelacjeU[x,rozwiazania0,korelacjeU,ti,tf,tytul,sciezka];)]


(* warto\:015bci wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ce N=0 i podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 (N=0 i a_0=Exp(N_0)) w momencie wychodzenia za horyzont, wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
WektorFalowyTest[Nkw_,pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},N0_:-8.]:=
(*WektorFalowyTest[Nkw,pola,fG,La,g,x,fR,wp,tf,fun,param,N0]=*)
Block[{rozwiazania0},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,N0,wp,tf,fun,param];

(* liczby falowe dla N=0 (k1) i N=Nkw (k2) w momencie przekraczania promienia Hubble'a: k=aH; {k1, k2, k1-k2} *)
mrkRozwiazania`wektorFalowyTest[x,rozwiazania0,Nkw])]


(* domy\:015blne opcje funkcji IndeksSpektralny *)
Options[IndeksSpektralny]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{"N",0.}, Nkw2->{"N",0.001}, baza->"F", perti->"M"};

(* indeks spektralny n_s dla perturbacji krzywizny i izokrzywizny *)
IndeksSpektralny[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},OptionsPattern[]]:=
(*IndeksSpektralny[pola,fG,La,g,x,fR,wp,tf,fun,param,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],
	OptionValue[MS],OptionValue[r],OptionValue[Nkw],OptionValue[Nkw2],OptionValue[baza],OptionValue[perti]]=*)
Block[{rozwiazania0,kwNorm,kw,kw2,widma,widma2,indeks},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kw=Which[OptionValue[Nkw][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[2]]], 
		 OptionValue[Nkw][[1]]=="kw", OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="", -1];
kw2=Which[OptionValue[Nkw2][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw2][[2]]], 
		  OptionValue[Nkw2][[1]]=="kw", OptionValue[Nkw2][[2]],
		  OptionValue[Nkw2][[1]]=="", -1];

(* widma mocy perturbacji *)
widma=RozwiazanieWidma[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,0.,0.,
	OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",0.,OptionValue[baza],OptionValue[perti]];
widma2=RozwiazanieWidma[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw2,0.,0.,
	OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",0.,OptionValue[baza],OptionValue[perti]];

(* indeks spektralny n_s dla perturbacji krzywizny i izokrzywizny *)
indeks=mrkRozwiazania`indeksn[x,widma[[2]],widma2[[2]],kw,kw2,tf,rozwiazania0];
{kw,kw2,kw-kw2,indeks})]


(* domy\:015blne opcje funkcji IndeksSpektralnyB *)
Options[IndeksSpektralnyB]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{{"N",0.}}, Nkw2->{0.001}, NkwNorm->{0.}, baza->"F", perti->"M", nrwidm->{1}};

(* indeks spektralny n_s dla perturbacji krzywizny i izokrzywizny *)
IndeksSpektralnyB[pola_,fG_,La_,g_,x_,fR_,wp_,listatf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*IndeksSpektralnyB[pola,fG,La,g,x,fR,wp,listatf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],
	OptionValue[MS],OptionValue[r],OptionValue[Nkw],OptionValue[Nkw2],OptionValue[baza],OptionValue[perti],OptionValue[nrwidm]]=*)
Block[{lrozw,lNkw,lp,ns,tf,polao,Go,Xo,kw,kw2,rozwiazania0,kwNorm,rozwiazania02,rozwiazaniaP,rozwiazaniaP2,bazatf,dd\[Phi]N0,
rozwiazaniaRS,rozwiazaniaRS2,widma,widma2,indeks,ww,tytul},(
lrozw=Length[listatf]; lNkw=Length[OptionValue[Nkw]];
(* liczby podzia\[LSlash]\[OAcute]w *)
lp=Map[Length, listatf]-1;
(* tensor metryczny w przestrzeni p\[OAcute]l oraz cz\[LSlash]on kinetyczny *)
{polao,Go,Xo}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],3]/.{Symbol["P"]->0}/.fun/.param;

ns=Reap[Do[
Print[TimeObject[Now],"Rozwi\:0105zanie ",j];
tf=Last[listatf[[j]]];
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];
(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kwNorm=mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[NkwNorm][[j]]];

Sow[Transpose[Reap[Do[
(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kw=Which[OptionValue[Nkw][[i]][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[i]][[2]]], 
		 OptionValue[Nkw][[i]][[1]]=="kw", OptionValue[Nkw][[i]][[2]],
		 OptionValue[Nkw][[i]][[1]]=="wsp", kwNorm*OptionValue[Nkw][[i]][[2]]];
kw2=Which[OptionValue[Nkw][[i]][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[i]][[2]]+OptionValue[Nkw2][[i]]], 
		 OptionValue[Nkw][[i]][[1]]=="kw", kw+OptionValue[Nkw2][[i]],
		 OptionValue[Nkw][[i]][[1]]=="wsp", kw+OptionValue[Nkw2][[i]]];
		  
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
If[Length[listatf[[j]]]>1,
	({rozwiazania0,rozwiazaniaP}=RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,OptionValue[N0],wp,listatf[[j]],kw,
		OptionValue[N0P],OptionValue[wpP],fun,param,OptionValue[MS],OptionValue[r],"",OptionValue[perti],True,sciezka];
	{rozwiazania02,rozwiazaniaP2}=RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,OptionValue[N0],wp,listatf[[j]],kw2,
		OptionValue[N0P],OptionValue[wpP],fun,param,OptionValue[MS],OptionValue[r],"",OptionValue[perti],True,sciezka];),
		
	(rozwiazaniaP=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,
		OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",OptionValue[perti]];
	rozwiazaniaP2=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw2,
		OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",OptionValue[perti]];)];

(* baza *)
bazatf=Which[
	OptionValue[baza]=="F", 
	((* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
	dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];
	(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
	mrkIzoKrzywizna`bazaFrenetaTest[{polao,Go},dd\[Phi]N0,x,rozwiazania0,tf,fun,param]),
	
	OptionValue[baza]=="M",
	mrkLagrange`bazaMasyTest[g,x,pola,fG,La,rozwiazania0,tf,fun,param]];

(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
rozwiazaniaRS=mrkRozwiazania`przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x,Xo,rozwiazaniaP,bazatf,Go,fun,param];
rozwiazaniaRS2=mrkRozwiazania`przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x,Xo,rozwiazaniaP2,bazatf,Go,fun,param];

(* widma mocy perturbacji *)
widma=mrkRozwiazania`widmaRozw[rozwiazaniaRS,kw,1];
widma2=mrkRozwiazania`widmaRozw[rozwiazaniaRS2,kw2,1];

(* indeks spektralny n_s dla perturbacji krzywizny i izokrzywizny *)
indeks=mrkRozwiazania`indeksn[x,widma[[2]],widma2[[2]],kw,kw2,tf,rozwiazania0];

(* wzmocnienie perturbacji krzywizny *)
ww=Map[{kw/kwNorm, indeks[[#]]} &, OptionValue[nrwidm]];
Sow[ww];,
{i,1,lNkw}]][[2,1]]]];,
{j,1,lrozw}]][[2,1]];

Export[FileNameJoin[{sciezka,StringJoin["ns_",ToString[lp],".txt"]}],ns];

(* tytu\[LSlash] wykresu *)
tytul=mrkWykresy`tytulWykresu[param];
(* wykres eksportowany do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyIndeksSpektralny[ns,lp,OptionValue[baza],tytul,sciezka,OptionValue[nrwidm]];)]


(*(* domy\:015blne opcje funkcji IndeksSpektralnyB *)
Options[IndeksSpektralnyB]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{"N",0.}, Nkw2->{"N",0.001}, baza->"F", perti->"M"};

(* indeks spektralny n_s dla perturbacji krzywizny i izokrzywizny *)
IndeksSpektralnyB[pola_,fG_,La_,g_,x_,fR_,wp_,listatf_,fun_:{},param_:{},OptionsPattern[]]:=
(*IndeksSpektralnyB[pola,fG,La,g,x,fR,wp,listatf,fun,param,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],
	OptionValue[MS],OptionValue[r],OptionValue[Nkw],OptionValue[Nkw2],OptionValue[baza],OptionValue[perti]]=*)
Block[{tf,polao,Go,Xo,kw,kw2,rozwiazania0,rozwiazania02,rozwiazaniaP,rozwiazaniaP2,bazatf,dd\[Phi]N0,
rozwiazaniaRS,rozwiazaniaRS2,widma,widma2,indeks},(
tf=Last[listatf];
(* tensor metryczny w przestrzeni p\[OAcute]l oraz cz\[LSlash]on kinetyczny *)
{polao,Go,Xo}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],3]/.{Symbol["P"]->0}/.fun/.param;
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kw=Which[OptionValue[Nkw][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[2]]], 
		 OptionValue[Nkw][[1]]=="kw", OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="", -1];
kw2=Which[OptionValue[Nkw2][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw2][[2]]], 
		  OptionValue[Nkw2][[1]]=="kw", OptionValue[Nkw2][[2]],
		  OptionValue[Nkw2][[1]]=="", -1];
		  
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
If[Length[listatf]>1,
	({rozwiazania0,rozwiazaniaP}=RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,OptionValue[N0],wp,listatf,kw,
		OptionValue[N0P],OptionValue[wpP],fun,param,OptionValue[MS],OptionValue[r],"",OptionValue[perti]];
	{rozwiazania02,rozwiazaniaP2}=RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,OptionValue[N0],wp,listatf,kw2,
		OptionValue[N0P],OptionValue[wpP],fun,param,OptionValue[MS],OptionValue[r],"",OptionValue[perti]];),
		
	(rozwiazaniaP=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,
		OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",OptionValue[perti]];
	rozwiazaniaP2=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw2,
		OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",OptionValue[perti]];)];
		
(* baza *)
bazatf=Which[
	OptionValue[baza]=="F", 
	((* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
	dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];
	(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
	mrkIzoKrzywizna`bazaFrenetaTest[{polao,Go},dd\[Phi]N0,x,rozwiazania0,tf,fun,param]),
	
	OptionValue[baza]=="M",
	mrkLagrange`bazaMasyTest[g,x,pola,fG,La,rozwiazania0,tf,fun,param]];

(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
rozwiazaniaRS=mrkRozwiazania`przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x,Xo,rozwiazaniaP,bazatf,Go,fun,param];
rozwiazaniaRS2=mrkRozwiazania`przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x,Xo,rozwiazaniaP2,bazatf,Go,fun,param];

(* widma mocy perturbacji *)
widma=mrkRozwiazania`widmaRozw[rozwiazaniaRS,kw,1];
widma2=mrkRozwiazania`widmaRozw[rozwiazaniaRS2,kw2,1];

(* indeks spektralny n_s dla perturbacji krzywizny i izokrzywizny *)
indeks=mrkRozwiazania`indeksn[x,widma[[2]],widma2[[2]],kw,kw2,tf,rozwiazania0];
{kw,kw2,kw-kw2,indeks})]*)


(* domy\:015blne opcje funkcji Wzmocnienie *)
Options[Wzmocnienie]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{"N",0.}, NkwNorm->0., perti->"M"};

(* wzmocnienie widma perturbacji krzywizny (ko\:0144cowa warto\:015b\[CAcute] widma znormalizowanego do widma jednego pola) *)
Wzmocnienie[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},OptionsPattern[]]:=
Wzmocnienie[pola,fG,La,g,x,fR,wp,tf,fun,param,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],
	OptionValue[MS],OptionValue[r],OptionValue[Nkw],OptionValue[NkwNorm],OptionValue[perti]]=
Block[{rozwiazania0,kwNorm,kw,widma},(
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kwNorm=If[MemberQ[{"wsp",""}, OptionValue[Nkw][[1]]], 
	mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[NkwNorm]], 1];

kw=Which[OptionValue[Nkw][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[2]]], 
		 OptionValue[Nkw][[1]]=="kw", OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="wsp", kwNorm*OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="", -1];

(* widma mocy perturbacji *)
widma=RozwiazanieWidma[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,kwNorm,OptionValue[NkwNorm],
	OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"h",0.,"F",OptionValue[perti]];

(* ko\:0144cowa warto\:015b\[CAcute] widma perturbacji krzywizny *)
mrkRozwiazania`wzmocnienie[x,widma[[2,1]],tf,rozwiazania0])]


(* domy\:015blne opcje funkcji WzmocnienieB *)
Options[WzmocnienieB]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{{"N",0.}}, NkwNorm->{0.}, baza->"F", perti->"M", nrwidm->{1}, legenda->{}};

(* wzmocnienie widma perturbacji krzywizny (ko\:0144cowa warto\:015b\[CAcute] widma znormalizowanego do widma jednego pola) *)
WzmocnienieB[pola_,fG_,La_,g_,x_,fR_,wp_,listatf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*WzmocnienieB[pola,fG,La,g,x,fR,wp,listatf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],
	OptionValue[MS],OptionValue[r],OptionValue[Nkw],OptionValue[NkwNorm],OptionValue[baza],OptionValue[perti],OptionValue[nrwidm],OptionValue[legenda]]=*)
Block[{lrozw,lNkw,lp,tf,polao,Go,Xo,kwNorm,normalizacja,kw,rozwiazania0,rozwiazania02,rozwiazaniaP,bazatf,dd\[Phi]N0,
rozwiazaniaRS,widma,wzmoc,tytul,ww,tf2,nazwa},(
lrozw=Length[listatf]; lNkw=Length[OptionValue[Nkw]];
(* liczby podzia\[LSlash]\[OAcute]w *)
lp=Map[Length, listatf]-1;
(* tensor metryczny w przestrzeni p\[OAcute]l oraz cz\[LSlash]on kinetyczny *)
{polao,Go,Xo}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],3]/.{Symbol["P"]->0}/.fun/.param;

wzmoc=Reap[Do[
Print[TimeObject[Now],"Rozwi\:0105zanie ",j];
tf=Last[listatf[[j]]];
tf2=2.5*10^6;
tf2=tf;

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf2,fun,param];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kwNorm=mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[NkwNorm][[j]]];
(* normalizacja *)
normalizacja=NormalizacjaWidmaKorelacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf2,fun,param,kwNorm,OptionValue[NkwNorm][[j]],"h",0.,"R"];

Sow[Transpose[Reap[Do[
(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kw=Which[OptionValue[Nkw][[i]][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[i]][[2]]], 
		 OptionValue[Nkw][[i]][[1]]=="kw", OptionValue[Nkw][[i]][[2]],
		 OptionValue[Nkw][[i]][[1]]=="wsp", kwNorm*OptionValue[Nkw][[i]][[2]]];
		  
(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
If[Length[listatf[[j]]]>1,
	(nazwa=If[OptionValue[Nkw][[i]][[1]]=="wsp", ToString[NumberForm[OptionValue[Nkw][[i]][[2]],"NumberPoint"->","]], 
			ToString[NumberForm[N[kw/kwNorm], {3,3}, "NumberPoint"->","]]];
	{rozwiazania0,rozwiazaniaP}=RozwiazanieProdukcjaCzastek[pola,fG,La,g,x,fR,OptionValue[N0],wp,listatf[[j]],kw,
		OptionValue[N0P],OptionValue[wpP],fun,param,OptionValue[MS],OptionValue[r],"",OptionValue[perti],True,sciezka,nazwa];),
		
	(rozwiazaniaP=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,
		OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",OptionValue[perti]];)];
		
(* baza *)
bazatf=Which[
	OptionValue[baza]=="F", 
	((* lista podstawie\:0144 drugich pochodnych pierwotnych p\[OAcute]l wyznaczonych z r\[OAcute]wna\:0144 ruchu dla t\[LSlash]a *)
	dd\[Phi]N0=ddpolaN0f[g,x,pola,fG,La];
	(* baza Freneta - ortonormalna baza w przestrzeni p\[OAcute]l zorientowana kanonicznie *)
	mrkIzoKrzywizna`bazaFrenetaTest[{polao,Go},dd\[Phi]N0,x,rozwiazania0,tf,fun,param]),
	
	OptionValue[baza]=="M",
	mrkLagrange`bazaMasyTest[g,x,pola,fG,La,rozwiazania0,tf,fun,param]];

(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
rozwiazaniaRS=mrkRozwiazania`przejscieQ\[ScriptCapitalR]\[ScriptCapitalS][x,Xo,rozwiazaniaP,bazatf,Go,fun,param];

(* widma mocy perturbacji *)
widma=mrkRozwiazania`widmaRozw[rozwiazaniaRS,kw,normalizacja];

(* wzmocnienie perturbacji krzywizny *)
ww=Map[{kw/kwNorm, mrkRozwiazania`wzmocnienie[x,widma[[2,#]],tf,rozwiazania0]} &, OptionValue[nrwidm]];
Sow[ww];,
{i,1,lNkw}]][[2,1]]]];,
{j,1,lrozw}]][[2,1]];

Map[Export[FileNameJoin[{sciezka,StringJoin["wzmoc_",ToString[lp[[#]]],".txt"]}], wzmoc[[#]], "Table", "FieldSeparators" -> " "] &, Range[lrozw]];

(* tytu\[LSlash] wykresu *)
tytul=mrkWykresy`tytulWykresu[param];
(* wykres eksportowany do plik\[OAcute]w .pdf *)
mrkWykresy`wykresyWzmocnienie[wzmoc,lp,OptionValue[baza],tytul,sciezka,OptionValue[nrwidm],OptionValue[legenda]];)]


(* domy\:015blne opcje funkcji LiczbaObsadzen *)
Options[LiczbaObsadzen]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{"N",0.}, NkwNorm->0., zakrest->{}, perti->"M", FT->True};

(* zale\:017cno\:015bci liczby obsadze\:0144 od liczby e-powi\:0119ksze\:0144 lub liczby falowej *)
LiczbaObsadzen[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*LiczbaObsadzen[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],OptionValue[MS],
	OptionValue[r],OptionValue[Nkw],OptionValue[NkwNorm],OptionValue[zakrest],OptionValue[perti],OptionValue[FT]]=*)
Block[{Go,Xo,Lao,rozwiazania0,kwNorm,kw,rozwiazaniaP,masa,tytul,t1,t2},(
(* tensor metryczny w przestrzeni p\[OAcute]l, cz\[LSlash]on kinetyczny i lagran\:017cjan z polami podzielonymi na t\[LSlash]o i perturbacje*)
{Go,Xo,Lao}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2,4}]/.{Symbol["P"]->0}/.fun/.param;

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kwNorm=If[MemberQ[{"wsp",""}, OptionValue[Nkw][[1]]], 
	mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[NkwNorm]], 1];

kw=Which[OptionValue[Nkw][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[2]]], 
		 OptionValue[Nkw][[1]]=="kw", OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="wsp", kwNorm*OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="", -1];

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
rozwiazaniaP=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,
	OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",OptionValue[perti]];

(* macierzy masy *)	
masa=MacierzMasy[g,x,pola,fG,La]/.fun/.param;

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
If[kw==-1,
	((* czas, dla kt\[OAcute]rego ma zosta\[CAcute] wyrysowana liczba obsadze\:0144 *)
	{t1}=If[OptionValue[zakrest]=={}, {tf}, OptionValue[zakrest]];
	mrkWykresy`wykresyLiczbaObsadzenk[x,pola,La,{Go,Xo,Lao},rozwiazania0,rozwiazaniaP,masa,t1,kwNorm,tytul,sciezka];),
	((* zakres czasu dla liczby obsadze\:0144 *)
	{t1,t2}=If[OptionValue[zakrest]=={}, {0,tf}, OptionValue[zakrest]];
	mrkWykresy`wykresyLiczbaObsadzenN[x,pola,La,{Go,Xo,Lao},rozwiazania0,rozwiazaniaP,masa,t1,t2,kw,tytul,sciezka];)];)]


(* domy\:015blne opcje funkcji LiczbaObsadzen *)
Options[LiczbaObsadzen]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, Nkw->{"N",0.}, NkwNorm->0., zakrest->{}, perti->"M", FT->True};

(* zale\:017cno\:015bci liczby obsadze\:0144 od liczby e-powi\:0119ksze\:0144 lub liczby falowej *)
LiczbaObsadzen[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*LiczbaObsadzen[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],OptionValue[MS],
	OptionValue[r],OptionValue[Nkw],OptionValue[NkwNorm],OptionValue[zakrest],OptionValue[perti],OptionValue[FT]]=*)
Block[{Go,Xo,Lao,rozwiazania0,kwNorm,kw,rozwiazaniaP,masa,tytul,t1,t2},(
(* tensor metryczny w przestrzeni p\[OAcute]l, cz\[LSlash]on kinetyczny i lagran\:017cjan z polami podzielonymi na t\[LSlash]o i perturbacje*)
{Go,Xo,Lao}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2,4}]/.{Symbol["P"]->0}/.fun/.param;

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];

(* warto\:015b\[CAcute] wsp\[OAcute]\[LSlash]poruszaj\:0105cego si\:0119 wektora falowego, odpowiadaj\:0105ca podanej liczbie e-powi\:0119ksze\:0144, w momencie przekraczania promienia Hubble'a: k=aH;
przyj\:0119to normalizacj\:0119 a=1 dla N=0 (a_0=Exp(N_0)), wi\:0119c a=a_0*Exp(N-N_0)=Exp(N) *)
kwNorm=If[MemberQ[{"wsp",""}, OptionValue[Nkw][[1]]], 
	mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[NkwNorm]], 1];

kw=Which[OptionValue[Nkw][[1]]=="N", mrkRozwiazania`wektorFalowy[x,rozwiazania0,OptionValue[Nkw][[2]]], 
		 OptionValue[Nkw][[1]]=="kw", OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="wsp", kwNorm*OptionValue[Nkw][[2]],
		 OptionValue[Nkw][[1]]=="", -1];

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
rozwiazaniaP=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,kw,
	OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",OptionValue[perti]];

(* macierzy masy *)	
masa=MacierzMasy[g,x,pola,fG,La]/.fun/.param;

(* tytu\[LSlash] wykres\[OAcute]w *)
tytul=mrkWykresy`tytulWykresu[param];
(* wykresy eksportowane do plik\[OAcute]w .pdf *)
If[kw==-1,
	((* czas, dla kt\[OAcute]rego ma zosta\[CAcute] wyrysowana liczba obsadze\:0144 *)
	{t1}=If[OptionValue[zakrest]=={}, {tf}, OptionValue[zakrest]];
	mrkWykresy`wykresyLiczbaObsadzenk[x,pola,La,{Go,Xo,Lao},rozwiazania0,rozwiazaniaP,masa,t1,kwNorm,tytul,sciezka];),
	((* zakres czasu dla liczby obsadze\:0144 *)
	{t1,t2}=If[OptionValue[zakrest]=={}, {0,tf}, OptionValue[zakrest]];
	mrkWykresy`wykresyLiczbaObsadzenN[x,pola,La,{Go,Xo,Lao},rozwiazania0,rozwiazaniaP,masa,t1,t2,kw,tytul,sciezka];)];)]


(* domy\:015blne opcje funkcji GestoscEnergiiCzastekTest *)
Options[GestoscEnergiiCzastekTest]={N0->-8., N0P->-8., wpP->{}, MS->True, r->1, t0->0., perti->"M", FT->True};

(* zale\:017cno\:015bci g\:0119sto\:015bci energii wyprodukowanych cz\:0105stek w danej chwili dla mod\[OAcute]w aH<k<am *)
GestoscEnergiiCzastekTest[pola_,fG_,La_,g_,x_,fR_,wp_,tf_,fun_:{},param_:{},sciezka_:Directory[],OptionsPattern[]]:=
(*GestoscEnergiiCzastekTest[pola,fG,La,g,x,fR,wp,tf,fun,param,sciezka,OptionValue[N0],OptionValue[N0P],OptionValue[wpP],
	OptionValue[MS],OptionValue[r],OptionValue[t0],OptionValue[perti],OptionValue[FT]]=*)
Block[{Go,Xo,Lao,rozwiazania0,rozwiazaniaPk,masa},(
(* cz\[LSlash]on kinetyczny i lagran\:017cjan z polami podzielonymi na t\[LSlash]o i perturbacje*)
{Go,Xo,Lao}=Take[mrkLagrange`lagrangianO[g,x,pola,fG,La],{2,4}]/.{Symbol["P"]->0}/.fun/.param;

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla t\[LSlash]a dla danych warto\:015bci pocz\:0105tkowych *)
rozwiazania0=RozwiazanieTlo[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param];

(* rozwi\:0105zania r\[OAcute]wna\:0144 dla perturbacji (liczba przebieg\[OAcute]w = liczba zestaw\[OAcute]w warto\:015bci pocz\:0105tkowych): {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
rozwiazaniaPk=RozwiazaniePerturbacje[pola,fG,La,g,x,fR,OptionValue[N0],wp,tf,fun,param,-1,
	OptionValue[N0P],OptionValue[wpP],OptionValue[MS],OptionValue[r],"",OptionValue[perti]];

(* macierzy masy *)	
masa=MacierzMasy[g,x,pola,fG,La]/.fun/.param;

(* g\:0119sto\:015bci energii wyprodukowanych cz\:0105stek dla mod\[OAcute]w aH<k<am *)
mrkProdukcjaCzastek`gestoscEnergiiCzastekTest[x,La,{Go,Xo,Lao},rozwiazania0,rozwiazaniaPk,masa,OptionValue[t0]])]


End[];
EndPackage[];


(* ::Input:: *)
(* *)
(**)
(**)
(**)
(**)
