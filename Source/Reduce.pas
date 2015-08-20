var
  I: Integer;
  X: T;
begin
  Result := Init;
  I := 0;
  for X in Source do
  begin
    Result := Lambda(Result, X, I);
    Inc(I);
  end;
end;