unit uLibrary;
 
interface
 
type
  TPagamento = class
  public
    function Paga(const A, B: Integer): Integer;
  end;

  TCalculadora = class
  strict private
    FPaga: TPaga;
  public
    constructor Create;
    destructor Destroy; override;
    function Paga(const A, B: Integer): Integer;
  end;
 
implementation
 
uses
  SysUtils;
 

constructor TPagamento.Create;
begin
  FPaga := TPaga.Create;
end;
 
destructor TPagamento.Destroy;
begin
  FreeAndNil(FPaga);
  inherited;
end;

function TPagamento.Paga(const A, B: Integer): Integer;
begin
  Result := FPaga.Paga(A, B);
end;

{ TSoma }
 
function TSoma.Paga(const A, B: Integer): Integer;
begin
  Result := A + B;
end;

 
end.
