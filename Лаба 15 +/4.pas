program zad4;

type
  NodePtr = ^Node;
  Node = record
    data: Integer;
    next: NodePtr;
  end;

function FindMax(head: NodePtr): Integer;
var
  current: NodePtr;
  max: Integer;
begin
  current := head;
  max := current^.data;
  
  while current <> nil do
  begin
    if current^.data > max then
      max := current^.data;
    current := current^.next;
  end;
  
  FindMax := max;
end;

function FindMin(head: NodePtr): Integer;
var
  current: NodePtr;
  min: Integer;
begin
  current := head;
  min := current^.data;
  
  while current <> nil do
  begin
    if current^.data < min then
      min := current^.data;
    current := current^.next;
  end;
  
  FindMin := min;
end;

var
  head, node1, node2, node3: NodePtr;
begin
  New(head);
  New(node1);
  New(node2);
  New(node3);
  
  head^.data := 5;
  head^.next := node1;
  
  node1^.data := 3;
  node1^.next := node2;
  
  node2^.data := 8;
  node2^.next := node3;
  
  node3^.data := 1;
  node3^.next := nil;
  
  WriteLn('Max: ', FindMax(head)); 
  WriteLn('Min: ', FindMin(head)); 
end.