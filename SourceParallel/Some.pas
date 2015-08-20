var
  ResultValue: Integer;
begin
  ResultValue := 0;
  TParallel.For(low(Source), high(Source),
    procedure(AIndex: Integer; ALoopState: TParallel.TLoopState)
    begin
      if Lambda(Source[AIndex]) then
      begin
        TInterlocked.Exchange(ResultValue, 1);
        ALoopState.Break; // .Stop ???
      end;
    end);
  Result := ResultValue.ToBoolean;
end;