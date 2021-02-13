unit u_ingrediente_cad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, Grids, DBGrids, Mask,SqlExpr;

type
  Tf_ingrediente_cad = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    id: TEdit;
    grid_itens: TDBGrid;
    nome: TDBEdit;
    b_finalizar: TBitBtn;
    b_gravar: TBitBtn;
    valor: TDBEdit;
    b_excluir: TBitBtn;
    b_limpar: TBitBtn;
    procedure idEnter(Sender: TObject);
    procedure idExit(Sender: TObject);
    procedure b_gravarClick(Sender: TObject);
    procedure b_excluirClick(Sender: TObject);
    procedure b_finalizarClick(Sender: TObject);
    procedure b_limparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function limpar:boolean;
  public
    { Public declarations }
  end;

var
  f_ingrediente_cad: Tf_ingrediente_cad;

implementation

{$R *.dfm}
uses u_dm_modulo, u_funcoes;

procedure Tf_ingrediente_cad.idEnter(Sender: TObject);
var qry : TSQLQuery;
begin

   cria_qry(qry);

   qry.Close;
   qry.SQL.Clear;
   qry.SQL.Add('select max(pk_ingrediente) as pk_ingrediente from ingrediente');
   qry.open;
   if qry.IsEmpty then begin
      id.Text  := '1';
   end
   else begin
      id.Text  := IntToStr(qry.FieldByName('pk_ingrediente').AsInteger + 1);
   end;

   finaliza_qry(qry);
end;

procedure Tf_ingrediente_cad.idExit(Sender: TObject);
begin
   if trim(id.text) <> '' then begin
      if not dm.ingrediente.Locate('pk_ingrediente',StrToInt(id.text),[]) then begin
         dm.ingrediente.Append;
         dm.ingredientePK_INGREDIENTE.AsString := id.Text;
      end
      else begin
         Try
            dm.ingrediente.edit;
         Except
            ShowMessage('Erro ao acessar registro');
            id.setfocus;
            exit;
         end;
      end;
   end
   else begin
      messageBox(handle,'Id inválido.','Consistência',mb_ok+mb_IconError);
      id.SetFocus;
   end;
end;

procedure Tf_ingrediente_cad.b_gravarClick(Sender: TObject);
begin
   Try
      dm.ingrediente.Post;
      dm.ingrediente.ApplyUpdates(0);
   Except
      messageBox(handle,'Erro ao gravar registro.','Consistência',mb_ok+mb_IconError);
   end;
   limpar;
end;

procedure Tf_ingrediente_cad.b_excluirClick(Sender: TObject);
begin
   if (dm.ingredientePK_INGREDIENTE.AsString <> '') and (dm.ingredienteNOME.AsString <> '') then begin
      if MessageBox(handle,'Deseja excluir o ingrediente cadastrados?','Confirmação',mb_YesNo+mb_IconQuestion)=idyes then begin

         Try
            dm.ingrediente.Delete;
            dm.ingrediente.ApplyUpdates(0);
         Except
            messageBox(handle,'Erro ao excluir registro.','Consistência',mb_ok+mb_IconError);
         end;
      end;
   end;
   limpar;
end;

procedure Tf_ingrediente_cad.b_finalizarClick(Sender: TObject);
begin
   close;
end;

procedure Tf_ingrediente_cad.b_limparClick(Sender: TObject);
begin
   limpar;
end;

function Tf_ingrediente_cad.limpar: boolean;
begin
   SelectFirst;

   nome.clear;
   valor.clear;

   id.SetFocus;

end;

procedure Tf_ingrediente_cad.FormShow(Sender: TObject);
begin
   dm.ingrediente.close;
   dm.ingrediente.open;
   limpar;
end;

procedure Tf_ingrediente_cad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   dm.ingrediente.close;
end;

end.
