unit u_lanches_cad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, Grids, DBGrids, Mask,SqlExpr,
   DB, Math;

type
  Tf_lanche_cad = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    grid_itens: TDBGrid;
    Group_lanche: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    id_lanche: TEdit;
    nome_lanche: TDBEdit;
    valor_lanche: TDBEdit;
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
    procedure seqEnter(Sender: TObject);
    procedure seqExit(Sender: TObject);
    procedure b_gravarClick(Sender: TObject);
    procedure b_excluirClick(Sender: TObject);
    procedure b_limparClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure id_lancheEnter(Sender: TObject);
    procedure id_lancheExit(Sender: TObject);
    procedure Group_lancheExit(Sender: TObject);
    procedure grid_itensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure b_excluir_hdClick(Sender: TObject);
    procedure b_finalizaClick(Sender: TObject);
    procedure b_limpar_hdClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function limpar:boolean;
  public
    { Public declarations }
  end;

var
  f_lanche_cad: Tf_lanche_cad;
  finalizar : boolean;

implementation

{$R *.dfm}
uses  u_dm_modulo, u_funcoes, u_ingrediente_pes;

procedure Tf_lanche_cad.seqEnter(Sender: TObject);
var qry  : TSQLQuery;
    item : integer;
begin
   item        := 0;

   dm.it_lanche.Last;
   item        := dm.it_lancheSEQUENCIA.AsInteger + 1;
   seq.Text    := IntToStr(item);

end;

procedure Tf_lanche_cad.seqExit(Sender: TObject);
begin
   if not finalizar then begin
      if trim(seq.text) <> '' then begin
         if not dm.it_lanche.Locate('sequencia',StrToInt(seq.text),[]) then begin
            dm.it_lanche.Append;
            dm.it_lancheFK_LANCHE.AsInteger        := dm.lanchePK_LANCHE.AsInteger;
            dm.it_lancheSEQUENCIA.AsString         := seq.Text;

            application.createform(Tf_ingrediente_pes,f_ingrediente_pes);
            f_ingrediente_pes.showmodal;

            dm.it_lancheFK_INGREDIENTES.AsString   := f_ingrediente_pes.retorno;
            dm.it_lancheNOME_INGREDIENTE.AsString  := f_ingrediente_pes.desc_retorno;
            dm.it_lancheVALOR_INGREDIENTE.AsFloat  := f_ingrediente_pes.valor_retorno;

            f_ingrediente_pes.release;
            f_ingrediente_pes := nil;

         end
         else begin
            Try
               dm.it_lanche.edit;
            Except
               ShowMessage('Erro ao acessar registro');
               seq.setfocus;
               exit;
            end;
         end;
      end
      else begin
         messageBox(handle,'Sequência inválido.','Consistência',mb_ok+mb_IconError);
         seq.SetFocus;
      end;
   end;      
end;

procedure Tf_lanche_cad.b_gravarClick(Sender: TObject);
begin

   Try
      dm.lanche.Edit;
      dm.lancheVALOR.AsFloat  := StrToFloat(FormatFloat('##0.00',(dm.lancheVALOR.AsFloat + dm.it_lancheVALOR_INGREDIENTE.AsFloat)));
      dm.lanche.Post;
   Except
      messageBox(handle,'Erro ao gravar registro.','Consistência',mb_ok+mb_IconError);
   end;

   Try
      dm.it_lanche.Post;
   Except
      messageBox(handle,'Erro ao gravar registro.','Consistência',mb_ok+mb_IconError);
   end;
   seq.SetFocus;
end;

procedure Tf_lanche_cad.b_excluirClick(Sender: TObject);
begin
   if dm.it_lancheSEQUENCIA.AsString <> '' then begin
      if MessageBox(handle,'Deseja excluir o ingrediente cadastrado?','Confirmação',mb_YesNo+mb_IconQuestion)=idyes then begin

         Try
            dm.lanche.Edit;
            dm.lancheVALOR.AsFloat  := StrToFloat(FormatFloat('##0.00',(dm.lancheVALOR.AsFloat - dm.it_lancheVALOR_INGREDIENTE.AsFloat)));
            dm.lanche.Post;
         Except
            messageBox(handle,'Erro ao gravar registro.','Consistência',mb_ok+mb_IconError);
         end;

         Try
            dm.it_lanche.Delete;
            dm.it_lanche.ApplyUpdates(0);
         Except
            messageBox(handle,'Erro ao excluir registro.','Consistência',mb_ok+mb_IconError);
         end;
      end;
   end;
end;

procedure Tf_lanche_cad.b_limparClick(Sender: TObject);
begin
   limpar;
end;

function Tf_lanche_cad.limpar: boolean;
begin
   SelectFirst;

   nome.clear;
   valor.clear;

   seq.SetFocus;

end;

procedure Tf_lanche_cad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   dm.lanche.close;
   dm.it_lanche.close;
end;

procedure Tf_lanche_cad.id_lancheEnter(Sender: TObject);
var qry : TSQLQuery;
begin

   cria_qry(qry);

   qry.Close;
   qry.SQL.Clear;
   qry.SQL.Add('select max(pk_lanche) as pk_lanche from lanche');
   qry.open;
   if qry.IsEmpty then begin
      id_lanche.Text  := '1';
   end
   else begin
      id_lanche.Text  := IntToStr(qry.FieldByName('PK_LANCHE').AsInteger + 1);
   end;

   finaliza_qry(qry);

end;

procedure Tf_lanche_cad.id_lancheExit(Sender: TObject);
begin
   if trim(id_lanche.text) <> '' then begin

      dm.lanche.close;
      dm.lanche.Params.ParamByName('pk_lanche').AsString := id_lanche.Text;
      dm.lanche.open;
      if dm.lanche.IsEmpty then begin
         dm.lanche.Append;
         dm.lanchePk_lanche.AsString := id_lanche.Text;
      end
      else begin
         Try
            dm.lanche.edit;
         Except
            ShowMessage('Erro ao acessar registro');
            id_lanche.setfocus;
            exit;
         end;
      end;

      Try
         dm.it_lanche.close;
         dm.it_lanche.Params.ParamByName('fk_lanche').AsInteger := dm.lanchePk_lanche.AsInteger;
         dm.it_lanche.open;
      Except
         ShowMessage('Erro ao acessar registro item lanche');
         id_lanche.setfocus;
         exit;
      end;

   end
   else begin
      messageBox(handle,'Código inválido.','Consistência',mb_ok+mb_IconError);
      id_lanche.SetFocus;
   end;

end;

procedure Tf_lanche_cad.Group_lancheExit(Sender: TObject);
begin
   Try
      dm.lanche.Post;
   Except
      messageBox(handle,'Erro ao gravar registro.','Consistência',mb_ok+mb_IconError);
   end;
end;

procedure Tf_lanche_cad.grid_itensDrawColumnCell(Sender: TObject;
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

procedure Tf_lanche_cad.b_excluir_hdClick(Sender: TObject);
begin
   if dm.lanchePk_lanche.AsString <> '' then begin
      if MessageBox(handle,'Deseja excluir o cadastro do lanche e seus ingrediente cadastrados?','Confirmação',mb_YesNo+mb_IconQuestion)=idyes then begin

         dm.it_lanche.First;
         while not dm.it_lanche.Eof do begin
            Try
               dm.it_lanche.Delete;
               dm.it_lanche.ApplyUpdates(0);
            Except
               messageBox(handle,'Erro ao excluir registro.','Consistência',mb_ok+mb_IconError);
            end;
            dm.it_lanche.First;
         end;

         Try
            dm.lanche.Delete;
            dm.lanche.ApplyUpdates(0);
         Except
            messageBox(handle,'Erro ao excluir registro.','Consistência',mb_ok+mb_IconError);
         end;
      end;
   end;
end;

procedure Tf_lanche_cad.b_finalizaClick(Sender: TObject);
begin
   finalizar   := true;
   Try
      dm.lanche.ApplyUpdates(0);
      dm.it_lanche.ApplyUpdates(0);
   Except
      messageBox(handle,'Erro ao excluir registro.','Consistência',mb_ok+mb_IconError);
   end;

   b_limpar_hdClick(Sender);

   finalizar   := false;

end;

procedure Tf_lanche_cad.b_limpar_hdClick(Sender: TObject);
begin
   SelectFirst;
   Dm.it_lanche.Close;

   nome_lanche.clear;
   valor_lanche.clear;

   id_lanche.SetFocus;

end;

procedure Tf_lanche_cad.FormShow(Sender: TObject);
begin
   finalizar := false;
end;

end.
