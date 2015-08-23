var
  X: T;
begin
  Result := Source[0];
  if Length(Source) > 2 then
    for X in Source do
      Result := Lambda(Result, X);
end;