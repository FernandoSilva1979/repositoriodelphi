unit ufrm_CancelarPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, Vcl.ComCtrls;
type
  Tfrm_CancelarPedidos = class(TForm)
    Label1: TLabel;
    edtNroPedido: TEdit;
    btnBuscarPedido: TBitBtn;
    procedure btnBuscarPedidoClick(Sender: TObject);
    procedure edtNroPedidoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_CancelarPedidos: Tfrm_CancelarPedidos;

implementation

{$R *.dfm}

uses udmodule,ufrm_pedidos;

procedure Tfrm_CancelarPedidos.btnBuscarPedidoClick(Sender: TObject);
var FD_Query : TFDQuery;
begin
 if (edtNroPedido.Text<>'') then
   begin
      FD_Query := TFDQuery.Create(nil);
      with FD_Query do
       begin
         Connection:= dmodule.FDConnection1;
         try
           close;
           sql.clear;
           sql.add('select nro_pedido,cod_cliente,' +
               '(select nome from clientes b where b.cod_cliente=a.cod_cliente) cliente from pedidos a'+
               ' where nro_pedido='+QuotedStr(edtNroPedido.text));
           open;
         Except
         on E: Exception do
          begin
             ShowMessage('Erro ao Selecionar pedido : ' + E.Message );
          end;
         end;
         if (RecordCount=0) then
             showmessage('Pedido Nao Encontrado !!!')
           else
           begin
            If  MessageDlg('Confirma Cancelamento ? ',mtConfirmation,[mbyes,mbno],0)=mryes    then
              begin
                 Connection.StartTransaction;
                 try
                   close;
                   sql.Clear;
                   sql.Add('delete from pedidos_produtos where nro_pedido= '+edtNroPedido.text);
                   execsql;

                   close;
                   sql.Clear;
                   sql.Add('delete from pedidos where nro_pedido= '+edtNroPedido.text);
                   execsql;
                   Connection.commit;
                   showmessage('Pedido : '+edtNroPedido.Text+' Cancelado');
                 except on E : Exception do
                  begin
                    Connection.Rollback;
                    ShowMessage('Erro No Cancelamento de Pedido : '+E.Message);
                  end;
                 end;
              end;
           end;
           Free;
       end;
   end;
end;


procedure Tfrm_CancelarPedidos.edtNroPedidoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#13) then
  begin
    btnBuscarPedido.Click();
  end;

end;

end.
