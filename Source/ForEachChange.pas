var
  I: Integer;
  Done: Boolean;
begin
  Done := False;
  for I := Low(Source) to High(Source) do
  begin
    Lambda(Source[I], I, Done);
    if Done then
      Break;
  end;
end;