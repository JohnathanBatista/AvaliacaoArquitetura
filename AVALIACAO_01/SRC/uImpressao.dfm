object frmImpressao: TfrmImpressao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Impress'#227'o da folha de pagamento'
  ClientHeight = 112
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblNome: TLabel
    Left = 24
    Top = 8
    Width = 83
    Height = 13
    Caption = 'Nome funcion'#225'rio'
  end
  object lblCPF: TLabel
    Left = 345
    Top = 8
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object lblMesAno: TLabel
    Left = 473
    Top = 8
    Width = 120
    Height = 13
    Caption = 'M'#234's/Ano de compet'#234'ncia'
  end
  object lblVlrTransporte: TLabel
    Left = 637
    Top = 8
    Width = 76
    Height = 13
    Caption = 'Vale Transporte'
  end
  object edtNome: TEdit
    Left = 24
    Top = 27
    Width = 313
    Height = 21
    MaxLength = 100
    ReadOnly = True
    TabOrder = 0
  end
  object edtVlrTransporte: TEdit
    Left = 599
    Top = 27
    Width = 119
    Height = 21
    TabOrder = 3
    Text = '0,00'
    OnExit = edtVlrTransporteExit
    OnKeyPress = edtVlrTransporteKeyPress
  end
  object edtCPF: TMaskEdit
    Left = 345
    Top = 27
    Width = 119
    Height = 21
    EditMask = '999.999.999-99;0;_'
    MaxLength = 14
    ParentShowHint = False
    ReadOnly = True
    ShowHint = False
    TabOrder = 1
  end
  object edtMesAno: TMaskEdit
    Left = 472
    Top = 27
    Width = 120
    Height = 21
    EditMask = '!99/9999;1;_'
    MaxLength = 7
    TabOrder = 2
    Text = '  /    '
    OnKeyPress = edtMesAnoKeyPress
  end
  object btnImprimir: TButton
    Left = 643
    Top = 54
    Width = 75
    Height = 25
    Caption = 'Gerar Folha'
    TabOrder = 4
    OnClick = btnImprimirClick
  end
  object dlgSalvaArquivo: TSaveDialog
    DefaultExt = 'txt'
    Filter = '*.txt'
    Left = 576
    Top = 64
  end
end
