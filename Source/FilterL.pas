var
  X: T;
begin
  Result := [];
  for X in Source do
    if Lambda(X) then
      Result := Result + [X];
end;