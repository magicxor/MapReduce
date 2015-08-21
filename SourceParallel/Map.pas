var
  ThreadList: TThreadList<TIndexed>;
  FinalList: TList<TIndexed>;
  Comparison: TComparison<TIndexed>;
  TmpIndexedRecord: TIndexed;
begin
  Result := [];
  // Thread-safe unordered storage
  ThreadList := TThreadList<TIndexed>.Create;
  try
    ThreadList.Duplicates := dupAccept;

    // do the job
    TParallel.For(low(Source), high(Source),
      procedure(AIndex: Integer; ALoopState: TParallel.TLoopState)
      begin
        // add item to the ThreadList
        TListWriter.AddToThreadList(TIndexed.Create(AIndex, Lambda(Source[AIndex], AIndex)), ThreadList);
      end);

    // not-thread-safe ordered storage
    FinalList := ThreadList.LockList;
    try
      // specify the comparer
      Comparison := function(const Left: TIndexed; const Right: TIndexed): Integer
        begin
          Result := TComparer<Integer>.Default.Compare(Left.FIndex, Right.FIndex);
        end;
      // sort list by the comparer
      FinalList.Sort(TComparer<TIndexed>.Construct(Comparison));
      // put list items to the result array
      for TmpIndexedRecord in FinalList do
        Result := Result + [TmpIndexedRecord.FValue];
    finally
      ThreadList.UnlockList;
    end;

  finally
    FreeAndNil(ThreadList);
  end;
end;