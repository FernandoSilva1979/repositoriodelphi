unit ufrm_Pedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, Vcl.ComCtrls,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  Tfrm_Pedidos = class(TForm)
    panPrincipal: TPanel;
    panBarraBotoes: TPanel;
    panTotal: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    labTotal: TLabel;
    dbGridPedidoProdutos: TDBGrid;
    grIncluirProdutos: TGroupBox;
    Label2: TLabel;
    edtCodProduto: TEdit;
    edtDescProduto: TEdit;
    edtPreco: TEdit;
    Label3: TLabel;
    edtQtd: TEdit;
    Label5: TLabel;
    btnIncluitItem: TButton;
    grClientes: TGroupBox;
    grPedido: TGroupBox;
    Label1: TLabel;
    Label6: TLabel;
    labNroPedido: TLabel;
    Label7: TLabel;
    labTotalGeral: TLabel;
    edtCodCliente: TEdit;
    edtNomeCliente: TEdit;
    btnPedidos: TBitBtn;
    FDMemPedidoProdutos: TFDMemTable;
    FDMemPedidoProdutosid: TIntegerField;
    FDMemPedidoProdutosnro_pedido: TIntegerField;
    FDMemPedidoProdutoscod_produto: TIntegerField;
    FDMemPedidoProdutosquantidade: TFloatField;
    FDMemPedidoProdutosvlr_unitario: TFloatField;
    FDMemPedidoProdutosvlr_total: TFloatField;
    FDMemPedidoProdutosproduto: TStringField;
    DsMemPedidoProdutos: TDataSource;
    edtIdProduto: TEdit;
    FDMemPedidoProdutosid_produto: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure limpartela();
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluitItemClick(Sender: TObject);
    function atualizarPedidoProdutosTotal : double;

    procedure atualizarPedidoProdutos();
    procedure atualizarItensPedidoProdutos();  // atualiza pedido sempre que for feita alteracao e o botao de inserir (+) for clicado
    procedure deletarPedidoProdutos(nro_pedido : integer;id_produto : integer);
    procedure btnFecharClick(Sender: TObject);
    procedure btnPedidosClick(Sender: TObject);
    procedure btnLImparClick(Sender: TObject);
    procedure edtCodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbGridPedidoProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodClienteChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frm_Pedidos: Tfrm_Pedidos;

implementation

  uses udmodule,uclasse_Pedidos,uclasse_Produtos,ufrm_buscarpedidos,
  ufrm_CancelarPedidos;

{$R *.dfm}

procedure Tfrm_Pedidos.atualizarItensPedidoProdutos;
var produtopedido :PedidoProdutos;
    FD_Query : TFDQuery;

begin
    FD_Query := TFDQuery.Create(nil);
    with FD_Query do
    begin
      Connection:= dmodule.FDConnection1;
      close;
      sql.clear;
      sql.add('delete from pedidos_produtos '+
              ' where nro_pedido='+QuotedStr(labNroPedido.caption));
      execsql;
    end;

    produtopedido:=PedidoProdutos.Create();                                 // criação de objeto para inclusao de ites de pedido
    FDMemPedidoProdutos.First;
    while not FDMemPedidoProdutos.eof do
     begin
         produtopedido.nro_pedido:=strtoint(labNroPedido.caption);            // objeto vindo de tabela temporaria para envio a cadastro
         produtopedido.cod_produto:=FDMemPedidoProdutoscod_produto.value;
         produtopedido.quantidade:=FDMemPedidoProdutosquantidade.value;
         produtopedido.vlr_unitario:=FDMemPedidoProdutosvlr_unitario.value;
         produtopedido.vlr_total:=FDMemPedidoProdutosquantidade.value*FDMemPedidoProdutosvlr_unitario.value;
         produtopedido.inserirProdutoPedido(produtopedido);        // inserção de itens de produto passando do objeto
         FDMemPedidoProdutos.Next;
      end;
      atualizarPedidoProdutos;
      labTotalGeral.Caption:=floattostr(atualizarPedidoProdutosTotal);   // total do pedido
end;


procedure Tfrm_Pedidos.dbGridPedidoProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);     // pressionar tecla delete no grid de itens
begin
  if (key=VK_DELETE) then
   begin
    If  MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0)=mryes    then
       begin
         deletarPedidoProdutos(FDMemPedidoProdutosnro_pedido.value,FDMemPedidoProdutoscod_produto.Value);
         atualizarPedidoProdutos;
         labTotalGeral.Caption:=floattostr(atualizarPedidoProdutosTotal);
       end;
   end;
end;


procedure Tfrm_Pedidos.deletarPedidoProdutos(nro_pedido : integer;id_produto : integer);         // excluir item com argumento de nro de pedido e cod produto
var FD_Query : TFDQuery;
begin
  FD_Query := TFDQuery.Create(nil);
  with FD_Query do
   begin
      Connection:= dmodule.FDConnection1;
     try
       close;
       sql.clear;
       sql.add('delete from pedidos_produtos '+
           ' where nro_pedido='+QuotedStr(inttostr(nro_pedido))+
           ' and cod_produto='+QuotedStr(inttostr(id_produto)));
       execsql;
       Except
       on E: Exception do
          begin
            ShowMessage('Erro ao Excluir Item : ' + E.Message );
          end;
     end;
   Free;
  end;
end;


procedure Tfrm_Pedidos.atualizarPedidoProdutos();      // atualizacao de itens do pedidos (tabela temporaria) sempre que houver inclusao,alteracao ou exclusao.
var vTotal : double;
var FD_Query : TFDQuery;
begin
  FD_Query := TFDQuery.Create(nil);
  with FD_Query do
    begin
      Connection:= dmodule.FDConnection1;
      close;
      sql.clear;
      sql.add('select a.*,'+
              ' (select descricao from produtos b where b.id=a.cod_produto) produto '+
              ' from pedidos_produtos a '+
              ' where nro_pedido='+QuotedStr(labNroPedido.caption));
      open;
      FDMemPedidoProdutos.EmptyDataSet;
      while not eof do
       begin
         FDMemPedidoProdutos.Insert;                    // inserir em tabela temporaria
         FDMemPedidoProdutosnro_pedido.Value := fieldbyname('nro_pedido').value;
         FDMemPedidoProdutoscod_produto.Value := fieldbyname('cod_produto').value;
         FDMemPedidoProdutosproduto.asstring := fieldbyname('produto').Asstring;
         FDMemPedidoProdutosquantidade.Value := fieldbyname('quantidade').value;
         FDMemPedidoProdutosvlr_unitario.Value := fieldbyname('vlr_unitario').value;
         FDMemPedidoProdutosvlr_total.Value := fieldbyname('vlr_total').value;
         FDMemPedidoProdutos.Post;
         next;
       end;
   end;
end;


function Tfrm_Pedidos.atualizarPedidoProdutosTotal() : double;   // funcao que retorna valor total de itens do pedido
var vTotal : double;
begin
   with FDMemPedidoProdutos do
   begin
       first;
       vTotal:=0;
       while not eof do
       begin
         vTotal:=VTotal+fieldbyname('vlr_total').value;
         next;
       end;
   end;
   Result := vTotal;
end;


procedure Tfrm_Pedidos.btnPedidosClick(Sender: TObject);
begin
    try
      frm_BuscarPedidos := Tfrm_BuscarPedidos.Create(Self);    //  formes criados e destruidos em tempo de execaucao
      frm_BuscarPedidos.ShowModal;
    finally
      freeandnil(frm_BuscarPedidos)
    end;
end;


procedure Tfrm_Pedidos.btnCancelarClick(Sender: TObject);
begin
    try
      frm_CancelarPedidos := Tfrm_CancelarPedidos.Create(Self);
      frm_CancelarPedidos.ShowModal;
    finally
      freeandnil(frm_CancelarPedidos)
    end;
end;


procedure Tfrm_Pedidos.btnFecharClick(Sender: TObject);
begin
 close;
end;


procedure Tfrm_Pedidos.btnIncluitItemClick(Sender: TObject);
var produtopedido,inserirprodutopedido : PedidoProdutos;
begin
   // incluir itens na tabela temporária de pedido

   if (edtCodProduto.text='') then
   begin
    if (labNroPedido.caption <> '') then
       begin
         atualizarItensPedidoProdutos;
         showmessage('Pedido Atualziado !!!');
        end;
   end
   else
   begin
     FDMemPedidoProdutos.Insert;     // tabela temporaria de pedido
     FDMemPedidoProdutosnro_pedido.Value:=0;
     FDMemPedidoProdutosid_produto.Value:=strtoint(edtIdProduto.text);
     FDMemPedidoProdutosproduto.Value:=edtDescProduto.text;
     FDMemPedidoProdutoscod_produto.Value:=strtoint(edtCodProduto.text);
     FDMemPedidoProdutosquantidade.Value:=strtofloat(edtQtd.Text);
     FDMemPedidoProdutosvlr_unitario.Value:=strtofloat(edtPreco.text);
     FDMemPedidoProdutosvlr_total.Value:=strtofloat(edtPreco.Text) * strtofloat(edtQtd.text);
     FDMemPedidoProdutos.Post;
     labTotalGeral.Caption :=  floattostr(atualizarPedidoProdutosTotal);
     edtCodProduto.Text:='';
     edtDescProduto.Text:='';
     edtQtd.Text:='';
     edtPreco.Text:='';
     edtIdProduto.Text:='';
   end;
end;


procedure Tfrm_Pedidos.btnLImparClick(Sender: TObject);
begin
 limpartela;
end;


procedure Tfrm_Pedidos.btnGravarClick(Sender: TObject);
var pedido,pedidoInicial : Pedidos;
    produtopedido :PedidoProdutos;
    vNro_pedido : integer;
begin
   if (edtNomeCliente.Text='') then
   begin
     showmessage('Erro !!! Selecione Cliente');
     exit;
   end;
   if  ((FDMemPedidoProdutos.Active=false) or (FDMemPedidoProdutos.RecordCount=0)) then
   begin
     showmessage('Erro !!! Inclua Produtos');
     exit;
   end;

   pedidoInicial:=Pedidos.Create();                                    // objeto com o pedido para inclusão em banco
   pedidoInicial.data_emissao:=date();
   pedidoInicial.cod_cliente:=strtoint(edtCodCliente.Text);
   pedidoInicial.valor_total:=strtofloat(labTotalGeral.caption);

   pedido:=Pedidos.Create();
   pedido:=pedido.novoPedido(pedidoInicial);
   if (pedido.nro_pedido>0) then
   begin
      labNroPedido.Caption:=inttostr(pedido.nro_pedido);
      produtopedido:=PedidoProdutos.Create();                                 // criação de objeto para inclusao de ites de pedido
      FDMemPedidoProdutos.First;
      while not FDMemPedidoProdutos.eof do
      begin
         produtopedido.nro_pedido:=strtoint(labNroPedido.caption);            // objeto vindo de tabela temporaria para envio a cadastro
         produtopedido.cod_produto:=FDMemPedidoProdutosid_produto.value;
         produtopedido.quantidade:=FDMemPedidoProdutosquantidade.value;
         produtopedido.vlr_unitario:=FDMemPedidoProdutosvlr_unitario.value;
         produtopedido.vlr_total:=FDMemPedidoProdutosquantidade.value*FDMemPedidoProdutosvlr_unitario.value;
         produtopedido.inserirProdutoPedido(produtopedido);        // inserção de itens de produto passando do objeto
         FDMemPedidoProdutos.Next;
      end;
      labTotalGeral.Caption:=floattostr(atualizarPedidoProdutosTotal);   // total do pedido
      btnGravar.Enabled:=false;
      btnCancelar.Enabled:=false;
      btnPedidos.Enabled:=false;
   end;
   pedido.Free;
end;


procedure Tfrm_Pedidos.edtCodClienteChange(Sender: TObject);
begin
  if (edtCodCliente.Text='') then
  begin
     btnCancelar.Enabled:=true;
     btnPedidos.Enabled:=true;
  end
  else
  begin
     btnCancelar.Enabled:=false;
     btnPedidos.Enabled:=false;
  end;
  edtNomeCliente.Text:='';
end;


procedure Tfrm_Pedidos.edtCodClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var FD_Query : TFDQuery;
 begin
   IF KEY = VK_RETURN THEN
   begin
     if (edtCodCliente.Text<>'') then
       begin
          FD_Query := TFDQuery.Create(nil);     // buscar cliente
          with FD_Query do
           begin
             try
               Connection:= dmodule.FDConnection1;
               close;
               sql.clear;
               sql.add('select cod_cliente,nome from clientes'+
                  ' where cod_cliente='+QuotedStr(edtCodCliente.text));
               open;
               if (RecordCount=0) then
                 showmessage('Cliente Nao Encontrado !!!')
               else
               begin
                 edtNomeCliente.Text:=fieldbyname('nome').AsString;
               end;

                Except
               on E: Exception do
                  begin
                    ShowMessage('Erro ao Excluir Item : ' + E.Message );
                  end;
             end;
               Free;
           end;
       end;
  end;
end;


procedure Tfrm_Pedidos.edtCodProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var produtoatual : Produtos;
  begin
 IF KEY = VK_RETURN THEN
  begin
    if (edtCodProduto.Text='') then
     exit
     else
     begin
       produtoatual:=Produtos.Create;
       produtoatual:=produtoatual.buscarProduto(strtoint(edtCodProduto.text));   // buscar produto e aloca no objeto
       if (produtoatual.id>0) then
       begin
         edtDescProduto.Text:=produtoatual.descricao;
         edtPreco.Text:=floattostr(produtoatual.preco_venda);
         edtIdProduto.text:=inttostr(produtoatual.id);
         produtoatual.Free;
       end;
     end;
  end;
end;

procedure Tfrm_Pedidos.FormCreate(Sender: TObject);
var FD_Query : TFDQuery;
begin
  limpartela();
end;

procedure Tfrm_Pedidos.limpartela();
begin
//  cmbClientes.ItemIndex:=-1;
  edtCodProduto.Text:='';
  edtDescProduto.Text:='';
  edtPreco.Text:='';
  edtQtd.Text:='';
  labTotalGeral.caption:='';
  labNroPedido.Caption:='';
end;

end.
