unit u_cardapio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, Grids, DBGrids, Mask,SqlExpr,
  DB, jpeg;

type
  Tf_cardapio = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    grid_itens: TDBGrid;
    souce_pesq: TDataSource;
    Label1: TLabel;
    procedure grid_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    retorno       : string;
    desc_retorno  : string;
    valor_retorno : Extended;
  end;

var
  f_cardapio: Tf_cardapio;
  troca_cor : integer;

implementation

{$R *.dfm}

uses u_dm_modulo, u_funcoes,u_ingrediente_cad;

procedure Tf_cardapio.grid_itensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   if datacol = 3 then begin
      grid_itens.Canvas.FillRect(Rect);
      grid_itens.Canvas.TextOut(Rect.Right - Canvas.TextExtent(FormatFloat('#,##0.00',Column.Field.AsFloat)).cx - 8 , rect.top + 2, FormatFloat('#,##0.00',Column.Field.AsFloat));
   end
   else begin
      grid_itens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure Tf_cardapio.FormShow(Sender: TObject);
begin
   troca_cor:=0;
   dm.cds_pesq.close;

   dm.qry_pesq.close;
   dm.qry_pesq.sql.clear;
   dm.qry_pesq.sql.add('select      lpad(la.pk_lanche, 4,0)  as codigo,                         '+
                       '            la.nome,                                                    '+
                       '            cast((list(ing.nome)) as  varchar (5000)) as itens_lanche,  '+
                       '            la.valor                                                    '+
                       '                                                                        '+
                       'from        lanche la                                                   '+
                       'inner join  it_lanche   itl on itl.fk_lanche = la.pk_lanche             '+
                       'inner join  ingrediente ing on ing.pk_ingrediente = itl.fk_ingredientes '+
                       'group by 1,2,4                                                          ');
   dm.cds_pesq.open;

   grid_itens.setfocus;
end;

end.
