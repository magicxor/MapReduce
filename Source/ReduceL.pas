var
  X: T;
begin
  Result := Init;
  for X in Source do
    Result := Lambda(Result, X);
end;