unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, jpeg, ExtCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  a1,b1,a2,b2,a3,b3,a4,b4,x,e:real;

implementation

{$R *.dfm}
function f(x:real):real;
  begin
    f := 3*x-sin(x)-1;
  end;

function g(x:real):real;
  begin
    g := (x*x*x)-(2*(x*x))-x+0.4;
  end;

function f1(x:real):real;
  begin
    f1 := 3-cos(x);
  end;

function f2(x:real):real;
  begin
    f2 := sin(x);
  end;

function fi1(x:real):real;
  begin
    fi1 := power(((2*(x*x))+x-0.4),1/3);
  end;

function fi2(x:real):real;
  begin
    if (x>0) then fi2 := power(((x*x*x)-x+0.4),1/2)
    else fi2 := (power((((x*x*x)-x+0.4)/2),1/2))*(-1);
  end;

function fi3(x:double):real;
  begin
   fi3 := (x*x*x)-(2*(x*x))+0.4;
  end;

procedure local1(a,b:real;n:integer);
var
    h,x:real;
begin
    h:=(b-a)/n;
    x:=a;
while x<=b-h do
    begin
      if ( f(x)*f(x+h) )<0 then
        begin
        x:=SimpleRoundTo(x,-4);
        b1:=x+h;
        b1:=SimpleRoundTo(b1,-4);
        Form3.Memo1.Lines.Add('Локализация:');
        Form3.Memo1.Lines.Add('a = ' + floattostr(x));
        Form3.Memo1.Lines.Add('b = ' + floattostr(b1));
        a1:=x;
        end;
      x:=x+h;
    end;
end;

procedure local2(a,b:real;n:integer);
var
		h,x:real;
begin
	h:=(b-a)/n;
	x:=a;
	while x<=(b-h) do
		begin
			if ( g(x)*g(x+h) )<0 then
				begin
					if (a2=0) then
						begin
							a2:=x;
							b2:=x+h;
						end
						else if (a3=0) then
							 	begin
									a3:=x;
									b3:=x+h;
								end
								else if (a4=0) then
									 	begin
											a4:=x;
											b4:=x+h;
										end;
				end;
			x:=x+h;
		end;
    a2:=SimpleRoundTo(a2, -4);
    b2:=SimpleRoundTo(b2, -4);
    a3:=SimpleRoundTo(a3, -4);
    b3:=SimpleRoundTo(b3, -4);
    a4:=SimpleRoundTo(a4, -4);
    b4:=SimpleRoundTo(b4, -4);
  Form3.Memo1.Lines.Add('Локализация:');
	Form3.Memo1.Lines.Add('a1 = ' + floattostr(a2));
	Form3.Memo1.Lines.Add('b1 = ' + floattostr(b2));
	Form3.Memo1.Lines.Add('a2 = ' + floattostr(a3));
	Form3.Memo1.Lines.Add('b2 = ' + floattostr(b3));
	Form3.Memo1.Lines.Add('a3 = ' + floattostr(a4));
	Form3.Memo1.Lines.Add('b3 = ' + floattostr(b4));
  Form3.Memo1.Lines.Add('--------------------');
end;

procedure poldel(a,b:real);
var
  c:real;
begin
  repeat
    c:=((a+b)/2);
    if ( f(b)*f(c) )<0 then a:=c
    else b:=c;
  until ( abs(b-a)<=e );
  c:=SimpleRoundTo(c,-6);
  Form3.Memo1.Lines.Add('Методом половинного деления:');
  Form3.Memo1.Lines.Add(floattostr(c));
end;

procedure newton(x:real);
var
  a,b,c,xk:real;
begin
  a:=a1;
  b:=b1;
  if ( (f(a)*f2(a))>0 ) then x:=a
  else x:=b;
  repeat
    xk:=x-f(x)/f1(x);
    c:=abs(x-xk);
    x:=xk;
  until (c<e) ;
  x:=SimpleRoundTo(x,-6);
  Form3.Memo1.Lines.Add('Методом Ньютона:');
  Form3.Memo1.Lines.Add(floattostr(x));
end;

procedure sek(a,b:real);
var
  p,y1,y2,xk:real;
begin
	y1:=g(b);
	repeat
		y2:=g(a);
		xk:=a-y2*(a-b)/(y2-y1);
		p:=abs(a-xk);
		a:=xk;
	until(p<e);
	Form3.Memo1.Lines.Add(floattostr(xk));
end;

procedure Iter(a,b:real);
var
  y,x,c:real;
begin
  x:=(a+b)/2;
		repeat
			if (a=a2) then
				begin
					y:=fi2(x);
				end;
			if (a=a3) then
				begin
					y:=fi3(x);
				end;
			if (a=a4) then
		  		begin
					y:=fi1(x);
				end;    
			c:=abs(x-y);
			x:=y;
    until (c<e) ;
    x:=SimpleRoundTo(x, -4);
  if (a=a2) then Form3.Memo1.Lines.Add('1-й корень = '
  + floattostr(x));
  if (a=a3) then Form3.Memo1.Lines.Add('2-й корень = '
  + floattostr(x));
  if (a=a4) then Form3.Memo1.Lines.Add('3-й корень = '
  + floattostr(x));
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  a,b:real;
  n:integer;
begin
  a:=StrToFloat(Edit1.Text);
  b:=StrToFloat(Edit2.Text);
  n:=StrToInt(Edit3.Text);
  e:=strtofloat(Edit4.Text);
  local1(a,b,n);
  poldel(a1,b1);
  newton(x);
end;

procedure TForm3.Button2Click(Sender: TObject);
var
  a,b:real;
  n:integer;
begin
  a:=StrToFloat(Edit1.Text);
  b:=StrToFloat(Edit2.Text);
  n:=StrToInt(Edit3.Text);
  e:=strtofloat(Edit4.Text);
  local2(a,b,n);
  Form3.Memo1.Lines.Add('Методом секущих: ');
  sek(a2,b2);
  sek(a3,b3);
  sek(a4,b4);
  Form3.Memo1.Lines.Add('--------------------');
  Form3.Memo1.Lines.Add('Методом простых итераций: ');
  Iter(a2,b2);
  Iter(a3,b3);
  Iter(a4,b4);
  a2:=0;
  b2:=0;
  a3:=0;
  b3:=0;
  a4:=0;
  b4:=0;
end;
end.
