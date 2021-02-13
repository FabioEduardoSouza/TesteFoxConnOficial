unit u_ingred_pedido_cad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, Grids, DBGrids, Mask,SqlExpr,
  DB;

type
  Tf_ingred_pedido_cad = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    grid_itens: TDBGrid;
    b_inclui: TBitBtn;
    b_finaliza_inc: TBitBtn;
    procedure b_incluiClick(Sender: TObject);
    procedure b_selecionarClick(Sender: TObject);
    procedure grid_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure b_finaliza_incClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    retorno       : string;
    desc_retorno  : string;
    valor_retorno : Extended;
  end;

var
  f_ingred_pedido_cad: Tf_ingred_pedido_cad;

implementation

{$R *.dfm}

uses u_dm_modulo, u_funcoes,u_ingrediente_pes;

procedure Tf_ingred_pedido_cad.b_incluiClick(Sender: TObject);
var seq                 : integer;
    ingred_fd           : String;
    nomeIngrediente     : String;
    valorIngrediente    : Extended;


begin
   ingred_fd               := '';
   nomeIngrediente         := '';
   valorIngrediente        := 0;

   application.createform(Tf_ingrediente_pes,f_ingrediente_pes);
   f_ingrediente_pes.showmodal;

   ingred_fd               := f_ingrediente_pes.retorno;
   nomeIngrediente         := f_ingrediente_pes.desc_retorno;
   valorIngrediente        := f_ingrediente_pes.valor_retorno;

   f_ingrediente_pes.release;
   f_ingrediente_pes := nil;

   if nomeIngrediente <> '' then begin
      try
         dm.it_lanche_pd.Last;
         seq      := dm.it_lanche_pdSEQ_IT_LANCHE_PD.AsInteger +1;

         dm.it_lanche_pd.append;
         dm.it_lanche_pdFK_PEDIDO.AsInteger           := dm.it_pedidoFK_PEDIDO.AsInteger;
         dm.it_lanche_pdSEQ_IT_PEDIDO.AsInteger       := dm.it_pedidoSEQ_IT_PEDIDO.AsInteger;
         dm.it_lanche_pdFK_LANCHE_PD.AsInteger        := dm.it_pedidoFK_LANCHE.AsInteger;
         dm.it_lanche_pdSEQ_IT_LANCHE_PD.AsInteger    := seq;
         dm.it_lanche_pdFK_INGREDIENTES_PD.AsString   := ingred_fd;
         dm.it_lanche_pdnomeIngrediente.AsString      := nomeIngrediente;
         dm.it_lanche_pdvalorIngrediente.AsFloat      := valorIngrediente;

         dm.it_pedidoVALOR_TOTAL.AsFloat              := dm.it_pedidoVALOR_TOTAL.AsFloat + dm.it_lanche_pdvalorIngrediente.AsFloat;

         dm.it_lanche_pd.Post;
         dm.it_lanche_pd.ApplyUpdates(0);
      Except
         ShowMessage('Erro ao incluir registro');
         exit;
      end;
   end;
   grid_itens.setfocus;
end;

procedure Tf_ingred_pedido_cad.b_selecionarClick(Sender: TObject);
begin
   if not dm.cds_pesq.IsEmpty then begin
      retorno        := grid_itens.Fields[0].AsString;
      desc_retorno   := grid_itens.Fields[1].AsString;
      valor_retorno  := grid_itens.Fields[2].AsFloat;
   end;
   Close;

end;

procedure Tf_ingred_pedido_cad.grid_itensDrawColumnCell(Sender: TObject;
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

procedure Tf_ingred_pedido_cad.b_finaliza_incClick(Sender: TObject);
begin
   close;
end;

end.
