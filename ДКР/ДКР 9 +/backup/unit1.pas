unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, edit,
  Grids, StdCtrls;

type
  Contacts = record
    Title: string[100];
    Proizvoditel: string[100];
    Model: string[100];
    Ves: integer;
    Price: double;
  end;

type

  { TfMain }

  TfMain = class(TForm)
    Panel1: TPanel;
    bAdd: TSpeedButton;
    bEdit: TSpeedButton;
    bDel: TSpeedButton;
    bSort: TSpeedButton;
    SG: TStringGrid;
    procedure bAddClick(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);

  private
    function ValidateInput: Boolean;

  public

  end;

var
  fMain: TfMain;
  adres: string;

implementation

{$R *.lfm}

{ TfMain }

function TfMain.ValidateInput: Boolean;
var
  Price: Double;
  Ves: Integer;
begin
  Result := False;
  if (fEdit.eTitle.Text = '') or (fEdit.eProizvoditel.Text = '') or
     (fEdit.eModel.Text = '') or (fEdit.eVes.Text = '') or (fEdit.ePrice.Text = '') then
  begin
    ShowMessage('Заполните все поля');
    Exit;
  end;

  if not TryStrToInt(fEdit.eVes.Text, Ves) then
  begin
    ShowMessage('Введите целое число');
    Exit;
  end;

  if not TryStrToFloat(fEdit.ePrice.Text, Price) then
  begin
    ShowMessage('Не вводите букавки');
    Exit;
  end;

  Result := True;
end;

procedure TfMain.bAddClick(Sender: TObject);
begin
  // Очищаем поля, если там что-то есть:
  fEdit.eTitle.Text := '';
  fEdit.eProizvoditel.Text := '';
  fEdit.eVes.Text := '';
  fEdit.ePrice.Text := '';
  // Устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult := mrNone;
  // Теперь выводим форму:
  fEdit.ShowModal;

  // Если пользователь ничего не ввел - выходим:
  if not ValidateInput then Exit;

  // Если пользователь не нажал "Сохранить" - выходим:
  if fEdit.ModalResult <> mrOk then Exit;

  // Иначе добавляем в сетку строку, и заполняем её:
  SG.RowCount := SG.RowCount + 1;
  SG.Cells[0, SG.RowCount-1] := fEdit.eTitle.Text;
  SG.Cells[1, SG.RowCount-1] := fEdit.eProizvoditel.Text;
  SG.Cells[2, SG.RowCount-1] := fEdit.eModel.Text;
  SG.Cells[3, SG.RowCount-1] := fEdit.eVes.Text;
  SG.Cells[4, SG.RowCount-1] := fEdit.ePrice.Text;
end;

procedure TfMain.bDelClick(Sender: TObject);
begin
  // Если данных нет - выходим:
  if SG.RowCount = 1 then Exit;
  // Иначе выводим запрос на подтверждение:
  if MessageDlg('Требуется подтверждение',
                'Вы действительно хотите удалить модель миксера"' +
                SG.Cells[0, SG.Row] + '"?',
      mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
         SG.DeleteRow(SG.Row);
end;

procedure TfMain.bEditClick(Sender: TObject);
begin
  // Если данных в сетке нет - просто выходим:
  if SG.RowCount = 1 then Exit;
  // Иначе записываем данные в форму редактора:
  fEdit.eTitle.Text := SG.Cells[0, SG.Row];
  fEdit.eProizvoditel.Text := SG.Cells[1, SG.Row];
  fEdit.eModel.Text := SG.Cells[2, SG.Row];
  fEdit.eVes.Text := SG.Cells[3, SG.Row];
  fEdit.ePrice.Text := SG.Cells[4, SG.Row];
  // Устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult := mrNone;
  // Теперь выводим форму:
  fEdit.ShowModal;

  // Сохраняем в сетку возможные изменения,
  // если пользователь нажал "Сохранить":
  if fEdit.ModalResult = mrOk then
  begin
    if not ValidateInput then Exit;

    SG.Cells[0, SG.Row] := fEdit.eTitle.Text;
    SG.Cells[1, SG.Row] := fEdit.eProizvoditel.Text;
    SG.Cells[2, SG.Row] := fEdit.eModel.Text;
    SG.Cells[3, SG.Row] := fEdit.eVes.Text;
    SG.Cells[4, SG.Row] := fEdit.ePrice.Text;
  end;
end;

procedure TfMain.bSortClick(Sender: TObject);
begin
  // Если данных в сетке нет - просто выходим:
  if SG.RowCount = 1 then Exit;
  // Иначе сортируем список:
  SG.SortColRow(True, 0);
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  MyCont: Contacts; // для очередной записи
  f: file of Contacts; // файл данных
  i: Integer; // счетчик цикла
begin
  // Если строки данных пусты, просто выходим:
  if SG.RowCount = 1 then Exit;
  // Иначе открываем файл для записи:
  try
    AssignFile(f, adres + 'Micser.dat');
    Rewrite(f);
    // Теперь цикл - от первой до последней записи сетки:
    for i := 1 to SG.RowCount-1 do
    begin
      // Получаем данные текущей записи:
      MyCont.Title := SG.Cells[0, i];
      MyCont.Proizvoditel := SG.Cells[1, i];
      MyCont.Model := (SG.Cells[2, i]);
      MyCont.Ves := StrToint(SG.Cells[3, i]);
      MyCont.Price := StrTofloat(SG.Cells[4, i]);
      // Записываем их:
      Write(f, MyCont);
    end;
  finally
    CloseFile(f);
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  MyCont: Contacts; // для очередной записи
  f: file of Contacts; // файл данных
  i: Integer; // счетчик цикла
begin
  // Сначала получим адрес программы:
  adres := ExtractFilePath(ParamStr(0));
  // Настроим сетку:
  SG.Cells[0, 0] := 'Название миксера';
  SG.Cells[1, 0] := 'Производитель';
  SG.Cells[2, 0] := 'Модель';
  SG.Cells[3, 0] := 'Вес(г)';
  SG.Cells[4, 0] := 'Стоимость';
  SG.ColWidths[0] := 200;
  SG.ColWidths[1] := 200;
  SG.ColWidths[2] := 100;
  SG.ColWidths[3] := 150;
  SG.ColWidths[4] := 150;
  // Если файла данных нет, просто выходим:
  if not FileExists(adres + 'Micser.dat') then Exit;
  // Иначе файл есть, открываем его для чтения и
  // считываем данные в сетку:
  try
    AssignFile(f, adres + 'Micser.dat');
    Reset(f);
    // Теперь цикл - от первой до последней записи сетки:
    while not Eof(f) do
    begin
      // Считываем новую запись:
      Read(f, MyCont);
      // Добавляем в сетку новую строку, и заполняем её:
      SG.RowCount := SG.RowCount + 1;
      SG.Cells[0, SG.RowCount-1] := MyCont.Title;
      SG.Cells[1, SG.RowCount-1] := MyCont.Proizvoditel;
      SG.Cells[2, SG.RowCount-1] := (MyCont.Model);
      SG.Cells[3, SG.RowCount-1] := IntToStr(MyCont.Ves);
      SG.Cells[4, SG.RowCount-1] := FloatToStr(MyCont.Price);
    end;
  finally
    CloseFile(f);
  end;
end;

end.


