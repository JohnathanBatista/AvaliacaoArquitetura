unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TPrincipal = class(TForm)
    edtValor: TEdit;
    Label1: TLabel;
    cbxTiposPagamento: TComboBox;
    lblTiposPagamento: TLabel;
    btnPagar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

{$R *.dfm}

end.
