object Dm: TDm
  OldCreateOrder = False
  Left = 261
  Top = 114
  Height = 515
  Width = 827
  object Conexao: TSQLConnection
    ConnectionName = 'IBConnection'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database='
      'RoleName=RoleName'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    Left = 48
    Top = 16
  end
  object ingrediente: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_ingrediente'
    Left = 144
    Top = 112
    object ingredientePK_INGREDIENTE: TIntegerField
      FieldName = 'PK_INGREDIENTE'
      Required = True
    end
    object ingredienteNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object ingredienteVALOR: TFMTBCDField
      DefaultExpression = '0'
      DisplayWidth = 10
      FieldName = 'VALOR'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
      Precision = 15
      Size = 2
    end
  end
  object qry_ingrediente: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select  pk_ingrediente, nome, valor'
      'from INGREDIENTE'
      '')
    SQLConnection = Conexao
    Left = 149
    Top = 16
    object qry_ingredientePK_INGREDIENTE: TIntegerField
      FieldName = 'PK_INGREDIENTE'
      Required = True
    end
    object qry_ingredienteNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object qry_ingredienteVALOR: TFMTBCDField
      FieldName = 'VALOR'
      ProviderFlags = [pfInUpdate]
      Precision = 15
      Size = 2
    end
  end
  object dsp_ingrediente: TDataSetProvider
    DataSet = qry_ingrediente
    Left = 144
    Top = 64
  end
  object source_ingrediente: TDataSource
    DataSet = ingrediente
    Left = 145
    Top = 160
  end
  object Icones: TImageList
    Left = 48
    Top = 80
  end
  object lanche: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'pk_lanche'
        ParamType = ptInput
      end>
    ProviderName = 'dsp_lanche'
    Left = 234
    Top = 112
    object lanchePK_LANCHE: TIntegerField
      FieldName = 'PK_LANCHE'
      Required = True
    end
    object lancheNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object lancheVALOR: TFloatField
      DefaultExpression = '0'
      FieldName = 'VALOR'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object it_lanche: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'fk_lanche'
        ParamType = ptInput
      end>
    ProviderName = 'dsp_it_lanche'
    OnCalcFields = it_lancheCalcFields
    Left = 325
    Top = 112
    object it_lancheFK_LANCHE: TIntegerField
      FieldName = 'FK_LANCHE'
      Required = True
    end
    object it_lancheSEQUENCIA: TIntegerField
      FieldName = 'SEQUENCIA'
      Required = True
    end
    object it_lancheFK_INGREDIENTES: TIntegerField
      FieldName = 'FK_INGREDIENTES'
      Required = True
    end
    object it_lanchenome_ingrediente: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'nome_ingrediente'
      Size = 50
    end
    object it_lanchevalor_ingrediente: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'valor_ingrediente'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object qry_lanche: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'pk_lanche'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select  pk_lanche, nome, valor'
      'from LANCHE'
      'where pk_lanche = :pk_lanche')
    SQLConnection = Conexao
    Left = 234
    Top = 16
    object qry_lanchePK_LANCHE: TIntegerField
      FieldName = 'PK_LANCHE'
      Required = True
    end
    object qry_lancheNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object qry_lancheVALOR: TFloatField
      FieldName = 'VALOR'
      ProviderFlags = [pfInUpdate]
    end
  end
  object qry_it_lanche: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'fk_lanche'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select      i.FK_LANCHE,'
      '             i.SEQUENCIA,'
      '             i.FK_INGREDIENTES'
      ''
      'from        IT_LANCHE i'
      'where       i.FK_LANCHE    = :fk_lanche')
    SQLConnection = Conexao
    Left = 325
    Top = 16
    object qry_it_lancheFK_LANCHE: TIntegerField
      FieldName = 'FK_LANCHE'
      Required = True
    end
    object qry_it_lancheSEQUENCIA: TIntegerField
      FieldName = 'SEQUENCIA'
      Required = True
    end
    object qry_it_lancheFK_INGREDIENTES: TIntegerField
      FieldName = 'FK_INGREDIENTES'
      Required = True
    end
  end
  object dsp_lanche: TDataSetProvider
    DataSet = qry_lanche
    Left = 234
    Top = 64
  end
  object dsp_it_lanche: TDataSetProvider
    DataSet = qry_it_lanche
    Left = 325
    Top = 64
  end
  object source_lanche: TDataSource
    DataSet = lanche
    Left = 234
    Top = 160
  end
  object source_it_lanche: TDataSource
    DataSet = it_lanche
    Left = 325
    Top = 160
  end
  object pedido: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'pk_pedido'
        ParamType = ptInput
      end>
    ProviderName = 'dsp_pedido'
    Left = 481
    Top = 112
    object pedidoPK_PEDIDO: TIntegerField
      FieldName = 'PK_PEDIDO'
      Required = True
    end
    object pedidoCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 50
    end
    object pedidoDATA_PEDIDO: TDateField
      FieldName = 'DATA_PEDIDO'
      Required = True
    end
    object pedidoVALOR_DESC: TFloatField
      DefaultExpression = '0'
      FieldName = 'VALOR_DESC'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object pedidoVALOR_TOTAL: TFloatField
      DefaultExpression = '0'
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object source_pedido: TDataSource
    DataSet = pedido
    Left = 481
    Top = 160
  end
  object dsp_pedido: TDataSetProvider
    DataSet = qry_pedido
    Left = 481
    Top = 64
  end
  object qry_pedido: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'pk_pedido'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select  pk_pedido,'
      '        cliente,'
      '        data_pedido,'
      '        valor_desc,'
      '        valor_total'
      ''
      'from PEDIDO'
      'where pk_pedido = :pk_pedido')
    SQLConnection = Conexao
    Left = 481
    Top = 16
    object qry_pedidoPK_PEDIDO: TIntegerField
      FieldName = 'PK_PEDIDO'
      Required = True
    end
    object qry_pedidoCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 50
    end
    object qry_pedidoDATA_PEDIDO: TDateField
      FieldName = 'DATA_PEDIDO'
      Required = True
    end
    object qry_pedidoVALOR_DESC: TFloatField
      FieldName = 'VALOR_DESC'
    end
    object qry_pedidoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
  end
  object it_pedido: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'fk_pedido'
        ParamType = ptInput
      end>
    ProviderName = 'dsp_it_pedido'
    OnCalcFields = it_pedidoCalcFields
    Left = 567
    Top = 112
    object it_pedidoFK_PEDIDO: TIntegerField
      FieldName = 'FK_PEDIDO'
      Required = True
    end
    object it_pedidoSEQ_IT_PEDIDO: TIntegerField
      FieldName = 'SEQ_IT_PEDIDO'
      Required = True
    end
    object it_pedidoFK_LANCHE: TIntegerField
      FieldName = 'FK_LANCHE'
      Required = True
    end
    object it_pedidoVALOR_TOTAL: TFloatField
      DefaultExpression = '0'
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object it_pedidonomeLanche: TStringField
      DisplayWidth = 100
      FieldKind = fkInternalCalc
      FieldName = 'nomeLanche'
      Size = 100
    end
  end
  object source_it_pedido: TDataSource
    DataSet = it_pedido
    Left = 567
    Top = 160
  end
  object dsp_it_pedido: TDataSetProvider
    DataSet = qry_it_pedido
    Left = 567
    Top = 64
  end
  object qry_it_pedido: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'fk_pedido'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select  fk_pedido,'
      '        seq_it_pedido,'
      '        fk_lanche,'
      '        valor_total'
      ''
      'from    IT_PEDIDO'
      'where   fk_pedido = :fk_pedido')
    SQLConnection = Conexao
    Left = 567
    Top = 16
    object qry_it_pedidoFK_PEDIDO: TIntegerField
      FieldName = 'FK_PEDIDO'
      Required = True
    end
    object qry_it_pedidoSEQ_IT_PEDIDO: TIntegerField
      FieldName = 'SEQ_IT_PEDIDO'
      Required = True
    end
    object qry_it_pedidoFK_LANCHE: TIntegerField
      FieldName = 'FK_LANCHE'
      Required = True
    end
    object qry_it_pedidoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
  end
  object it_lanche_pd: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'fk_pedido'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'seq_it_pedido'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_lanche_pd'
        ParamType = ptInput
      end>
    ProviderName = 'dsp_it_lanche_pd'
    OnCalcFields = it_lanche_pdCalcFields
    Left = 663
    Top = 112
    object it_lanche_pdFK_PEDIDO: TIntegerField
      FieldName = 'FK_PEDIDO'
      Required = True
    end
    object it_lanche_pdSEQ_IT_PEDIDO: TIntegerField
      FieldName = 'SEQ_IT_PEDIDO'
      Required = True
    end
    object it_lanche_pdFK_LANCHE_PD: TIntegerField
      FieldName = 'FK_LANCHE_PD'
      Required = True
    end
    object it_lanche_pdSEQ_IT_LANCHE_PD: TIntegerField
      FieldName = 'SEQ_IT_LANCHE_PD'
      Required = True
    end
    object it_lanche_pdFK_INGREDIENTES_PD: TIntegerField
      FieldName = 'FK_INGREDIENTES_PD'
      Required = True
    end
    object it_lanche_pdnomeIngrediente: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'nomeIngrediente'
      Size = 100
    end
    object it_lanche_pdvalorIngrediente: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'valorIngrediente'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object source_it_lanche_pd: TDataSource
    DataSet = it_lanche_pd
    Left = 663
    Top = 160
  end
  object dsp_it_lanche_pd: TDataSetProvider
    DataSet = qry_it_lanche_pd
    Left = 663
    Top = 64
  end
  object qry_it_lanche_pd: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'fk_pedido'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'seq_it_pedido'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'fk_lanche_pd'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT a.fk_pedido,'
      '       a.seq_it_pedido,'
      '       a.fk_lanche_pd,'
      '       a.seq_it_lanche_pd,'
      '       a.fk_ingredientes_pd'
      ''
      'FROM IT_LANCHE_PD a'
      'where  a.fk_pedido     = :fk_pedido'
      '  and     a.seq_it_pedido   = :seq_it_pedido'
      '   and   a.fk_lanche_pd   = :fk_lanche_pd')
    SQLConnection = Conexao
    Left = 663
    Top = 16
    object qry_it_lanche_pdFK_PEDIDO: TIntegerField
      FieldName = 'FK_PEDIDO'
      Required = True
    end
    object qry_it_lanche_pdSEQ_IT_PEDIDO: TIntegerField
      FieldName = 'SEQ_IT_PEDIDO'
      Required = True
    end
    object qry_it_lanche_pdFK_LANCHE_PD: TIntegerField
      FieldName = 'FK_LANCHE_PD'
      Required = True
    end
    object qry_it_lanche_pdSEQ_IT_LANCHE_PD: TIntegerField
      FieldName = 'SEQ_IT_LANCHE_PD'
      Required = True
    end
    object qry_it_lanche_pdFK_INGREDIENTES_PD: TIntegerField
      FieldName = 'FK_INGREDIENTES_PD'
      Required = True
    end
  end
  object qry_pesq: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Conexao
    Left = 144
    Top = 218
  end
  object dsp_pesq: TDataSetProvider
    DataSet = qry_pesq
    Exported = False
    Left = 144
    Top = 266
  end
  object cds_pesq: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_pesq'
    Left = 144
    Top = 314
  end
  object qry_con: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Conexao
    Left = 232
    Top = 216
  end
  object dsp_con: TDataSetProvider
    DataSet = qry_con
    Exported = False
    Left = 232
    Top = 264
  end
  object cds_con: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_con'
    Left = 232
    Top = 312
  end
  object qry_cad: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Conexao
    Left = 328
    Top = 216
  end
  object dsp_cad: TDataSetProvider
    DataSet = qry_cad
    Exported = False
    Left = 328
    Top = 264
  end
  object cds_cad: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_cad'
    Left = 328
    Top = 312
  end
end
