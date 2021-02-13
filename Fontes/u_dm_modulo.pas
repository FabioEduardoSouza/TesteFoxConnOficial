unit u_dm_modulo;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, DB, Provider, SqlExpr, DBClient,
  ImgList, Controls;

type
  TDm = class(TDataModule)
    Conexao: TSQLConnection;
    ingrediente: TClientDataSet;
    qry_ingrediente: TSQLQuery;
    dsp_ingrediente: TDataSetProvider;
    source_ingrediente: TDataSource;
    ingredientePK_INGREDIENTE: TIntegerField;
    ingredienteNOME: TStringField;
    ingredienteVALOR: TFMTBCDField;
    qry_ingredientePK_INGREDIENTE: TIntegerField;
    qry_ingredienteNOME: TStringField;
    qry_ingredienteVALOR: TFMTBCDField;
    Icones: TImageList;
    lanche: TClientDataSet;
    it_lanche: TClientDataSet;
    qry_lanche: TSQLQuery;
    qry_it_lanche: TSQLQuery;
    dsp_lanche: TDataSetProvider;
    dsp_it_lanche: TDataSetProvider;
    source_lanche: TDataSource;
    source_it_lanche: TDataSource;
    qry_lanchePK_LANCHE: TIntegerField;
    qry_lancheNOME: TStringField;
    qry_lancheVALOR: TFloatField;
    lanchePK_LANCHE: TIntegerField;
    lancheNOME: TStringField;
    lancheVALOR: TFloatField;
    qry_it_lancheFK_LANCHE: TIntegerField;
    qry_it_lancheSEQUENCIA: TIntegerField;
    qry_it_lancheFK_INGREDIENTES: TIntegerField;
    it_lancheFK_LANCHE: TIntegerField;
    it_lancheSEQUENCIA: TIntegerField;
    it_lancheFK_INGREDIENTES: TIntegerField;
    it_lanchenome_ingrediente: TStringField;
    it_lanchevalor_ingrediente: TFloatField;
    pedido: TClientDataSet;
    source_pedido: TDataSource;
    dsp_pedido: TDataSetProvider;
    qry_pedido: TSQLQuery;
    it_pedido: TClientDataSet;
    source_it_pedido: TDataSource;
    dsp_it_pedido: TDataSetProvider;
    qry_it_pedido: TSQLQuery;
    it_lanche_pd: TClientDataSet;
    source_it_lanche_pd: TDataSource;
    dsp_it_lanche_pd: TDataSetProvider;
    qry_it_lanche_pd: TSQLQuery;
    qry_pedidoPK_PEDIDO: TIntegerField;
    qry_pedidoCLIENTE: TStringField;
    qry_pedidoDATA_PEDIDO: TDateField;
    qry_pedidoVALOR_DESC: TFloatField;
    qry_pedidoVALOR_TOTAL: TFloatField;
    pedidoPK_PEDIDO: TIntegerField;
    pedidoCLIENTE: TStringField;
    pedidoDATA_PEDIDO: TDateField;
    pedidoVALOR_DESC: TFloatField;
    pedidoVALOR_TOTAL: TFloatField;
    qry_it_pedidoFK_PEDIDO: TIntegerField;
    qry_it_pedidoSEQ_IT_PEDIDO: TIntegerField;
    qry_it_pedidoFK_LANCHE: TIntegerField;
    qry_it_pedidoVALOR_TOTAL: TFloatField;
    it_pedidoFK_PEDIDO: TIntegerField;
    it_pedidoSEQ_IT_PEDIDO: TIntegerField;
    it_pedidoFK_LANCHE: TIntegerField;
    it_pedidoVALOR_TOTAL: TFloatField;
    it_pedidonomeLanche: TStringField;
    qry_it_lanche_pdFK_PEDIDO: TIntegerField;
    qry_it_lanche_pdSEQ_IT_PEDIDO: TIntegerField;
    qry_it_lanche_pdFK_LANCHE_PD: TIntegerField;
    qry_it_lanche_pdSEQ_IT_LANCHE_PD: TIntegerField;
    qry_it_lanche_pdFK_INGREDIENTES_PD: TIntegerField;
    it_lanche_pdFK_PEDIDO: TIntegerField;
    it_lanche_pdSEQ_IT_PEDIDO: TIntegerField;
    it_lanche_pdFK_LANCHE_PD: TIntegerField;
    it_lanche_pdSEQ_IT_LANCHE_PD: TIntegerField;
    it_lanche_pdFK_INGREDIENTES_PD: TIntegerField;
    it_lanche_pdnomeIngrediente: TStringField;
    it_lanche_pdvalorIngrediente: TFloatField;
    qry_pesq: TSQLQuery;
    dsp_pesq: TDataSetProvider;
    cds_pesq: TClientDataSet;
    qry_con: TSQLQuery;
    dsp_con: TDataSetProvider;
    cds_con: TClientDataSet;
    qry_cad: TSQLQuery;
    dsp_cad: TDataSetProvider;
    cds_cad: TClientDataSet;
    procedure it_lancheCalcFields(DataSet: TDataSet);
    procedure it_pedidoCalcFields(DataSet: TDataSet);
    procedure it_lanche_pdCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}
uses u_funcoes;


procedure TDm.it_lancheCalcFields(DataSet: TDataSet);
var qry : TSQLQuery;
begin
   cria_qry(qry);

   if trim(DataSet.FieldByName('fk_ingredientes').AsString) <> '' then begin
      qry.close;
      qry.sql.clear;
      qry.sql.add('select nome, valor from ingrediente where pk_ingrediente = :codigo');
      qry.ParamByName('codigo').Asinteger     := DataSet.FieldByName('fk_ingredientes').value;
      qry.Open;
      if not qry.IsEmpty then begin
         DataSet.FieldByName('NOME_INGREDIENTE').AsString := qry.fieldbyname('nome').AsString;
         DataSet.FieldByName('VALOR_INGREDIENTE').AsFloat := qry.fieldbyname('valor').AsFloat;
      end
      else begin
         DataSet.FieldByName('nome_ingrediente').AsString := '';
         DataSet.FieldByName('valor').AsFloat             := 0;
      end;
   end;
   finaliza_qry(qry);
end;

procedure TDm.it_pedidoCalcFields(DataSet: TDataSet);
var qry : TSQLQuery;
begin
   cria_qry(qry);

   if trim(DataSet.FieldByName('fk_lanche').AsString) <> '' then begin
      qry.close;
      qry.sql.clear;
      qry.sql.add('select nome, valor from lanche where pk_lanche = :codigo');
      qry.ParamByName('codigo').Asinteger     := DataSet.FieldByName('fk_lanche').value;
      qry.Open;
      if not qry.IsEmpty then begin
         DataSet.FieldByName('nomeLanche').AsString := qry.fieldbyname('nome').AsString;
      end
      else begin
         DataSet.FieldByName('nomeLanche').AsString := '';
      end;
   end;
   finaliza_qry(qry);

end;

procedure TDm.it_lanche_pdCalcFields(DataSet: TDataSet);
var qry : TSQLQuery;
begin
   cria_qry(qry);

   if trim(DataSet.FieldByName('fk_ingredientes_pd').AsString) <> '' then begin
      qry.close;
      qry.sql.clear;
      qry.sql.add('select nome, valor from ingrediente where pk_ingrediente = :codigo');
      qry.ParamByName('codigo').Asinteger     := DataSet.FieldByName('fk_ingredientes_pd').value;
      qry.Open;
      if not qry.IsEmpty then begin
         DataSet.FieldByName('nomeIngrediente').AsString := qry.fieldbyname('nome').AsString;
         DataSet.FieldByName('valorIngrediente').AsFloat := qry.fieldbyname('valor').AsFloat;
      end
      else begin
         DataSet.FieldByName('nomeIngrediente').AsString := '';
         DataSet.FieldByName('valorIngrediente').AsFloat := 0;
      end;
   end;
   finaliza_qry(qry);

end;

end.
