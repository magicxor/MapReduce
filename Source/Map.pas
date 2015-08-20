var
  I: Integer;
  X: T;
begin
  Result := [];
  I := 0;
  for X in Source do
  begin
    Result := Result + [Lambda(X, I)];
    Inc(I);
  end;
end;