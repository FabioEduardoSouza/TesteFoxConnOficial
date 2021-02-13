program lanches;

uses
  Forms,
  u_dm_modulo in 'u_dm_modulo.pas' {Dm: TDataModule},
  u_menu_principal in 'u_menu_principal.pas' {f_menu_principal},
  u_pedido_cad in 'u_pedido_cad.pas' {f_pedido_cad},
  u_funcoes in 'u_funcoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(Tf_menu_principal, f_menu_principal);
  Application.Run;
end.
