var
  ThreadList: TThreadList<TIndexedRecord>;
  FinalList: TList<TIndexedRecord>;
  Comparison: TComparison<TIndexedRecord>;
  TmpIndexedRecord: TIndexedRecord;
begin
  Result := [];
  // Thread-safe unordered storage
  ThreadList := TThreadList<TIndexedRecord>.Create;
  try
    ThreadList.Duplicates := dupAccept;

    // do the job
    TParallel.For(low(Source), high(Source),
      procedure(AIndex: Integer; ALoopState: TParallel.TLoopState)
      begin
        // add item to the ThreadList
        if Lambda(Source[AIndex], AIndex) then
          AddToThreadList(TIndexedRecord.Create(AIndex, Source[AIndex]), ThreadList);
      end);

    // not-thread-safe ordered storage
    FinalList := ThreadList.LockList;
    try
      // specify the comparer
      Comparison := function(const Left: TIndexedRecord; const Right: TIndexedRecord): Integer
        begin
          Result := TComparer<Integer>.Default.Compare(Left.FIndex, Right.FIndex);
        end;
      // sort list by the comparer
      FinalList.Sort(TComparer<TIndexedRecord>.Construct(Comparison));
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