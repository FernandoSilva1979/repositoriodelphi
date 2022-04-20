unit uclasse_Pedidos;          // classe de pedidos e produtos de pedido
interface
uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Phys.ADSDef,
  FireDAC.Phys.ADS, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

 type Pedidos = class
   private
       Fnro_pedido:integer;
       Fdata_emissao:TDate;
       Fcod_cliente:integer;
       Fvalor_total:double;
    procedure Setcod_cliente(const Value: integer);
    procedure Setdata_emissao(const Value: TDate);
    procedure Setnro_pedido(const Value: integer);
    procedure Setvalor_total(const Value: double);
   public
       property  nro_pedido:integer read Fnro_pedido write Setnro_pedido;
       property data_emissao:TDate read Fdata_emissao write Setdata_emissao;
       property cod_cliente:integer read Fcod_cliente write Setcod_cliente;
       property valor_total:double read Fvalor_total write Setvalor_total;
       function novoPedido(pedidoInicial : Pedidos) : Pedidos;
       constructor Create;
 end;

 type PedidoProdutos = class
   private
       Fid:integer;
       Fnro_pedido:integer;
       Fcod_produto:integer;
       Fquantidade:double;
       Fvlr_unitario:double;
       Fvlr_total:double;
    procedure Setcod_produto(const Value: integer);
    procedure Setid(const Value: integer);
    procedure Setnro_pedido(const Value: integer);
    procedure Setquantidade(const Value: double);
    procedure Setvlr_total(const Value: double);
    procedure Setvlr_unitario(const Value: double);
   public
       property id:integer read Fid write Setid;
       property nro_pedido:integer read Fnro_pedido write Setnro_pedido;
       property cod_produto:integer read Fcod_produto write Setcod_produto;
       property quantidade:double read Fquantidade write Setquantidade;
       property vlr_unitario:double read Fvlr_unitario write Setvlr_unitario;
       property vlr_total:double read Fvlr_total write Setvlr_total;
       function inserirProdutoPedido(vpedidoprodutos : PedidoProdutos) : Boolean;

       constructor Create;
 end;

implementation
uses udmodule,Dialogs;
{ Pedidos }

constructor Pedidos.Create;
begin
   nro_pedido:=0;
end;


function Pedidos.novoPedido(pedidoInicial : Pedidos) : Pedidos;
var FD_Query : TFDQuery;
    vErro : boolean;
    sql : string;
    vUlt_id : integer;
    novopedido : Pedidos;
begin
  FD_Query := TFDQuery.Create(nil);
  with FD_Query do
  begin
     try
       vUlt_id := 0;
       Connection:= dmodule.FDConnection1;
       close;
       sql.clear;                                                                  //  insercao de pedido
       sql.add('insert into pedidos (cod_cliente,data_emissao,valor_total) '
                +' values ('+QuotedStr(inttostr(pedidoInicial.cod_cliente))+
               ',' + QuotedStr(datetostr(pedidoInicial.data_emissao))+
               ',' + StringReplace(floattostr(pedidoInicial.valor_total),',', '.',[rfReplaceAll, rfIgnoreCase])+')');
       execsql;

       close;
       sql.clear;
       sql.add('SELECT LAST_INSERT_ID() ult_id');
       open;
       vUlt_id := fieldbyname('ult_id').value;   //  ultimo id de pedido cadastrado

       close;
       sql.clear;
       sql.add('SELECT * from pedidos where nro_pedido='+inttostr(vUlt_id));  // seleciona o pedido e aloca em um objeto
       open;
       novopedido:=Pedidos.Create;
       novopedido.nro_pedido:=fieldbyname('nro_pedido').value;
       novopedido.data_emissao:=fieldbyname('data_emissao').asdatetime;
       novopedido.cod_cliente:=fieldbyname('cod_cliente').value;
       novopedido.valor_total:=fieldbyname('valor_total').value;

       Except
       on E: Exception do
          begin
            ShowMessage('Erro ao Incluir : ' + E.Message );
          end;
     end;
     Result :=novopedido;
     Free;
  end;
end;


procedure Pedidos.Setcod_cliente(const Value: integer);
begin
  Fcod_cliente := Value;
end;


procedure Pedidos.Setdata_emissao(const Value: TDate);
begin
  Fdata_emissao := Value;
end;

procedure Pedidos.Setnro_pedido(const Value: integer);
begin
  Fnro_pedido := Value;
end;


procedure Pedidos.Setvalor_total(const Value: double);
begin
  Fvalor_total := Value;
end;

{ PedidoProdutos }

constructor PedidoProdutos.Create;
begin

end;


function PedidoProdutos.inserirProdutoPedido(vpedidoprodutos : PedidoProdutos): Boolean;                 // insercao de produtos no pedido
var FD_Query : TFDQuery;
    vErro : boolean;
    vUlt_id : integer;
begin
  FD_Query := TFDQuery.Create(nil);
  with FD_Query do
  begin
     try
       vErro := true;
       Connection:= dmodule.FDConnection1;
       close;
       sql.clear;
       sql.Add('INSERT INTO pedidos_produtos (nro_pedido,cod_produto,quantidade,vlr_unitario,vlr_total) '
                +' values ('''+ inttostr(vpedidoprodutos.nro_pedido)
                +''','''+ inttostr(vpedidoprodutos.cod_produto)
                +''','''+StringReplace(floattostr(vpedidoprodutos.quantidade),',', '.',[rfReplaceAll, rfIgnoreCase])
                +''','''+StringReplace(floattostr(vpedidoprodutos.vlr_unitario),',', '.',[rfReplaceAll, rfIgnoreCase])
                +''','''+StringReplace(floattostr(vpedidoprodutos.vlr_total),',', '.',[rfReplaceAll, rfIgnoreCase])+''')');
       execsql;
       Except
       on E: Exception do
          begin
            ShowMessage('Erro ao Incluir Produto em Pedido : ' + E.Message );
            vErro:=false
          end;
     end;
     Result :=vErro;
     Free;
  end;
end;


procedure PedidoProdutos.Setcod_produto(const Value: integer);
begin
  Fcod_produto := Value;
end;


procedure PedidoProdutos.Setid(const Value: integer);
begin
  Fid := Value;
end;


procedure PedidoProdutos.Setnro_pedido(const Value: integer);
begin
  Fnro_pedido := Value;
end;


procedure PedidoProdutos.Setquantidade(const Value: double);
begin
  Fquantidade := Value;
end;


procedure PedidoProdutos.Setvlr_total(const Value: double);
begin
  Fvlr_total := Value;
end;


procedure PedidoProdutos.Setvlr_unitario(const Value: double);
begin
  Fvlr_unitario := Value;
end;

end.
