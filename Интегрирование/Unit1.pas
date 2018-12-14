unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Math;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Image1: TImage;
    Image2: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function fa(x:real):real;
begin
  fa:=1/(sqrt(x*x-x+1))
end;

function fb(x:real):real;
begin
  fb:=cos(x)/(4+(sin(x)*sin(x)));
end;

procedure LevPr1(a,b:real;n:integer);
var
  h,x,c1:real; i:integer;
begin
  h:=(b-a)/n;
  for i:=0 to n-1 do
    begin
      x:=a+h*i;
      c1:=c1+fa(x);
    end;
  c1:=c1*h;
  c1:=SimpleRoundTo(c1,-6);
  Form1.Memo1.Lines.Add(floattostr(c1));
end;

procedure PravPr1(a,b:real;n:integer);
var
  x,h,c2:real; i:integer;
begin
  h:=(b-a)/n;
  for i:=1 to n do
    begin
      x:=a+h*i;
      c2:=c2+fa(x);
    end;
  c2:=c2*h;
  c2:=SimpleRoundTo(c2,-6);
  Form1.Memo1.Lines.Add(floattostr(c2));
end;

procedure SredPr1(a,b:real;n:integer);
var
  x,h,c3:real; i:integer;
begin
  h:=(b-a)/n;
  for i:=0 to n-1 do
    begin
      x:=a+h*i;
      c3:=c3+fa(x+h/2);
    end;
  c3:=c3*h;
  c3:=SimpleRoundTo(c3,-6);
  Form1.Memo1.Lines.Add(floattostr(c3));
end;

procedure Simps1(a,b:real;n:integer);
var
 x,h,c,z,y1:real; i:integer;
begin
  h:=(b-a)/n;
  c:=fa(a)+fa(b);
  z:=1;
  x:=a+h;
  for i:=1 to n-1 do
    begin
      c:=c+((3+z)*fa(x));
      x:=x+h;
      z:=-z;
    end;
    y1:=c*h/3;
    y1:=SimpleRoundTo(y1,-6);
    Form1.Memo1.Lines.Add(floattostr(y1));
end;

procedure Trapec1(a,b:real;n:integer);
var
  x,h,c:real; i:integer;
begin
  h:=(b-a)/n;
  for i:=1 to n-1 do
    begin
      x:=a+h*i;
      c:=c+fa(x+h/2);
    end;
  c:=(c*h)+(( fa(a)+fa(b))/2)*h;
  c:=SimpleRoundTo(c,-6);
  Form1.Memo1.Lines.Add(floattostr(c));
end;

procedure LevPr2(a,b:real;n:integer);
var
  h,x,ci1:real; i:integer;
begin
  h:=(b-a)/n;
  for i:=0 to n do
    begin
      x:=a+h*i;
      ci1:=ci1+fb(x);
    end;
  ci1:=ci1*h;
  ci1:=SimpleRoundTo(ci1,-6);
  Form1.Memo1.Lines.Add(floattostr(ci1));
end;

procedure PravPr2(a,b:real;n:integer);
var
  x,h,ci2:real; i:integer;
begin
  h:=(b-a)/n;
  for i:=1 to n-1 do
    begin
      x:=a+h*i;
      ci2:=ci2+fb(x);
    end;
  ci2:=ci2*h;
  ci2:=SimpleRoundTo(ci2,-6);
  Form1.Memo1.Lines.Add(floattostr(ci2));
end;

procedure SredPr2(a,b:real;n:integer);
var
  x,h,ci3:real; i:integer;
begin
  h:=(b-a)/n;
  for i:=0 to n-1 do
    begin
      x:=a+h*i;
      ci3:=ci3+fb(x+h/2);
    end;
  ci3:=ci3*h;
  ci3:=SimpleRoundTo(ci3,-6);
  Form1.Memo1.Lines.Add(floattostr(ci3));
end;

procedure Simps2(a,b:real;n:integer);
var
 x,h,c,z,y2:real; i:integer;
begin
  h:=(b-a)/n;
  c:=fb(a)+fb(b);
  z:=1;
  x:=a+h;
  for i:=1 to n-1 do
    begin
      c:=c+((3+z)*fb(x));
      x:=x+h;
      z:=-z;
    end;
    y2:=c*h/3;
    y2:=SimpleRoundTo(y2,-6);
    Form1.Memo1.Lines.Add(floattostr(y2));
end;

procedure Trapec2(a,b:real;n:integer);
var
  x,h,ci4:real; i:integer;
begin
  h:=(b-a)/n;
  for i:=0 to n-1 do
    begin
      x:=a+h*i;
      ci4:=ci4+fb(x+h/2);
    end;
  ci4:=(ci4*h)+(( fb(a)+fb(b))/2)*h;
  ci4:=SimpleRoundTo(ci4,-6);
  Form1.Memo1.Lines.Add(floattostr(ci4));
end;

procedure TForm1.Button1Click(Sender: TObject);
var
a,b,e,I1,I2,t,o6,o7,o8,o9,o10:real; n,k:integer;
begin
a:=strtofloat(Edit1.Text);
b:=strtofloat(Edit2.Text);
n:=strtoint(Edit3.Text);
Form1.Memo1.Lines.Add('Методом левых прямоугольников: ');
 LevPr1(a,b,n);
Form1.Memo1.Lines.Add('Методом правых прямоугольников: ');
 PravPr1(a,b,n);
Form1.Memo1.Lines.Add('Методом средних прямоугольников: ');
 SredPr1(a,b,n);
Form1.Memo1.Lines.Add('Методом Симпсона: ');
 Simps1(a,b,n);
Form1.Memo1.Lines.Add('Методом трапеций: ');
 Trapec1(a,b,n);
Form1.Memo1.Lines.Add('----------------------------------')
end;

procedure TForm1.Button2Click(Sender: TObject);
var
a,b,e,I1,I2,t,o1,o2,o3,o4,o5:real; n,k:integer;
begin
a:=strtofloat(Edit1.Text);
b:=strtofloat(Edit2.Text);
n:=strtoint(Edit3.Text);
Form1.Memo1.Lines.Add('Методом левых прямоугольников: ');
 LevPr2(a,b,n);
Form1.Memo1.Lines.Add('Методом правых прямоугольников: ');
 PravPr2(a,b,n);
Form1.Memo1.Lines.Add('Методом средних прямоугольников: ');
 SredPr2(a,b,n);
Form1.Memo1.Lines.Add('Методом Симпсона: ');
 Simps2(a,b,n);
Form1.Memo1.Lines.Add('Методом трапеций: ');
 Trapec2(a,b,n);
Form1.Memo1.Lines.Add('-----------------------------------')
end;

end.
