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
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
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

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  edit1.Clear;
  edit2.Clear;
  edit1.SetFocus;
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b,t: integer;
  f: real;
begin
a:=strtoint(Edit1.Text);
b:=strtoint(Edit2.Text);
t:=strtoint(Edit3.Text);
f:=(exp(-b*t)*sin(a*t+b))-sqrt(abs(b*t+a));
Memo1.Lines.add('При значении а = '+inttostr(a)+', значении b = '+inttostr(b)+' и значении t = '+inttostr(t)+' функция будет равна '+floattostr(f));
end;

end.

