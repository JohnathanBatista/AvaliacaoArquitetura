program Pagamentos;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {Principal},
  uLibrary in 'uLibrary.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
