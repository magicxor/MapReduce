var
  I: Integer;
  X: T;
begin
  Result := Source[Low(Source)];
  if Length(Source) > 1 then
    for I := Low(Source) + 1 to High(Source) do
      Result := Lambda(Result, Source[I], I);
end;