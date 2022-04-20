program Projeto_WK;

uses
  Vcl.Forms,
  ufrm_Pedidos in 'ufrm_Pedidos.pas' {frm_Pedidos},
  udmodule in 'udmodule.pas' {dModule: TDataModule},
  uclasse_Pedidos in 'uclasse_Pedidos.pas',
  ufrm_CancelarPedidos in 'ufrm_CancelarPedidos.pas' {frm_CancelarPedidos},
  ufrm_BuscarPedidos in 'ufrm_BuscarPedidos.pas' {frm_BuscarPedidos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdModule, dModule);
  Application.CreateForm(Tfrm_Pedidos, frm_Pedidos);
  Application.Run;
end.
