var
  X: T;
begin
  Result := True;
  for X in Source do
    if not Lambda(X) then
      Exit(False);
end;