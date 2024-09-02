unit Edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TfEdit }

  TfEdit = class(TForm)
    bSave: TBitBtn;
    bCancel: TBitBtn;
    eProizvoditel: TEdit;
    eModel: TEdit;
    eTitle: TEdit;
    eVes: TEdit;
    ePrice: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure eTitleChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

{ TfEdit }

procedure TfEdit.FormCreate(Sender: TObject);
begin

end;

procedure TfEdit.eTitleChange(Sender: TObject);
begin

end;

procedure TfEdit.FormShow(Sender: TObject);
begin
  eTitle.SetFocus;
end;


end.

