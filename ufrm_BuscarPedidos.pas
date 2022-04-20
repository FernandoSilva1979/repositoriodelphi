unit ufrm_BuscarPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, Vcl.ComCtrls;
type
  Tfrm_BuscarPedidos = class(TForm)
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
  frm_BuscarPedidos: Tfrm_BuscarPedidos;

implementation

{$R *.dfm}

uses udmodule,ufrm_pedidos;

procedure Tfrm_BuscarPedidos.btnBuscarPedidoClick(Sender: TObject);   // buscar pedido para exibicao no form de pedido
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
            ShowMessage('Erro ao Buscar Pedidos : ' + E.Message );
          end;
         end;

         if (RecordCount=0) then
             showmessage('Pedido Nao Encontrado !!!')
           else
           begin
             frm_Pedidos.labNroPedido.caption:=fieldbyname('nro_pedido').AsString;  // inclui informacoes do pedido no form de pedido
             frm_Pedidos.atualizarPedidoProdutos;
             frm_Pedidos.edtCodCliente.text :=  fieldbyname('cod_cliente').asstring;
             frm_Pedidos.edtNomeCliente.text :=  fieldbyname('cliente').asstring;
             frm_Pedidos.labTotalGeral.Caption :=  floattostr(frm_Pedidos.atualizarPedidoProdutosTotal);
             ModalResult:=mrok;
           end;
           Free;
       end;
   end;
end;


procedure Tfrm_BuscarPedidos.edtNroPedidoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#13) then
  begin
    btnBuscarPedido.Click();
  end;
end;

end.
