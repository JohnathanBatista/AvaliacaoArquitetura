unit uAlteraSalario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DateUtils;

type
  TfrmAlteraSalario = class(TForm)
    edtNome: TEdit;
    lblNome: TLabel;
    lblCPF: TLabel;
    edtVlrSalario: TEdit;
    edtCPF: TMaskEdit;
    lblVlrSalario: TLabel;
    btnSalvar: TButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnSalvarClick(Sender: TObject);
    procedure edtVlrSalarioExit(Sender: TObject);
    procedure edtVlrSalarioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlteraSalario: TfrmAlteraSalario;

implementation

uses
   uBiblioteca;

{$R *.dfm}

procedure TfrmAlteraSalario.btnSalvarClick(Sender: TObject);
var
   lvalor: Double;
begin
   try
      lvalor := StrToFloat(StringReplace(edtVlrSalario.Text, '.', '', [rfReplaceall]));
      edtVlrSalario.Text := FormatFloat(MASCARA, lvalor);
   except
      Atencao('Valor inválido!');
      edtVlrSalario.SetFocus;
      edtVlrSalario.SelectAll;
      Abort;
   end;

   ModalResult := mrOk;
end;

procedure TfrmAlteraSalario.edtVlrSalarioExit(Sender: TObject);
var
   lvalor: Double;
begin
   try
      lvalor := StrToFloat(StringReplace(edtVlrSalario.Text, '.', '', [rfReplaceall]));
      edtVlrSalario.Text := FormatFloat(MASCARA, lvalor);
   except
      Atencao('Valor inválido!');
      edtVlrSalario.SetFocus;
      edtVlrSalario.SelectAll;
   end;
end;

procedure TfrmAlteraSalario.edtVlrSalarioKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9', ',', '.', #13, #8]) then
   begin
      Key := #0;
   end;
end;

procedure TfrmAlteraSalario.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end
end;

end.
