unit udmodule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Phys.ADSDef,
  FireDAC.Phys.ADS, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdModule = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysADSDriverLink1: TFDPhysADSDriverLink;
    FDQryPedidoProdutos: TFDQuery;
    dsPedidodProdutos: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dModule: TdModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
