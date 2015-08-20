var
  X: T;
begin
  Result := False;
  for X in Source do
    if Lambda(X) then
      Exit(True);
end;