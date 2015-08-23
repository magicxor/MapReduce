var
  I: Integer;
  X: T;
begin
  Result := Source[0];
  if Length(Source) > 2 then
  begin
    I := 0;
    for X in Source do
    begin
      Result := Lambda(Result, X, I);
      Inc(I);
    end;
  end;
end;