object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Folha Pagamento'
  ClientHeight = 476
  ClientWidth = 773
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
  object grdFuncionarios: TStringGrid
    Left = 24
    Top = 8
    Width = 729
    Height = 427
    Hint = 'Duplo clique para editar'
    ColCount = 3
    DefaultRowHeight = 19
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 0
    OnDblClick = grdFuncionariosDblClick
    OnSelectCell = grdFuncionariosSelectCell
    ColWidths = (
      309
      230
      162)
    RowHeights = (
      19
      19)
  end
  object btnImprimir: TButton
    Left = 678
    Top = 441
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 1
    OnClick = btnImprimirClick
  end
end
