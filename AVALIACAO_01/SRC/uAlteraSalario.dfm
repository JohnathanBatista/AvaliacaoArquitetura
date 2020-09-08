object frmAlteraSalario: TfrmAlteraSalario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o sal'#225'rio base'
  ClientHeight = 98
  ClientWidth = 602
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
  object lblVlrSalario: TLabel
    Left = 470
    Top = 8
    Width = 58
    Height = 13
    Caption = 'Sal'#225'rio Base'
  end
  object edtNome: TEdit
    Left = 24
    Top = 27
    Width = 313
    Height = 21
    TabStop = False
    MaxLength = 100
    ReadOnly = True
    TabOrder = 0
  end
  object edtVlrSalario: TEdit
    Left = 470
    Top = 27
    Width = 119
    Height = 21
    TabOrder = 2
    Text = '0,00'
    OnExit = edtVlrSalarioExit
    OnKeyPress = edtVlrSalarioKeyPress
  end
  object edtCPF: TMaskEdit
    Left = 345
    Top = 27
    Width = 119
    Height = 21
    TabStop = False
    EditMask = '999.999.999-99;0;_'
    MaxLength = 14
    ParentShowHint = False
    ReadOnly = True
    ShowHint = False
    TabOrder = 1
  end
  object btnSalvar: TButton
    Left = 514
    Top = 54
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = btnSalvarClick
  end
end
