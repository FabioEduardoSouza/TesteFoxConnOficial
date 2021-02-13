unit u_pedido_cad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, Grids, DBGrids, Mask,SqlExpr,
   DB, Math;

type
  Tf_pedido_cad = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    grid_itens: TDBGrid;
    Group_lanche: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    id_pedido: TEdit;
    cliente: TDBEdit;
    Group_ingrediente: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    seq: TEdit;
    nome: TDBEdit;
    b_gravar: TBitBtn;
    valor: TDBEdit;
    b_excluir: TBitBtn;
    b_limpar: TBitBtn;
    b_excluir_hd: TSpeedButton;
    b_limpar_hd: TSpeedButton;
    b_finaliza: TSpeedButton;
    Panel4: TPanel;
    Label5: TLabel;
    Label8: TLabel;
    desconto: TDBEdit;
    valor_total: TDBEdit;
    data_pedido: TDBEdit;
    Label9: TLabel;
    b_incluir: TSpeedButton;
    procedure seqEnter(Sender: TObject);
    procedure seqExit(Sender: TObject);
    procedure b_gravarClick(Sender: TObject);
    procedure b_excluirClick(Sender: TObject);
    procedure b_limparClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure id_pedidoEnter(Sender: TObject);
    procedure id_pedidoExit(Sender: TObject);
    procedure Group_lancheExit(Sender: TObject);
    procedure grid_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure b_excluir_hdClick(Sender: TObject);
    procedure b_finalizaClick(Sender: TObject);
    procedure b_limpar_hdClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure data_pedidoEnter(Sender: TObject);
    procedure b_incluirClick(Sender: TObject);
  private
    { Private declarations }
    function   limpar:boolean;
    procedure  grava_ingredientes_pedido;
    procedure  calcula_pedido;
    procedure  exclui_ingredientes_lanche_pedido;
  public
    { Public declarations }
  end;

var
  f_pedido_cad: Tf_pedido_cad;
  finalizar : boolean;

implementation

{$R *.dfm}
uses  u_dm_modulo, u_funcoes, u_ingrediente_pes, u_ingred_pedido_cad, u_lanches_pes;

procedure Tf_pedido_cad.seqEnter(Sender: TObject);
var qry  : TSQLQuery;
    item : integer;
begin
   item        := 0;

   dm.it_pedido.Last;
   item        := dm.it_pedidoSEQ_IT_PEDIDO.AsInteger + 1;
   seq.Text    := IntToStr(item);

end;

procedure Tf_pedido_cad.seqExit(Sender: TObject);
begin
   if not finalizar then begin
      if trim(seq.text) <> '' then begin
         if not dm.it_pedido.Locate('seq_it_pedido',StrToInt(seq.text),[]) then begin
            dm.it_pedido.Append;
            dm.it_pedidoFK_PEDIDO.AsInteger        := dm.pedidoPK_PEDIDO.AsInteger;
            dm.it_pedidoSEQ_IT_PEDIDO.AsString     := seq.Text;

            application.createform(Tf_lanches_pes,f_lanches_pes);
            f_lanches_pes.showmodal;

            dm.it_pedidoFK_LANCHE.AsString   := f_lanches_pes.retorno;
            dm.it_pedidonomeLanche.AsString  := f_lanches_pes.desc_retorno;
            dm.it_pedidoVALOR_TOTAL.AsFloat  := f_lanches_pes.valor_retorno;

            f_lanches_pes.release;
            f_lanches_pes := nil;

         end
         else begin
            Try
               dm.it_pedido.edit;
            Except
               ShowMessage('Erro ao acessar registro');
               seq.setfocus;
               exit;
            end;
         end;
         dm.it_lanche_pd.Close;
         dm.it_lanche_pd.Params.ParamByName('fk_pedido').AsInteger      := dm.it_pedidoFK_PEDIDO.AsInteger;
         dm.it_lanche_pd.Params.ParamByName('seq_it_pedido').AsInteger  := dm.it_pedidoSEQ_IT_PEDIDO.AsInteger;
         dm.it_lanche_pd.Params.ParamByName('fk_lanche_pd').AsInteger   := dm.it_pedidoFK_LANCHE.AsInteger;
         dm.it_lanche_pd.open;
      end
      else begin
         messageBox(handle,'Sequência inválido.','Consistência',mb_ok+mb_IconError);
         seq.SetFocus;
      end;
   end;      
end;

procedure Tf_pedido_cad.b_gravarClick(Sender: TObject);
begin

   Try
      dm.pedido.Edit;
      dm.pedidoVALOR_TOTAL.AsFloat  := StrToFloat(FormatFloat('##0.00',(dm.pedidoVALOR_TOTAL.AsFloat + dm.it_pedidoVALOR_TOTAL.AsFloat)));
      dm.pedido.Post;
   Except
      messageBox(handle,'Erro ao gravar registro.','Consistência',mb_ok+mb_IconError);
   end;

   Try
      dm.it_pedido.Post;

      grava_ingredientes_pedido;

   Except
      messageBox(handle,'Erro ao gravar registro.','Consistência',mb_ok+mb_IconError);
   end;

   calcula_pedido;

   seq.SetFocus;
end;

procedure Tf_pedido_cad.b_excluirClick(Sender: TObject);
begin
   if dm.it_pedidoSEQ_IT_PEDIDO.AsString <> '' then begin
      if MessageBox(handle,'Deseja excluir o ingrediente cadastrado?','Confirmação',mb_YesNo+mb_IconQuestion)=idyes then begin
         Try
            dm.pedido.Edit;
            dm.pedidoVALOR_TOTAL.asfloat  := StrToFloat(FormatFloat('##0.00',(dm.pedidoVALOR_TOTAL.asfloat + dm.pedidoVALOR_DESC.AsFloat)));
            dm.pedidoVALOR_TOTAL.AsFloat  := StrToFloat(FormatFloat('##0.00',(dm.pedidoVALOR_TOTAL.AsFloat - dm.it_pedidoVALOR_TOTAL.AsFloat)));
            dm.pedido.Post;

            exclui_ingredientes_lanche_pedido;

            dm.it_pedido.Delete;
            dm.it_pedido.ApplyUpdates(0);
         Except
            messageBox(handle,'Erro ao excluir registro.','Consistência',mb_ok+mb_IconError);
         end;
      end;
      calcula_pedido;
      seq.SetFocus;
   end;
end;

procedure Tf_pedido_cad.b_limparClick(Sender: TObject);
begin
   limpar;
end;

function Tf_pedido_cad.limpar: boolean;
begin
   SelectFirst;

   nome.clear;
   valor.clear;

   seq.SetFocus;

end;

procedure Tf_pedido_cad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   dm.pedido.close;
   dm.it_pedido.close;
   dm.it_lanche_pd.close;
end;

procedure Tf_pedido_cad.id_pedidoEnter(Sender: TObject);
var qry : TSQLQuery;
begin

   cria_qry(qry);

   qry.Close;
   qry.SQL.Clear;
   qry.SQL.Add('select max(pk_pedido) as pk_pedido from PEDIDO');
   qry.open;
   if qry.IsEmpty then begin
      id_pedido.Text  := '1';
   end
   else begin
      id_pedido.Text  := IntToStr(qry.FieldByName('PK_PEDIDO').AsInteger + 1);
   end;

   finaliza_qry(qry);

end;

procedure Tf_pedido_cad.id_pedidoExit(Sender: TObject);
begin
   if trim(id_pedido.text) <> '' then begin

      dm.pedido.close;
      dm.pedido.Params.ParamByName('pk_pedido').AsString := id_pedido.Text;
      dm.pedido.open;
      if dm.pedido.IsEmpty then begin
         dm.pedido.Append;
         dm.pedidoPk_pedido.AsString := id_pedido.Text;
      end
      else begin
         Try
            dm.pedido.edit;
         Except
            ShowMessage('Erro ao acessar registro');
            id_pedido.setfocus;
            exit;
         end;
      end;

      Try
         dm.it_pedido.close;
         dm.it_pedido.Params.ParamByName('fk_pedido').AsInteger := dm.pedidoPk_pedido.AsInteger;
         dm.it_pedido.open;

      Except
         ShowMessage('Erro ao acessar registro item lanche');
         id_pedido.setfocus;
         exit;
      end;

   end
   else begin
      messageBox(handle,'Código inválido.','Consistência',mb_ok+mb_IconError);
      id_pedido.SetFocus;
   end;

end;

procedure Tf_pedido_cad.Group_lancheExit(Sender: TObject);
begin
   Try
      dm.pedido.Post;
   Except
      messageBox(handle,'Erro ao gravar registro.','Consistência',mb_ok+mb_IconError);
   end;
end;

procedure Tf_pedido_cad.grid_itensDrawColumnCell(Sender: TObject;
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

procedure Tf_pedido_cad.b_excluir_hdClick(Sender: TObject);
begin
   if dm.pedidoPK_PEDIDO.AsString <> '' then begin
      if MessageBox(handle,'Deseja excluir o cadastro do lanche e seus ingrediente cadastrados?','Confirmação',mb_YesNo+mb_IconQuestion)=idyes then begin

         dm.it_pedido.First;
         while not dm.it_pedido.Eof do begin

            exclui_ingredientes_lanche_pedido;

            Try
               dm.it_pedido.Delete;
               dm.it_pedido.ApplyUpdates(0);
            Except
               messageBox(handle,'Erro ao excluir registro.','Consistência',mb_ok+mb_IconError);
            end;
            dm.it_pedido.First;
         end;

         Try
            dm.pedido.Delete;
            dm.pedido.ApplyUpdates(0);
         Except
            messageBox(handle,'Erro ao excluir registro.','Consistência',mb_ok+mb_IconError);
         end;
      end;
      id_pedido.SetFocus;
   end;
end;

procedure Tf_pedido_cad.b_finalizaClick(Sender: TObject);
begin
   finalizar   := true;
   Try
      dm.pedido.ApplyUpdates(0);
      dm.it_pedido.ApplyUpdates(0);
   Except
      messageBox(handle,'Erro ao excluir registro.','Consistência',mb_ok+mb_IconError);
   end;

   b_limpar_hdClick(Sender);

   finalizar   := false;

end;

procedure Tf_pedido_cad.b_limpar_hdClick(Sender: TObject);
begin
   SelectFirst;
   Dm.it_pedido.Close;

   cliente.clear;
   valor.clear;
   data_pedido.Clear;
   desconto.Clear;
   valor_total.Clear ;

   id_pedido.SetFocus;

end;

procedure Tf_pedido_cad.FormShow(Sender: TObject);
begin
   finalizar := false;
end;

procedure Tf_pedido_cad.data_pedidoEnter(Sender: TObject);
begin
   dm.pedidoDATA_PEDIDO.AsDateTime := now;
end;

procedure Tf_pedido_cad.grava_ingredientes_pedido;
var qry : TSQLQuery;
begin

   cria_qry(qry);

   if dm.it_lanche_pd.IsEmpty then begin

      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select  fk_ingredientes,         '+
                  '        sequencia                '+
                  'from    it_lanche                '+
                  'where   fk_lanche = :fk_lanche   '+
                  'order by sequencia               ');
      qry.ParamByName('fk_lanche').AsInteger          := dm.it_pedidoFK_LANCHE.AsInteger;
      qry.open;
      while not qry.Eof do begin

         try
            dm.it_lanche_pd.Append;
            dm.it_lanche_pdFK_PEDIDO.AsInteger           := dm.it_pedidoFK_PEDIDO.AsInteger;
            dm.it_lanche_pdSEQ_IT_PEDIDO.AsInteger       := dm.it_pedidoSEQ_IT_PEDIDO.AsInteger;
            dm.it_lanche_pdFK_LANCHE_PD.AsInteger        := dm.it_pedidoFK_LANCHE.AsInteger;
            dm.it_lanche_pdSEQ_IT_LANCHE_PD.AsInteger    := qry.FieldByName('sequencia').AsInteger;
            dm.it_lanche_pdFK_INGREDIENTES_PD.AsInteger  := qry.FieldByName('fk_ingredientes').AsInteger;
            dm.it_lanche_pd.post;
            dm.it_lanche_pd.ApplyUpdates(0);
         except
            ShowMessage('Erro ao incluir registro');
            exit;
         end;
         qry.Next;
      end;
   end
   else begin
      dm.it_lanche_pd.Edit;
   end;

   finaliza_qry(qry);

end;

procedure Tf_pedido_cad.b_incluirClick(Sender: TObject);
begin

   grava_ingredientes_pedido;

   application.createform(Tf_ingred_pedido_cad,f_ingred_pedido_cad);
   f_ingred_pedido_cad.showmodal;
   f_ingred_pedido_cad.release;
   f_ingred_pedido_cad := nil;

end;

procedure Tf_pedido_cad.calcula_pedido;
var valorSomado : extended;
begin

   valorSomado := 0;

   dm.it_pedido.First;
   while not dm.it_pedido.eof do begin

      valorSomado := valorSomado + dm.it_pedidoVALOR_TOTAL.AsFloat;

      dm.it_pedido.Next;
   end;


   dm.pedido.Edit;

   dm.pedidoVALOR_TOTAL.asfloat     := StrToFloat(FormatFloat('##0.00',(valorSomado)));
   dm.pedidoVALOR_DESC.AsFloat      := 0;

   if dm.it_pedido.RecordCount = 2 then begin
      dm.pedidoVALOR_DESC.AsFloat   := StrToFloat(FormatFloat('##0.00',((dm.pedidoVALOR_TOTAL.AsFloat * 3) / 100)));
      dm.pedidoVALOR_TOTAL.asfloat  := StrToFloat(FormatFloat('##0.00',(dm.pedidoVALOR_TOTAL.asfloat - dm.pedidoVALOR_DESC.AsFloat)));
   end
   else if dm.it_pedido.RecordCount = 3 then begin
      dm.pedidoVALOR_DESC.AsFloat   := StrToFloat(FormatFloat('##0.00',((dm.pedidoVALOR_TOTAL.AsFloat * 5) / 100)));
      dm.pedidoVALOR_TOTAL.asfloat  := StrToFloat(FormatFloat('##0.00',(dm.pedidoVALOR_TOTAL.asfloat - dm.pedidoVALOR_DESC.AsFloat)));
   end
   else if dm.it_pedido.RecordCount >= 5 then begin
      dm.pedidoVALOR_DESC.AsFloat   := StrToFloat(FormatFloat('##0.00',((dm.pedidoVALOR_TOTAL.AsFloat * 10) / 100)));
      dm.pedidoVALOR_TOTAL.asfloat  := StrToFloat(FormatFloat('##0.00',(dm.pedidoVALOR_TOTAL.asfloat - dm.pedidoVALOR_DESC.AsFloat)));
   end;
   dm.pedido.post;

end;

procedure Tf_pedido_cad.exclui_ingredientes_lanche_pedido;
begin

   dm.it_lanche_pd.Close;
   dm.it_lanche_pd.Params.ParamByName('fk_pedido').AsInteger      := dm.it_pedidoFK_PEDIDO.AsInteger;
   dm.it_lanche_pd.Params.ParamByName('seq_it_pedido').AsInteger  := dm.it_pedidoSEQ_IT_PEDIDO.AsInteger;
   dm.it_lanche_pd.Params.ParamByName('fk_lanche_pd').AsInteger   := dm.it_pedidoFK_LANCHE.AsInteger;
   dm.it_lanche_pd.open;
   dm.it_lanche_pd.First;
   while not dm.it_lanche_pd.Eof do begin
      Try
         dm.it_lanche_pd.Delete;
         dm.it_lanche_pd.ApplyUpdates(0);
      Except
         messageBox(handle,'Erro ao excluir registro.','Consistência',mb_ok+mb_IconError);
      end;
      dm.it_lanche_pd.First;
   end;

end;

end.
