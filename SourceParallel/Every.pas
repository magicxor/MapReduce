var
  ResultValue: Integer;
begin
  ResultValue := 1;
  TParallel.For(low(Source), high(Source),
    procedure(AIndex: Integer; ALoopState: TParallel.TLoopState)
    begin
      if not Lambda(Source[AIndex]) then
      begin
        TInterlocked.Exchange(ResultValue, 0);
        ALoopState.Break; // .Stop ???
      end;
    end);
  Result := ResultValue.ToBoolean;
end;