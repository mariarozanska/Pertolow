(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkWykresy`*)


(* :Title: Rysowanie wykres\[OAcute]w *)

(* :Context: mrkWykresy` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
wykresy dla t\[LSlash]a
wykresy dla perturbacji
wykresy paramtr\[OAcute]w/H^2
wykresy mas
wykresy element\[OAcute]w bazy
wykresy liczby obsadze\:0144
*)

(* :Copyright: *)
 
(* :Package Version: 1.3 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 09.11.2016
    Version 1.1, 10.04.2017
      - dodanie argumentu ti do wykres\[OAcute]w perturbacji
      - rysowanie element\[OAcute]w bazy
      - rysowanie r\[OAcute]\:017cnych funkcji z\[LSlash]o\:017conych z rozwi\:0105za\:0144 dla t\[LSlash]a
      - rysowanie widm w zale\:017cno\:015bci od k
      - rysowanie widm dla konkretnych przebieg\[OAcute]w
    Version 1.2, 09.05.2017
      - rysowanie mas
      - rysowanie element\[OAcute]w bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy
    Version 1.3, 20.07.2017
      - rysowanie liczby obsadze\:0144 zale\:017cnej od czasu i od liczby falowej
      - rysowanie pr\:0119dko\:015bci k\:0105towych dla bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy
*)

(* :Keywords: *)

(* :Requirements: 
"mrkUzyteczny`"
*)

(* :Sources: *)

(* :Warnings: 
wykresyMasa[], wykresyBazaMasy[], wykresyLiczbaObsadzenN[], wykresyLiczbaObsadzenk[], wykresyParametrowBazaMasy[]: 
czy kolejno\:015b\[CAcute] wektor\[OAcute]w w\[LSlash]asnych macierzy masy b\:0119dzie zawsze prawid\[LSlash]owa? (za\[LSlash]o\:017cono, \:017ce najwi\:0119ksze warto\:015bci w macierzy wektor\[OAcute]w w\[LSlash]asnych wyst\:0119puj\:0105 na diagonali lub \:017ce najwi\:0119ksze warto\:015bci w macierzy wektor\[OAcute]w w\[LSlash]asnych wyst\:0119puj\:0105 tam, gdzie w bazie Freneta)
*)

(* :Limitations:
*)

(* :Discussion: 
- liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn
- liczba falowa musi by\[CAcute] oznaczona przez kk
*)



BeginPackage["mrkWykresy`",{"mrkUzyteczny`"}];

tytulWykresu::usage="tytulWykresu[param,indn:'n']: 
param - lista podstawie\:0144 parametr\[OAcute]w,
indn - warto\:015b\[CAcute] indeksu spektralnego n;
wyj\:015bcie: string w formie 'nazwa_param1=warto\:015b\[CAcute]_param1  nazwa_param2=warto\:015b\[CAcute]_param2...  n_s=indn'";

wykresyTlo::usage="wykresyTlo[pola,x,rozwiazania0,tytul:'',sciezka:Directory[]]: 
pola - lista nazw p\[OAcute]l, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a {pola(t),N(t)} (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn), 
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - trajektorie inflacyjne w przestrzeni p\[OAcute]l (gdy jedno pole, to wykres pole(N))";

wykresyPochodne::usage="wykresyTlo[pola,x,Xo,rozwiazania0,tytul:'',sciezka:Directory[]]: 
pola - lista nazw p\[OAcute]l, 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
Xo - cz\[LSlash]on kinetyczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a {pola(t),N(t)} (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn), 
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
tytul - tytu\[LSlash] wykres\[OAcute]w (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - pochodne p\[OAcute]l w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 (oddzielne wykresy)";

wykresyPerturbacje::usage="wykresyPerturbacje[x,Go,Xo,rozwiazania0,rozwiazaniaP,masa,ti,tf,kw,norma:1,tytul:'',sciezka:Directory[],norm:'']: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
Go - tensor metryczny w przestrzeni p\[OAcute]l,
Xo - cz\[LSlash]on kinetyczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
rozwiazaniaP - rozwi\:0105zania dla perturbacji dla dowolnej liczby przebieg\[OAcute]w w formie {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(1\)]\),...},{\!\(\*SubscriptBox[\(Q1\), \(2\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...} (uwaga! to musz\:0105 by\[CAcute] same rozwi\:0105zania, a nie lista podstawie\:0144),
masa - macierz masy,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
kw - liczba falowa,
norma - normalizacja widm,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
norm - spos\[OAcute]b normalizacji;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci widm w bazie wektor\[OAcute]w w\[LSlash]asnych macierzy masy od liczby e-powi\:0119ksze\:0144";

wykresyWidma::usage="wykresyWidma[x,rozwiazania0,widma,ti,tf,tytul:'',sciezka:Directory[],norm:'']: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
widma - lista widm mocy,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
norm - spos\[OAcute]b normalizacji;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci widm od liczby e-powi\:0119ksze\:0144";

wykresyPerturbacjeB::usage="wykresyPerturbacjeB[x,Go,Xo,rozwiazania0,rozwiazaniaP,masa,ti,tf,kw,norma:1,tytul:'',sciezka:Directory[],norm:'']: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
Go - tensor metryczny w przestrzeni p\[OAcute]l,
Xo - cz\[LSlash]on kinetyczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
rozwiazaniaP - rozwi\:0105zania dla perturbacji dla dowolnej liczby przebieg\[OAcute]w w formie {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(1\)]\),...},{\!\(\*SubscriptBox[\(Q1\), \(2\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...} (uwaga! to musz\:0105 by\[CAcute] same rozwi\:0105zania, a nie lista podstawie\:0144),
masa - macierz masy,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
kw - liczba falowa,
norma - normalizacja widm,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
norm - spos\[OAcute]b normalizacji;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci widm w bazie wektor\[OAcute]w w\[LSlash]asnych macierzy masy od liczby e-powi\:0119ksze\:0144";

wykresyWidmaB::usage="wykresyWidmaMB[x,Go,Xo,rozwiazania0,rozwiazaniaP,masa,ti,tf,kw,norma:1,tytul:'',sciezka:Directory[],norm:'']: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
Go - tensor metryczny w przestrzeni p\[OAcute]l,
Xo - cz\[LSlash]on kinetyczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
rozwiazaniaP - rozwi\:0105zania dla perturbacji dla dowolnej liczby przebieg\[OAcute]w w formie {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(1\)]\),...},{\!\(\*SubscriptBox[\(Q1\), \(2\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...} (uwaga! to musz\:0105 by\[CAcute] same rozwi\:0105zania, a nie lista podstawie\:0144),
masa - macierz masy,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
kw - liczba falowa,
norma - normalizacja widm,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
norm - spos\[OAcute]b normalizacji;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci widm w bazie wektor\[OAcute]w w\[LSlash]asnych macierzy masy od liczby e-powi\:0119ksze\:0144";

wykresyWidmaPrzebiegi::usage="wykresyWidmaPrzebiegi[x,rozwiazania0,widma,ti,tf,tytul:'',sciezka:Directory[],norm:'']: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
widma - lista widm mocy,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
norm - spos\[OAcute]b normalizacji;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci widm dla poszczeg\[OAcute]lnych przebieg\[OAcute]w od liczby e-powi\:0119ksze\:0144";

wykresyWidmak::usage="wykresyWidmak[x,rozwiazania0,widmak,t,kwNorm:1,norm:1,tytul:'',sciezka:Directory[]]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
widmak - lista widm mocy z liczb\:0105 falow\:0105 jako parametrem (uwaga! liczba falowa musi by\[CAcute] oznaczona przez kk),
t - warto\:015b\[CAcute] czasu, dla kt\[OAcute]rej maj\:0105 zosta\[CAcute] narysowane widma,
kwNorm - liczba falowa, kt\[OAcute]ra zostanie wykorzystana do przeskalowania osi x,
norm - spos\[OAcute]b normalizacji widma,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci widm od liczby falowej (k/kwNorm)";

wykresyWidmakB::usage="wykresyWidmakB[x,Go,Xo,rozwiazania0,rozwiazaniaP,masa,tf,kwNorm,norma:1,tytul:'',sciezka:Directory[],norm:'']: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
Go - tensor metryczny w przestrzeni p\[OAcute]l,
Xo - cz\[LSlash]on kinetyczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
rozwiazaniaP - rozwi\:0105zania dla perturbacji dla dowolnej liczby przebieg\[OAcute]w w formie {{\!\(\*SubscriptBox[\(Q1\), \(1\)]\),\!\(\*SubscriptBox[\(Q2\), \(1\)]\),...},{\!\(\*SubscriptBox[\(Q1\), \(2\)]\),\!\(\*SubscriptBox[\(Q2\), \(2\)]\),...},...} (uwaga! to musz\:0105 by\[CAcute] same rozwi\:0105zania, a nie lista podstawie\:0144),
masa - macierz masy,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
kwNorm - liczba falowa, kt\[OAcute]ra zostanie wykorzystana do przeskalowania osi x,
norma - normalizacja widm,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
norm - spos\[OAcute]b normalizacji;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci widm w bazie wektor\[OAcute]w w\[LSlash]asnych macierzy masy od liczby falowej (k/kwNorm)";

wykresyWzmocnienie::usage="wykresyWzmocnienie[wzmoc,lp,Tbaza,tytul:'',sciezka:Directory[]]: 
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
norm - spos\[OAcute]b normalizacji;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci wzmocnienia perturbacji krzywizny od liczby falowej (k/kwNorm)";

wykresyIndeksSpektralny::usage="wykresyIndeksSpektralny[wzmoc,lp,Tbaza,tytul:'',sciezka:Directory[]]: 
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
norm - spos\[OAcute]b normalizacji;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci wzmocnienia perturbacji krzywizny od liczby falowej (k/kwNorm)";

wykresyKorelacjeU::usage="wykresyKorelacjeU[x,rozwiazania0,korelacjeU,ti,tf,tytul:'',sciezka:Directory[]]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
korelacjeU - lista wszystkich wzgl\:0119dnych korelacji,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci wzgl\:0119dnych korelacji od liczby e-powi\:0119ksze\:0144";

wykresyKorelacje::usage="wykresyKorelacje[x,rozwiazania0,korelacje,ti,tf,tytul:'',sciezka:Directory[],norm:'']: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0N - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
korelacje - lista wszystkich korelacji,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy,
norm - spos\[OAcute]b normalizacji;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci korelacji od liczby e-powi\:0119ksze\:0144";

wykresyParametrow::usage="wykresyParametrow[x,rozwiazania0,zmienne,nazwyzm,ti,tf,plik:'',osy:'',sciezka:Directory[]]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
zmienne - lista funkcji do narysowania,
nazwyzm - lista nazw zmiennych,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
plik - nazwa wyj\:015bciowego pliku bez rozszerzenia (zostanie dodane H.pdf),
osy - opis osi y,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci zmiennych podzielonych przez parametr Hubble'a od liczby e-powi\:0119ksze\:0144";

wykresyMasa::usage="wykresyMasa[x,rozwiazania0,masa,nazwyzm,baza:{},plik:'M',osy:'',sciezka:Directory[]]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0 - rozwi\:0105zania dla t\[LSlash]a i liczby e-powi\:0119ksze\:0144 (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
masa - macierz masy (lista list),
nazwyzm - lista nazw zmiennych,
baza - baza Freneta wykorzystywana do ustalenia kolejno\:015bci warto\:015bci w\[LSlash]asnych macierzy masy (je\:017celi nie zostanie podana, uporz\:0105dkowanie b\:0119dzie oparte o za\[LSlash]o\:017cenie, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali),
plik - nazwa wyj\:015bciowego pliku bez rozszerzenia (zostanie dodane H.pdf),
osy - opis osi y,
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci mas od liczby e-powi\:0119ksze\:0144: \!\(\*SuperscriptBox[\(m\), \(2\)]\)/\!\(\*SuperscriptBox[\(H\), \(2\)]\)";

wykresyBaza::usage="wykresyBaza[x,rozwiazania0,baza,tytul:'',sciezka:Directory[]]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0 - rozwi\:0105zania dla t\[LSlash]a i liczby e-powi\:0119ksze\:0144 (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
baza - baza (lista list),
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci element\[OAcute]w bazy od liczby e-powi\:0119ksze\:0144 (wierszami E_i oraz kolumnami E^i)";

wykresyBazaMasy::usage="wykresyBazaMasy[x,Go,rozwiazania0,masa,tytul:'',sciezka:Directory[]]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
Go - tensor metryczny w przestrzeni p\[OAcute]l,
rozwiazania0 - rozwi\:0105zania dla t\[LSlash]a i liczby e-powi\:0119ksze\:0144 (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
masa - macierz masy (lista list),
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci element\[OAcute]w bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy od liczby e-powi\:0119ksze\:0144 (wierszami E_i oraz kolumnami E^i)";

wykresyParametrowBazaMasy::usage="wykresyParametrowBazaMasy[x,Go,rozwiazania0,masa,ti,tf,tytul:'',sciezka:Directory[]]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
Go - tensor metryczny w przestrzeni p\[OAcute]l,
rozwiazania0 - rozwi\:0105zania dla t\[LSlash]a i liczby e-powi\:0119ksze\:0144 (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn),
masa - macierz masy (lista list),
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
tytul - tytu\[LSlash] wykresu (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci pr\:0119dko\:015bci k\:0105towych bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy od liczby e-powi\:0119ksze\:0144";

wykresyLiczbaObsadzenN::usage="wykresyLiczbaObsadzenN[x,pola,La,listao,rozwiazania0,rozwiazaniaP,masa,ti,tf,kw,tytul:'',sciezka:Directory[]]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
pola - nazwy p\[OAcute]l,
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
listao - metryka w przestrzeni p\[OAcute]l, cz\[LSlash]on kinetyczny i lagran\:017cjan z polami podzielonymi na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P; mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn), 
rozwiazaniaP - lista rozwi\:0105za\:0144 dla perturbacji,
masa - macierz masy,
ti - pocz\:0105tkowa warto\:015b\[CAcute] czasu,
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
kw - liczba falowa, odpowiadaj\:0105ca perturbacjom,
tytul - tytu\[LSlash] wykres\[OAcute]w (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci liczb obsadze\:0144 od liczby e-powi\:0119ksze\:0144";

wykresyLiczbaObsadzenk::usage="wykresyLiczbaObsadzenk[x,pola,La,listao,rozwiazania0,rozwiazaniaP,masa,t0,kwNorm,tytul:'',sciezka:Directory[]]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
pola - nazwy p\[OAcute]l,
La - lagran\:017cjan zapisany bez argument\[OAcute]w przy polach z cz\[LSlash]onem kinetycznym XK i ew. potencja\[LSlash]em w formie V[Sequence@@pola],
listao - metryka w przestrzeni p\[OAcute]l, cz\[LSlash]on kinetyczny i lagran\:017cjan z polami podzielonymi na t\[LSlash]o i perturbacje (uwaga! perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P; mo\:017cna znale\:017a\[CAcute], korzystaj\:0105c z mrkLagrange`lagrangianO),
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn), 
rozwiazaniaP - lista rozwi\:0105za\:0144 dla perturbacji z liczb\:0105 falow\:0105 jako parametrem (uwaga! liczba falowa musi by\[CAcute] oznaczona przez kk),
masa - macierz masy,
t0 - czas kosmiczny, w kt\[OAcute]rym ma zosta\[CAcute] wyrysowana liczba obsadze\:0144,
kwNorm - liczba falowa, kt\[OAcute]ra zostanie wykorzystana do przeskalowania osi x,
tytul - tytu\[LSlash] wykres\[OAcute]w (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - zale\:017cno\:015bci liczb obsadze\:0144 od liczby falowej (k/kwNorm)";

wykresyTestoweTlo::usage="wykresyTestoweTlo[funkcje,x,rozwiazania0,tf,opisy,tytul:'',sciezka:Directory[]]: 
funkcje - lista list funkcji z\[LSlash]o\:017conych z rozwi\:0105za\:0144 dla t\[LSlash]a - funkcje z jednej listy b\:0119d\:0105 rysowane na jednym wykresie (np. {{f1,f2},{g1}}), 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny,
rozwiazania0 - lista rozwiaza\:0144 r\[OAcute]wna\:0144 ruchu t\[LSlash]a (uwaga! liczba e-powi\:0119ksze\:0144 musi by\[CAcute] oznaczona przez nn), 
tf - ko\:0144cowa warto\:015b\[CAcute] czasu,
opisy - lista opis\[OAcute]w funkcji w formie np. {{nazwaf, {nf1,nf2}}, {nazwag,{ng1}}} - pierwsza warto\:015b\[CAcute] zostanie u\:017cyta do nadania nazwy osi y i pliku, a druga warto\:015b\[CAcute] (lista) do utworzenia legendy (uwaga! opis\[OAcute]w musi by\[CAcute] tyle samo, co funkcji),
tytul - tytu\[LSlash] wykres\[OAcute]w (mo\:017cna poda\[CAcute], korzystaj\:0105c z mrkWykresy`tytulWykresu),
sciezka - \:015bcie\:017cka do miejsca, gdzie maj\:0105 zosta\[CAcute] wyeksportowane wykresy;
wyj\:015bcie: wyeksportowane wykresy - przekazane funkcje w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144";

Begin["`Private`"];


(* ::Section:: *)
(*Pomocnicze funkcje*)


(* tytu\[LSlash] wykresu *)
tytulWykresu[param_,indn_:"n"]:=
tytulWykresu[param,indn]=
Block[{tytul,fs},(
fs=7;
(* parametry *)
tytul=StringJoin[Riffle[Table[ToString[param[[i,1]], TraditionalForm]<>"="<>
	(*ToString[ScientificForm[If[Element[param[[i,2]],Rationals],N[param[[i,2]]],param[[i,2]]], 2, NumberMultiplier->"*"], TraditionalForm],*)
	ToString[ScientificForm[If[Element[param[[i,2]],Rationals],N[param[[i,2]]],param[[i,2]]], 3], TraditionalForm],
	{i,1,Length[param]}], "  "]];
(* indeks spektralny *)
Style[If[ToString[indn]=="n", tytul,
	StringJoin[tytul, "  \!\(\*SubscriptBox[StyleBox[\"n\",\nFontSlant->\"Italic\"], \(s\)]\)=", ToString[NumberForm[indn, {Infinity,3}]]]],fs])]


(* nazwy perturbacji *)
nazwyPerturbacji[pola_,pertu_,Tbaza_,RS_]:=
nazwyPerturbacji[pola,pertu,Tbaza,RS]=
Block[{lpol,ozn,nazwy},(
lpol=Length[pola];
ozn=If[pertu, "\!\(\*StyleBox[\"u\",\nFontSlant->\"Italic\"]\)", 
			  "\!\(\*StyleBox[\"Q\",\nFontSlant->\"Italic\"]\)"];

nazwy=Which[Tbaza=="", 
			Table[Subscript[ozn,pola[[i]]],{i,1,lpol}],
			RS, 
			If[pertu, Join[{Subscript[ozn,"\[ScriptCapitalR]"]},Table[Subscript[ozn,Subscript["\[ScriptCapitalS]",ToString[i]]],{i,1,lpol-1}]], 
					  Join[{"\[ScriptCapitalR]"},Table[Subscript["\[ScriptCapitalS]",ToString[i]],{i,1,lpol-1}]]],
			Tbaza=="F", 
			Join[{Subscript[ozn,"\[Sigma]"]},Table[Subscript[ozn,Subscript["s",ToString[i]]],{i,1,lpol-1}]],
			Tbaza=="M", 
			Join[{Subscript[ozn,"\[Sigma]"]},Table[Subscript[ozn,Subscript["s",ToString[i]]],{i,1,lpol-1}]]];
			
Map[TraditionalForm,nazwy])]


(* ::Section:: *)
(*Wykresy dla t\[LSlash]a*)


(* trajektorie inflacyjne w przestrzeni p\[OAcute]l *)
wykresyTlo[pola_,x_,rozwiazania0_,ti_,tf_,tytul_:"",legenda_:{},sciezka_:Directory[]]:=
(*wykresyTlo[pola,x,rozwiazania0,ti,tf,tytul,legenda,sciezka]=*)
Block[{lpol,lrozw,zakres,kolory,N0,Nf,plotN,styl={},pp="",funNi,Nt,punktyt,opcje,polat,plotpola,plotpolam,
minx,dx,punkty,wykres,epilog,lenpt,pp1,pp2,listaN,wyk3d,listat,listaNt,dN,legendaw={},lp,tt,grid},(
lpol=Length[pola]; lrozw=Length[rozwiazania0];
(* opcje wykres\[OAcute]w *)
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality"};
	(*PlotPoints\[Rule]20*)
kolory=ColorData[97,"ColorList"];

(* liczba e-powi\:0119ksze\:0144 oraz liczby przedzia\[LSlash]\[OAcute]w, legenda i styl linii na wykresie *)
plotN=Flatten[Symbol["nn"][x[[1]]]/.rozwiazania0];
Nt=Reap[Do[
If[Head[plotN[[i]]]===Piecewise,
	(* z produkcj\:0105 cz\:0105stek *)
	(funNi=plotN[[i]];
	Sow[Compile[{{t,_Real}}, funNi /. {x[[1]]->t}, RuntimeOptions->"Speed", RuntimeAttributes->{Listable}]];
	lp=Length[plotN[[i,1]]]-1; pp=pp<>"_pp"<>ToString[lp]; AppendTo[styl,Thick];), 
	(* bez produkcji cz\:0105stek *)
	(Sow[plotN[[i]][[0]]]; lp=0; pp=pp<>"_"; AppendTo[styl,Dashed];)];
	AppendTo[legendaw,ToString[lp]];,
{i,1,lrozw}]][[2,1]];
If[lrozw==1 && lp==0, styl[[1]]=Thick];

(* warto\:015b\[CAcute] pocz\:0105tkowa i ko\:0144cowa liczby e-powi\:0119ksze\:0144 *)
{N0,Nf}=Transpose[Map[plotN[[#]] /. {{x[[1]]->ti[[#]]}, {x[[1]]->tf[[#]]}} &, Range[lrozw]]];
(* znajdowanie czas\[OAcute]w odpowiadaj\:0105cych dziesi\:0105tkowym warto\:015bciom liczby e-powi\:0119ksze\:0144 oraz dla pierwszej i ostatniej warto\:015bci (...,0,10,20,...) *)
Print[TimeObject[Now]," Czasy"];
dN=Map[If[#<=10, 0.1, 1] &, Abs[Nf-N0]];
(*listaN=Table[If[dN[[i]]<=10, Range[Floor[N0[[i]]]+1,Ceiling[Nf[[i]]]-1,1],
	Range[Floor[N0[[i]],10]+10,Ceiling[Nf[[i]],10]-10,10]] ,{i,1,lrozw}];*)
listaN=Range[Floor[N0,10]+10,Ceiling[Nf,10]-10,10];
			
(*punktyt=Map[Chop[Solve[(Symbol["nn"][x[[1]]]/.rozwiazania0)==#,x[[1]], WorkingPrecision->5][[1]]] &, listaN];*)
(*punktyt=Map[If[-0.01<Nt[#]<0.01,(Nt[#])] &, Range[0.,tf,(tf-0.)*10^(-6)]];*)
(*punktyt=Join[{{x[[1]]->0.}}, punktyt, {{x[[1]]->tf}}];*)

(* ==========================  czy zawsze dobrze bra\[CAcute] taki krok?  ===========================\[Equal] *)
listat=Map[Range[ti[[#]],tf[[#]],tf[[#]]*10^(-5)] &, Range[lrozw]];
(*listaNt=If[Length[plotN]>1, Map[{#1,#2} &, {Nt[listat],listat}], Map[{Nt[#],#} &,listat]];*)
punktyt=Reap[Do[
	If[Head[plotN[[i]]]===Piecewise, listaNt=Transpose[{Nt[[i]][listat[[i]]], listat[[i]]}];,
		(listaNt=Map[{Nt[[i]][#], #} &, listat[[i]]]);];
		punktyt=Cases[listaNt,{n_,t_} /; MemberQ[listaN[[i]],Floor[n]] :> {x[[1]]->t}];
		punktyt=If[punktyt!={}, Join[{First[punktyt]}, Cases[Partition[punktyt,2,1], {a_,b_} /; Abs[a[[1,2]]-b[[1,2]]]>tf[[i]]*10^(-5)+10^(-6) :> b]], {}];
		(*punktyt={};*)
	Sow[Join[{{x[[1]]->ti[[i]]}},punktyt,If[Round[Nf[[i]],dN]!=Ceiling[Nf[[i]],10*dN]-10*dN,{{x[[1]]->tf[[i]]}},{}]]];,
{i,1,lrozw}]][[2,1]];
lenpt=Map[Length, punktyt];

(* rysowanie wykres\[OAcute]w *)
If[lpol==1, 
	(* przypadek jednego pola - wykres pole(N) *)
	(plotpola=Flatten[pola[[1]][x[[1]]]/.rozwiazania0];
		
	(* opcje wykres\[OAcute]w *)
	Print[TimeObject[Now]," Epilog"];
	minx=Min[N0,Nf];
	dx=Max[Abs[Nf-N0]];
	epilog=Table[{PointSize[Medium], punkty=Point[Table[{Nt[[j]][x[[1]]],plotpola[[j]]}/.punktyt[[j,i]],{i,1,lenpt[[j]]}]],
			Join[{Text[Round[N0[[j]],dN[[j]]] "(start)",{punkty[[1,1,1]]-dx*0.1,punkty[[1,1,2]]}]},
			Table[Text[listaN[[j,i]],{punkty[[1,i+1,1]]-dx*0.04,punkty[[1,i+1,2]]}],{i,1,lenpt[[j]]-2}],
			{Text[Round[Nf[[j]],dN[[j]]] "(end)",{punkty[[1,lenpt[[j]],1]]-dx*0.1,punkty[[1,lenpt[[j]],2]]}]}]}, {j,1,lrozw}];
	
	With[{lopcje=opcje},(
	pp1[t_]:=pp1[t]=plotpola/.{x[[1]]->t};
	Print[TimeObject[Now]," Wykres"];	
	wykres=Show[Map[ParametricPlot[{Nt[[#]][tt],pp1[tt][[#]]}, {tt,ti[[#]],tf[[#]]}, Evaluate[Sequence@@lopcje],
		PlotRange->{{minx+dx*(-0.2),All},All}, Epilog->epilog, PlotStyle->Directive[kolory[[#]],styl[[#]]],
		PlotRange->All, FrameLabel->{"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",pola[[1]]}] &, Range[lrozw]]];
	Export[FileNameJoin[{sciezka,StringJoin["0",pp,".pdf"]}],wykres];)]),
	
	(* przypadek wielu p\[OAcute]l - wykresy w przestrzeni p\[OAcute]l pole1(pole2) *)
	((* opcje wykres\[OAcute]w *)
	Print[TimeObject[Now]," Epilog"];
	polat=Subsets[pola,{2}];
	plotpola=Transpose[Map[{#[[1]][x[[1]]], #[[2]][x[[1]]]} &, polat]/.rozwiazania0];
	(*plotpolam=Map[Abs[Table[(plotpola[[All,All,1]][[#,i]]/.x[[1]]->ti[[i]])-(plotpola[[All,All,1]][[#,i]]/.x[[1]]->tf[[i]]), {i,1,lrozw}]] &, Range[Length[polat]]];*)
	plotpolam=Map[Abs[Table[(plotpola[[All,All,1]][[#,i]]/.punktyt)-Max[(plotpola[[All,All,1]][[#,i]]/.{{x[[1]]->ti[[i]]},{x[[1]]->tf[[i]]}})], {i,1,lrozw}]] &, Range[Length[polat]]];
	(*minx=Map[Min[Table[plotpola[[All,All,1]][[#,i]] /. {{x[[1]]->ti[[i]]}, {x[[1]]->tf[[i]]}},{i,1,lrozw}]] &, Range[Length[polat]]];*)
	minx=Map[Min[Table[plotpola[[All,All,1]][[#,i]] /. punktyt, {i,1,lrozw}]] &, Range[Length[polat]]];
	dx=Map[Max, plotpolam];
	epilog=Table[Map[{PointSize[Medium], punkty=Point[Table[plotpola[[#,j]]/.punktyt[[j,i]],{i,1,lenpt[[j]]}]],
			Join[{Text[Round[N0[[j]],dN[[j]]],{punkty[[1,1,1]]-dx[[#]]*0.06,punkty[[1,1,2]]}]},
			Table[Text[listaN[[j,i]],{punkty[[1,i+1,1]]-dx[[#]]*0.04,punkty[[1,i+1,2]]}],{i,1,lenpt[[j]]-2}],
			{Text[Round[Nf[[j]],dN[[j]]],{punkty[[1,lenpt[[j]],1]]-dx[[#]]*0.06,punkty[[1,lenpt[[j]],2]]}]}]} &, 
			Range[1,Length[plotpola]]], {j,1,lrozw}];
	
	pp1[t_]:=pp1[t]=With[{xt=t}, plotpola[[All,All,1]]/.{x[[1]]->xt}];
	pp2[t_]:=pp2[t]=With[{xt=t}, plotpola[[All,All,2]]/.{x[[1]]->xt}];
		
	(* trajektorie w przestrzeni p\[OAcute]l *)
	With[{lopcje=opcje, zm=x[[1]]},
	Do[Print[TimeObject[Now]," Wykres ",i];
	If[AllTrue[legendaw, #=="0" &] && legenda=={},
	(wykres=Show[Map[ParametricPlot[{pp1[tt][[i,#]],pp2[tt][[i,#]]}, {tt,ti[[#]],tf[[#]]}, Evaluate[Sequence@@lopcje], FrameLabel->polat[[i]],
		PlotRange->{{minx[[i]]+dx[[i]]*(-0.2),All},All}, Epilog->epilog[[#,i]], PlotStyle->Directive[kolory[[#]],styl[[#]],Thickness[0.004]]] &, Range[lrozw]]];),			
	(wykres=Legended[Show[Map[ParametricPlot[{pp1[tt][[i,#]],pp2[tt][[i,#]]}, {tt,ti[[#]],tf[[#]]}, Evaluate[Sequence@@lopcje], FrameLabel->polat[[i]],
		PlotRange->{{minx[[i]]+dx[[i]]*(-0.2),All},All}, Epilog->epilog[[#,i]], PlotStyle->Directive[kolory[[#]],styl[[#]],Thickness[0.004]]] &, Range[lrozw]]], 
		Placed[SwatchLegend[kolory, legendaw, LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
			LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->40]&), LegendLayout->"Column"],{Left,Bottom}]];)];
	Export[FileNameJoin[{sciezka,StringJoin[ToString[i],pp,".pdf"]}],wykres];, {i,1,Length[polat]}];
	
	(* przypadek trzech p\[OAcute]l - wykres w trzech wymiarach *)
	If[lpol==3,
	(Print[TimeObject[Now]," Wykres 3D"];	
	wyk3d=Show[Map[ParametricPlot3D[{plotpola[[1,#,1]],plotpola[[1,#,2]],plotpola[[2,#,2]]}, {zm,ti[[#]],tf[[#]]},
		PlotRange->All, AxesLabel->pola, PlotLabel ->tytul, PerformanceGoal->"Quality", 
		BoxRatios->{1, 1, 1}] &, Range[lrozw]]];
	Export[FileNameJoin[{sciezka,StringJoin["4",pp,".pdf"]}],wyk3d];)];
	];
)];)]


(* pochodne p\[OAcute]l w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 *)
wykresyPochodne[pola_,x_,Xo_,rozwiazania0_,tf_,tytul_:"",sciezka_:Directory[]]:=
wykresyPochodne[pola,x,Xo,rozwiazania0,tf,tytul,sciezka]=
Block[{Nt,opcje,polat,plotpola,energiak,wykres,pp,plotN},(
(* opcje wykres\[OAcute]w *)
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PlotRange->All, PerformanceGoal->"Quality"};

(* skompilowana liczba e-powi\:0119ksze\:0144 *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144"];
plotN=Symbol["nn"][x[[1]]]/.rozwiazania0;
Nt=Compile[{{t,_Real}}, plotN/.{x[[1]]->t}, RuntimeOptions->"Speed"];

(* pochodne p\[OAcute]l *)
polat=Map[#'[x[[1]]] &, pola];
plotpola=polat/.rozwiazania0;
(* energia kinetyczna *)
energiak=Function[t, Xo /. x[[1]]->t /.
	(rozwiazania0 /. x[[1]]->t /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];
 
(* rysowanie wykres\[OAcute]w *)
With[{lim={x[[1]],0.,tf},lopcje=opcje},
Map[pp=Compile[{{t,_Real}}, plotpola[[#]]/.{x[[1]]->t}];
    Print[TimeObject[Now]," Wykres ",#];
	wykres=ParametricPlot[{Nt[x[[1]]],pp[x[[1]]]},lim,Evaluate[Sequence@@lopcje],
		FrameLabel->{"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",polat[[#]]}];
	Export[FileNameJoin[{sciezka,StringJoin["pochodna",ToString[#],".pdf"]}],wykres]; &, Range[1,Length[plotpola]]];

Print[TimeObject[Now]," Wykres energii kinetycznej"];
wykres=ParametricPlot[{Nt[x[[1]]],energiak[x[[1]]]},lim,Evaluate[Sequence@@lopcje],
	FrameLabel->{"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",Subscript["E","k"]}];
Export[FileNameJoin[{sciezka,StringJoin["energiak.pdf"]}],wykres]];	
)]


(* ::Section:: *)
(*Wykresy dla perturbacji*)


(* zale\:017cno\:015bci widm od liczby e-powi\:0119ksze\:0144 *)
wykresyWidma[x_,rozwiazania0_,widma_,ti_,tf_,tytul_:"",sciezka_:Directory[],norm_:"",baza_:"F"]:=
(*wykresyWidma[x,rozwiazania0,widma,ti,tf,tytul,sciezka,norm,baza]=*)
Block[{lwidm,opcje,t0,zakresP,nazwywidm,wykresP,Nt,listaw,osy,framelabel,plotN,kolory,legenda},(
lwidm=Length[widma];
(* opcje wykres\[OAcute]w *)
zakresP=Which[norm=="", All, norm=="h", {All,{-7.,All}}, norm=="t", {All,{-4.,1}}];
t0=ti+10.^(-6);
kolory=ColorData[97,"ColorList"];
osy=If[norm=="", "\[ScriptCapitalP]", "\[ScriptCapitalP]/"<>ToString[Subscript["\[ScriptCapitalP]","*"],TraditionalForm]];
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)", osy};
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality", 
	PlotRange->zakresP, FrameLabel->framelabel, 
	ScalingFunctions->{Identity,"Log"}, 
	AxesOrigin->{0,1},
	(*GridLines\[Rule]{{{0,Black}},{{1,Black}}}, Axes\[Rule]False,*)
	PlotPoints->100, MaxRecursion->6};

(* indeksy przy nazwach widm *)
nazwywidm=If[baza=="", Table["\!\(\*StyleBox[\"Q\",\nFontSlant->\"Italic\"]\)"<>ToString[i],{i,1,lwidm}],
	Join[{"\[ScriptCapitalR]"},Table["\[ScriptCapitalS]"<>ToString[i],{i,1,lwidm-1}]]];
legenda=Map[Subscript["\[ScriptCapitalP]",ToString[nazwywidm[[#]]]] &,Range[lwidm]];

(* kompilacja liczby e-powi\:0119ksze\:0144 i funkcje widm mocy *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144 i widma"];
plotN=Symbol["nn"][x[[1]]]/.rozwiazania0;
Nt=Compile[{{t,_Real}}, plotN/.{x[[1]]->t}, RuntimeOptions->"Speed"];

listaw[t_]:=listaw[t]=With[{xt=t}, widma /. x[[1]]->xt /.
	(rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];

With[{lim={x[[1]],t0,tf},lopcje=opcje},
(* rysowanie widm *)
Print[TimeObject[Now]," Wykres widm"];
wykresP=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listaw[x[[1]]][[#]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lwidm]]], Placed[SwatchLegend[kolory, legenda, LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.17,0.2}]];
Export[FileNameJoin[{sciezka,"PN.pdf"}],wykresP];];
)]


(* zale\:017cno\:015bci widm od liczby e-powi\:0119ksze\:0144 *)
wykresyWidmaPrzebiegi[x_,rozwiazania0_,widma_,ti_,tf_,tytul_:"",sciezka_:Directory[],norm_:"",baza_:"F"]:=
(*wykresyWidmaPrzebiegi[x,rozwiazania0,widma,ti,tf,tytul,sciezka,norm,baza]=*)
Block[{lwidm,opcje,t0,zakresP,nazwywidm,wykresP,Nt,listaw,osy,framelabel,plotN,kolory,legenda},(
lwidm=Length[widma];
(* opcje wykres\[OAcute]w *)
zakresP=Which[norm=="", All, norm=="h", {All,{-7.,All}}, norm=="t", {All,{-5.,1}}];
t0=ti+10.^(-6);
kolory=ColorData[97,"ColorList"];
osy=If[norm=="", "\[ScriptCapitalP]", "\[ScriptCapitalP]/"<>ToString[Subscript["\[ScriptCapitalP]","*"],TraditionalForm]];
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)", osy};
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality", 
	PlotRange->zakresP, FrameLabel->framelabel, 
	ScalingFunctions->{Identity,"Log"}, 
	AxesOrigin->{0,1},
	(*GridLines\[Rule]{{{0,Black}},{{1,Black}}}, Axes\[Rule]False,*)
	PlotPoints->100, MaxRecursion->6};

(* indeksy przy nazwach widm *)
nazwywidm=If[baza=="", Table["\!\(\*StyleBox[\"Q\",\nFontSlant->\"Italic\"]\)"<>ToString[i],{i,1,lwidm}],
	Join[{"\[ScriptCapitalR]"},Table["\[ScriptCapitalS]"<>ToString[i],{i,1,lwidm-1}]]];
legenda=Array[Subscript["\[ScriptCapitalP]",ToString[nazwywidm[[#1]]]<>ToString[#2]] &, {lwidm,lwidm}];

(* kompilacja liczby e-powi\:0119ksze\:0144 i funkcje widm mocy *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144 i widma"];
plotN=Symbol["nn"][x[[1]]]/.rozwiazania0;
Nt=Compile[{{t,_Real}}, plotN/.{x[[1]]->t}, RuntimeOptions->"Speed"];

listaw[t_]:=listaw[t]=With[{xt=t}, widma /. x[[1]]->xt /.
	(rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];

With[{lim={x[[1]],t0,tf},lopcje=opcje},
(* rysowanie wierszami *)
Do[(Print[TimeObject[Now]," Wykres wierszy ",i];
wykresP=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listaw[x[[1]]][[i,#]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lwidm]]], Placed[SwatchLegend[kolory, legenda[[i]], LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.17,0.2}]];
Export[FileNameJoin[{sciezka,"PN_"<>ToString[i-1]<>".pdf"}],wykresP];),{i,lwidm}];

(* rysowanie kolumnami *)
Do[(Print[TimeObject[Now]," Wykres kolumn ",i];
wykresP=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listaw[x[[1]]][[#,i]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lwidm]]], Placed[SwatchLegend[kolory, Transpose[legenda][[i]], LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.17,0.2}]];
Export[FileNameJoin[{sciezka,"PN^"<>ToString[i-1]<>".pdf"}],wykresP];),{i,lwidm}];];
)]


(* zale\:017cno\:015bci perturbacji w podanej bazie od liczby e-powi\:0119ksze\:0144 *)
wykresyPerturbacjeB[x_,pola_,La_,Go_,Xo_,rozwiazania0_,rozwiazaniaP_,bp_,ti_,tf_,kw_,norma_:1,tytul_:"",sciezka_:Directory[],norm_:"",Tbaza_:"F",RS_:True,pertu_:False]:=
(*wykresyPerturbacjeB[x,La,Go,Xo,rozwiazania0,rozwiazaniaP,bp,ti,tf,kw,norm,tytul,sciezka,norm,Tbaza,pertu]=*)
Block[{lper,lprzebiegow,opcje,t0,zakresP,wykresP,Nt,osy,framelabel,plotN,kolory,nazwyper,ozn,
legenda,rozwt,bpt,Gpola,kolejnosc,baza,pert,wsp,wspu,pertB,normalizacja,listaa,listap,typ,wspQu,perturbacje,pp},(
lper=Length[rozwiazaniaP[[1]]]; lprzebiegow=Length[rozwiazaniaP];
(* opcje wykres\[OAcute]w *)
(*zakresP=Which[norm=="", All, norm=="h", {All,{-7.,All}}, norm=="t", {All,{-5.,1}}];*)
zakresP=All;
t0=ti+10.^(-6);
kolory=ColorData[97,"ColorList"];
typ=Which[pertu, "u", Tbaza=="", "Q", RS, "RS", True, "Q"];
(*ozn=ToString[Style[ToString[If[RS, "Q", typ]],Italic]];*)
ozn=If[pertu, "\!\(\*
StyleBox[\"u\",\nFontSlant->\"Italic\"]\)", "\!\(\*
StyleBox[\"Q\",\nFontSlant->\"Italic\"]\)"];
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality", 
	PlotRange->zakresP, ScalingFunctions->{Identity,"Log"}, PlotPoints->100};
(*ScalingFunctions->{Identity,"Log"}, - wtedy trzeba Abs dla Re i Im *)

(* kompilacja liczby e-powi\:0119ksze\:0144 i funkcje widm mocy *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144 i widma"];
plotN=Symbol["nn"][x[[1]]]/.rozwiazania0;
Nt=Compile[{{t,_Real}}, plotN/.{x[[1]]->t}, RuntimeOptions->"Speed"];

pp=If[Head[plotN]===Piecewise, "_pp"<>ToString[Length[plotN[[1]]]], "_"];

rozwt[t_]:=rozwt[t]=With[{xt=t}, (rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];
Gpola[t_]:=Gpola[t]=With[{xt=t}, (Go /. x[[1]]->xt /. rozwt[xt])];

normalizacja=Function[t, With[{xt=t}, (norma /. x[[1]]->xt /. rozwt[xt])]];

(* perturbacje: {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
(*pert=Function[t, With[{xt=t}, (rozwiazaniaP /. x[[1]]->xt /. rozwt[xt])]];*)
pert=Function[t, With[{xt=t}, (rozwiazaniaP /. x[[1]]->xt)]];

(* baza *)
Which[
	(* Freneta *)
	Tbaza=="F",
	(bpt=Function[t, With[{xt=t}, (bp /. x[[1]]->xt /. rozwt[xt])]];
	baza=Function[t, Block[{fb=bpt[t], G=Gpola[t]}, 
	(mrkUzyteczny`ortonormalnaBaza[fb,G])]];),
	
	(* wektor\[OAcute]w w\[LSlash]asnych macierzy masy *)
	Tbaza=="M",
	(bpt=Function[t, With[{xt=t}, (bp /. x[[1]]->xt /. rozwt[xt])]];
	(* uwaga! Eigenvectors sortuje wektory malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
	w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania wektor\[OAcute]w, 
	za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
	kolejnosc=Range[lper];
	baza=Function[t, Block[{wekt, Mbaza, m=bpt[t], G=Gpola[t]}, 
	(wekt=Eigenvectors[m]; 
	Mbaza = kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wekt}];  
	mrkUzyteczny`ortonormalnaBaza[Mbaza,G])]];)];
	
Which[Tbaza=="",
	(* perturbacje: {{Q11,Q12,...},{Q21,Q22,...},...} *)
	pertB[t_]:=With[{per=pert[t]}, Transpose[per]];,
	RS && MemberQ[{"F","M"},Tbaza],
	((* wsp\[OAcute]\[LSlash]czynnik H/d\[Sigma] *)
	wsp=Function[t, With[{xt=t}, ((Symbol["nn"]'[x[[1]]]/Sqrt[2*Xo]) /. x[[1]]->xt /. rozwt[xt])]];
	(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
	pertB[t_]:=With[{G=Gpola[t], bt=baza[t], wspt=wsp[t], per=pert[t]}, wspt*(bt.G.Transpose[per])];),
	!RS && MemberQ[{"F","M"},Tbaza],
	(* perturbacja krzywizny i izokrzywizny: {{Q\[Sigma]1,Q\[Sigma]2,...},{Qs1,Qs2,...},...} *)
	pertB[t_]:=With[{G=Gpola[t], bt=baza[t], per=pert[t]}, (bt.G.Transpose[per])];];

(*If[pertu && MemberQ[{"F","M"},Tbaza],*)
If[pertu, 
	((* wsp\[OAcute]\[LSlash]czynniki przej\:015bcia od perturbacji krzywizny i izokrzywizny do wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji: 
	{a*(P'(X))^(1/2)/c_s, a*(P'(X))^(1/2)}, gdzie cs - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku, X - cz\[LSlash]on kinetyczny w lagran\:017cjanie P *)
	wspQu=Exp[Symbol["nn"][x[[1]]]]*Join[{Sqrt[D[La,Symbol["XK"]]+2*Symbol["XK"]*D[La,{Symbol["XK"],2}]]}, 
		Table[Sqrt[D[La,Symbol["XK"]]],{i,2,lper}]] /. Symbol["XK"]->Xo /. Symbol["P"]->0;
	wspu=Function[t, With[{xt=t}, (wspQu /. x[[1]]->xt /. rozwt[xt])]];
	perturbacje[t_]:=perturbacje[t]=With[{per=pertB[t], wu=wspu[t]}, wu*per];),
	perturbacje[t_]:=perturbacje[t]=pertB[t];];

(* perturbacje - cz\:0119\:015b\[CAcute] rzeczywista i urojona: {Re[{{|Q11|,|Q12|,...},{|Q21|,|Q22|,...},...}], Im[{{|Q11|,|Q12|,...},{|Q21|,|Q22|,...},...}]} *)
(*listap[t_]:=listap[t]=With[{per=perturbacje[t]}, {Re[per],Im[per]}];*)
listap[t_]:=listap[t]=With[{per=perturbacje[t]}, Abs[{Re[per],Im[per]}]];
(* amplitudy perturbacji: {{{|Q11|,|Q12|,...},{|Q21|,|Q22|,...},...}, {|Q1tot|,|Q2tot|,|Q3tot|,...}} *)
listaa[t_]:=listaa[t]=With[{per=perturbacje[t], normal=normalizacja[t]}, {Abs[per], Table[Sqrt[Total[Abs[per[[i]]]^2]],{i,1,lper}]}/(normal)];

Print["kw ",kw];
Print["tf A ",listaa[tf][[2]]];
Print["tf {Re,Im} ",listap[tf]];

With[{lim={x[[1]],t0,tf},lopcje=opcje},
(* nazwy perturbacji *)
nazwyper=nazwyPerturbacji[pola,pertu,Tbaza,RS];	
legenda=nazwyper;
osy=If[norm=="", "|"<>ozn<>"|", 
	"|"<>ozn<>"|/|"<>ToString[Subscript[ozn,"*"],TraditionalForm]<>"|"];
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)", osy};

(* rysowanie amplitud perturbacji *)
Print[TimeObject[Now]," Wykres perturbacji"];
wykresP=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listaa[x[[1]]][[2,#]]}, lim, FrameLabel->framelabel, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lper]], AxesOrigin->{0,0}], Placed[SwatchLegend[kolory, legenda, LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{Right,Bottom}]];
Export[FileNameJoin[{sciezka,typ<>"A_"<>Tbaza<>"B"<>pp<>".pdf"}],wykresP];

(* indeksy przy nazwach perturbacji dla poszczeg\[OAcute]lnych przebieg\[OAcute]w *)
legenda=Array[Subscript[ToString[nazwyper[[#1]]],ToString[#2]] &, {lper,lprzebiegow}];

(* rysowanie wierszami *)
Do[(Print[TimeObject[Now]," Wykres wierszy ",i];
wykresP=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listaa[x[[1]]][[1,i,#]]}, lim, FrameLabel->framelabel, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lprzebiegow]], AxesOrigin->{0,0}], Placed[SwatchLegend[kolory, legenda[[i]], LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{Right,Bottom}]];
Export[FileNameJoin[{sciezka,typ<>"_"<>Tbaza<>"B_"<>ToString[i-1]<>pp<>".pdf"}],wykresP];),{i,lper}];

(* rysowanie kolumnami *)
Do[(Print[TimeObject[Now]," Wykres kolumn ",i];
wykresP=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listaa[x[[1]]][[1,#,i]]}, lim, FrameLabel->framelabel, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lper]], AxesOrigin->{0,0}], Placed[SwatchLegend[kolory, Transpose[legenda][[i]], LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{Right,Bottom}]];
Export[FileNameJoin[{sciezka,typ<>"_"<>Tbaza<>"B^"<>ToString[i-1]<>pp<>".pdf"}],wykresP];),{i,lprzebiegow}];

(* rysowanie perturbacji - cz\:0119\:015b\[CAcute] rzeczywista i urojona *)
kolory=Partition[kolory,{lprzebiegow}];
(*osy="Re("<>ozn<>")";*)
osy="|"<>"Re("<>ozn<>")"<>"|";
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)", osy};
Print[TimeObject[Now]," Wykres Re"];
wykresP=Legended[Show[Flatten[Array[ParametricPlot[{Nt[x[[1]]],listap[x[[1]]][[1,#1,#2]]}, lim, FrameLabel->framelabel, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#1,#2]]] &, {lper,lprzebiegow}]], AxesOrigin->{0,0}], Placed[SwatchLegend[Flatten[kolory], Flatten[legenda], LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{Right,Bottom}]];
Export[FileNameJoin[{sciezka,typ<>"Re_"<>Tbaza<>"B"<>pp<>".pdf"}],wykresP];

(*osy="Im("<>ozn<>")";*)
osy="|"<>"Im("<>ozn<>")"<>"|";
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)", osy};
Print[TimeObject[Now]," Wykres Im"];
wykresP=Legended[Show[Flatten[Array[ParametricPlot[{Nt[x[[1]]],listap[x[[1]]][[2,#1,#2]]}, lim, FrameLabel->framelabel, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#1,#2]]] &, {lper,lprzebiegow}]], AxesOrigin->{0,0}], Placed[SwatchLegend[Flatten[kolory], Flatten[legenda], LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{Right,Bottom}]];
Export[FileNameJoin[{sciezka,typ<>"Im_"<>Tbaza<>"B"<>pp<>".pdf"}],wykresP];];
)]


(* zale\:017cno\:015bci widm w podanej bazie od liczby e-powi\:0119ksze\:0144 *)
wykresyWidmaB[x_,pola_,La_,Go_,Xo_,rozwiazania0_,rozwiazaniaP_,bp_,ti_,tf_,kw_,norma_:1,tytul_:"",sciezka_:Directory[],norm_:"",Tbaza_:"F",RS_:True,pertu_:False,gridt_:{},opisy_:{}]:=
(*wykresyWidmaB[x,Go,Xo,rozwiazania0,rozwiazaniaP,bp,ti,tf,kw,norm,tytul,sciezka,norm,Tbaza,RS,pertu,gridt,opisy]=*)
Block[{lwidm,lprzebiegow,lrozw,opcje,t0,legendaw={},lp,styl={},zakresP,zakresPw,nazwywidm,wykresP,funNi,Nt,wspQu,perturbacje,listaw,osy,framelabel,
plotN,kolory,typ,legenda,kol,rozwt,bpt,Gpola,kolejnosc,baza,pert,wsp,wspu,pertB,normalizacja,pp="",tt,grid,ims},(
lwidm=Length[rozwiazaniaP[[1,1]]]; lprzebiegow=Length[rozwiazaniaP[[1]]]; lrozw=Length[rozwiazaniaP];
(* opcje wykres\[OAcute]w *)
zakresP=Which[norm=="", {All,All}, norm=="h", {All,{All,{-9.,All}}}, norm=="t", {{All,{-5.,1}},{All,{-5.,1}}}];
kolory=Join[ColorData[97,"ColorList"],ColorData[89,"ColorList"]];
typ=Which[pertu, "u", Tbaza=="", "Q", RS, "RS", True, "Q"];
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality", 
	ScalingFunctions->{Identity,"Log"}, PlotPoints->100};

(* liczba e-powi\:0119ksze\:0144 oraz liczby przedzia\[LSlash]\[OAcute]w, legenda i styl linii na wykresie *)
plotN=Flatten[Symbol["nn"][x[[1]]]/.rozwiazania0];
Nt=Reap[Do[
If[Head[plotN[[i]]]===Piecewise,
	(* z produkcj\:0105 cz\:0105stek *)
	(funNi=plotN[[i]];
	Sow[Compile[{{t,_Real}}, funNi /. {x[[1]]->t}, RuntimeOptions->"Speed"]];
	lp=Length[plotN[[i,1]]]-1; pp=pp<>"_pp"<>ToString[lp]; AppendTo[styl,Thick];), 
	(* bez produkcji cz\:0105stek *)
	(Sow[plotN[[i]][[0]]]; lp=0; pp=pp<>"_"; AppendTo[styl,Dashed];)];
	AppendTo[legendaw,ToString[lp]];,
{i,1,lrozw}]][[2,1]];
legendaw=If[opisy=={}, legendaw, opisy];
styl=If[AllTrue[styl, #==Dashed &], styl /. Dashed -> Thick, styl];

(* rozwi\:0105zania dla t\[LSlash]a, tensor metryczny w przestrzeni p\[OAcute]l *)
rozwt[t_]:=rozwt[t]=With[{xt=t}, (rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];
Gpola[t_]:=Gpola[t]=With[{xt=t}, (Go /. x[[1]]->xt /. rozwt[xt])];
(* normalizacja *)
normalizacja=Function[t, With[{xt=t}, (norma /. x[[1]]->xt /. rozwt[xt])]];
(* perturbacje: {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
pert=Function[t, With[{xt=t}, (rozwiazaniaP /. x[[1]]->xt)]];

(* baza *)
Which[
	(* Freneta *)
	Tbaza=="F",
	(bpt=Function[t, With[{xt=t}, (bp /. x[[1]]->xt /. rozwt[xt])]];
	baza=Function[t, Block[{fb=bpt[t], G=Gpola[t]}, 
	Reap[Do[Sow[mrkUzyteczny`ortonormalnaBaza[fb[[i]],G[[i]]]], {i,1,lrozw}]][[2,1]]]];),
	
	(* wektor\[OAcute]w w\[LSlash]asnych macierzy masy *)
	Tbaza=="M",
	(bpt=Function[t, With[{xt=t}, (bp /. x[[1]]->xt /. rozwt[xt])]];
	(* uwaga! Eigenvectors sortuje wektory malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
	w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania wektor\[OAcute]w, 
	za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
	kolejnosc=Range[lwidm];	
	baza[t_]:=Block[{wekt, Mbaza, m=bpt[t], G=Gpola[t]}, 
		Reap[Do[(wekt=Eigenvectors[m[[i]]]; 
		Mbaza = kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wekt}];  
		Sow[mrkUzyteczny`ortonormalnaBaza[Mbaza,G[[i]]]]), {i,1,lrozw}]][[2,1]]];)];
	
Which[Tbaza=="",
	(* perturbacje: {{Q11,Q12,...},{Q21,Q22,...},...} *)
	pertB[t_]:=With[{per=pert[t]}, Map[Transpose,per]];,
	RS && MemberQ[{"F","M"},Tbaza],
	((* wsp\[OAcute]\[LSlash]czynnik H/d\[Sigma] *)
	wsp=Function[t, With[{xt=t}, ((Symbol["nn"]'[x[[1]]]/Sqrt[2*Xo]) /. x[[1]]->xt /. rozwt[xt])]];
	(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
	pertB[t_]:=With[{G=Gpola[t], bt=baza[t], wspt=wsp[t], per=pert[t]}, 
		Reap[Do[Sow[wspt[[i]]*(bt[[i]].G[[i]].Transpose[per[[i]]])], {i,1,lrozw}]][[2,1]]];),
	!RS && MemberQ[{"F","M"},Tbaza],
	(* perturbacja krzywizny i izokrzywizny: {{Q\[Sigma]1,Q\[Sigma]2,...},{Qs1,Qs2,...},...} *)
	pertB[t_]:=With[{G=Gpola[t], bt=baza[t], per=pert[t]}, 
		Reap[Do[Sow[(bt[[i]].G[[i]].Transpose[per[[i]]])], {i,1,lrozw}]][[2,1]]];];

(*If[pertu && MemberQ[{"F","M"},Tbaza],*)
If[pertu, 
	((* wsp\[OAcute]\[LSlash]czynniki przej\:015bcia od perturbacji krzywizny i izokrzywizny do wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji: 
	{a*(P'(X))^(1/2)/c_s, a*(P'(X))^(1/2)}, gdzie cs - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku, X - cz\[LSlash]on kinetyczny w lagran\:017cjanie P *)
	wspQu=Exp[Symbol["nn"][x[[1]]]]*Join[{Sqrt[D[La,Symbol["XK"]]+2*Symbol["XK"]*D[La,{Symbol["XK"],2}]]}, 
		Table[Sqrt[D[La,Symbol["XK"]]],{i,2,lwidm}]] /. Symbol["XK"]->Xo /. Symbol["P"]->0;
	wspu=Function[t, With[{xt=t}, (wspQu /. x[[1]]->xt /. rozwt[xt])]];
	perturbacje[t_]:=With[{per=pertB[t], wu=wspu[t]}, Map[wu*# &, per]];),
	perturbacje[t_]:=pertB[t];];
	
(* (bezwymiarowe) widma mocy: {{{P11,P12,...},{P21,P22,...},...}, {P1tot,P2tot,P3tot,...}} *)
listaw[t_]:=listaw[t]=With[{per=perturbacje[t], normal=normalizacja[t]}, 
	{Table[Abs[per[[j]]]^2*kw[[j]]^3/normal[[j]]+10^(-30),{j,1,lrozw}], Table[Total[Abs[per[[j,i]]]^2]*kw[[j]]^3/normal[[j]],{j,1,lrozw},{i,1,lwidm}]}/(2*Pi^2)];

Print["kw ",kw];
Print["tf ",listaw[Max[tf]][[2]]];

(* rysowanie wykresu *)
With[{lopcje=opcje},(
(* indeksy przy nazwach widm *)
nazwywidm=nazwyPerturbacji[pola,pertu,Tbaza,RS];
legenda=Map[ToString[Subscript["\[ScriptCapitalP]",nazwywidm[[#]]],TraditionalForm] &, Range[lwidm]];
grid=If[gridt!={}, {Flatten[Table[Map[{Nt[[i]][#],kolory[[i]]} &, gridt[[i]]], {i,1,lrozw}],1],None}, {None,None}];

(* odzielne wykresy dla poszczeg\[OAcute]lnych perturbacji *)	
Do[Print[TimeObject[Now]," Wykres widm ",i];
osy=If[norm=="", legenda[[i]], legenda[[i]]<>"/"<>ToString[Subscript["\[ScriptCapitalP]","*"],TraditionalForm]];
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",osy};
wykresP=Legended[Show[Map[ParametricPlot[{Nt[[#]][tt],listaw[tt][[2,#,i]]}, {tt,ti[[#]],tf[[#]]}, Evaluate[Sequence@@lopcje], 
	FrameLabel->framelabel, PlotStyle->Directive[kolory[[#]],styl[[#]],Thickness[0.004]], PlotRange->zakresP[[1]], 
	GridLines->grid, GridLinesStyle->Directive[Thickness[0.004],Opacity[0.5]]] &, Range[lrozw]], AxesOrigin->{0,0}],
	Placed[SwatchLegend[kolory, legendaw, LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
		LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->50]&), LegendLayout->"Column"],{Right,Top}]];
Export[FileNameJoin[{sciezka,"P"<>typ<>"N_"<>Tbaza<>"B_v"<>pp<>"_i"<>ToString[i]<>".pdf"}],wykresP];, {i,1,lwidm}];

(* wszystko na jednym wykresie *)
Print[TimeObject[Now]," Wykres widm"];
osy=If[norm=="", "\[ScriptCapitalP]", "\[ScriptCapitalP]/"<>ToString[Subscript["\[ScriptCapitalP]","*"],TraditionalForm]];
ims=55;
Which[lrozw==1 && lp!=0, framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)", osy<>" ("<>ToString[lp]<>")"};,
	  lrozw==1 && lp==0, (framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",osy}; ims=45;),
	  lrozw!=1,
	(framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)", osy}; 
	legenda=Array[legenda[[#1]]<>" ("<>legendaw[[#2]]<>")" &, {lwidm,lrozw}];)];
kol=Partition[kolory,lrozw];
wykresP=Legended[Show[Flatten[Array[ParametricPlot[{Nt[[#2]][tt],listaw[tt][[2,#2,#1]]}, {tt,ti[[#2]],tf[[#2]]}, Evaluate[Sequence@@lopcje], 
	FrameLabel->framelabel, PlotStyle->Directive[kol[[#1,#2]],styl[[#2]],Thickness[0.004]]] &, {lwidm,lrozw}]], AxesOrigin->{0,0}, PlotRange->zakresP[[2]]],
	Placed[SwatchLegend[kolory, Flatten[legenda], LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
		LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->ims]&), LegendLayout->"Column"],{Left,Bottom}]];
Export[FileNameJoin[{sciezka,"P"<>typ<>"N_"<>Tbaza<>"B_v"<>pp<>".pdf"}],wykresP];

(* indeksy przy nazwach widm dla poszczeg\[OAcute]lnych przebieg\[OAcute]w *)
legenda=Array[Subscript["\[ScriptCapitalP]",Subscript[nazwywidm[[#1]],ToString[#2]]] &, {lwidm,lprzebiegow}];
Do[
	framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)", osy<>" ("<>legendaw[[j]]<>")"};

	(* rysowanie wierszami *)
	Do[(Print[TimeObject[Now]," Wykres wierszy ",i];
	wykresP=Legended[Show[Map[ParametricPlot[{Nt[[j]][tt],listaw[tt][[1,j,i,#]]}, {tt,ti[[j]],tf[[j]]}, Evaluate[Sequence@@lopcje],
		FrameLabel->framelabel, PlotStyle->kolory[[#]]] &, Range[lprzebiegow]], AxesOrigin->{0,0}, PlotRange->{All,{-30.,All}}], 
		Placed[SwatchLegend[kolory, legenda[[i]], LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
			LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->45]&), LegendLayout->"Column"],{Left,Bottom}]];
	Export[FileNameJoin[{sciezka,"P"<>typ<>"N_"<>Tbaza<>"B_"<>ToString[i]<>"_v"<>legendaw[[j]]<>".pdf"}],wykresP];),{i,lwidm}];

	(* rysowanie kolumnami *)
	Do[(Print[TimeObject[Now]," Wykres kolumn ",i];
	wykresP=Legended[Show[Map[ParametricPlot[{Nt[[j]][tt],listaw[tt][[1,j,#,i]]}, {tt,ti[[j]],tf[[j]]}, Evaluate[Sequence@@lopcje],
		FrameLabel->framelabel, PlotStyle->kolory[[#]]] &, Range[lwidm]], AxesOrigin->{0,0}, PlotRange->{All,{-30.,All}}], 
		Placed[SwatchLegend[kolory, Transpose[legenda][[i]], LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
			LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->45]&), LegendLayout->"Column"],{Left,Bottom}]];
	Export[FileNameJoin[{sciezka,"P"<>typ<>"N_"<>Tbaza<>"B^"<>ToString[i]<>"_v"<>legendaw[[j]]<>".pdf"}],wykresP];),{i,lprzebiegow}];, 
{j,1,lrozw}];
)];
)]


(* zale\:017cno\:015bci widm od liczby falowej *)
wykresyWidmak[x_,rozwiazania0_,widmak_,t_,kwNorm_:1,norm_:"",tytul_:"",sciezka_:Directory[],baza_:"F"]:=
(*wykresyWidmak[x,rozwiazania0,widmak,t,kwNorm,norm,tytul,sciezka,baza]=*)
Block[{lwidm,zakres,osx,osy,kolory,legenda,opcje,nazwywidm,wykresP,widmat,listaw,kw},(
lwidm=Length[widmak];
(* opcje wykres\[OAcute]w *)
zakres=Which[norm=="", All, norm=="h", {All,{All,3}}];
kolory=ColorData[97,"ColorList"];
osx=If[kwNorm==1, "\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)/",
	"\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)/"<>ToString[Subscript["\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)","*"],TraditionalForm]];
osy=If[norm=="", "\[ScriptCapitalP]", "\[ScriptCapitalP]/"<>ToString[Subscript["\[ScriptCapitalP]","*"],TraditionalForm]];
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality",
	ScalingFunctions->{"Log",Identity}, GridLines->{None,{{1,Black}}}, Axes->False,
	FrameLabel->{osx,osy}, PlotRange->zakres, 
	(*PlotPoints->20, MaxRecursion->2};*) 
	PlotPoints->10};

(* indeksy przy nazwach widm *)
nazwywidm=If[baza=="", Table["\!\(\*
StyleBox[\"Q\",\nFontSlant->\"Italic\"]\)"<>ToString[i],{i,1,lwidm}],
	Join[{"\[ScriptCapitalR]"},Table["\[ScriptCapitalS]"<>ToString[i],{i,1,lwidm-1}]]];
legenda=Map[Subscript["\[ScriptCapitalP]",ToString[nazwywidm[[#]]]] &,Range[lwidm]];

(* funkcje widm mocy *)
Print[TimeObject[Now]," Widma"];
(*widmat=Simplify[(widmak) /. x[[1]]->t /. (rozwiazania0/.x[[1]]->t/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];*)
widmat=(widmak) /. x[[1]]->t /. (rozwiazania0/.x[[1]]->t/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]));
listaw[k_]:=listaw[k]=With[{kkw=k}, (widmat /. Symbol["kk"]->kkw)];

Print["kNorm ",kwNorm,TimeObject[Now]];
Print["1: ",listaw[kwNorm],TimeObject[Now]];
Print["2: ",listaw[kwNorm*2.],TimeObject[Now]];
Print["0.1: ",listaw[kwNorm*0.1],TimeObject[Now]];
Print["10: ",listaw[kwNorm*10.],TimeObject[Now]];

With[{lim={kw,0.1,10.},lopcje=opcje},
(* rysowanie widm *)
Print[TimeObject[Now]," Wykres widm(k)"];
wykresP=Legended[Show[Map[ParametricPlot[{kw,listaw[kw*kwNorm][[#]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lwidm]]], Placed[SwatchLegend[kolory, legenda, LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.18,0.80}]];	
Export[FileNameJoin[{sciezka,"Pk.pdf"}],wykresP];];
)]


(* zale\:017cno\:015bci widm w podanej bazie od liczby falowej *)
wykresyWidmakB[x_,Go_,Xo_,rozwiazania0_,rozwiazaniaP_,bp_,tf_,kwNorm_,norma_:1,tytul_:"",sciezka_:Directory[],norm_:"",lw_:1,Tbaza_:"F"]:=
(*wykresyWidmakB[x,Go,Xo,rozwiazania0,rozwiazaniaP,bp,tf,kwNorm,norma,tytul,sciezka,norm,lw,Tbaza]=*)
Block[{lwidm,lrozw,opcje,zakres,osx,osy,kolory,lp,pp="",legendaw={},styl={},legenda,nazwywidm,
rozwt,Gpola,normalizacja,kolejnosc,baza,rozwPt,pert,wsp,wMG,pertRS,listaw,kw,wykresP},(
lwidm=Min[lw,Length[rozwiazaniaP[[1,1]]]]; lrozw=Length[rozwiazaniaP];
(* opcje wykres\[OAcute]w *)
zakres=Which[norm=="", All, norm=="h", {All,{All,3}}];
zakres=All;
kolory=ColorData[97,"ColorList"];
osx=If[kwNorm==1, "\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)/",
	"\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)/"<>ToString[Subscript["\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)","*"],TraditionalForm]];
osy=If[norm=="", "\[ScriptCapitalP]", "\[ScriptCapitalP]/"<>ToString[Subscript["\[ScriptCapitalP]","*"],TraditionalForm]];
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality",
	ScalingFunctions->{"Log",Identity}, 
	(*GridLines\[Rule]{None,{{1,Black}}}, Axes\[Rule]False,*)
	FrameLabel->{osx,osy}, PlotRange->zakres,
	PlotPoints->20};
	(*PlotPoints\[Rule]10};*)
	
(* liczby przedzia\[LSlash]\[OAcute]w, legenda i styl linii na wykresie *)
Do[If[Head[rozwiazania0[[i,1,2,0]]]===Piecewise,
	(* z produkcj\:0105 cz\:0105stek *)
	(lp=Length[rozwiazania0[[i,1,2]]];
	pp=pp<>"_pp"<>ToString[lp];
	AppendTo[styl,Thick];), 
	(* bez produkcji cz\:0105stek *)
	(pp=pp<>"_"; lp=0; AppendTo[styl,Dashed];)];
	AppendTo[legendaw,ToString[lp]];,
{i,1,lrozw}];
If[lrozw==1 && lp==0, styl[[1]]=Thick];
Print[Head[rozwiazania0[[1,1,2,0]]]];
Print[Map[Length[rozwiazania0[[#,1,2]]] &,Range[lrozw]]];
Print[styl];

(* indeksy przy nazwach widm *)
nazwywidm=Join[{"\[ScriptCapitalR]"},Table["\[ScriptCapitalS]"<>ToString[i],{i,1,lwidm-1}]];
legenda=Map[Subscript["\[ScriptCapitalP]",ToString[nazwywidm[[#]]]] &, Range[lwidm]];
legenda=If[lrozw==1 && lp==0, legenda, 
	Flatten[Array[legenda[[#1]]<>" ("<>legendaw[[#2]]<>")" &, {lwidm,lrozw}]]];

(* rozwi\:0105zania dla t\[LSlash]a, tensor metryczny w przestrzeni p\[OAcute]l *)
rozwt=Map[rozwiazania0[[#]] /. x[[1]]->tf[[#]] /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]) &, Range[lrozw]];
Gpola=Map[Go /. x[[1]]->tf[[#]] /. rozwt[[#]] &, Range[lrozw]];
(* normalizacja *)
normalizacja=Map[norma /. x[[1]]->tf[[#]] /. rozwt[[#]] &, Range[lrozw]];

(* baza *)
baza=Which[
	(* Freneta *)
	Tbaza=="F", 
	Block[{fb, G=Gpola, rozt=rozwt}, 
	(fb=Map[bp /. x[[1]]->tf[[#]] /. rozt[[#]] &, Range[lrozw]];  
	Reap[Do[Sow[mrkUzyteczny`ortonormalnaBaza[fb[[i]],G[[i]]]], {i,1,lrozw}]][[2,1]])],
	
	(* wektor\[OAcute]w w\[LSlash]asnych macierzy masy *)
	Tbaza=="M",
	((* uwaga! Eigenvectors sortuje wektory malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
	w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania wektor\[OAcute]w, 
	za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
	kolejnosc=Range[Length[rozwiazaniaP[[1,1]]]];
	Block[{wekt, Mbaza, m, G=Gpola}, 
	(m=Map[bp /. x[[1]]->tf[[#]] /. rozwt[[#]] &, Range[lrozw]];
	Reap[Do[(wekt=Eigenvectors[m[[i]]]; 
		Mbaza = kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wekt}];  
		Sow[mrkUzyteczny`ortonormalnaBaza[Mbaza,G[[i]]]]), {i,1,lrozw}]][[2,1]])]),
		
	(* brak bazy *)
	Tbaza=="", {Table[Table[1, Length[rozwiazaniaP[[1,1]]]], lrozw]}];

(* perturbacje: {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
rozwPt=Map[rozwiazaniaP[[#]] /. x[[1]]->tf[[#]] &, Range[lrozw]];
pert=Function[k, With[{kkw=k}, (rozwPt /. Symbol["kk"]->kkw)]];
(* wsp\[OAcute]\[LSlash]czynnik H/d\[Sigma] *)
wsp=Map[Symbol["nn"]'[x[[1]]]/Sqrt[2*Xo] /. x[[1]]->tf[[#]] /. rozwt[[#]] &, Range[lrozw]];
(* niezmiennicza wzgl\:0119dem cechowania perturbacja krzywizny i zrenormalizowane perturbacje izokrzywizny: {{\[ScriptCapitalR]1,\[ScriptCapitalR]2,...},{\[ScriptCapitalS]11,\[ScriptCapitalS]12,...},...} *)
wMG=Map[wsp[[#]]*(baza[[#]].Gpola[[#]]) &, Range[lrozw]];
pertRS[k_]:=With[{per=pert[k]}, Map[wMG[[#]].Transpose[per[[#]]] &, Range[lrozw]]];
(* widma mocy: {{{P\[ScriptCapitalR]1,P\[ScriptCapitalR]2,...},{P\[ScriptCapitalS]11,P\[ScriptCapitalS]12,...},...}, {P\[ScriptCapitalR]tot,P\[ScriptCapitalS]1tot,P\[ScriptCapitalS]2tot,...}} *)
listaw[k_]:=listaw[k]=With[{kkw=k, perRS=pertRS[k]}, 
	Table[Total[Abs[perRS[[j,i]]]^2]/normalizacja[[j]],{j,1,lrozw},{i,1,lwidm}]*kkw^3/(2*Pi^2)];

Print["kNorm ",kwNorm,TimeObject[Now]];
Print["0.1: ",listaw[kwNorm*0.1],TimeObject[Now]];
Print["1: ",listaw[kwNorm],TimeObject[Now]];
Print["2: ",listaw[kwNorm*2.],TimeObject[Now]];
Print["10: ",listaw[kwNorm*10.],TimeObject[Now]];

With[{lim={kw,0.1,10.},lopcje=opcje},
(* rysowanie widm *)
Print[TimeObject[Now]," Wykres widm(k)"];	
wykresP=Legended[Show[Flatten[Array[ParametricPlot[{kw,listaw[kw*kwNorm][[#2,#1]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->Directive[kolory[[#2]],styl[[#2]],Thickness[0.004]]] &, {lwidm,lrozw}]], AxesOrigin->{0,0}],
	Placed[SwatchLegend[kolory, legenda, LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
		LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->50]&), LegendLayout->"Column"],{0.18,0.80}]];
Export[FileNameJoin[{sciezka,"Pk_"<>Tbaza<>"B_v"<>pp<>".pdf"}],wykresP];];
)]


(* zale\:017cno\:015bci wzmocnienia perturbacji krzywizny i izokrzywizny od liczby falowej *)
wykresyWzmocnienie[wzmoc_,lp_,Tbaza_,tytul_:"",sciezka_:Directory[],nrwidm_:{1},opisy_:{}]:=
(*wykresyWzmocnienie[wzmoc,lp,Tbaza,tytul,sciezka,nrwidm,opisy]=*)
Block[{lrozw,lwidm,zakres,kolory,nazwywidm,osy,framelabel,lpw,styl,opcje,legenda,wykres,ims},(
lrozw=Length[wzmoc];
lwidm=Length[nrwidm];
(* opcje wykres\[OAcute]w *)
zakres=All;
ims=40;
kolory=ColorData[97,"ColorList"];
nazwywidm=Map[ToString[Subscript["\[ScriptCapitalP]", If[#==1, "\[ScriptCapitalR]", Subscript["\[ScriptCapitalS]",ToString[#-1]]]], TraditionalForm] &, nrwidm];
osy=If[Length[nrwidm]!=1, "\[ScriptCapitalP]", nazwywidm[[1]]];
framelabel={"\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)/"<>ToString[Subscript["\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)","*"],TraditionalForm],
	osy<>"/"<>ToString[Subscript["\[ScriptCapitalP]","*"],TraditionalForm]};
lpw=Flatten[Map[Table[#,lwidm] &, lp]];
styl=Which[lrozw==1 && First[lp]==0 , Table[Thick,lwidm],
		   AllTrue[Flatten[lp], #==0 &], lpw /. {0 -> Thick},
	       True, lpw /. {n_ /; n==0 -> Dashed, n_ /; n!=1 -> Thick}];
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality", 
	Joined->True,
	AxesOrigin->{1,1}, PlotStyle->Map[Directive[kolory[[#]],styl[[#]],Thickness[0.004]] &, Range[lrozw*lwidm]],
	FrameLabel->framelabel, PlotRange->zakres}; 
	(*PlotPoints->20, MaxRecursion->2};*)
	(*PlotPoints\[Rule]10};*)

With[{lopcje=opcje},
(* rysowanie widm *)
Print[TimeObject[Now]," Wykres widm(k) - wzmocnienia(k)"];
If[lrozw==1 && lwidm==1 && First[lp]==0,	
	wykres=ListLogLinearPlot[Flatten[wzmoc,1], Evaluate[Sequence@@lopcje]];,
	(Which[AllTrue[Flatten[lp], #==0 &] && opisy != {}, lpw=opisy,
		   !AllTrue[Flatten[lp], #==0 &] && opisy != {}, (lpw=MapThread[#1<>" ("<>ToString[#2]<>")" &, {opisy, lpw}]; ims=60)];
	legenda=Which[lrozw==1 && lwidm!=1 && First[lp]==0, nazwywidm,
				  lrozw!=1 && lwidm==1, lpw, 
				  True, MapThread[#1<>" ("<>ToString[#2]<>")" &, {Flatten[Table[nazwywidm,lrozw]],lpw}]];
	(*wykres=Legended[ListLogLinearPlot[Flatten[wzmoc,1], Evaluate[Sequence@@lopcje]],*)
	wykres=Legended[ListLogLogPlot[Flatten[wzmoc,1], Evaluate[Sequence@@lopcje]],
		Placed[SwatchLegend[kolory, legenda, LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
		LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->ims]&), LegendLayout->"Column"],{Left,Top}]];)];
Export[FileNameJoin[{sciezka,"Pk_"<>Tbaza<>"B_v"<>StringRiffle[Map[ToString,lp],"_"]<>".pdf"}],wykres];];
)]


(* zale\:017cno\:015bci indeksu spektralnego perturbacji krzywizny i izokrzywizny od liczby falowej *)
wykresyIndeksSpektralny[ns_,lp_,Tbaza_,tytul_:"",sciezka_:Directory[],nrwidm_:{1}]:=
(*wykresyIndeksSpektralny[ns,lp,Tbaza,tytul,sciezka,nrwidm]=*)
Block[{lrozw,lwidm,zakres,kolory,nazwywidm,osy,framelabel,lpw,styl,opcje,legenda,wykres},(
lrozw=Length[ns];
lwidm=Length[nrwidm];
(* opcje wykres\[OAcute]w *)
zakres=All;
kolory=ColorData[97,"ColorList"];
nazwywidm=Map[ToString[Subscript["\[ScriptCapitalP]", If[#==1, "\[ScriptCapitalR]", Subscript["\[ScriptCapitalS]",ToString[#-1]]]], TraditionalForm] &, nrwidm];
osy=If[Length[nrwidm]!=1, Subscript["n","s"], Subscript["n","s"]<>"("<>nazwywidm[[1]]<>")"];
framelabel={"\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)/"<>ToString[Subscript["\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)","*"],TraditionalForm], osy};
lpw=Flatten[Map[Table[#,lwidm] &, lp]];
styl=If[lrozw==1 && First[lp]==0, Table[Thick,lwidm], lpw /. {n_ /; n==0 -> Dashed, n_ /; n!=1 -> Thick}];
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality", Joined->True,
	AxesOrigin->{1,1}, PlotStyle->Map[Directive[kolory[[#]],styl[[#]],Thickness[0.004]] &, Range[lrozw*lwidm]],
	FrameLabel->framelabel, PlotRange->zakres}; 
	(*PlotPoints->20, MaxRecursion->2};*)
	(*PlotPoints\[Rule]10};*)

With[{lopcje=opcje},
(* rysowanie widm *)
Print[TimeObject[Now]," Wykres ns(k)"];
If[lrozw==1 && lwidm==1 && First[lp]==0,	
	wykres=ListLogLinearPlot[Flatten[ns,1], Evaluate[Sequence@@lopcje]];,
	(legenda=Which[lrozw==1 && lwidm!=1 && First[lp]==0, nazwywidm, 
				   lrozw!=1 && lwidm==1, lpw, 
				   True, MapThread[#1<>" ("<>#2<>")" &, {Flatten[Table[nazwywidm,lrozw]],lpw}]];
	wykres=Legended[ListLogLinearPlot[Flatten[ns,1], Evaluate[Sequence@@lopcje]],
		Placed[SwatchLegend[kolory, legenda, LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
		LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->50]&), LegendLayout->"Column"],{Left,Top}]];)];
Export[FileNameJoin[{sciezka,"nsk_"<>Tbaza<>"B_v"<>StringRiffle[Map[ToString,lp],"_"]<>".pdf"}],wykres];];
)]


(* zale\:017cno\:015bci wzgl\:0119dnych korelacji od liczby e-powi\:0119ksze\:0144 *)
wykresyKorelacjeU[x_,rozwiazania0_,korelacjeU_,ti_,tf_,tytul_:"",sciezka_:Directory[]]:=
(*wykresyKorelacjeU[x,rozwiazania0,korelacjeU,ti,tf,tytul,sciezka]=*)
Block[{lpol,lkor,opcje,t0,zakresCU,nazwykor,wykresCU,Nt,listak,framelabel,plotN,kolory,legenda,indeksy},(
lkor=Length[korelacjeU]; lpol=(1.+Sqrt[1.+8.*lkor])/2.; 
(* opcje wykres\[OAcute]w *)
zakresCU={All,{-0.1,1.1}};
t0=ti;
kolory=ColorData[97,"ColorList"];
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",
			"\!\(\*StyleBox[OverscriptBox[\[ScriptCapitalC], \"~\"],\nFontSlant->\"Italic\"]\)"};
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, FrameLabel->framelabel, 
	PlotRange->zakresCU, PerformanceGoal->"Quality", PlotPoints->50};

(* indeksy przy nazwach korelacji *)
indeksy=Join[{"\[ScriptCapitalR]"},Table["\[ScriptCapitalS]"<>ToString[i],{i,1,lpol-1}]];
nazwykor=Subsets[indeksy,{2}];
legenda=Map[Subscript["\!\(\*StyleBox[OverscriptBox[\[ScriptCapitalC], \"~\"],\nFontSlant->\"Italic\"]\)",
			ToString[nazwykor[[#,1]]<>ToString[nazwykor[[#,2]]]]] &, Range[lkor]];

(* kompilacja liczby e-powi\:0119ksze\:0144 i funkcje korelacji wzgl\:0119dnych *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144 i wzgl\:0119dne korelacje"];
plotN=Symbol["nn"][x[[1]]]/.rozwiazania0;
Nt=Compile[{{t,_Real}}, plotN/.{x[[1]]->t}, RuntimeOptions->"Speed"];

listak[t_]:=listak[t]=With[{xt=t}, korelacjeU /. x[[1]]->xt /.
	(rozwiazania0 /. x[[1]]->t /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];

With[{lim={x[[1]],t0,tf},lopcje=opcje},
(* rysowanie wzgl\:0119dnych korelacji *)
Print[TimeObject[Now]," Wykres"];
wykresCU=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listak[x[[1]]][[#]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lkor]]], Placed[SwatchLegend[kolory, legenda, LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.18,0.80}]];
Export[FileNameJoin[{sciezka,"CUN.pdf"}],wykresCU];];
)]


(* zale\:017cno\:015bci korelacji od liczby e-powi\:0119ksze\:0144 *)
wykresyKorelacje[x_,rozwiazania0_,korelacje_,ti_,tf_,tytul_:"",sciezka_:Directory[],norm_:""]:=
(*wykresyKorelacje[x,rozwiazania0,korelacje,ti,tf,tytul,sciezka,norm]=*)
Block[{lpol,lkor,opcje,t0,zakresC,nazwykor,wykresC,Nt,listak,osy,framelabel,plotN,kolory,legenda,indeksy},(
lkor=Length[korelacje]; lpol=(1.+Sqrt[1.+8.*lkor])/2.; 
(* opcje wykres\[OAcute]w *)
zakresC=Which[norm=="", All, norm=="h", {All,{-7.,All}}, norm=="t", {All,{-4.,1}}];
t0=ti+10.^(-6);
kolory=ColorData[97,"ColorList"];
osy=If[norm=="", "\[ScriptCapitalC]", "\[ScriptCapitalC]/"<>ToString[Subscript["\[ScriptCapitalP]","*"],TraditionalForm]];
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)", osy};
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality", 
	FrameLabel->framelabel, PlotRange->zakresC, 
	ScalingFunctions->{Identity,"Log"}, GridLines->{{{0,Black}},{{1,Black}}}, Axes->False,
	PlotPoints->50};

(* indeksy przy nazwach korelacji *)
indeksy=Join[{"\[ScriptCapitalR]"},Table["\[ScriptCapitalS]"<>ToString[i],{i,1,lpol-1}]];
nazwykor=Subsets[indeksy,{2}];
legenda=Map[Subscript["\[ScriptCapitalC]",
			ToString[nazwykor[[#,1]]<>ToString[nazwykor[[#,2]]]]] &, Range[lkor]];

(* kompilacja liczby e-powi\:0119ksze\:0144 i funkcje korelacji *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144 i korelacje"];
plotN=Symbol["nn"][x[[1]]]/.rozwiazania0;
Nt=Compile[{{t,_Real}}, plotN/.{x[[1]]->t}, RuntimeOptions->"Speed"];

listak[t_]:=listak[t]=With[{xt=t}, korelacje /. x[[1]]->xt /.
	(rozwiazania0 /. x[[1]]->t /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];

With[{lim={x[[1]],t0,tf},lopcje=opcje},
(* rysowanie korelacji *)
Print[TimeObject[Now]," Wykres"];
wykresC=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listak[x[[1]]][[#]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lkor]]], Placed[SwatchLegend[kolory, legenda, LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.18,0.80}]];
Export[FileNameJoin[{sciezka,"CN.pdf"}],wykresC];];
)]


(* ::Section:: *)
(*Baza*)


(* zale\:017cno\:015bci zmiennych/H^2 od liczby e-powi\:0119ksze\:0144 *)
wykresyParametrow[x_,rozwiazania0_,zmienne_,nazwyzm_,ti_,tf_,plik_:"",osy_:"",sciezka_:Directory[]]:=
(*wykresyParametrow[x,rozwiazania0,zmienne,nazwyzm,ti,tf,plik,osy,sciezka]=*)
Block[{lzm,opcje,zakres,framelabel,kolory,legenda,plotN,Nt,zmienneH,drozw,listaz,wykres},(
lzm=Length[zmienne];
(* opcje wykresu *)
zakres=All;
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",osy};
kolory=ColorData[97,"ColorList"];
(*legenda=Map[#/Superscript["\!\(\*StyleBox[\"H\",\nFontSlant->\"Italic\"]\)",2] &, nazwyzm];*)
legenda=nazwyzm/"\!\(\*StyleBox[\"H\",\nFontSlant->\"Italic\"]\)";
opcje={Frame->True, AspectRatio->1, PerformanceGoal->"Quality",
	ScalingFunctions->{Identity,"Log"}, 
	FrameLabel->framelabel, PlotRange->zakres, PlotPoints->100};

(* zmienne i liczba e-powi\:0119ksze\:0144; parametr Hubble'a H(t)=N'(t) *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144 i zmienne"];
plotN=Symbol["nn"][x[[1]]]/.rozwiazania0;
Nt=Compile[{{t,_Real}},plotN/.{x[[1]]->t}, RuntimeOptions->"Speed"];

zmienneH=Sqrt[zmienne/Symbol["nn"]'[x[[1]]]^2]; 
(*zmienneH=zmienne/Symbol["nn"]'[x[[1]]]^2;*)
	
(*drozw=D[rozwiazania0,x[[1]]];*)
listaz[t_]:=listaz[t]=With[{xt=t}, zmienneH /. x[[1]]->xt /.
	(rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];
	(*(drozw/.x[[1]]->t/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200])));*)

With[{lim={x[[1]],ti,tf},lopcje=opcje}, 
(* rysowanie wykresu *)
Print[TimeObject[Now]," Wykres"];
wykres=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listaz[x[[1]]][[#]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lzm]]],
	Placed[SwatchLegend[kolory, legenda, LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), 
		LegendMarkers->"Line", LegendLayout->"Column"], {0.1,0.9}]];
Export[FileNameJoin[{sciezka,plik<>"H.pdf"}],wykres];];
)]


(* zale\:017cno\:015bci mas m^2/H^2 od liczby e-powi\:0119ksze\:0144 *)
wykresyMasa[x_,rozwiazania0_,masa_,nazwyzm_,ti_,tf_,baza_:{},plik_:"M",sciezka_:Directory[],tytul_:"",legenda_:{},gridt_:{}]:=
(*wykresyMasa[x,rozwiazania0,masa,nazwyzm,ti,tf,baza,plik,osy,sciezka]=*)
Block[{lpol,lrozw,opcje,zakres,zmienneH,listaz,Nt,wykres,framelabel,plotN,kolory,ozn,masat,masatt,Ht,mat,bazat,kolejnosc,rozwt,
legendaw={},plotH,funNi,lp,pp="",styl={},grid},(
lpol=Length[masa]; lrozw=Length[rozwiazania0];
(* opcje wykresu *)
zakres={All,{-3.,All}};
kolory=ColorData[97,"ColorList"];
ozn=Map[Superscript["("<>ToString[#,TraditionalForm]<>"/\!\(\*StyleBox[\"H\",\nFontSlant->\"Italic\"]\))",2] &, nazwyzm];
opcje={Frame->True, AspectRatio->1/GoldenRatio, PerformanceGoal->"Quality", 
	FrameLabel->framelabel, PlotRange->zakres, PlotLabel->tytul, 
	ScalingFunctions->{Identity,"Log"}, PlotPoints->20};

(* liczba e-powi\:0119ksze\:0144 oraz liczby przedzia\[LSlash]\[OAcute]w, legenda i styl linii na wykresie *)
plotN=Flatten[Symbol["nn"][x[[1]]]/.rozwiazania0];
Nt=Reap[Do[
If[Head[plotN[[i]]]===Piecewise,
	(* z produkcj\:0105 cz\:0105stek *)
	(funNi=plotN[[i]];
	Sow[Compile[{{t,_Real}}, funNi /. {x[[1]]->t}, RuntimeOptions->"Speed", RuntimeAttributes->{Listable}]];
	lp=Length[plotN[[i,1]]]-1; pp=pp<>"_pp"<>ToString[lp]; AppendTo[styl,Thick];), 
	(* bez produkcji cz\:0105stek *)
	(Sow[plotN[[i]][[0]]]; lp=0; pp=pp<>"_"; AppendTo[styl,Dashed];)];
	AppendTo[legendaw,ToString[lp]];,
{i,1,lrozw}]][[2,1]];
If[lrozw==1 && lp==0, styl[[1]]=Thick];
legendaw=If[legenda=={}, If[lrozw==1, ozn, legendaw], legenda];
grid=If[gridt!={}, {Flatten[Table[Map[{Nt[[i]][#],kolory[[i]]} &, gridt[[i]]], {i,1,lrozw}],1],None}, {None,None}];

(* parametr Hubble'a *)
plotH=Flatten[Symbol["nn"]'[x[[1]]]/.rozwiazania0];
Ht=Function[t, plotH/.{x[[1]]->t}];

(* rozwi\:0105zania dla t\[LSlash]a i macierz masy *)
rozwt=Function[t, With[{xt=t}, (rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))]];
masatt=Function[t, With[{xt=t}, (masa /. x[[1]]->xt /. rozwt[xt])]];

(* uwaga! Eigensystem sortuje wektory i warto\:015bci w\[LSlash]asne malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania warto\:015bci, 
za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali,
oraz \:017ce pozycja najwi\:0119kszych warto\:015bci w poszczeg\[OAcute]lnych wektorach bazy Freneta powinna odpowiada\[CAcute] 
pozycji najwi\:0119kszych warto\:015bci w wektorach w\[LSlash]asnych (efektywnej) macierzy masy zapisanej w bazie Freneta *)
If[baza!={},
	(kolejnosc=Function[t, With[{xt=t}, Flatten[Ordering[Abs[#],-1] &/@ (baza /. x[[1]]->xt /. rozwt[xt])]]];
	masat[t_]:=masat[t]=Block[{H=Ht[t]^2, wart, wekt, wartK, m=masatt[t]}, 
		Abs[Chop[Reap[Do[({wart,wekt}=Eigensystem[m[[i]]]; 
		wartK = kolejnosc[t] /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wart}]; 
		Sow[wartK/H[[i]]]), {i,1,lrozw}]][[2,1]]]+10^(-16)]];), 
	
	(kolejnosc=Range[lpol];
	masat[t_]:=masat[t]=Block[{H=Ht[t]^2, wart, wekt, wartK, m=masatt[t]}, 
		Abs[Chop[Reap[Do[({wart,wekt}=Eigensystem[m[[i]]]; 
		wartK = kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wart}]; 
		Sow[wartK/H[[i]]]), {i,1,lrozw}]][[2,1]]]+10^(-16)]];)
];

With[{lopcje=opcje},
(* rysowanie wykresu *)
Print[TimeObject[Now]," Wykres masy"];
If[lrozw==1,
	(*(framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)","mass  "<>ToString[lp]};*)
	(framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",""};
	wykres=Legended[Show[Map[ParametricPlot[{Nt[[1]][tt],masat[tt][[1,#]]}, {tt,ti[[1]],tf[[1]]}, Evaluate[Sequence@@lopcje], 
		FrameLabel->framelabel, PlotStyle->Directive[kolory[[#]],styl[[1]],Thickness[0.004]], GridLines->grid, GridLinesStyle->Directive[Thickness[0.004],Opacity[0.5]]] &, Range[lpol]]],
		Placed[SwatchLegend[kolory, legendaw, LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
		LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->50]&), LegendLayout->"Column"],{Right,Top}]];
	Export[FileNameJoin[{sciezka,"masa"<>pp<>".pdf"}],wykres];
	
	Do[framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",ozn[[i]]};	
	wykres=ParametricPlot[{Nt[[1]][tt],masat[tt][[1,i]]}, {tt,ti[[1]],tf[[1]]}, PlotRange->All, Evaluate[Sequence@@lopcje], 
		FrameLabel->framelabel, PlotStyle->Directive[kolory[[1]],styl[[1]],Thickness[0.004]], GridLines->grid, GridLinesStyle->Directive[Thickness[0.004],Opacity[0.5]]];
	Export[FileNameJoin[{sciezka,"masa"<>pp<>"_"<>ToString[i]<>".pdf"}],wykres];, {i,1,lpol}];),

	(Do[framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",ozn[[i]]};
	wykres=Legended[Show[Map[ParametricPlot[{Nt[[#]][tt],masat[tt][[#,i]]}, {tt,ti[[#]],tf[[#]]}, PlotRange->All, Evaluate[Sequence@@lopcje], 
		FrameLabel->framelabel, PlotStyle->Directive[kolory[[#]],styl[[#]],Thickness[0.004]], GridLines->grid, GridLinesStyle->Directive[Thickness[0.004],Opacity[0.5]]] &, Range[lrozw]]],
		Placed[SwatchLegend[kolory, legendaw, LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
			LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->50]&), LegendLayout->"Column"],{Right,Top}]];
	Export[FileNameJoin[{sciezka,"masa"<>pp<>"_"<>ToString[i]<>".pdf"}],wykres];, {i,1,lpol}];)];
];)]


(* zale\:017cno\:015bci element\[OAcute]w bazy od liczby e-powi\:0119ksze\:0144 *)
wykresyBaza[x_,rozwiazania0_,baza_,tytul_:"",sciezka_:Directory[]]:=
(*wykresyBaza[x,rozwiazania0,baza,tytul,sciezka]=*)
Block[{lbaza,opcje,t0,tf,wykres,Nt,listab,framelabel,plotN,plotB,kolory,legenda},(
lbaza=Length[baza];
(* opcje wykres\[OAcute]w *)
{t0,tf}=(rozwiazania0[[1,2]]/.x[[1]]->"Domain")[[1]];
kolory=ColorData[97,"ColorList"];
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)","elementy bazy"};
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, FrameLabel->framelabel, 
	PerformanceGoal->"Quality", PlotRange->All, PlotPoints->20};

(* nazwy element\[OAcute]w wektor\[OAcute]w bazy *)
legenda=Table[Subsuperscript["\!\(\*StyleBox[\"E\",\nFontSlant->\"Italic\"]\)",ToString[i],ToString[j]],{i,0,lbaza-1},{j,0,lbaza-1}];

(* kompilacja liczby e-powi\:0119ksze\:0144 i funkcje bazy *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144 i baza"];
plotN=Symbol["nn"][x[[1]]]/.rozwiazania0;
Nt=Compile[{{t,_Real}}, plotN/.{x[[1]]->t}, RuntimeOptions->"Speed"];

plotB=Abs[baza];
listab[t_]:=listab[t]=Chop[plotB /. x[[1]]->t /.
	(rozwiazania0/.x[[1]]->t/.(z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200])),10^(-50)];	

With[{lim={x[[1]],t0,tf},lopcje=opcje},
(* rysowanie wierszami *)
Do[(Print[TimeObject[Now]," Wykres wierszy ",i];
wykres=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listab[x[[1]]][[i,#]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lbaza]]], Placed[SwatchLegend[kolory, legenda[[i]], LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.17,0.2}]];
Export[FileNameJoin[{sciezka,"E_"<>ToString[i-1]<>".pdf"}],wykres];),{i,lbaza}];

(* rysowanie kolumnami *)
Do[(Print[TimeObject[Now]," Wykres kolumn ",i];
wykres=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listab[x[[1]]][[#,i]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lbaza]]], Placed[SwatchLegend[kolory, Transpose[legenda][[i]], LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.17,0.2}]];
Export[FileNameJoin[{sciezka,"E^"<>ToString[i-1]<>".pdf"}],wykres];),{i,lbaza}];];
)]


(* zale\:017cno\:015bci element\[OAcute]w bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy od liczby e-powi\:0119ksze\:0144 *)
wykresyBazaMasy[x_,Go_,rozwiazania0_,masa_,tytul_:"",sciezka_:Directory[]]:=
(*wykresyBazaMasy[x,Go,rozwiazania0,masa,tytul,sciezka]=*)
Block[{lbaza,zakres,opcje,t0,tf,wykres,plotN,Nt,listab,framelabel,kolory,legenda,rozwt,masat,kolejnosc,Gpola},(
lbaza=Length[masa];
(* opcje wykres\[OAcute]w *)
{t0,tf}=(rozwiazania0[[1,2]]/.x[[1]]->"Domain")[[1]];
zakres=All;
kolory=ColorData[97,"ColorList"];
(*framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)","elementy bazy"};*)
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",""};
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PlotRange->zakres, 
	PerformanceGoal->"Quality", PlotRange->All, FrameLabel->framelabel, PlotPoints->20};

(* nazwy element\[OAcute]w wektor\[OAcute]w bazy *)
legenda=Table[Subsuperscript["\!\(\*StyleBox[\"C\",\nFontSlant->\"Italic\"]\)",ToString[i],ToString[j]],{i,0,lbaza-1},{j,0,lbaza-1}];

(* liczba e-powi\:0119ksze\:0144 i baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144 i baza wektor\[OAcute]w w\[LSlash]asnych macierzy masy"];
plotN=Symbol["nn"][x[[1]]]/.rozwiazania0;
Nt=Compile[{{t,_Real}}, plotN/.{x[[1]]->t}, RuntimeOptions->"Speed"];

rozwt=Function[t, With[{xt=t}, (rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))]];
masat=Function[t, With[{xt=t}, (masa /. x[[1]]->xt /. rozwt[xt])]];
Gpola=Function[t, With[{xt=t}, (Go /. x[[1]]->xt /. rozwt[xt])]];

(* uwaga! Eigenvectors sortuje wektory malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania wektor\[OAcute]w, 
za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
kolejnosc=Range[lbaza];
listab[t_]:=listab[t]=Block[{wekt, Mbaza, m=masat[t], G=Gpola[t]}, 
	(wekt=Eigenvectors[m]; 
	Mbaza = kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wekt}]; 
	Chop[Abs[mrkUzyteczny`ortonormalnaBaza[Mbaza,G]],10^(-50)])];

With[{lim={x[[1]],t0,tf},lopcje=opcje},
(* rysowanie wierszami *)
Do[(Print[TimeObject[Now]," Wykres wierszy ",i];
wykres=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listab[x[[1]]][[i,#]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lbaza]],AxesOrigin->{0,0}], Placed[SwatchLegend[kolory, legenda[[i]], LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{Left,Bottom}]];
Export[FileNameJoin[{sciezka,"MB_"<>ToString[i-1]<>".pdf"}],wykres];),{i,lbaza}];

(* rysowanie kolumnami *)
Do[(Print[TimeObject[Now]," Wykres kolumn ",i];
wykres=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],listab[x[[1]]][[#,i]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lbaza]],AxesOrigin->{0,0}], Placed[SwatchLegend[kolory, Transpose[legenda][[i]], LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.17,0.2}]];
Export[FileNameJoin[{sciezka,"MB^"<>ToString[i-1]<>".pdf"}],wykres];),{i,lbaza}];];
)]


(* zale\:017cno\:015bci pr\:0119dko\:015bci k\:0105towych bazy wektor\[OAcute]w w\[LSlash]asnych macierzy masy od liczby e-powi\:0119ksze\:0144 *)
wykresyParametrowBazaMasy[x_,Go_,rozwiazania0_,masa_,ti_,tf_,tytul_:"",legenda_:{},sciezka_:Directory[],gridt_:{}]:=
(*wykresyParametrowBazaMasy[x,Go,rozwiazania0,masa,ti,tf,tytul,legenda,sciezka,gridt]=*)
Block[{lpol,lrozw,opcje,framelabel,kolory,ozn,legendaw={},plotN,pp="",lp,funNi,Nt,plotH,Ht,styl={},
rozwt,masat,kolejnosc,Gpola,baza,h,parametry,parametryH,tt,wykres,grid,t0},(
lpol=Length[masa]; lrozw=Length[rozwiazania0];
(* opcje wykresu *)
kolory=ColorData[97,"ColorList"];
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio,
	PerformanceGoal->"Quality", PlotPoints->10, PlotRange->All};
(*ScalingFunctions->{Identity,"Log"}, FrameTicks\[Rule]{{LogTicks,None},{Automatic,None}},*)
	
(* nazwy pr\:0119dko\:015bci k\:0105towych bazy *)
ozn=Map["|"<>ToString[#,TraditionalForm]<>"/\!\(\*StyleBox[\"H\",\nFontSlant->\"Italic\"]\)|" &, 
	Take[Join[{OverDot[Symbol["\[Theta]"]],OverDot[Symbol["\[CurlyPhi]"]]},
	Table[Subscript[Symbol[OverDot["\[Alpha]"]],ToString[i]],{i,3,lpol-1}]],lpol-1]];

(* liczba e-powi\:0119ksze\:0144 oraz liczby przedzia\[LSlash]\[OAcute]w, legenda i styl linii na wykresie *)
plotN=Flatten[Symbol["nn"][x[[1]]]/.rozwiazania0];
Nt=Reap[Do[
If[Head[plotN[[i]]]===Piecewise,
	(* z produkcj\:0105 cz\:0105stek *)
	(funNi=plotN[[i]];
	Sow[Compile[{{t,_Real}}, funNi /. {x[[1]]->t}, RuntimeOptions->"Speed", RuntimeAttributes->{Listable}]];
	lp=Length[plotN[[i,1]]]-1; pp=pp<>"_pp"<>ToString[lp]; AppendTo[styl,Thick];), 
	(* bez produkcji cz\:0105stek *)
	(Sow[plotN[[i]][[0]]]; lp=0; pp=pp<>"_"; AppendTo[styl,Dashed];)];
	AppendTo[legendaw,ToString[lp]];,
{i,1,lrozw}]][[2,1]];
If[lrozw==1 && lp==0, styl[[1]]=Thick];
legendaw=If[legenda=={}, If[lrozw==1, ozn, legendaw], legenda];
grid=If[gridt!={}, {Flatten[Table[Map[{Nt[[i]][#],kolory[[i]]} &, gridt[[i]]], {i,1,lrozw}],1],None}, {None,None}];

(* parametr Hubble'a *)
plotH=Flatten[Symbol["nn"]'[x[[1]]]/.rozwiazania0];
Ht=Function[t, plotH/.{x[[1]]->t}];

(* rozwi\:0105zania dla t\[LSlash]a, macierz masy i tensor metryczny w przestrzeni p\[OAcute]l *)
rozwt[t_]:=rozwt[t]=With[{xt=t}, (rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];
masat[t_]:=With[{xt=t}, (masa /. x[[1]]->xt /. rozwt[xt])];
Gpola[t_]:=With[{xt=t}, (Go /. x[[1]]->xt /. rozwt[xt])];

(* uwaga! Eigenvectors sortuje wektory malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania wektor\[OAcute]w, 
za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
kolejnosc=Range[lpol];
baza[t_]:=baza[t]=Block[{wekt, Mbaza, m=masat[t], G=Gpola[t]}, 
	Reap[Do[(wekt=Eigenvectors[m[[i]]]; 
	Mbaza = kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wekt}];  
	Sow[mrkUzyteczny`ortonormalnaBaza[Mbaza,G[[i]]]]), {i,1,lrozw}]][[2,1]]];

(* pr\:0119dko\:015bci k\:0105towe bazy: F_1'(t) = -\[Theta]_1'(t)F_2(t), F_n'(t) = \[Theta]_(n-1)'(t)F_(n-1)(t) - \[Theta]_n'(t)F_(n+1)(t) *)
h=0.0001;
parametry[t_]:=Block[{katy={}, pochodna, c1, c2, rown, mbN=baza[t], mb, mbhN=baza[t+h], mbh}, 
	Do[mbh=mbhN[[i]]; mb=mbN[[i]];
	pochodna=(mbh-mb)/(h);
	AppendTo[katy, Reap[c1=-(pochodna[[1,1]])/mb[[2,1]]; Sow[c1];
	Do[rown={pochodna[[i,1]]==c1*mb[[i-1,1]]-c2*mb[[i+1,1]]};
		c1=Solve[rown,c2][[1,1,2]];
		Sow[c1],{i,2,lpol-1}]][[2,1]]], {i,1,lrozw}]; katy];
				
(*parametryH[t_]:=parametryH[t]=With[{xt=t}, (parametry[xt]/Ht[xt])^2];*)
parametryH[t_]:=parametryH[t]=With[{xt=t}, Abs[parametry[xt]/Ht[xt]]];
(*parametryH[t_]:=parametryH[t]=With[{xt=t}, parametry[xt]/Ht[xt]];*)

(*t0=(tf-ti)/2.;
Print[Map[parametryH[t0[[#]]] &, Range[lrozw]]];*)

With[{lopcje=opcje},
(* rysowanie wykresu *)
Print[TimeObject[Now]," Wykres pr\:0119dko\:015bci k\:0105towych bazy"];
If[lrozw==1,
	(*(framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)","angular velocities  "<>ToString[lp]};*)
	(framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",""};
	wykres=Legended[Show[Map[ParametricPlot[{Nt[[1]][tt],parametryH[tt][[1,#]]}, {tt,ti[[1]],tf[[1]]}, Evaluate[Sequence@@lopcje], 
		FrameLabel->framelabel, PlotStyle->Directive[kolory[[#]],styl[[1]],Thickness[0.004]], GridLines->grid, GridLinesStyle->Directive[Thickness[0.004],Opacity[0.5]]] &, Range[lpol-1]]],
		Placed[SwatchLegend[kolory, legendaw, LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
		LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->50]&), LegendLayout->"Column"],{Right,Top}]];
	Export[FileNameJoin[{sciezka,"katyH_MB"<>pp<>".pdf"}],wykres];
	
	Do[framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",ozn[[i]]};	
	wykres=ParametricPlot[{Nt[[1]][tt],parametryH[tt][[1,i]]}, {tt,ti[[1]],tf[[1]]}, Evaluate[Sequence@@lopcje], 
		FrameLabel->framelabel, PlotStyle->Directive[kolory[[1]],styl[[1]],Thickness[0.004]], GridLines->grid, GridLinesStyle->Directive[Thickness[0.004],Opacity[0.5]]];
	Export[FileNameJoin[{sciezka,"katyH_MB"<>pp<>"_"<>ToString[i]<>".pdf"}],wykres];, {i,1,lpol-1}];),

	(Do[framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",ozn[[i]]};	
	wykres=Legended[Show[Map[ParametricPlot[{Nt[[#]][tt],parametryH[tt][[#,i]]}, {tt,ti[[#]],tf[[#]]}, Evaluate[Sequence@@lopcje], 
		FrameLabel->framelabel, PlotStyle->Directive[kolory[[#]],styl[[#]],Thickness[0.004]], GridLines->grid, GridLinesStyle->Directive[Thickness[0.004],Opacity[0.5]]] &, Range[lrozw]]],
		Placed[SwatchLegend[kolory, legendaw, LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
			LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->50]&), LegendLayout->"Column"],{Right,Top}]];
	Export[FileNameJoin[{sciezka,"katyH_MB"<>pp<>"_"<>ToString[i]<>".pdf"}],wykres];, {i,1,lpol-1}];)];
];)]


(* ::Section:: *)
(*Produkcja cz\:0105stek*)


(* zale\:017cno\:015bci liczb obsadze\:0144 od liczby e-powi\:0119ksze\:0144 *)
wykresyLiczbaObsadzenN[x_,pola_,La_,listao_,rozwiazania0_,rozwiazaniaP_,masa_,ti_,tf_,kw_,tytul_:"",sciezka_:Directory[]]:=
(*wykresyLiczbaObsadzenN[x,pola,La,listao,rozwiazania0,rozwiazaniaP,masa,ti,tf,kw,tytul,sciezka]=*)
Block[{lwidm,lprzebiegow,Go,Xo,Lao,opcje,zakres,wykres,Nt,framelabel,plotN,kolory,legenda,
rozwt,masat,Gpola,a,kolejnosc,baza,pert,wspQu,wsp,pertu,omd,h,wsp\[Beta],lobsadzen,tt},(
lwidm=Length[pola]; lprzebiegow=Length[rozwiazaniaP];
{Go,Xo,Lao}=listao;
(* opcje wykresu *)
zakres={All,{-8.,All}};
(*zakres={All,{-9.,-2.}};*)
kolory=ColorData[97,"ColorList"];
framelabel={"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)", "|\[Beta]\!\(\*SuperscriptBox[\(|\), \(2\)]\)"};
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1, PerformanceGoal->"Quality", 
	PlotRange->zakres, FrameLabel->framelabel, 
	ScalingFunctions->{Identity,"Log"}, PlotPoints->10};
legenda=Map[Subscript["\!\(\*StyleBox[\"n\",\nFontSlant->\"Italic\"]\)",ToString[pola[[#]]]] &, Range[lwidm]];

(* liczba e-powi\:0119ksze\:0144 i funkcja liczby obsadze\:0144 *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144 i liczba obsadze\:0144"];
Nt=(Symbol["nn"][x[[1]]]/.rozwiazania0)[[0]];

rozwt[t_]:=rozwt[t]=With[{xt=t}, (rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];
masat[t_]:=masat[t]=With[{xt=t}, (masa /. x[[1]]->xt /. rozwt[xt])];
Gpola[t_]:=Gpola[t]=With[{xt=t}, (Go /. x[[1]]->xt /. rozwt[xt])];

a[t_]:=a[t]=With[{xt=t}, Exp[Nt[xt]]];

(* uwaga! Eigenvectors sortuje wektory malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania wektor\[OAcute]w, 
za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
kolejnosc=Range[lwidm];
baza[t_]:=baza[t]=Block[{wart, wekt, kol, Mbaza, m=masat[t], G=Gpola[t]}, 
	({wart,wekt}=Eigensystem[m];
	kol=Flatten[Ordering[Abs[#],-1] &/@ wekt];
	Mbaza = kolejnosc /. MapThread[#1->#2 &, {kol, wekt}];
	wart = kolejnosc /. MapThread[#1->#2 &, {kol, wart}];  
	{wart, mrkUzyteczny`ortonormalnaBaza[Mbaza,G]})];

(* perturbacje: {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
pert=Function[t, With[{xt=t}, (rozwiazaniaP /. x[[1]]->xt)]];
(* wsp\[OAcute]\[LSlash]czynniki przej\:015bcia od perturbacji krzywizny i izokrzywizny do wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji: 
{a*(P'(X))^(1/2)/c_s, a*(P'(X))^(1/2)}, gdzie cs - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku, X - cz\[LSlash]on kinetyczny w lagran\:017cjanie P *)
wspQu=Exp[Symbol["nn"][x[[1]]]]*Join[{Sqrt[D[La,Symbol["XK"]]+2*Symbol["XK"]*D[La,{Symbol["XK"],2}]]}, Table[Sqrt[D[La,Symbol["XK"]]],{i,2,lwidm}]] /. Symbol["XK"]->Xo /. Symbol["P"]->0;
wsp=Function[t, With[{xt=t}, (wspQu /. x[[1]]->xt /. rozwt[xt])]];
(* wsp\[OAcute]\[LSlash]poruszaj\:0105ce si\:0119 perturbacje krzywizny i izokrzywizny: {{u\[Sigma]1,u\[Sigma]2,...},{us1,us2,...},...} *)
pertu[t_]:=pertu[t]=With[{xt=t}, wsp[xt]*(baza[xt][[2]].Gpola[xt].Transpose[pert[xt]])];

(* diagonalna macierz cz\:0119sto\:015bci \[Omega]^2=k^2 - a''(\[Tau])/a + a^2*m^2 (gdzie: a''(\[Tau])/a=a'(t)^2+a*a''(t)) *)
omd[t_]:=With[{xt=t, at2=a[t]^2}, Sqrt[(kw^2 - (at2*(Symbol["nn"]'[xt]^2 - (Lao /. Symbol["P"]->0)))/2)*IdentityMatrix[lwidm] +
	at2*DiagonalMatrix[baza[xt][[1]]]] /. x[[1]]->xt /. rozwt[xt]];
(* wsp\[OAcute]\[LSlash]czynnik Bogolyubov'a (macierz); w bazie wiersze odpowiadaj\:0105 kolejnym polom, dlatego B.(B')^T *)
h=0.0001;
wsp\[Beta][t_]:=With[{en=Sqrt[omd[t]], per=pertu[t], perh=pertu[t+h], mb=baza[t][[2]], mbh=baza[t+h][[2]], at=a[t]}, 
	(en.per-I*Inverse[en].((perh-per)/(h) + (mb.Transpose[(mbh-mb)/(h)]).per)*at)/Sqrt[2.]];
(* liczba obsadze\:0144 *)
lobsadzen=Function[t, With[{wspB=wsp\[Beta][t]}, Re[Diagonal[wspB.ConjugateTranspose[wspB]]]]];

Print[lobsadzen[ti],TimeObject[Now]];
Print[lobsadzen[(tf-ti)/2.],TimeObject[Now]];
Print[lobsadzen[tf],TimeObject[Now]];

With[{lim={tt,ti,tf},lopcje=opcje},
(* rysowanie liczb obsadze\:0144 *)
Print[TimeObject[Now]," Wykres"];
wykres=Legended[Show[Map[ParametricPlot[{Nt[tt],lobsadzen[tt][[#]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lwidm]]], Placed[SwatchLegend[kolory, legenda, LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.17,0.2}]];
Export[FileNameJoin[{sciezka,"BN.pdf"}],wykres];];
)]


(* zale\:017cno\:015bci liczb obsadze\:0144 od liczby falowej *)
wykresyLiczbaObsadzenk[x_,pola_,La_,listao_,rozwiazania0_,rozwiazaniaP_,masa_,t0_,kwNorm_,tytul_:"",sciezka_:Directory[]]:=
(*wykresyLiczbaObsadzenk[x,pola,La,listao,rozwiazania0,rozwiazaniaP,masa,t0,kwNorm,tytul,sciezka]=*)
Block[{lpol,Go,Xo,Lao,opcje,zakres,framelabel,kolory,legenda,
rozwt,masat,Gpola,at0,kolejnosc,baza,masyt,
pertk,wspQu,wsp,h,bGt0,bGthp,pertu,pertuhp,omdm,omd,cdcT,wsp\[Beta],lobsadzen,kkw,wykres},(
lpol=Length[pola]; 
{Go,Xo,Lao}=listao;
(* opcje wykresu *)
zakres=All;
kolory=ColorData[97,"ColorList"];
framelabel={"\!\(\*StyleBox[\"k\",\nFontSlant->\"Italic\"]\)/\!\(\*SubscriptBox[StyleBox[\"k\",\nFontSlant->\"Italic\"], \(*\)]\)", "|\[Beta]\!\(\*SuperscriptBox[\(|\), \(2\)]\)"};
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1, 
	ScalingFunctions->{"Log","Log"}, 
	PerformanceGoal->"Quality", 
	PlotPoints->10,
	PlotRange->zakres, FrameLabel->framelabel};
legenda=Map[Subscript["\!\(\*StyleBox[\"n\",\nFontSlant->\"Italic\"]\)",ToString[pola[[#]]]] &, Range[lpol]];

(* funkcja liczby obsadze\:0144 *)
Print[TimeObject[Now]," Liczba obsadze\:0144"];

rozwt[t_]:=rozwt[t]=With[{xt=t}, (rozwiazania0 /. x[[1]]->xt /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200]))];
masat[t_]:=masat[t]=With[{xt=t}, (masa /. x[[1]]->xt /. rozwt[xt])];
Gpola[t_]:=Gpola[t]=With[{xt=t}, (Go /. x[[1]]->xt /. rozwt[xt])];
(* czynnik skali w t0 *)
at0=Exp[Symbol["nn"][t0]] /. rozwt[t0];

(* uwaga! Eigenvectors sortuje wektory malej\:0105co wg absolutnych warto\:015bci warto\:015bci w\[LSlash]asnych;
w celu prawid\[LSlash]owego (odpowiadaj\:0105cego kolejnym polom) uszeregowania wektor\[OAcute]w, 
za\[LSlash]o\:017cono, \:017ce macierz z\[LSlash]o\:017cona z wektor\[OAcute]w w\[LSlash]asnych macierzy masy powinna zawiera\[CAcute] najwi\:0119ksze warto\:015bci na diagonali *)
kolejnosc=Range[lpol];
baza[t_]:=baza[t]=Block[{wekt, Mbaza, m=masat[t], G=Gpola[t]}, 
	(wekt=Eigenvectors[m]; 
	Mbaza = kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wekt}];  
	mrkUzyteczny`ortonormalnaBaza[Mbaza,G])];
masyt=Block[{wart, wekt, m=masat[t0]}, 
	({wart,wekt}=Eigensystem[m]; 
	kolejnosc /. MapThread[#1->#2 &, {Flatten[Ordering[Abs[#],-1] &/@ wekt], wart}])];

(* perturbacje: {{Q1_1,Q2_1,...},{Q1_2,Q2_2,...},...} *)
pertk[kw_]:=pertk[kw]=With[{k=kw}, (rozwiazaniaP /. Symbol["kk"]->k)];
(* wsp\[OAcute]\[LSlash]czynniki przej\:015bcia od perturbacji krzywizny i izokrzywizny do wsp\[OAcute]\[LSlash]poruszaj\:0105cych si\:0119 perturbacji: 
{a*(P'(X))^(1/2)/c_s, a*(P'(X))^(1/2)}, gdzie cs - efektywna pr\:0119dko\:015b\[CAcute] d\:017awi\:0119ku, X - cz\[LSlash]on kinetyczny w lagran\:017cjanie P *)
wspQu=Exp[Symbol["nn"][x[[1]]]]*Join[{Sqrt[D[La,Symbol["XK"]]+2*Symbol["XK"]*D[La,{Symbol["XK"],2}]]}, Table[Sqrt[D[La,Symbol["XK"]]],{i,2,lpol}]] /. Symbol["XK"]->Xo /. Symbol["P"]->0;
wsp[t_]:=With[{xt=t}, (wspQu /. x[[1]]->xt /. rozwt[xt])];
(* wsp\[OAcute]\[LSlash]poruszaj\:0105ce si\:0119 perturbacje krzywizny i izokrzywizny: {{u\[Sigma]1,u\[Sigma]2,...},{us1,us2,...},...} *)
h=0.0001;
bGt0=wsp[t0]*baza[t0].Gpola[t0];
bGthp=wsp[t0+h]*baza[t0+h].Gpola[t0+h];
pertu[kw_]:=With[{bG0=bGt0, per=pertk[kw] /. x[[1]]->t0}, bG0.Transpose[per]];
pertuhp[kw_]:=With[{bGh=bGthp, perh=pertk[kw] /. x[[1]]->t0+h}, bGh.Transpose[perh]];

(* diagonalna macierz cz\:0119sto\:015bci \[Omega]^2=k^2 - a''(\[Tau])/a + a^2*m^2 (gdzie: a''(\[Tau])/a=a'(t)^2+a*a''(t)) *)
omdm=at0^2*(((-Symbol["nn"]'[t0]^2 + (Lao /. Symbol["P"]->0))/2)*IdentityMatrix[lpol] + DiagonalMatrix[masyt]) /. x[[1]]->t0 /. rozwt[t0];
omd[kw_]:=With[{k=kw}, Sqrt[k^2*IdentityMatrix[lpol] + omdm]];
(* wsp\[OAcute]\[LSlash]czynnik Bogolyubov'a (macierz); w bazie wiersze odpowiadaj\:0105 kolejnym polom, dlatego B.(B')^T *)
cdcT=baza[t0].Transpose[(baza[t0+h]-baza[t0])/(h)];
wsp\[Beta][kw_]:=With[{cc=cdcT, at=at0, per=pertu[kw], perh=pertuhp[kw], en=Sqrt[omd[kw]]}, 
	(en.per-I*Inverse[en].((perh-per)/(h) + cc.per)*at)/Sqrt[2.]];	
(* liczba obsadze\:0144 *)
lobsadzen[kw_]:=lobsadzen[kw]=With[{wspB=wsp\[Beta][kw]}, Re[Diagonal[wspB.ConjugateTranspose[wspB]]]];

Print["kwNorm: ", lobsadzen[kwNorm],TimeObject[Now]]; 
Print["1.5: ", lobsadzen[1.5*kwNorm],TimeObject[Now]];
Print["2: ", lobsadzen[2.*kwNorm],TimeObject[Now]];
Print["10: ", lobsadzen[10.*kwNorm],TimeObject[Now]];
Print["20: ", lobsadzen[20.*kwNorm],TimeObject[Now]];

With[{lim={kkw,1.,2.*10},lopcje=opcje},
(* rysowanie liczb obsadze\:0144 *)
Print[TimeObject[Now]," Wykres"];
wykres=Legended[Show[Map[ParametricPlot[{kkw,lobsadzen[kkw*kwNorm][[#]]}, lim, Evaluate[Sequence@@lopcje],
	PlotStyle->kolory[[#]]] &, Range[lpol]]], Placed[SwatchLegend[kolory, legenda, LegendMarkers->"Line", 
	LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black]&), LegendLayout->"Column"],{0.17,0.2}]];
Export[FileNameJoin[{sciezka,"Bk.pdf"}],wykres];];
)]


(* ::Section:: *)
(*Inne wykresy*)


(* przekazane wielko\:015bci (z\[LSlash]o\:017cone z rozwi\:0105za\:0144 dla t\[LSlash]a) w zale\:017cno\:015bci od liczby e-powi\:0119ksze\:0144 *)
wykresyTestoweTlo[funkcje_,x_,rozwiazania0_,listatf_,opisy_,tytul_:"",sciezka_:Directory[]]:=
(*wykresyTestoweTlo[funkcje,x,rozwiazania0,listatf,opisy,tytul,sciezka]=*)
Block[{zakres,Nt,opcje,kolory,plotf,wykres,pp,plotN,drozw,lrozw},(
(* opcje wykres\[OAcute]w *)
(*zakres={All,{-3.,All}};*)
zakres=All;
opcje={Frame->True, PlotLabel->tytul, AspectRatio->1/GoldenRatio, PlotRange->zakres, 
	ScalingFunctions->{Identity,"Log"}, 
	(*ScalingFunctions->{Identity,"Log"}, FrameTicks\[Rule]{{LogTicks,None},{Automatic,None}},*)
	PlotPoints->10};
kolory=ColorData[97,"ColorList"];

lrozw=Length[listatf];
Do[
(* skompilowana liczba e-powi\:0119ksze\:0144 *)
Print[TimeObject[Now]," Liczba e-powi\:0119ksze\:0144"];
plotN=Symbol["nn"][x[[1]]]/.rozwiazania0[[j]];
Nt=Compile[{{t,_Real}}, (plotN/.{x[[1]]->t}), RuntimeOptions->"Speed"];

drozw=D[rozwiazania0[[j]],x[[1]]];

(* przekazane wyra\:017cenia *)
plotf=funkcje;

With[{lim={x[[1]],0.,Last[listatf[[j]]]},lopcje=opcje},
Do[((* funkcje przekazanych wyra\:017ce\:0144 *)
	pp[t_]:=pp[t]=(plotf[[i]] /. {x[[1]]->t} /.
		(rozwiazania0[[j]] /. x[[1]]->t /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200])) /.
		(drozw /. x[[1]]->t /. (z1_->z2_?NumberQ):>(z1->SetPrecision[z2,200])));
		
	(* rysowanie wykresu *)
    Print[TimeObject[Now]," Wykres ",i];
	wykres=Legended[Show[Map[ParametricPlot[{Nt[x[[1]]],pp[x[[1]]][[#]]},lim,Evaluate[Sequence@@lopcje],PlotStyle->Directive[kolory[[#]],Thickness[0.004]], 
		FrameLabel->{"\!\(\*StyleBox[\"N\",\nFontSlant->\"Italic\"]\)",opisy[[i,2]]}] &, Range[Length[plotf[[i]]]]]],
		Placed[SwatchLegend[kolory, opisy[[i,3]], LegendMarkers->"Line", LegendMarkerSize->8, LabelStyle->{FontSize->6}, 
			LegendFunction->(Framed[#,Background->Transparent,FrameStyle->Black,ImageSize->50]&), LegendLayout->"Column"],{Left,Bottom}]];
	Export[FileNameJoin[{sciezka,StringJoin[ToString[opisy[[i,1]]],ToString[j],".pdf"]}],wykres];), {i,Length[plotf]}];	
	];	
,{j,1,lrozw}]
)]


End[];
EndPackage[];
