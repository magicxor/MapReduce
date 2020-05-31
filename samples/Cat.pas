unit Cat;

interface

type
  TCat = record
  public
    var
      Name: string;
      Weight: Integer;
      Color: string;
      HasTail: Boolean;

    constructor Create(AName: string; AWeight: Integer; AColor: string; AHasTail: Boolean);
  end;

implementation

{ TCat }

constructor TCat.Create(AName: string; AWeight: Integer; AColor: string; AHasTail: Boolean);
begin
  Name := AName;
  Weight := AWeight;
  Color := AColor;
  HasTail := AHasTail;
end;

end.
