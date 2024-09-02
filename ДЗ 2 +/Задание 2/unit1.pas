unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
  var c, a: integer;
  s, a1, h: real;
begin
c:=strtoint(Edit1.Text);
a:=strtoint(Edit2.Text);
h:=c*sin(a);
s:=sqr(c)*sin(a);
a1:=2*c*cos(a/2);
label3.Caption:='Площадь треугольника = '+floattostr(s);
label4.Caption:='Боковая сторона = '+floattostr(a1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  edit1.Clear;
  edit2.Clear;
  edit1.SetFocus;
  label3.Caption:='Площадь треугольника = ';
label4.Caption:='Боковая сторона = ';
end;

end.

