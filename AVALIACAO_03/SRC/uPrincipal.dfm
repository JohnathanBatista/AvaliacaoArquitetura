object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Avalia'#231#227'o 3'
  ClientHeight = 612
  ClientWidth = 775
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrdNos: TDBGrid
    Left = 0
    Top = 0
    Width = 775
    Height = 313
    Align = alTop
    DataSource = dsNoz
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO_PAI'
        ReadOnly = True
        Title.Caption = 'C'#243'digo N'#243
        Width = 183
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_NO_PAI'
        Title.Caption = 'C'#243'digo N'#243' Pai'
        Width = 187
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_NO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 350
        Visible = True
      end>
  end
  object btnConverter: TButton
    Left = 0
    Top = 313
    Width = 775
    Height = 25
    Align = alTop
    Caption = 'Converter para TreeView'
    TabOrder = 1
    OnClick = btnConverterClick
  end
  object tvArvore: TTreeView
    Left = 0
    Top = 338
    Width = 775
    Height = 274
    Align = alClient
    Indent = 19
    TabOrder = 2
  end
  object cdsNos: TClientDataSet
    PersistDataPacket.Data = {
      640000009619E0BD01000000180000000300000000000300000064000A434F44
      49474F5F50414904000100000000000D434F4449474F5F4E4F5F504149040001
      00000000000C44455343524943414F5F4E4F0100490000000100055749445448
      0200020064000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 624
    Top = 16
    object cdsNosCODIGO_PAI: TIntegerField
      FieldName = 'CODIGO_PAI'
    end
    object cdsNosCODIGO_NO_PAI: TIntegerField
      FieldName = 'CODIGO_NO_PAI'
    end
    object cdsNosDESCRICAO_NO: TStringField
      FieldName = 'DESCRICAO_NO'
      Size = 100
    end
  end
  object dsNoz: TDataSource
    DataSet = cdsNos
    Left = 664
    Top = 16
  end
end
