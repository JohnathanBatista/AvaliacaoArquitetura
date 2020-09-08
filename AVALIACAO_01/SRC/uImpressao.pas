unit uImpressao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DateUtils;

type
  TfrmImpressao = class(TForm)
    edtNome: TEdit;
    lblNome: TLabel;
    lblCPF: TLabel;
    edtVlrTransporte: TEdit;
    edtCPF: TMaskEdit;
    lblMesAno: TLabel;
    lblVlrTransporte: TLabel;
    edtMesAno: TMaskEdit;
    btnImprimir: TButton;
    dlgSalvaArquivo: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtVlrTransporteExit(Sender: TObject);
    procedure edtVlrTransporteKeyPress(Sender: TObject; var Key: Char);
    procedure edtMesAnoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure GeraFolha;
  public
    { Public declarations }
    FSalario: Double;
  end;

var
  frmImpressao: TfrmImpressao;

implementation

uses
   uBiblioteca;

{$R *.dfm}

procedure TfrmImpressao.btnImprimirClick(Sender: TObject);
var
   lvalor: Double;
begin
   if edtMesAno.Text = '  /    ' then
   begin
      Atencao('Informe mês e ano de competência!');
      edtMesAno.SetFocus;
      Exit;
   end;

   if not ValidaMesAno(edtMesAno.Text) then
   begin
      Atencao('Mês/Ano informado está incorreto. Verifique!');
      edtMesAno.SetFocus;
      Exit;
   end;

   try
      lvalor := StrToFloat(edtVlrTransporte.Text);
      edtVlrTransporte.Text := FormatFloat(MASCARA, lvalor);
   except
      Atencao('Valor inválido!');
      edtVlrTransporte.SetFocus;
      edtVlrTransporte.SelectAll;
   end;

   GeraFolha;
end;

procedure TfrmImpressao.edtMesAnoKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9']) then
   begin
      Key := #0;
   end;
end;

procedure TfrmImpressao.edtVlrTransporteExit(Sender: TObject);
var
   lvalor: Double;
begin
   try
      lvalor := StrToFloat(edtVlrTransporte.Text);
      edtVlrTransporte.Text := FormatFloat(MASCARA, lvalor);
   except
      Atencao('Valor inválido!');
      edtVlrTransporte.SetFocus;
      edtVlrTransporte.SelectAll;
   end;
end;

procedure TfrmImpressao.edtVlrTransporteKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9', #8, #27]) then
   begin
      Key := #0;
   end;
end;

procedure TfrmImpressao.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end
end;

procedure TfrmImpressao.FormShow(Sender: TObject);
var
   lMes, lAno: string;
begin
   lMes := FormatFloat('00',   MonthOf(Now));
   lAno := FormatFloat('0000', YearOf(Now));

   edtMesAno.Text := lMes + '/' + lAno;
end;

procedure TfrmImpressao.GeraFolha;
var
   lArquivo: TextFile;
   lMes: integer;
   lAno: string;

const
   COLUNA_1 = 55;

   procedure AdicionaLinha(pConteudo: string);
   begin
      Writeln(lArquivo, pConteudo);
   end;

   procedure AddLinhaDivisa(pChar: Char);
   var
      lLinha: string;
   begin
      AdicionaLinha(RPad(lLinha, pChar, 100));
   end;
begin
   if dlgSalvaArquivo.Execute then
   begin
      AssignFile(lArquivo, dlgSalvaArquivo.FileName);
      try
         try
            if (FileExists(dlgSalvaArquivo.FileName)) then
            begin
               Append(lArquivo);
            end
            else
            begin
               Rewrite(lArquivo);
            end;


            lMes := StrToInt(Copy(edtMesAno.Text, 1, 2));
            lAno := Copy(edtMesAno.Text, 4, 4);
            AddLinhaDivisa('_');
            AdicionaLinha('COMPETENCIA ' + MesExtenso(lMes, True) + '/' + lAno);
            AddLinhaDivisa(' ');
            AdicionaLinha('EMPREGADOR                                                                     CPF');
            AdicionaLinha('  JOAQUIM MARIANO DA SILVA                                                       111.111.111-11');
            AddLinhaDivisa(' ');
            AdicionaLinha('EMPREGADO                                                                      CPF');
            AdicionaLinha(Lpad(UpperCase('  ' + edtNome.Text), ' ', 81) + FormataCPF(SoNumeros(edtCPF.Text)));
            AddLinhaDivisa('_');
            AdicionaLinha(Rpad('DEMOSNTRATIVO DE VALORES DEVIDOS', ' ', 66));
            AddLinhaDivisa('-');
            AdicionaLinha(Lpad('DESCRIÇÃO', ' ', COLUNA_1) + Lpad('BASE', ' ', 30)       + 'VALOR À' );
            AdicionaLinha(Lpad('', ' ', COLUNA_1)          + Lpad('DE CÁLCULO', ' ', 30) + 'RECOLHER' );
            AddLinhaDivisa('-');
            AdicionaLinha(Lpad('FGTS Mensal (8%)',                                    ' ', COLUNA_1) + Lpad('R$' + FormatFloat(MASCARA, FSalario), ' ', 30) + 'R$' + FormatFloat(MASCARA, CalcularDescontos(FSalario, tiFGTSMensal)));
            AdicionaLinha(Lpad('FGTS compensatório (3,2%)',                           ' ', COLUNA_1) + Lpad('R$' + FormatFloat(MASCARA, FSalario), ' ', 30) + 'R$' + FormatFloat(MASCARA, CalcularDescontos(FSalario, tiFGTSCompensatorio)));
            AdicionaLinha(Lpad('Contribuição Previdenciária do Empregador (8%)',      ' ', COLUNA_1) + Lpad('R$' + FormatFloat(MASCARA, FSalario), ' ', 30) + 'R$' + FormatFloat(MASCARA, CalcularDescontos(FSalario, tiCPEr)));
            AdicionaLinha(Lpad('Seguro Contra Acidentes de Trabalho - GILRAT (0,8%)', ' ', COLUNA_1) + Lpad('R$' + FormatFloat(MASCARA, FSalario), ' ', 30) + 'R$' + FormatFloat(MASCARA, CalcularDescontos(FSalario, tiSeguroAcidente)));
            AdicionaLinha(Lpad('Contribuição Previdênciaria do Empregado' + ' (' + FloatToStr(GetAliquotaINSS(FSalario)) + '%)',       ' ', COLUNA_1) + Lpad('R$' + FormatFloat(MASCARA, FSalario), ' ', 30) + 'R$' + FormatFloat(MASCARA, CalcularDescontos(FSalario, tiINSS)));
            AddLinhaDivisa(' ');
            AddLinhaDivisa('_');
            AdicionaLinha(Rpad('RECIBO DE SALÁRIO', ' ', 58));
            AddLinhaDivisa('-');
            AdicionaLinha(Lpad('DESCRIÇÃO', ' ', COLUNA_1) + Lpad('VENCIMENTO', ' ', 30)       + 'DESCONTO' );
            AddLinhaDivisa('-');
            AdicionaLinha(Lpad('Salário', ' ', COLUNA_1) + Lpad('R$' + FormatFloat(MASCARA, FSalario), ' ', 30));
            AdicionaLinha(Lpad('Vale Transporte - Adiantamento pago em dinheiro', ' ', COLUNA_1) + Lpad('R$' + FormatFloat(MASCARA, StrToFloatDef(edtVlrTransporte.Text, 0)), ' ', 30));
            AdicionaLinha(Lpad('Contribuição previdênciaria do empregado (INSS)', ' ', COLUNA_1) + Lpad(' ', ' ', 30) + 'R$' + FormatFloat(MASCARA, CalcularDescontos(FSalario, tiINSS)));
            AddLinhaDivisa(' ');
            AdicionaLinha(Lpad('TOTAL', ' ', COLUNA_1) + Lpad('R$' + FormatFloat(MASCARA, (FSalario + StrToFloatDef(edtVlrTransporte.Text, 0))), ' ', 30));
            AdicionaLinha('TOTAL LÍQUIDO: R$ ' + FormatFloat(MASCARA, (FSalario + StrToFloatDef(edtVlrTransporte.Text, 0) -  CalcularDescontos(FSalario, tiINSS))));
         except
            on E: exception do
            begin
               Erro('Erro ao gerar o arquivo de Folha! ' + sLineBreak + E.Message);
            end;
         end;

         Atencao('Folha gerada com sucesso!' + sLineBreak + dlgSalvaArquivo.FileName)
      finally
         CloseFile(lArquivo);
      end;
   end;
end;
end.
