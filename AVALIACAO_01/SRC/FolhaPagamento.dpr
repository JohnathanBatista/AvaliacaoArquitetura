program FolhaPagamento;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uImpressao in 'uImpressao.pas' {frmImpressao},
  uBiblioteca in 'uBiblioteca.pas',
  uAlteraSalario in 'uAlteraSalario.pas' {frmAlteraSalario};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
