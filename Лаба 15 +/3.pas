program zad3;

var
    i: integer;
    list: array[1..10] of integer;

begin
    // Заполнение списка
    list[1] := 5;
    list[2] := 12;
    list[3] := 7;
    list[4] := 8;
    list[5] := 3;
    list[6] := 10;
    list[7] := 6;
    list[8] := 9;
    list[9] := 2;
    list[10] := 4;

    // Вывод списка на экран
    writeln('Список из десяти элементов:');
    for i := 1 to 10 do
    begin
        writeln(list[i]);
    end;

    // Вывод четных элементов списка
    writeln('Четные элементы списка:');
    for i := 1 to 10 do
    begin
        if (list[i] mod 2 = 0) then
            writeln(list[i]);
    end;
end.