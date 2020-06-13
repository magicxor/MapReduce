unit Tests;

interface

uses
  TestFramework, System.SysUtils;

type
  TestArrayLinq = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEveryLong0Elements;
    procedure TestEveryLong1Element;
    procedure TestEveryLong2Elements;
    procedure TestEveryLong3Elements;

    procedure TestEveryString0Elements;
    procedure TestEveryString1Element;
    procedure TestEveryString2Elements;
    procedure TestEveryString3Elements;

    procedure TestFilter0Elements;
    procedure TestFilter1Element;
    procedure TestFilter2Elements;

    procedure TestFilterInd0Elements;
    procedure TestFilterInd1Element;
    procedure TestFilterInd2Elements;

    procedure TestFlatMap0Elements;
    procedure TestFlatMap1Element;
    procedure TestFlatMap2Elements;

    procedure TestFlatMapInd0Elements;
    procedure TestFlatMapInd1Element;
    procedure TestFlatMapInd2Elements;

    procedure TestForEachAlt0Elements;
    procedure TestForEachAlt1Element;
    procedure TestForEachAlt2Elements;

    procedure TestForEachInd0Elements;
    procedure TestForEachInd1Element;
    procedure TestForEachInd2Elements;
    procedure TestForEachInd3Elements;

    procedure TestForEach0Elements;
    procedure TestForEach1Element;
    procedure TestForEach2Elements;
    procedure TestForEach3Elements;

    procedure TestMap0Elements;
    procedure TestMap1Elements;
    procedure TestMap2Elements;

    procedure TestMapInd0Elements;
    procedure TestMapInd1Elements;
    procedure TestMapInd2Elements;

    procedure TestMapTo0Elements;
    procedure TestMapTo1Elements;
    procedure TestMapTo2Elements;

    procedure TestMapIndTo0Elements;
    procedure TestMapIndTo1Elements;
    procedure TestMapIndTo2Elements;

    procedure TestReduceInit0Elements;
    procedure TestReduceInit1Elements;
    procedure TestReduceInit2Elements;

    procedure TestReduceInitInd0Elements;
    procedure TestReduceInitInd1Elements;
    procedure TestReduceInitInd2Elements;

    procedure TestReduce0Elements;
    procedure TestReduce1Elements;
    procedure TestReduce2Elements;

    procedure TestReduceInd0Elements;
    procedure TestReduceInd1Elements;
    procedure TestReduceInd3Elements;

    procedure TestReduceTo0Elements;
    procedure TestReduceTo1Elements;
    procedure TestReduceTo2Elements;

    procedure TestReduceIndTo0Elements;
    procedure TestReduceIndTo1Elements;
    procedure TestReduceIndTo3Elements;

    procedure TestSome0Elements;
    procedure TestSome1Element;
    procedure TestSome2Elements;
    procedure TestSome3Elements;

    procedure TestOrder0Elements;
    procedure TestOrder1Elements;
    procedure TestOrderManyElements;

    procedure TestOrderBy0Elements;
    procedure TestOrderBy1Elements;
    procedure TestOrderByManyElements;

    procedure FirstOrDefault0Elements;
    procedure FirstOrDefault1Elements;
    procedure FirstOrDefault2Elements;

    procedure FirstOrDefaultBy0Elements;
    procedure FirstOrDefaultBy1Elements;
    procedure FirstOrDefaultBy2Elements;
  end;

implementation

uses System.Generics.Collections, System.Generics.Defaults, System.Types, ArrayContainer;

procedure TestArrayLinq.SetUp;
begin
  inherited;

  Self.FailsOnMemoryLeak := true;
  Self.FailsOnNoChecksExecuted := true;
end;

procedure TestArrayLinq.TearDown;
begin
  inherited;
end;

procedure TestArrayLinq.TestEveryLong0Elements;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<int64>
    .Create([])
    .Every(function (const X: int64): Boolean begin Exit(X > 0); end);
  ExpectedResult := true;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestEveryLong1Element;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<int64>
    .Create([1])
    .Every(function (const X: int64): Boolean begin Exit(X > 0); end);
  ExpectedResult := true;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestEveryLong2Elements;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<int64>
    .Create([1, 2])
    .Every(function (const X: int64): Boolean begin Exit(X > 0); end);
  ExpectedResult := true;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestEveryLong3Elements;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<int64>
    .Create([1, 2, -3])
    .Every(function (const X: int64): Boolean begin Exit(X > 0); end);
  ExpectedResult := false;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestEveryString0Elements;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<string>
    .Create([])
    .Every(function (const X: string): Boolean begin Exit(X.Contains('o')); end);
  ExpectedResult := true;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestEveryString1Element;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<string>
    .Create(['one'])
    .Every(function (const X: string): Boolean begin Exit(X.Contains('o')); end);
  ExpectedResult := true;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestEveryString2Elements;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<string>
    .Create(['one', 'two'])
    .Every(function (const X: string): Boolean begin Exit(X.Contains('o')); end);
  ExpectedResult := true;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestEveryString3Elements;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<string>
    .Create(['one', 'two', 'three'])
    .Every(function (const X: string): Boolean begin Exit(X.Contains('o')); end);
  ExpectedResult := false;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestFilter0Elements;
var
  ExpectedResult: TArray<string>;
  ActualResult: TArray<string>;
begin
  ActualResult := TArrayContainer<string>
    .Create([])
    .Filter(function (const X: string): Boolean begin Exit(X.Contains('o')); end)
    .ToArray;
  ExpectedResult := [];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
end;

procedure TestArrayLinq.TestFilter1Element;
var
  ExpectedResult: TArray<string>;
  ActualResult: TArray<string>;
  i: int32;
begin
  ActualResult := TArrayContainer<string>
    .Create(['one'])
    .Filter(function (const X: string): Boolean begin Exit(X.Contains('o')); end)
    .ToArray;
  ExpectedResult := ['one'];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
  for i := Low(ExpectedResult) to High(ExpectedResult) do
    CheckEquals(ExpectedResult[i], ActualResult[i]);
end;

procedure TestArrayLinq.TestFilter2Elements;
var
  ExpectedResult: TArray<string>;
  ActualResult: TArray<string>;
  i: int32;
begin
  ActualResult := TArrayContainer<string>
    .Create(['one', 'two'])
    .Filter(function (const X: string): Boolean begin Exit(X.Contains('w')); end)
    .ToArray;
  ExpectedResult := ['two'];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
  for i := Low(ExpectedResult) to High(ExpectedResult) do
    CheckEquals(ExpectedResult[i], ActualResult[i]);
end;

procedure TestArrayLinq.TestFilterInd0Elements;
var
  ExpectedResult: TArray<string>;
  ActualResult: TArray<string>;
begin
  ActualResult := TArrayContainer<string>
    .Create([])
    .Filter(function(const X: string; const I: Integer): Boolean begin Exit(I = 1); end)
    .ToArray;
  ExpectedResult := [];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
end;

procedure TestArrayLinq.TestFilterInd1Element;
var
  ExpectedResult: TArray<string>;
  ActualResult: TArray<string>;
begin
  ActualResult := TArrayContainer<string>
    .Create(['one'])
    .Filter(function(const X: string; const I: Integer): Boolean begin Exit(I = 1); end)
    .ToArray;
  ExpectedResult := [];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
end;

procedure TestArrayLinq.TestFilterInd2Elements;
var
  ExpectedResult: TArray<string>;
  ActualResult: TArray<string>;
  i: int32;
begin
  ActualResult := TArrayContainer<string>
    .Create(['one', 'two'])
    .Filter(function(const X: string; const I: Integer): Boolean begin Exit(I = 1); end)
    .ToArray;
  ExpectedResult := ['two'];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
  for i := Low(ExpectedResult) to High(ExpectedResult) do
    CheckEquals(ExpectedResult[i], ActualResult[i]);
end;

procedure TestArrayLinq.TestFlatMap0Elements;
var
  ResultArray: TArray<string>;
  ActualResult: int32;
begin
  ResultArray := TArrayContainer<TArray<string>>
    .Create([])
    .FlatMap<string>(function(const X: TArray<string>): TArray<string> begin Exit(X); end)
    .ToArray;
  ActualResult := Length(ResultArray);
  CheckEquals(0, ActualResult);
end;

procedure TestArrayLinq.TestFlatMap1Element;
var
  ActualResult: TArray<string>;
  ExpectedResult: TArray<string>;
  i: int32;
begin
  ActualResult := TArrayContainer<TArray<string>>
    .Create([['one', 'two']])
    .FlatMap<string>(function(const X: TArray<string>): TArray<string> begin Exit(X); end)
    .ToArray;
  ExpectedResult := ['one', 'two'];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
  for i := Low(ExpectedResult) to High(ExpectedResult) do
    CheckEquals(ExpectedResult[i], ActualResult[i]);
end;

procedure TestArrayLinq.TestFlatMap2Elements;
var
  ActualResult: TArray<string>;
  ExpectedResult: TArray<string>;
  i: int32;
begin
  ActualResult := TArrayContainer<TArray<string>>
    .Create([['one', 'two'], ['three', 'four']])
    .FlatMap<string>(function(const X: TArray<string>): TArray<string> begin Exit(X); end)
    .ToArray;
  ExpectedResult := ['one', 'two', 'three', 'four'];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
  for i := Low(ExpectedResult) to High(ExpectedResult) do
    CheckEquals(ExpectedResult[i], ActualResult[i]);
end;

procedure TestArrayLinq.TestFlatMapInd0Elements;
var
  ActualResult: TArray<string>;
  ExpectedResult: TArray<string>;
  i: int32;
begin
  ActualResult := TArrayContainer<TArray<string>>
    .Create([])
    .FlatMap<string>(function(const X: TArray<string>; const I: Integer): TArray<string> begin Exit(X); end)
    .ToArray;
  ExpectedResult := [];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
  for i := Low(ExpectedResult) to High(ExpectedResult) do
    CheckEquals(ExpectedResult[i], ActualResult[i]);
end;

procedure TestArrayLinq.TestFlatMapInd1Element;
var
  ActualResult: TArray<string>;
  ExpectedResult: TArray<string>;
  i: int32;
begin
  ActualResult := TArrayContainer<TArray<string>>
    .Create([['one', 'two']])
    .FlatMap<string>(function(const X: TArray<string>; const I: Integer): TArray<string>
      begin
        Exit(TArrayContainer<string>
          .Create(X)
          .Map(function(const Y: string): string begin Exit(Y + IntToStr(I)) end)
          .ToArray);
      end)
    .ToArray;
  ExpectedResult := ['one0', 'two0'];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
  for i := Low(ExpectedResult) to High(ExpectedResult) do
    CheckEquals(ExpectedResult[i], ActualResult[i]);
end;

procedure TestArrayLinq.TestFlatMapInd2Elements;
var
  ActualResult: TArray<string>;
  ExpectedResult: TArray<string>;
  i: int32;
begin
  ActualResult := TArrayContainer<TArray<string>>
    .Create([['one', 'two'], ['three', 'four']])
    .FlatMap<string>(function(const X: TArray<string>; const I: Integer): TArray<string>
      begin
        Exit(TArrayContainer<string>
          .Create(X)
          .Map(function(const Y: string): string begin Exit(Y + IntToStr(I)) end)
          .ToArray);
      end)
    .ToArray;
  ExpectedResult := ['one0', 'two0', 'three1', 'four1'];
  CheckEquals(Length(ExpectedResult), Length(ActualResult));
  for i := Low(ExpectedResult) to High(ExpectedResult) do
    CheckEquals(ExpectedResult[i], ActualResult[i]);
end;

procedure TestArrayLinq.TestForEachInd0Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create([])
    .ForEach(function(const X: string; const I: Integer): Boolean begin ResultArray := ResultArray + [X + IntToStr(I)]; Exit(false); end);
  ExpectedArray := [];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
end;

procedure TestArrayLinq.TestForEachInd1Element;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: int32;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create(['one'])
    .ForEach(function(const X: string; const I: Integer): Boolean begin ResultArray := ResultArray + [X + IntToStr(I)]; Exit(false); end);
  ExpectedArray := ['one0'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestForEachInd2Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: int32;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create(['one', 'two'])
    .ForEach(function(const X: string; const I: Integer): Boolean begin ResultArray := ResultArray + [X + IntToStr(I)]; Exit(false); end);
  ExpectedArray := ['one0', 'two1'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestForEachInd3Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: int32;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create(['one', 'two', 'three'])
    .ForEach(function(const X: string; const I: Integer): Boolean begin ResultArray := ResultArray + [X + IntToStr(I)]; Exit(I >= 1); end);
  ExpectedArray := ['one0', 'two1'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestMap0Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
begin
  ResultArray := TArrayContainer<string>
    .Create([])
    .Map(function(const X: string): string begin Exit(X + '▲'); end)
    .ToArray;
  ExpectedArray := [];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
end;

procedure TestArrayLinq.TestMap1Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: Integer;
begin
  ResultArray := TArrayContainer<string>
    .Create(['one'])
    .Map(function(const X: string): string begin Exit(X + '▲'); end)
    .ToArray;
  ExpectedArray := ['one▲'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestMap2Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: Integer;
begin
  ResultArray := TArrayContainer<string>
    .Create(['one', 'two'])
    .Map(function(const X: string): string begin Exit(X + '▲'); end)
    .ToArray;
  ExpectedArray := ['one▲', 'two▲'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestMapInd0Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
begin
  ResultArray := TArrayContainer<string>
    .Create([])
    .Map(function(const X: string; const I: Integer): string begin Exit(X + IntToStr(I)) end)
    .ToArray;
  ExpectedArray := [];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
end;

procedure TestArrayLinq.TestMapInd1Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: Integer;
begin
  ResultArray := TArrayContainer<string>
    .Create(['one'])
    .Map(function(const X: string; const I: Integer): string begin Exit(X + IntToStr(I)) end)
    .ToArray;
  ExpectedArray := ['one0'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestMapInd2Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: Integer;
begin
  ResultArray := TArrayContainer<string>
    .Create(['one', 'two'])
    .Map(function(const X: string; const I: Integer): string begin Exit(X + IntToStr(I)) end)
    .ToArray;
  ExpectedArray := ['one0', 'two1'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestMapIndTo0Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: Integer;
begin
  ResultArray := TArrayContainer<int32>
    .Create([])
    .Map<string>(function(const X: int32; const I: Integer): string begin Exit(IntToStr(X) + IntToStr(I)); end)
    .ToArray;
  ExpectedArray := [];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestMapIndTo1Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: Integer;
begin
  ResultArray := TArrayContainer<int32>
    .Create([8])
    .Map<string>(function(const X: int32; const I: Integer): string begin Exit(IntToStr(X) + IntToStr(I)); end)
    .ToArray;
  ExpectedArray := ['80'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestMapIndTo2Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: Integer;
begin
  ResultArray := TArrayContainer<int32>
    .Create([8, 9])
    .Map<string>(function(const X: int32; const I: Integer): string begin Exit(IntToStr(X) + IntToStr(I)); end)
    .ToArray;
  ExpectedArray := ['80', '91'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestMapTo0Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
begin
  ResultArray := TArrayContainer<int32>
    .Create([])
    .Map<string>(function(const X: int32): string begin Exit(IntToStr(X)); end)
    .ToArray;
  ExpectedArray := [];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
end;

procedure TestArrayLinq.TestMapTo1Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: Integer;
begin
  ResultArray := TArrayContainer<int32>
    .Create([1])
    .Map<string>(function(const X: int32): string begin Exit(IntToStr(X)); end)
    .ToArray;
  ExpectedArray := ['1'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestMapTo2Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: Integer;
begin
  ResultArray := TArrayContainer<int32>
    .Create([1, 2])
    .Map<string>(function(const X: int32): string begin Exit(IntToStr(X)); end)
    .ToArray;
  ExpectedArray := ['1', '2'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestOrder0Elements;
var
  ResultArray: TArray<int32>;
  ExpectedArray: TArray<int32>;
begin
  ResultArray := TArrayContainer<int32>
    .Create([])
    .Order()
    .ToArray;
  ExpectedArray := [];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
end;

procedure TestArrayLinq.TestOrder1Elements;
var
  ResultArray: TArray<int32>;
  ExpectedArray: TArray<int32>;
  i: Integer;
begin
  ResultArray := TArrayContainer<int32>
    .Create([2])
    .Order()
    .ToArray;
  ExpectedArray := [2];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestOrderManyElements;
var
  ResultArray: TArray<int32>;
  ExpectedArray: TArray<int32>;
  i: Integer;
begin
  ResultArray := TArrayContainer<int32>
    .Create([2, 4, 5, 1, 7, 0, 10, 35, 1, 0, 8])
    .Order()
    .ToArray;
  ExpectedArray := [0, 0, 1, 1, 2, 4, 5, 7, 8, 10, 35];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestOrderBy0Elements;
var
  ResultArray: TArray<int32>;
  ExpectedArray: TArray<int32>;
begin
  ResultArray := TArrayContainer<int32>
    .Create([])
    .Order(TComparer<int32>.Construct(function(const Left: int32; const Right: int32): Integer
        begin
          Result := TComparer<Integer>.Default.Compare(Left, Right) * -1;
        end))
    .ToArray;
  ExpectedArray := [];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
end;

procedure TestArrayLinq.TestOrderBy1Elements;
var
  ResultArray: TArray<int32>;
  ExpectedArray: TArray<int32>;
  i: Integer;
begin
  ResultArray := TArrayContainer<int32>
    .Create([2])
    .Order(TComparer<int32>.Construct(function(const Left: int32; const Right: int32): Integer
        begin
          Result := TComparer<Integer>.Default.Compare(Left, Right) * -1;
        end))
    .ToArray;
  ExpectedArray := [2];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestOrderByManyElements;
var
  ResultArray: TArray<int32>;
  ExpectedArray: TArray<int32>;
  i: Integer;
begin
  ResultArray := TArrayContainer<int32>
    .Create([2, 4, 5, 1, 7, 0, 10, 35, 1, 0, 8])
    .Order(TComparer<int32>.Construct(function(const Left: int32; const Right: int32): Integer
        begin
          Result := TComparer<Integer>.Default.Compare(Left, Right) * -1;
        end))
    .ToArray;
  ExpectedArray := [35, 10, 8, 7, 5, 4, 2, 1, 1, 0, 0];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestReduce0Elements;
var
  ActualResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([])
    .Reduce(function(const Accumulator: int32; const X: int32): int32 begin Exit(Accumulator + X); end);
  CheckEquals(0, ActualResult);
end;

procedure TestArrayLinq.TestReduce1Elements;
var
  ActualResult: int32;
  ExpectedResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([2])
    .Reduce(function(const Accumulator: int32; const X: int32): int32 begin Exit(Accumulator + X); end);
  ExpectedResult := 2;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduce2Elements;
var
  ActualResult: int32;
  ExpectedResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1, 2])
    .Reduce(function(const Accumulator: int32; const X: int32): int32 begin Exit(Accumulator + X); end);
  ExpectedResult := 3;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceInd0Elements;
var
  ActualResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([])
    .Reduce(function(const Accumulator: int32; const X: int32; const I: Integer): int32 begin Exit(Accumulator + X + I); end);
  CheckEquals(0, ActualResult);
end;

procedure TestArrayLinq.TestReduceInd1Elements;
var
  ActualResult: int32;
  ExpectedResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1])
    .Reduce(function(const Accumulator: int32; const X: int32; const I: Integer): int32 begin Exit(Accumulator + X + I); end);
  ExpectedResult := 1;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceInd3Elements;
var
  ActualResult: int32;
  ExpectedResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1, 2, 3])
    .Reduce(function(const Accumulator: int32; const X: int32; const I: Integer): int32 begin Exit(Accumulator + X + I); end);
  ExpectedResult := 9;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceIndTo0Elements;
var
  ActualResult: string;
  ExpectedResult: string;
begin
  ActualResult := TArrayContainer<int32>
    .Create([])
    .Reduce<string>('0', function(const Accumulator: string; const X: int32; const I: Integer): string
      begin
        Exit(IntToStr(StrToInt(Accumulator) + X + I));
      end);
  ExpectedResult := '0';
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceIndTo1Elements;
var
  ActualResult: string;
  ExpectedResult: string;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1])
    .Reduce<string>('0', function(const Accumulator: string; const X: int32; const I: Integer): string
      begin
        Exit(IntToStr(StrToInt(Accumulator) + X + I));
      end);
  ExpectedResult := '1';
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceIndTo3Elements;
var
  ActualResult: string;
  ExpectedResult: string;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1, 2, 3])
    .Reduce<string>('0', function(const Accumulator: string; const X: int32; const I: Integer): string
      begin
        Exit(IntToStr(StrToInt(Accumulator) + X + I));
      end);
  ExpectedResult := '9';
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceInit0Elements;
var
  ActualResult: int32;
  ExpectedResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([])
    .Reduce(0, function(const Accumulator: int32; const X: int32): int32 begin Exit(Accumulator + X); end);
  ExpectedResult := 0;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceInit1Elements;
var
  ActualResult: int32;
  ExpectedResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1])
    .Reduce(0, function(const Accumulator: int32; const X: int32): int32 begin Exit(Accumulator + X); end);
  ExpectedResult := 1;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceInit2Elements;
var
  ActualResult: int32;
  ExpectedResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1, 2])
    .Reduce(0, function(const Accumulator: int32; const X: int32): int32 begin Exit(Accumulator + X); end);
  ExpectedResult := 3;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceInitInd0Elements;
var
  ActualResult: int32;
  ExpectedResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([])
    .Reduce(0, function(const Accumulator: int32; const X: int32; const I: Integer): int32 begin Exit(Accumulator + X + I); end);
  ExpectedResult := 0;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceInitInd1Elements;
var
  ActualResult: int32;
  ExpectedResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1])
    .Reduce(0, function(const Accumulator: int32; const X: int32; const I: Integer): int32 begin Exit(Accumulator + X + I); end);
  ExpectedResult := 1;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceInitInd2Elements;
var
  ActualResult: int32;
  ExpectedResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1, 2])
    .Reduce(0, function(const Accumulator: int32; const X: int32; const I: Integer): int32 begin Exit(Accumulator + X + I); end);
  ExpectedResult := 4;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceTo0Elements;
var
  ActualResult: string;
  ExpectedResult: string;
begin
  ActualResult := TArrayContainer<int32>
    .Create([])
    .Reduce<string>('0', function(const Accumulator: string; const X: int32): string
      begin
        Exit(IntToStr(StrToInt(Accumulator) + X));
      end);
  ExpectedResult := '0';
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceTo1Elements;
var
  ActualResult: string;
  ExpectedResult: string;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1])
    .Reduce<string>('0', function(const Accumulator: string; const X: int32): string
      begin
        Exit(IntToStr(StrToInt(Accumulator) + X));
      end);
  ExpectedResult := '1';
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestReduceTo2Elements;
var
  ActualResult: string;
  ExpectedResult: string;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1, 2])
    .Reduce<string>('0', function(const Accumulator: string; const X: int32): string
      begin
        Exit(IntToStr(StrToInt(Accumulator) + X));
      end);
  ExpectedResult := '3';
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestForEach0Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create([])
    .ForEach(function(const X: string): Boolean begin ResultArray := ResultArray + [X]; Exit(X = 'two'); end);
  ExpectedArray := [];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
end;

procedure TestArrayLinq.TestForEach1Element;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: int32;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create(['one'])
    .ForEach(function(const X: string): Boolean begin ResultArray := ResultArray + [X]; Exit(X = 'two'); end);
  ExpectedArray := ['one'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestForEach2Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: int32;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create(['one', 'two'])
    .ForEach(function(const X: string): Boolean begin ResultArray := ResultArray + [X]; Exit(X = 'two'); end);
  ExpectedArray := ['one', 'two'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestForEach3Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: int32;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create(['one', 'two', 'three'])
    .ForEach(function(const X: string): Boolean begin ResultArray := ResultArray + [X]; Exit(X = 'two'); end);
  ExpectedArray := ['one', 'two'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestForEachAlt0Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create([])
    .ForEach(procedure(const X: string) begin ResultArray := ResultArray + [X]; end);
  ExpectedArray := [];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
end;

procedure TestArrayLinq.TestForEachAlt1Element;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: int32;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create(['one'])
    .ForEach(procedure(const X: string) begin ResultArray := ResultArray + [X]; end);
  ExpectedArray := ['one'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestForEachAlt2Elements;
var
  ResultArray: TArray<string>;
  ExpectedArray: TArray<string>;
  i: int32;
begin
  ResultArray := [];
  TArrayContainer<string>
    .Create(['one', 'two'])
    .ForEach(procedure(const X: string) begin ResultArray := ResultArray + [X]; end);
  ExpectedArray := ['one', 'two'];
  CheckEquals(Length(ExpectedArray), Length(ResultArray));
  for i := Low(ExpectedArray) to High(ExpectedArray) do
    CheckEquals(ExpectedArray[i], ResultArray[i]);
end;

procedure TestArrayLinq.TestSome0Elements;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<int64>
    .Create([])
    .Some(function (const X: int64): Boolean begin Exit(X > 0); end);
  ExpectedResult := false;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestSome1Element;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<int64>
    .Create([345341123])
    .Some(function (const X: int64): Boolean begin Exit(X > 0); end);
  ExpectedResult := true;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestSome2Elements;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<int64>
    .Create([-2, 345341123])
    .Some(function (const X: int64): Boolean begin Exit(X > 0); end);
  ExpectedResult := true;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.TestSome3Elements;
var
  ActualResult: Boolean;
  ExpectedResult: Boolean;
begin
  ActualResult := TArrayContainer<int64>
    .Create([-2, -345341123, -123123])
    .Some(function (const X: int64): Boolean begin Exit(X > 0); end);
  ExpectedResult := false;
  CheckEquals(ExpectedResult, ActualResult);
end;

procedure TestArrayLinq.FirstOrDefault0Elements;
var
  ActualResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([])
    .FirstOrDefault();
  CheckEquals(0, ActualResult);
end;

procedure TestArrayLinq.FirstOrDefault1Elements;
var
  ActualResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([1])
    .FirstOrDefault();
  CheckEquals(1, ActualResult);
end;

procedure TestArrayLinq.FirstOrDefault2Elements;
var
  ActualResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([-123, -2])
    .FirstOrDefault();
  CheckEquals(-123, ActualResult);
end;

procedure TestArrayLinq.FirstOrDefaultBy0Elements;
var
  ActualResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([])
    .FirstOrDefault(function(const X: int32): Boolean begin Exit(X > 0) end);
  CheckEquals(0, ActualResult);
end;

procedure TestArrayLinq.FirstOrDefaultBy1Elements;
var
  ActualResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([-1])
    .FirstOrDefault(function(const X: int32): Boolean begin Exit(X > 0) end);
  CheckEquals(0, ActualResult);
end;

procedure TestArrayLinq.FirstOrDefaultBy2Elements;
var
  ActualResult: int32;
begin
  ActualResult := TArrayContainer<int32>
    .Create([-1, -2, -3, 0, -8, -10, 1235, 146, 99999])
    .FirstOrDefault(function(const X: int32): Boolean begin Exit(X > 0) end);
  CheckEquals(1235, ActualResult);
end;

initialization

RegisterTest(TestArrayLinq.Suite);

end.
