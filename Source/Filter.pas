var
  I: Integer;
  X: T;
begin
  Result := [];
  I := 0;
  for X in Source do
  begin
    if Lambda(X, I) then
      Result := Result + [X];
    Inc(I);
  end;
end;