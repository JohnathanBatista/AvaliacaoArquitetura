object Principal: TPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pagamentos'
  ClientHeight = 84
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 51
    Height = 13
    Caption = 'Valor pago'
  end
  object lblTiposPagamento: TLabel
    Left = 135
    Top = 13
    Width = 92
    Height = 13
    Caption = 'Tipo do pagamento'
  end
  object edtValor: TEdit
    Left = 8
    Top = 32
    Width = 121
    Height = 21
    BiDiMode = bdRightToLeft
    ParentBiDiMode = False
    TabOrder = 0
    Text = '0,00'
  end
  object cbxTiposPagamento: TComboBox
    Left = 135
    Top = 32
    Width = 209
    Height = 21
    ItemHeight = 13
    TabOrder = 1
  end
  object btnPagar: TButton
    Left = 350
    Top = 30
    Width = 75
    Height = 25
    Caption = 'Pagar'
    TabOrder = 2
  end
end
