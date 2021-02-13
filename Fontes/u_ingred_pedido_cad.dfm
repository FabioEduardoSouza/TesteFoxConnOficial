object f_ingred_pedido_cad: Tf_ingred_pedido_cad
  Left = 403
  Top = 231
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Ingredientes do item do lanche'
  ClientHeight = 484
  ClientWidth = 476
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
    Width = 476
    Height = 44
    Align = alTop
    Color = clSkyBlue
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object b_inclui: TBitBtn
      Left = 291
      Top = 11
      Width = 77
      Height = 22
      Caption = '&Incluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = b_incluiClick
    end
    object b_finaliza_inc: TBitBtn
      Left = 376
      Top = 11
      Width = 77
      Height = 22
      Caption = '&Finaliza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = b_finaliza_incClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 443
    Width = 476
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
    Top = 44
    Width = 476
    Height = 399
    Align = alClient
    DataSource = Dm.source_it_lanche_pd
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
        FieldName = 'FK_INGREDIENTES_PD'
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
        FieldName = 'nomeIngrediente'
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
        FieldName = 'valorIngrediente'
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
end
