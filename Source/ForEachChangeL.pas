var
  I: Integer;
begin
  for I := Low(Source) to High(Source) do
    Lambda(Source[I]);
end;