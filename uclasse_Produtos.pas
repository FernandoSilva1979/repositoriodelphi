unit uclasse_Produtos;

interface
  uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Phys.ADSDef,
  FireDAC.Phys.ADS, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

   type Produtos = class
   private
       Fid:integer;
       Fcod_produto:integer;
       Fdescricao:string;
       Fpreco_venda:double;
    procedure Setcod_produto(const Value: integer);
    procedure Setdescricao(const Value: string);
    procedure Setid(const Value: Integer);
    procedure Setpreco_venda(const Value: double);
   public
       property id :Integer read Fid write Setid;
       property cod_produto :integer read Fcod_produto write Setcod_produto;
       property descricao : string read Fdescricao write Setdescricao;
       property preco_venda : double read Fpreco_venda write Setpreco_venda;
       constructor Create();
       function buscarProduto(cod_produto : integer) : Produtos;

   end;

implementation
uses udmodule,Dialogs;
{ Produtos }

function Produtos.buscarProduto(cod_produto : integer): Produtos;
var FD_Query : TFDQuery;
    vErro : boolean;
    sql : string;
    produto : Produtos;
begin
  FD_Query := TFDQuery.Create(nil);
  with FD_Query do
  begin
     try
       Connection:= dmodule.FDConnection1;
       close;
       sql.clear;
       sql.add('SELECT id,cod_produto,descricao,preco_venda from produtos where cod_produto='+inttostr(cod_produto));
       open;

       produto:=Produtos.Create;
       produto.id:=fieldbyname('id').asinteger;
       produto.cod_produto:=fieldbyname('cod_produto').asinteger;
       produto.descricao:=fieldbyname('descricao').asstring;
       produto.Fpreco_venda:=fieldbyname('preco_venda').value;
       Except
       on E: Exception do
          begin
            ShowMessage('Erro ao Buscar Produto : ' + E.Message );
          end;
     end;
     Result :=produto;
     Free;
  end;
end;


constructor Produtos.Create;
begin
   id:=0;
end;


procedure Produtos.Setcod_produto(const Value: integer);
begin
  Fcod_produto := Value;
end;


procedure Produtos.Setdescricao(const Value: string);
begin
  Fdescricao := Value;
end;


procedure Produtos.Setid(const Value: Integer);
begin
  Fid := Value;
end;


procedure Produtos.Setpreco_venda(const Value: double);
begin
  Fpreco_venda := Value;
end;

end.
