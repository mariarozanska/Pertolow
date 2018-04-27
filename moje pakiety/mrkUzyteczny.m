(* ::Package:: *)

(* ::Section:: *)
(*Pakiet mrkUzyteczny`*)


(* :Title: U\:017cyteczne funkcje *)

(* :Context: mrkUzyteczny` *)

(* :Author: Maria R\[OAcute]\:017ca\:0144ska-Kami\:0144ska *)

(* :Summary: 
nazwy perturbacji
grupowanie
podstawienia
iloczyn skalarny
ortonormalna baza zorientowana kanonicznie
zapisywanie danych do plik\[OAcute]w
*)

(* :Copyright: *)

(* :Package Version: 1.3 *)

(* :Mathematica Version: 11.0 *)

(* :History:
    Version 1.0, 15.08.2016
    Version 1.1, 06.04.2017
      - tworzenie notebooka oraz pliku txt z r\[OAcute]wnaniami i tabel\:0105 do latexa  
      - wyci\:0105ganie wsp\[OAcute]\[LSlash]czynnik\[OAcute]w z r\[OAcute]wna\:0144
    Version 1.2, 26.04.2017
      - zast\:0105pienie parametru Hubble'a przez czynnik skali
      - r\[OAcute]wnanie ze wsp\[OAcute]\[LSlash]czynnikiem 1 przy wskazanej zmiennej
    Version 1.3, 08.08.2017
      - zast\:0105pienie parametru Hubble'a przez liczb\:0119 e-powi\:0119ksze\:0144
*)

(* :Keywords: *)

(* :Requirements: - *)

(* :Sources: *)

(* :Warnings:
ortonormalnaBaza[]: gdyby co\:015b by\[LSlash]o nie tak (np. z powodu nieprzewidzianej postaci rozwi\:0105zania), 
					to poni\:017cej jest drugi algorytm - nieco wolniejszy, ale prawdopodobnie prawid\[LSlash]owy?
plikTexRow[]: \:017ale przekszta\[LSlash]ca greckie litery w nazwach zmiennych, przez co nie przerabia np. r\[OAcute]wna\:0144 dla perturbacji krzywizny i izokrzywizny
*)

(* :Limitations:
nazwy perturbacji: przez dodanie przedrostka, wyj\:0119te z obiektu
podstawienia: podstawienie parametru Hubble'a
ortonormalna baza zorientowana kanonicznie: dla rzeczywistych wielko\:015bci
*)

(* :Discussion: 
- w tensorze metrycznym perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P
- czynnik skali w tensorze metrycznym musi by\[CAcute] oznaczony przez a

- parametr Hubble'a jest oznaczany przez H
- liczba e-powi\:0119ksze\:0144 jest oznaczana przez nn
*)


BeginPackage["mrkUzyteczny`"];

perturbacjeNazwy::usage="perturbacjeNazwy[prefix,nazwy]: 
prefix - przedrostek dodawany do nazw, 
nazwy - lista nazw; 
wyj\:015bcie: nazwy utworzone przez dodanie przedrostka";

perturbacjeObiekt::usage="perturbacjeObiekt[obiekt,x]: 
obiekt - obiekt (np. tablica, r\[OAcute]wnanie), z kt\[OAcute]rego maj\:0105 zosta\[CAcute] odczytane nazwy perturbacji, 
x - lista nazw wsp\[OAcute]\[LSlash]rz\:0119dnych;\[IndentingNewLine]wyj\:015bcie: nazwy perturbacji (zmiennych zale\:017cnych od wszystkich wsp\[OAcute]\[LSlash]rz\:0119dnych) wyst\:0119puj\:0105ce w podanym obiekcie";

grupowanie::usage="grupowanie[lista,n]: 
lista - lista nazw zmiennych, 
n - numer (pozycji na li\:015bcie) zmiennej, wg kt\[OAcute]rej ma nast\:0105pi\[CAcute] grupowanie;
wyj\:015bcie: lista wykorzystywana do porz\:0105dkowania wyra\:017ce\:0144/r\[OAcute]wna\:0144 (za pomoc\:0105 funkcji Collect)";

podstawienieH::usage="podstawienieH[x]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: podstawienie parametru Hubble'a: {a'[x[[1]]]\[Rule]H[x[[1]]]*a[x[[1]]]}";
zastapienieH::usage="zastapienieH[x]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: wyra\:017cenie parametru Hubble'a przez czynnik skali: {H[x[[1]]]\[Rule]a'[x[[1]]]/a[x[[1]]]}";
zastapienieHN::usage="zastapienieHN[x]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: wyra\:017cenie parametru Hubble'a przez liczb\:0119 e-powi\:0119ksze\:0144: {H[x[[1]]]\[Rule]nn'[x[[1]]]}";
zastapienieaN::usage="zastapienieaN[x]: 
x - lista zmiennych, w kt\[OAcute]rych zapisany jest tensor metryczny;
wyj\:015bcie: wyra\:017cenie czynnika skali przez liczb\:0119 e-powi\:0119ksze\:0144: {a[x[[1]]]\[Rule]Exp[nn[x[[1]]]]}";

wspolczynnik1Row::usage="wspolczynnik1Row[row,gl]: 
row - r\[OAcute]wnanie,
gl - zmienna, przy kt\[OAcute]rej wsp\[OAcute]\[LSlash]czynnik ma by\[CAcute] r\[OAcute]wny 1;
wyj\:015bcie: r\[OAcute]wnanie ze wsp\[OAcute]\[LSlash]czynnikiem 1 przy wskazanej zmiennej";

wspolczynnikiRow::usage="wspolczynnikiRow[row,gl,zmienne]: 
row - r\[OAcute]wnanie,
gl - zmienna, przy kt\[OAcute]rej wsp\[OAcute]\[LSlash]czynnik ma by\[CAcute] r\[OAcute]wny 1,
zmienne - lista zmiennych, dla kt\[OAcute]rych maj\:0105 zosta\[CAcute] znalezione wsp\[OAcute]\[LSlash]czynniki;
wyj\:015bcie: lista wsp\[OAcute]\[LSlash]czynnik\[OAcute]w pobrana z podanego r\[OAcute]wnania dla wskazanych zmiennych";

iloczynSkalarnyG::usage="iloczynSkalarnyG[g,v1,v2]: 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P), 
v1 i v2 - obiekty z przestrzeni z podanym tensorem metrycznym;
wyj\:015bcie: iloczyn skalarny: \!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)\!\(\*SubsuperscriptBox[\(v\), \(1\), \(\[Mu]\)]\)\!\(\*SubsuperscriptBox[\(v\), \(2\), \(\[Nu]\)]\)";

orientacjaKanoniczna::usage="orientacjaKanoniczna[baza,g]: 
baza - baza; 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: baza w przestrzeni z metryk\:0105 g zorientowana kanonicznie, tzn. Sqrt[|det(g)|]*det(baza)=1";

ortonormalnaBaza::usage="ortonormalnaBaza[baza,g]: 
baza - baza; 
g - tensor metryczny (uwaga! w metryce perturbacje musz\:0105 by\[CAcute] pomno\:017cone przez parametr P);
wyj\:015bcie: ortonormalna baza w przestrzeni z metryk\:0105 g zorientowana kanonicznie";

plikNb::usage="plikNb[lista,nazwa,sciezka:Directory[]]: 
lista - lista opis\[OAcute]w i wyra\:017ce\:0144 w formie {{opis, wyra\:017cenie}, ...},
nazwa - nazwa pliku,
sciezka - \:015bcie\:017cka do miejsca, gdzie ma zosta\[CAcute] zapisany notebook;
wyj\:015bcie: notebook, zawieraj\:0105cy podane wyra\:017cenia";

plikTex::usage="plikTex[pola,lista]: 
pola - lista nazw p\[OAcute]l,
lista - lista wyra\:017ce\:0144;
wyj\:015bcie: string, zawieraj\:0105cy podane wyra\:017cenia w formie latexowej";

plikTexRow::usage="plikTexRow[pola,lista,nazwa,sciezka:Directory[]]: 
pola - lista nazw p\[OAcute]l,
lista - lista opis\[OAcute]w i wyra\:017ce\:0144 w formie {{opis, wyra\:017cenie}, ...}, 
nazwa - nazwa pliku,
sciezka - \:015bcie\:017cka do miejsca, gdzie ma zosta\[CAcute] zapisany plik txt;
wyj\:015bcie: plik txt, zawieraj\:0105cy podane r\[OAcute]wnania w formie latexowej";

plikTexBaza::usage="plikTexBaza[pola,lista,nazwa,sciezka:Directory[]]: 
pola - lista nazw p\[OAcute]l,
lista - lista z opisem i baz\:0105 w formie {opis, baza}, 
nazwa - nazwa pliku,
sciezka - \:015bcie\:017cka do miejsca, gdzie ma zosta\[CAcute] zapisany plik txt;
wyj\:015bcie: plik txt, zawieraj\:0105cy baz\:0119 dla perturbacji krzywizny i izokrzywizny w formie latexowej";

plikTexTabela::usage="plikTexTabela[opisy,wartosci,nazwa,sciezka:Directory[]]: 
opisy - lista nag\[LSlash]\[OAcute]wk\[OAcute]w tabeli - wymagane, gdy plik jeszcze nie istnieje,
wartosci - lista warto\:015bci, kt\[OAcute]re maj\:0105 zosta\[CAcute] dopisane do tabeli w formie wiersza (uwaga! warto\:015bci musi by\[CAcute] tyle samo, co kolumn w tabeli), 
nazwa - nazwa pliku,
sciezka - \:015bcie\:017cka do miejsca, gdzie ma zosta\[CAcute] zapisany plik txt;
wyj\:015bcie: plik txt, zawieraj\:0105cy tabel\:0119 w formie latexowej - je\:017celi plik ju\:017c istnieje, dopisywany jest kolejny wiersz (u g\[OAcute]ry pliku znajduje si\:0119 zako\:0144czenie tabeli)";

Begin["`Private`"];


(* ::Section:: *)
(*Nazwy perturbacji*)


(* nazwy utworzone przez dodanie podanego przedrostka *)
perturbacjeNazwy[prefix_,nazwy_]:=perturbacjeNazwy[prefix,nazwy]=Map[ToExpression[prefix<>ToString[#]] &, nazwy]


(* nazwy perturbacji z podanego obiektu *)
perturbacjeObiekt[obiekt_,x_]:=perturbacjeObiekt[obiekt,x]=Block[{pero},(
(* za\[LSlash]. perturbacje zale\:017c\:0105 od wszystkich wsp\[OAcute]\[LSlash]rz\:0119dnych *)
pero=(Cases[obiekt, __[Sequence@@x], Infinity]//Union); 
(* pozbycie si\:0119 [Sequence@@x] *)
pero=Map[Head,pero];
(* pozbycie si\:0119 pochodnych *)
Cases[pero, _Symbol, Infinity]//Union)]


(* ::Section:: *)
(*Grupowanie*)


(* lista wykorzystywana do porz\:0105dkowania wyra\:017ce\:0144/r\[OAcute]wna\:0144 *)
grupowanie[lista_,n_]:=grupowanie[lista,n]=
Join[{Derivative[___][lista[[n]]][__],lista[[n]][__]},Map[Derivative[___][#][__]&,Delete[lista,n]],Map[#[__] &,Delete[lista,n]]]


(* ::Section:: *)
(*Podstawienia*)


(* podstawienie parametru Hubble'a *)
podstawienieH[x_]:=podstawienieH[x]={Symbol["a"]'[x[[1]]]->Symbol["H"][x[[1]]]*Symbol["a"][x[[1]]]}

(* wyra\:017cenie parametru Hubble'a przez czynnik skali *)
zastapienieH[x_]:=zastapienieH[x]={Symbol["H"][x[[1]]]->Symbol["a"]'[x[[1]]]/Symbol["a"][x[[1]]]}

(* wyra\:017cenie parametru Hubble'a przez liczb\:0119 e-powi\:0119ksze\:0144 *)
zastapienieHN[x_]:=zastapienieHN[x]={Symbol["H"][x[[1]]]->Symbol["nn"]'[x[[1]]]}

(* wyra\:017cenie czynnika skali przez liczb\:0119 e-powi\:0119ksze\:0144 *)
zastapienieaN[x_]:=zastapienieaN[x]={Symbol["a"][x[[1]]]->Exp[Symbol["nn"][x[[1]]]]}


(* ::Section:: *)
(*Wsp\[OAcute]\[LSlash]czynniki*)


(* r\[OAcute]wnanie ze wsp\[OAcute]\[LSlash]czynnikiem 1 przy wskazanej zmiennej *)
wspolczynnik1Row[row_,gl_]:=wspolczynnik1Row[row,gl]=
Block[{lhs,rhs,wyr,coef},(
(* przeniesienie wszystkich wyraz\[OAcute]w na jedn\:0105 stron\:0119 *)
{lhs,rhs}=row/.{Equal->List};
wyr=lhs-rhs;

(* podzielenie przez wsp\[OAcute]\[LSlash]czynnik przy wskazanym g\[LSlash]\[OAcute]wnym wyrazie *)
coef=Coefficient[wyr,gl];
wyr=wyr/coef;

(* r\[OAcute]wnanie ze wsp\[OAcute]\[LSlash]czynnikiem 1 przy wskazanej zmiennej *)
wyr==0)]


(* lista wsp\[OAcute]\[LSlash]czynnik\[OAcute]w pobrana z podanego r\[OAcute]wnania dla wskazanych zmiennych *)
wspolczynnikiRow[row_,gl_,zmienne_]:=wspolczynnikiRow[row,gl,zmienne]=
Block[{wyr},(
(* podzielenie przez wsp\[OAcute]\[LSlash]czynnik przy wskazanym g\[LSlash]\[OAcute]wnym wyrazie *)
wyr=wspolczynnik1Row[row,gl][[1]];

(* wsp\[OAcute]\[LSlash]czynniki przy podanych zmiennych *)
Coefficient[wyr,zmienne])]


(* ::Section:: *)
(*Iloczyn skalarny*)


(* iloczyn skalarny w przestrzeni z podan\:0105 metryk\:0105 *)
iloczynSkalarnyG[g_,v1_,v2_]:=iloczynSkalarnyG[g,v1,v2]=
Block[{max,g0},(max=Dimensions[g][[1]];
(* w iloczynie wykorzystywany jest nieperturbowany tensor metryczny *)
g0=(g/.{Symbol["P"]->0});
(* iloczyn skalarny *)
If[max==1, Simplify[Flatten[g0*v1*v2][[1]], TimeConstraint->5], Simplify[Dot[g0,v1,v2], TimeConstraint->5]])]
(*Simplify[Sum[g0[[I,J]]*v1[[I]]*v2[[J]],{I,1,max},{J,1,max}]]*)


(* ::Section:: *)
(*Ortonormalna baza zorientowana kanonicznie*)


(* baza zorientowana kanonicznie *) 
orientacjaKanoniczna[baza_,g_]:=orientacjaKanoniczna[baza,g]=
Block[{m,warunek},(
m=baza;
(* zorientowanie bazy kanonicznie (tzn. Sqrt[|det(G)|]*det(E)=1 - je\:017celi wysz\[LSlash]o -1, nast\:0119puje zmiana znak\[OAcute]w we wszystkich sk\[LSlash]adowych ostatniego wektora) *)
warunek=Simplify[Det[m]Sqrt[Abs[Det[g/.{Symbol["P"]->0}]]], Element[___,Reals], TimeConstraint->5];
If[warunek!=1.,m[[-1]]=m[[-1]]*(-1)]; 
m)]

(*(* =====================\[Equal] inny algorytm - nieco wolniejszy, ale na pewno prawid\[LSlash]owy???? ==================== *)
(* zorientowanie bazy kanonicznie (tzn. Sqrt[|det(G)|]*det(E)=1) - za\[LSlash]. wszystkie funkcje wyst\:0119puj\:0105ce w lagran\:017cjanie s\:0105 rzeczywiste *)
(* z warunku na orientacj\:0119 otrzyma si\:0119 warunkowe rozwi\:0105zanie: {{-1,warunek},{1,True}} lub {{1,warunek},{-1,True}} *)
warunek=Simplify[Det[Ebaza]Sqrt[Abs[Det[g/.{Symbol["P"]\[Rule]0}]]],Element[___,Reals], TimeConstraint\[Rule]0.01][[1,1]];
Ebaza=Simplify[Ebaza, warunek[[2]] && Element[___,Reals]];
(* je\:017celi warunek odpowiada\[LSlash] orientacji -1, nast\:0119puje zmiana znak\[OAcute]w we wszystkich sk\[LSlash]adowych ostatniego wektora) *)
If[warunek[[1]]\[Equal]-1,Ebaza[[-1]]\[Equal]-Ebaza[[-1]]];
(* zwracana ortonormalna baza zorientowana kanonicznie *)
Ebaza)]*)


(* ortonormalna baza zorientowana kanonicznie *) 
ortonormalnaBaza[baza_,g_]:=ortonormalnaBaza[baza,g]=
Block[{max,isg,n,Ebaza,solcon,solcon2,Erob,sols,vecs,warunek},(
max=Length[baza];
(* iloczyn skalarny w przestrzeni z podan\:0105 metryk\:0105 *)
isg[v1_,v2_]:=iloczynSkalarnyG[g,v1,v2];

(* pierwszy wektor bazy ortonormalnej E *)
Erob=baza[[1]]/Sqrt[isg[baza[[1]],baza[[1]]]]; 
Ebaza={Erob}; 

(* pozosta\[LSlash]e wektory *)
For[n=2,n<=max,n++,
	(* wektor ortogonalny - ortogonalizacja Grama-Schmidta *)
	Erob=Simplify[baza[[n]]-Sum[Projection[baza[[n]],Ebaza[[i]],isg],{i,1,n-1}], TimeConstraint->5];
	(* unormowanie wektora do 1 (za\[LSlash]. wszystkie wielko\:015bci s\:0105 rzeczywiste) *)
	Erob=Simplify[Erob/Sqrt[isg[Erob,Erob]],Element[___,Reals], TimeConstraint->5];
	(* rozk\[LSlash]ad wektora na podwyra\:017cenia i znalezienie rozwi\:0105zania z warunkiem (co oznacza, \:017ce dla takiego rozwi\:0105zania by\[LSlash]y dwie mo\:017cliwo\:015bci +rozw i -rozw) *)
	(* wektor ze wszystkimi rozwi\:0105zaniami dla poszczeg\[OAcute]lnych sk\[LSlash]adowych (lista list, np. {{+rozw1,-rozw1},{+rozw2,-rozw2},{rozw3}}) *)
	sols=Table[(solcon=Cases[Erob[[I]],{___},1]; solcon2=Cases[Erob[[I]],Abs[___],{1,2}];
	If[Length[solcon]==0,If[Length[solcon2]==0,{Erob[[I]]},Simplify[{Erob[[I]],-Erob[[I]]}/.Abs[___]->solcon2[[1,1]], TimeConstraint->5]],
		{solcon[[1,1,1]],-solcon[[1,1,1]]}]),{I,1,max}];
	(* wektor ze wszystkimi mo\:017cliwymi wektorami - kombinacjami mo\:017cliwych warto\:015bci sk\[LSlash]adowych, np. {{+rozw1,-rozw2,rozw3},...} *)
	vecs=Tuples[sols];
	(* znalezienie pierwszego ortonormalnego wektora i do\[LSlash]\:0105czenie go do ortonormalnej bazy E *)
	(*Erob=FirstCase[vecs,vi_ /; (Length[Cases[Chop[Table[isg[Ebaza[[i]],vi],{i,1,n-1}]],Except[0]]]==0)];*)
	Erob=FirstCase[vecs,vi_ /; AllTrue[Table[isg[Ebaza[[i]],vi],{i,1,n-1}], # == 0. &]];
	Ebaza=Append[Ebaza,Erob]]; 

(* ta wersja nie upraszcza wyra\:017ce\:0144 *)
(*Ebaza=Orthogonalize[baza,isg];*)
(* zorientowanie bazy kanonicznie (tzn. Sqrt[|det(G)|]*det(E)=1 - je\:017celi wysz\[LSlash]o -1, nast\:0119puje zmiana znak\[OAcute]w we wszystkich sk\[LSlash]adowych ostatniego wektora) *)
Ebaza=orientacjaKanoniczna[Ebaza,g];
(*If[Simplify[Det[Ebaza]Sqrt[Abs[Det[g/.{Symbol["P"]->0}]]],Element[___,Reals], TimeConstraint->5]!=1.,Ebaza[[max]]=Ebaza[[max]]*(-1)];*)
(* zwracana ortonormalna baza zorientowana kanonicznie *) 
Ebaza)]


(* ::Section:: *)
(*Zapisywanie danych do plik\[OAcute]w*)


(* tworzenie notebooka *) 
plikNb[lista_,nazwa_,sciezka_:Directory[]]:=plikNb[lista,nazwa,sciezka]=
Block[{plik,nb,wpis},(
(* \:015bcie\:017cka do pliku *)
plik=FileNameJoin[{sciezka,nazwa}];
(* tworzenie wpisu *)
wpis=Map[{TextCell[#[[1]],"Subsubsection"],ExpressionCell[#[[2]],"Output"]} &, lista]//Flatten;
(* tworzenie notebooka *)
nb=CreateDocument[wpis,NotebookFileName->plik];
NotebookSave[nb]; NotebookClose[nb];
)]


(* przerabianie wzor\[OAcute]w do latexa *) 
plikTex[pola_,lista_]:=plikTex[pola,lista]=
Block[{plik,wpis,polatex,str,lpol,regex,pochodne,zmianap,zmianat,zmianaMS,indeksyRS,zmianaRS},(
lpol=Length[pola];

(* latexowe nazwy p\[OAcute]l *)
polatex=StringDelete[ToString[TeXForm[pola]],{"\\{","\\}",Whitespace}];

(* skasowanie niepotrzebnych znak\[OAcute]w *)
(*str=Map[StringDelete[StringDelete[ToString[TeXForm[#[[2]]]],{"\\left","\\{","\\}","\\right","(t)","$",Whitespace}],"("<>Sequence@@polatex<>")"] &, lista];*)
str=Map[StringDelete[StringDelete[ToString[TeXForm[#]],{"\\left","\\{","\\}","\\right","(t)","$",Whitespace}],"("<>Sequence@@polatex<>")"] &, lista];

polatex=StringSplit[polatex,","];
(* wyra\:017cenie regularne, znajduj\:0105ce pochodne po polach *)
regex=RegularExpression["\\^\\{\\("<>StringJoin[Table["(\\d),?",lpol]]<>"\\)\\}"];
(* zamiana liczbowych oznacze\:0144 pochodnych po polach na nazwy p\[OAcute]l *)
pochodne=Map[ToExpression[StringSplit[StringDelete[#,{"^","(",")","{","}"}],","]] &, StringCases[str,regex]];
zmianap=Map[Table["^{("<>StringDelete[ToString[#[[i]]],{Whitespace,"{","}"}]<>")}" -> "_{"<>Flatten[MapThread[ConstantArray,{polatex,#[[i]]}]]<>"}", {i,Length[#]}] &, pochodne];
str=Map[StringReplace[str[[#]], zmianap[[#]]] &, Range[Length[str]]];

(* zamiana prim\[OAcute]w - pochodnych po czasie - na kropki oraz usuni\:0119cie oznacze\:0144 \text{} *)
zmianat={Map[#<>"''" -> "\\ddot{"<>#<>"}" &, polatex], Map[#<>"'" -> "\\dot{"<>#<>"}" &, polatex],
	{RegularExpression["\\\\text\\{([^{]+?)\\}''"] -> "\\ddot{$1}", RegularExpression["\\\\text\\{([^{]+?)\\}'"] -> "\\dot{$1}", 
	RegularExpression["\\\\text\\{(.*?)\\}"] -> "$1"}}//Flatten;
str=Map[StringReplace[#, zmianat]&, str];


(* ============ korzystam z wiedzy jakie mam oznaczenia w pakietach - czy nie powinnam tego przenie\:015b\[CAcute]? ==================== *)
(* usuni\:0119cie oznacze\:0144 zmiennych fourierowskich kw i zamiana oznaczenia kw na k *)
str=Map[StringReplace[#, {RegularExpression["([^{])kw"] -> "$1 ","kw"->"k"}] &, str];

(* zamiana nazw zmiennych Mukhanova-Sasakiego na nazwy z dolnym indeksem *)
zmianaMS=Map["Q"<># -> "Q_"<># &, polatex];
str=Map[StringReplace[#, zmianaMS] &, str];

(* zamiana nazw zmiennych perturbacji krzywizny i izokrzywizny na nazwy z dolnym indeksem *)
indeksyRS=Join[{"\[Sigma]"},Table["s"<>ToString[J],{J,1,lpol-1}]];
zmianaRS=Map["Q"<># -> "Q_{"<>ToString[TeXForm[#]]<>"}" &, indeksyRS];
str=Map[StringReplace[#, zmianaRS] &, str]
)]


(* tworzenie pliku txt z r\[OAcute]wnaniami do latexa *) 
plikTexRow[pola_,lista_,nazwa_,sciezka_:Directory[]]:=plikTexRow[pola,lista,nazwa,sciezka]=
Block[{plik,wpis,rownania,str,lpol},(lpol=Length[pola];
(* \:015bcie\:017cka do pliku *)
plik=FileNameJoin[{sciezka,nazwa<>"R.txt"}];

(* wprowadzenie latexowych oznacze\:0144 *)
rownania=Map[#[[2]] &, lista];
str=plikTex[pola,rownania];

(* podzia\[LSlash] na oddzielne r\[OAcute]wnania *)
str=Map[StringSplit[#,","] &, str];
str=Map[{"\\begin{align}", 
	Drop[Flatten[Map[{"\\everybeforeautobreak{+}","\\begin{autobreak}",Sequence@@StringSplit[StringReplace[#, "+" -> "+++"],"++"],"\\end{autobreak}",
	"\\label{"<>ToString[Unique["modrow"]]<>"}","\\\\"} &, #]],-1], 
	"\\end{align}"} &, str];

(* tworzenie wpisu *)
wpis=Map[{lista[[#,1]]<>":",Sequence@@str[[#]]} &, Range[Length[lista]]]//Flatten;

(* tworzenie pliku txt *)
Export[plik,wpis];
)]


(* tworzenie pliku txt z r\[OAcute]wnaniami do latexa *) 
plikTexBaza[pola_,lista_,nazwa_,sciezka_:Directory[]]:=plikTexBaza[pola,lista,nazwa,sciezka]=
Block[{plik,wpis,elementy,str,lpol,wektory,indeksyRS,baza},(lpol=Length[pola];
(* \:015bcie\:017cka do pliku *)
plik=FileNameJoin[{sciezka,nazwa<>"B.txt"}];

(* wprowadzenie latexowych oznacze\:0144 *)
elementy=Flatten[lista[[2]]];
str=plikTex[pola,elementy];

(* podzia\[LSlash] na oddzielne elementy *)
str=StringSplit[str,","];
(* podzia\[LSlash] na wektory *)
wektory=Partition[str,{lpol}];

(* ============ korzystam z wiedzy jakie mam oznaczenia w pakietach - czy nie powinnam tego przenie\:015b\[CAcute]? ==================== *)
(* nazwy element\[OAcute]w bazy dla perturbacji krzywizny i izokrzywizny *)
indeksyRS=Join[{"\\sigma"},Table["s_"<>ToString[J],{J,1,lpol-1}]];
baza=Map["E_{"<>indeksyRS[[#]]<>"}^I="<>ToString[Flatten[wektory[[#]]]] &, Range[lpol]];

(* latexowe r\[OAcute]wnania *)
str={"\\begin{align}", Sequence@@Drop[Flatten[Map[{"\\begin{autobreak}","\\MoveEqLeft[0.]",
	Sequence@@StringSplit[StringReplace[#, {"," -> ",,,",RegularExpression["=\\{"] -> "=\\Big\\{",RegularExpression["\\}$"] -> "\\Big\\}"}],",,"],
	"\\end{autobreak}", "\\\\"} &, baza]],-1], "\\label{"<>"modbaza"<>"}", "\\end{align}"};

(* tworzenie wpisu *)
wpis={lista[[1]]<>":",Sequence@@str};

(* tworzenie pliku txt *)
Export[plik,wpis];
)]


(* tworzenie pliku txt z tabel\:0105 do latexa *) 
plikTexTabela[opisy_,wartosci_,nazwa_,sciezka_:Directory[]]:=plikTexTabela[opisy,wartosci,nazwa,sciezka]=
Block[{lkol,plikNazwa,plik,wpis,str},(lkol=Length[opisy];
(* \:015bcie\:017cka do pliku *)
plikNazwa=FileNameJoin[{sciezka,nazwa}];

(* latexowy wpis do tabeli *)
str=StringRiffle[Map["$"<>ToString[TeXForm[#]]<>"$" &, wartosci]," & "]<>" \\\\ \\hline \n";

(* je\:017celi plik jeszcze nie istnieje, to do pliku zapisywana jest te\:017c ca\[LSlash]a budowa tabeli *)
wpis=If[FileExistsQ[plikNazwa], str, 
	"\\caption{}\n\\label{}\n\\end{longtable}\n\n"<>
	"\\LTcapwidth=\\linewidth\n"<>"\\newcolumntype{C}[1]{>{\\centering\\let\\newline\\\\\\arraybackslash\\hspace{0pt}}m{#1}}\n"<>
	"\\begin{longtable}[c]{|"<>StringJoin[Table["C{1.4cm}|",lkol]]<>"} \\hline\n"<>
	StringRiffle[Map["$"<>ToString[TeXForm[#]]<>"$" &,opisy]," & "]<>" \\\\ \\hline\\hline \n"<>str];

(* tworzenie pliku txt *)
plik = OpenAppend[plikNazwa, PageWidth -> Infinity];
WriteString[plik, wpis];
Close[plik];
)]


End[];
EndPackage[];
