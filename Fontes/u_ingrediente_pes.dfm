object f_ingrediente_pes: Tf_ingrediente_pes
  Left = 403
  Top = 231
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pesquisa de ingredientes'
  ClientHeight = 484
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 52
    Align = alTop
    Color = clSkyBlue
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Label2: TLabel
      Left = 21
      Top = 7
      Width = 64
      Height = 14
      Caption = 'Ingrediente'
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object b_pesquisa: TBitBtn
      Left = 397
      Top = 21
      Width = 77
      Height = 22
      Caption = '&Atualizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = b_pesquisaClick
    end
    object item: TEdit
      Left = 21
      Top = 21
      Width = 371
      Height = 20
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 443
    Width = 493
    Height = 41
    Align = alBottom
    AutoSize = True
    Color = clSkyBlue
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object b_selecionar: TSpeedButton
      Left = 15
      Top = 9
      Width = 89
      Height = 22
      Caption = '&Selecionar'
      OnClick = b_selecionarClick
    end
    object b_cadastrar: TSpeedButton
      Left = 117
      Top = 9
      Width = 89
      Height = 22
      Caption = '&Cadastrar'
      OnClick = b_cadastrarClick
    end
    object Panel3: TPanel
      Left = 268
      Top = 1
      Width = 210
      Height = 39
      BevelOuter = bvNone
      Color = clSkyBlue
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
  end
  object grid_itens: TDBGrid
    Left = 0
    Top = 52
    Width = 493
    Height = 391
    Align = alClient
    DataSource = souce_pesq
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = grid_itensDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'PK_INGREDIENTE'
        Title.Alignment = taRightJustify
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Ingrediente'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor '
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 100
        Visible = True
      end>
  end
  object souce_pesq: TDataSource
    DataSet = Dm.cds_pesq
    Left = 408
    Top = 288
  end
end
