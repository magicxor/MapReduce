var
  X: T;
begin
  Result := [];
  for X in Source do
    Result := Result + [Lambda(X)];
end;