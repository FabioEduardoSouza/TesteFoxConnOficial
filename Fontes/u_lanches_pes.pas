unit u_lanches_pes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, Grids, DBGrids, Mask,SqlExpr,
  DB;

type
  Tf_lanches_pes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    grid_itens: TDBGrid;
    b_pesquisa: TBitBtn;
    item: TEdit;
    b_selecionar: TSpeedButton;
    souce_con: TDataSource;
    procedure b_pesquisaClick(Sender: TObject);
    procedure b_selecionarClick(Sender: TObject);
    procedure grid_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    retorno       : string;
    desc_retorno  : string;
    valor_retorno : Extended;
  end;

var
  f_lanches_pes: Tf_lanches_pes;

implementation

{$R *.dfm}

uses u_dm_modulo, u_funcoes;

procedure Tf_lanches_pes.b_pesquisaClick(Sender: TObject);
begin
   dm.cds_con.close;

   dm.qry_con.close;
   dm.qry_con.sql.clear;
   dm.qry_con.sql.add('Select pk_lanche, nome, cast(valor as decimal(11,2)) as valor from lanche where ');
   dm.qry_con.sql.add('upper(nome) like upper(' + '''' + '%' + item.text + '%' + '''' + ') order by pk_lanche');
   dm.cds_con.open;

   grid_itens.setfocus;
end;

procedure Tf_lanches_pes.b_selecionarClick(Sender: TObject);
begin
   if not dm.cds_con.IsEmpty then begin
      retorno        := grid_itens.Fields[0].AsString;
      desc_retorno   := grid_itens.Fields[1].AsString;
      valor_retorno  := grid_itens.Fields[2].AsFloat;
   end;
   Close;

end;

procedure Tf_lanches_pes.grid_itensDrawColumnCell(Sender: TObject;
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

end.
