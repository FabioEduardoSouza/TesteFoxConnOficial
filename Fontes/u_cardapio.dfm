object f_cardapio: Tf_cardapio
  Left = 206
  Top = 110
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Card'#225'pio'
  ClientHeight = 612
  ClientWidth = 1017
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1017
    Height = 129
    Align = alTop
    Color = clSkyBlue
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Label1: TLabel
      Left = 242
      Top = -5
      Width = 655
      Height = 126
      Align = alCustom
      Alignment = taCenter
      AutoSize = False
      Caption = ' Lanches '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -133
      Font.Name = 'Monotype Corsiva'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 571
    Width = 1017
    Height = 41
    Align = alBottom
    AutoSize = True
    Color = clSkyBlue
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
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
    Top = 129
    Width = 1017
    Height = 442
    Align = alClient
    DataSource = souce_pesq
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgColLines, dgRowLines]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = []
    OnDrawColumnCell = grid_itensDrawColumnCell
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codigo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -12
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Lanche'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -12
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'itens_lanche'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Ingredientes'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -12
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 800
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Valor'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -12
        Title.Font.Name = 'Arial'
        Title.Font.Style = []
        Width = 150
        Visible = True
      end>
  end
  object souce_pesq: TDataSource
    DataSet = Dm.cds_pesq
    Left = 408
    Top = 288
  end
end
