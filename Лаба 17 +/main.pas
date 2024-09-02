unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TfMain }

  TfMain = class(TForm)
    lClock: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }
procedure TfMain.Timer1Timer(Sender: TObject);
var
  i: byte; //для получения случайного числа
begin
  lClock.Caption:= TimeToStr(Now);
  i:= Random(4);
  case i of
    0: lClock.Left:= lClock.Left + 500;
    1: lClock.Left:= lClock.Left - 500;
    2: lClock.Top:= lClock.Top + 500;
    3: lClock.Top:= lClock.Top - 500;
  end;

  if lClock.Left < 0 then lClock.Left:= 0;
  //если ушла вверх:
  if lClock.Top < 0 then lClock.Top:= 0;
  //если ушла вправо:
  if (lClock.Left + lClock.Width) > fMain.Width then
    lClock.Left:= fMain.Width - lClock.Width;
  //если ушла вниз:
  if (lClock.Top + lClock.Height) > fMain.Height then
    lClock.Top:= fMain.Height - lClock.Height;
end;

end.

