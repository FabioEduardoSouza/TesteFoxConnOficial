unit u_funcoes;

interface

uses  SqlExpr, SysUtils;

   procedure cria_qry(var qry:TSQLQuery);
   procedure finaliza_qry(var qry:TSQLQuery);

implementation

uses u_dm_modulo;

procedure cria_qry(var qry:TSQLQuery);
begin
   qry := TSQLQuery.Create(nil);
   qry.SQLConnection := dm.Conexao;
end;

procedure finaliza_qry(var qry:TSQLQuery);
begin
   if qry <> nil then
      qry.Close;
   FreeAndNil(qry);
end;


end.
