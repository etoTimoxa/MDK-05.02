program dkr6;

type
  Node = record
    data: integer;
    prev, next: ^Node;
  end;
  
var
  head, tail: ^Node;

procedure AddNode(data: integer);
var
  newNode: ^Node;
begin
  New(newNode);
  newNode^.data := data;
  newNode^.prev := nil;
  newNode^.next := nil;
  
  if head = nil then
  begin
    head := newNode;
    tail := newNode;
  end
  else
  begin
    tail^.next := newNode;
    newNode^.prev := tail;
    tail := newNode;
  end;
end;

procedure DisplayList;
var
  current: ^Node;
begin
  writeln('Двусвязный список:');
  current := head;
  while current <> nil do
  begin
    write(current^.data, ' ');
    current := current^.next;
  end;
  writeln;
end;

procedure Menu;
var
  choice, data: integer;
begin
  repeat
    writeln('Меню:');
    writeln('1. Добавить узел');
    writeln('2. Отобразить список');
    writeln('3. Выйти');
    write('Выбор за вами: ');
    readln(choice);
    
    case choice of
      1: begin
           write('Введите данные: ');
           readln(data);
           AddNode(data);
         end;
      2: DisplayList;
      3: writeln('До скорой встречи(');
      else writeln('Подумай лучше)');
    end;
  until choice = 3;
end;

begin
  head := nil;
  tail := nil;
  Menu;
end.