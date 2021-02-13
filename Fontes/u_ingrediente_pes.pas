unit u_ingrediente_pes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, Grids, DBGrids, Mask,SqlExpr,
  DB;

type
  Tf_ingrediente_pes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    grid_itens: TDBGrid;
    b_pesquisa: TBitBtn;
    item: TEdit;
    b_selecionar: TSpeedButton;
    souce_pesq: TDataSource;
    b_cadastrar: TSpeedButton;
    procedure b_pesquisaClick(Sender: TObject);
    procedure b_selecionarClick(Sender: TObject);
    procedure grid_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure b_cadastrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    retorno       : string;
    desc_retorno  : string;
    valor_retorno : Extended;
  end;

var
  f_ingrediente_pes: Tf_ingrediente_pes;

implementation

{$R *.dfm}

uses u_dm_modulo, u_funcoes,u_ingrediente_cad;

procedure Tf_ingrediente_pes.b_pesquisaClick(Sender: TObject);
begin
   dm.cds_pesq.close;

   dm.qry_pesq.close;
   dm.qry_pesq.sql.clear;
   dm.qry_pesq.sql.add('Select pk_ingrediente, nome, cast(valor as decimal(11,2)) as valor from ingrediente where ');
   dm.qry_pesq.sql.add('upper(nome) like upper(' + '''' + '%' + item.text + '%' + '''' + ') order by pk_ingrediente');
   dm.cds_pesq.open;

   grid_itens.setfocus;
end;

procedure Tf_ingrediente_pes.b_selecionarClick(Sender: TObject);
begin
   if not dm.cds_pesq.IsEmpty then begin
      retorno        := grid_itens.Fields[0].AsString;
      desc_retorno   := grid_itens.Fields[1].AsString;
      valor_retorno  := grid_itens.Fields[2].AsFloat;
   end;
   Close;
end;

procedure Tf_ingrediente_pes.grid_itensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   if datacol = 2 then begin
      grid_itens.Canvas.FillRect(Rect);
      grid_itens.Canvas.TextOut(Rect.Right - Canvas.TextExtent(FormatFloat('#,##0.00',Column.Field.AsFloat)).cx - 3 , rect.top + 2, FormatFloat('#,##0.00',Column.Field.AsFloat));
   end
   else begin
      grid_itens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;

end;

procedure Tf_ingrediente_pes.b_cadastrarClick(Sender: TObject);
begin
   application.createform(Tf_ingrediente_cad,f_ingrediente_cad);
   f_ingrediente_cad.showmodal;
   f_ingrediente_cad.release;
   f_ingrediente_cad := nil;

end;

end.
