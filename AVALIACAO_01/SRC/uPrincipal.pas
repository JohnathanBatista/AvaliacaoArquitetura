unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, Mask, StdCtrls, uBiblioteca;

type
  TfrmPrincipal = class(TForm)
    grdFuncionarios: TStringGrid;
    btnImprimir: TButton;
    procedure grdFuncionariosDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure grdFuncionariosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FFuncSelecionado: TFuncionario;
    procedure EditarFuncionario;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
   uImpressao, uAlteraSalario;

{$R *.dfm}

procedure TfrmPrincipal.btnImprimirClick(Sender: TObject);
begin
   {Abrir tela de impressão}
   frmImpressao := TfrmImpressao.Create(Self);
   frmImpressao.edtNome.Text := FFuncSelecionado.fNome;
   frmImpressao.edtCPF.Text  := FFuncSelecionado.fCpf;
   frmImpressao.FSalario     := FFuncSelecionado.fSalarioBase;

   frmImpressao.ShowModal;
end;

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
   {Rotina para preencher a grid com os funcionário pré definidos em uma constante}
   PreencheFuncionarios(grdFuncionarios);
end;

procedure TfrmPrincipal.grdFuncionariosDblClick(Sender: TObject);
begin
   EditarFuncionario;
end;

procedure TfrmPrincipal.grdFuncionariosSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
   {Ao clicar no grid, salva as informações do funcionário em uma variável global, para a tela de impressão ter acesso
   aos dados selecionados no grid para impressão}
   FFuncSelecionado.fNome        := grdFuncionarios.Cells[0, ARow];
   FFuncSelecionado.fCpf         := SoNumeros(grdFuncionarios.Cells[1, ARow]);
   FFuncSelecionado.fSalarioBase := StrToFloat(StringReplace(grdFuncionarios.Cells[2, ARow], '.', '', [rfReplaceall]));
   FFuncSelecionado.fLinhaGrid   := ARow;
end;

procedure TfrmPrincipal.EditarFuncionario;
var
   lCanSelect: Boolean; 
begin
   frmAlteraSalario := TfrmAlteraSalario.Create(Self);
   frmAlteraSalario.edtNome.Text       := FFuncSelecionado.fNome;
   frmAlteraSalario.edtCPF.Text        := FFuncSelecionado.fCpf;
   frmAlteraSalario.edtVlrSalario.Text := FormatFloat(MASCARA, FFuncSelecionado.fSalarioBase);

   if (frmAlteraSalario.ShowModal = mrOk) then
   begin
      grdFuncionarios.Cells[2, FFuncSelecionado.fLinhaGrid] :=
         FormatFloat(MASCARA, StrToFloat(StringReplace(frmAlteraSalario.edtVlrSalario.Text, '.', '', [rfReplaceall])));

      grdFuncionariosSelectCell(grdFuncionarios, 0, FFuncSelecionado.fLinhaGrid, lCanSelect);
   end;
end;

end.
