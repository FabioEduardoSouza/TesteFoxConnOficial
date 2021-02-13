unit u_menu_principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Menus, jpeg;

type
  Tf_menu_principal = class(TForm)
    Panel1: TPanel;
    b_cardapio: TSpeedButton;
    b_pedido_cad: TSpeedButton;
    SpeedButton3: TSpeedButton;
    b_ingredientes: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Panel2: TPanel;
    Label1: TLabel;
    l_data_hora: TLabel;
    Timer1: TTimer;
    Image1: TImage;
    Panel3: TPanel;
    Label2: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure b_ingredientesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure b_pedido_cadClick(Sender: TObject);
    procedure b_cardapioClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_menu_principal: Tf_menu_principal;

implementation

uses u_ingrediente_cad, u_dm_modulo, u_lanches_cad, u_cardapio, u_pedido_cad;

{$R *.dfm}

procedure Tf_menu_principal.Timer1Timer(Sender: TObject);
begin
   l_data_hora.caption := FormatDateTime('dd/mm/yyyy - HH:MM:SS', now);
end;

procedure Tf_menu_principal.SpeedButton5Click(Sender: TObject);
begin
   close;
end;

procedure Tf_menu_principal.b_ingredientesClick(Sender: TObject);
begin
   Timer1.Enabled := false;
   application.createform(Tf_ingrediente_cad,f_ingrediente_cad);
   f_ingrediente_cad.showmodal;
   f_ingrediente_cad.release;
   f_ingrediente_cad := nil;
   Timer1.Enabled := true;
end;

procedure Tf_menu_principal.FormShow(Sender: TObject);
begin
   try
      dm.Conexao.Connected := false;
      dm.Conexao.Close;
      dm.Conexao.Params.Clear;
      dm.Conexao.Params.Add('DriverName=Interbase');
      dm.Conexao.Params.Add('Database=' + 'Localhost:dados_teste');
      dm.Conexao.Params.Add('RoleName=RoleName');
      dm.Conexao.Params.Add('User_Name=' + 'SYSDBA');
      dm.Conexao.Params.Add('Password=' + 'masterkey');
      dm.Conexao.Params.Add('ServerCharSet=');
      dm.Conexao.Params.Add('SQLDialect=3');
      dm.Conexao.Params.Add('ErrorResourceFile=');
      dm.Conexao.Params.Add('LocaleCode=0000');
      dm.Conexao.Params.Add('BlobSize=-1');
      dm.Conexao.Params.Add('CommitRetain=False');
      dm.Conexao.Params.Add('WaitOnLocks=True');
      dm.Conexao.Params.Add('Interbase TransIsolation=ReadCommited');
      dm.Conexao.Params.Add('Trim Char=False');
      dm.Conexao.Connected := true;
   except
      ShowMessage('Não foi possível abrir o banco de dados.');
      application.Terminate;
   end;
end;

procedure Tf_menu_principal.b_pedido_cadClick(Sender: TObject);
begin
   Timer1.Enabled := false;
   application.createform(Tf_lanche_cad,f_lanche_cad);
   f_lanche_cad.showmodal;
   f_lanche_cad.release;
   f_lanche_cad := nil;
   Timer1.Enabled := true;

end;

procedure Tf_menu_principal.b_cardapioClick(Sender: TObject);
begin
   Timer1.Enabled := false;
   application.createform(Tf_cardapio,f_cardapio);
   f_cardapio.showmodal;
   f_cardapio.release;
   f_cardapio := nil;
   Timer1.Enabled := true;
end;

procedure Tf_menu_principal.SpeedButton3Click(Sender: TObject);
begin

   Timer1.Enabled := false;
   application.createform(Tf_pedido_cad,f_pedido_cad);
   f_pedido_cad.showmodal;
   f_pedido_cad.release;
   f_pedido_cad := nil;
   Timer1.Enabled := true;

end;

end.
