object dModule: TdModule
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=dbwk'
      'User_Name=root'
      'Server='
      'DriverID=MySQL')
    UpdateOptions.AssignedValues = [uvUpdateMode]
    Left = 152
    Top = 72
  end
  object FDPhysADSDriverLink1: TFDPhysADSDriverLink
    VendorHome = 'C:\Windows\SysWOW64\libmysql.dll'
    VendorLib = 'C:\Windows\SysWOW64\libmysql.dll'
    DefaultPath = 'C:\Windows\SysWOW64\libmysql.dll'
    SearchPath = 'D:\wk\libmysql'
    Left = 328
    Top = 72
  end
  object FDQryPedidoProdutos: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select a.*,(select descricao from produtos b where b.id=a.cod_pr' +
        'oduto) produto from pedidos_produtos a')
    Left = 280
    Top = 176
  end
  object dsPedidodProdutos: TDataSource
    DataSet = FDQryPedidoProdutos
    Left = 400
    Top = 192
  end
end
