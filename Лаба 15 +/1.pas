program AlphabetFrequencyDictionary;

type
  NodePtr = ^Node;
  Node = record
    Word: string;
    Frequency: Integer;
    Next: NodePtr;
  end;

var
  F: Text;
  Head, Current, NewNode, PrevNode: NodePtr;
  Word: string;
  Found: Boolean;

function CreateNode(Word: string): NodePtr;
var
  NewNode: NodePtr;
begin
  New(NewNode);
  NewNode^.Word := Word;
  NewNode^.Frequency := 1;
  NewNode^.Next := nil;
  CreateNode := NewNode;
end;

procedure AddBefore(NodeToAdd, PrevNode: NodePtr);
begin
  NodeToAdd^.Next := PrevNode^.Next;
  PrevNode^.Next := NodeToAdd;
end;

procedure MakePlace(Word: string; var Current, PrevNode: NodePtr; var Found: Boolean);
begin
  PrevNode := nil;
  Current := Head;
  Found := False;
  
  while (Current <> nil) and (not Found) do
  begin
    if Current^.Word > Word then
      Found := True
    else
    begin
      PrevNode := Current;
      Current := Current^.Next;
    end;
  end;
end;

begin
  Assign(F, 'input1.txt');
  Reset(F);

  Head := nil;
  while not Eof(F) do
  begin
    Readln(F, Word);
    Current := Head;
    Found := False;

    while (Current <> nil) and (not Found) do
    begin
      if Current^.Word = Word then
      begin
        Current^.Frequency := Current^.Frequency + 1;
        Found := True;
      end
      else
        Current := Current^.Next;
    end;

    if not Found then
    begin
      NewNode := CreateNode(Word);
      MakePlace(Word, Current, PrevNode, Found);
      if PrevNode = nil then
        Head := NewNode
      else
        AddBefore(NewNode, PrevNode);
    end;
  end;

  Close(F);

  Current := Head;
  while Current <> nil do
  begin
    WriteLn(Current^.Word, ': ', Current^.Frequency);
    Current := Current^.Next;
  end;
end.