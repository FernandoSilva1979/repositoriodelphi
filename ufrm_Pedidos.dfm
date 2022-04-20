object frm_Pedidos: Tfrm_Pedidos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'WK - Tela de Pedidos'
  ClientHeight = 451
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object panPrincipal: TPanel
    Left = 0
    Top = 65
    Width = 624
    Height = 351
    Align = alClient
    Caption = 'nome'
    TabOrder = 0
    object dbGridPedidoProdutos: TDBGrid
      Left = 1
      Top = 152
      Width = 622
      Height = 198
      Align = alBottom
      DataSource = DsMemPedidoProdutos
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      OnKeyDown = dbGridPedidoProdutosKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'cod_produto'
          Title.Caption = 'Codigo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'produto'
          Title.Caption = 'Produto'
          Width = 268
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Title.Caption = 'Qtd'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vlr_unitario'
          Title.Caption = 'Pre'#231'o'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vlr_total'
          Title.Caption = 'Total'
          Visible = True
        end>
    end
    object grIncluirProdutos: TGroupBox
      Left = 1
      Top = 82
      Width = 623
      Height = 69
      TabOrder = 1
      object Label2: TLabel
        Left = 10
        Top = 11
        Width = 261
        Height = 15
        Caption = 'Digite Codigo de Produto e pressione <Enter> :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 422
        Top = 11
        Width = 38
        Height = 15
        Caption = 'Pre'#231'o :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 497
        Top = 11
        Width = 27
        Height = 15
        Caption = 'Qtd :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCodProduto: TEdit
        Left = 10
        Top = 32
        Width = 64
        Height = 23
        TabOrder = 0
        OnKeyDown = edtCodProdutoKeyDown
      end
      object edtDescProduto: TEdit
        Left = 80
        Top = 32
        Width = 337
        Height = 23
        Color = clGradientInactiveCaption
        ReadOnly = True
        TabOrder = 1
      end
      object edtPreco: TEdit
        Left = 422
        Top = 32
        Width = 70
        Height = 23
        TabOrder = 2
      end
      object edtQtd: TEdit
        Left = 497
        Top = 32
        Width = 66
        Height = 23
        TabOrder = 3
      end
      object btnIncluitItem: TButton
        Left = 569
        Top = 24
        Width = 40
        Height = 40
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = btnIncluitItemClick
      end
      object edtIdProduto: TEdit
        Left = 80
        Top = 32
        Width = 9
        Height = 23
        Color = clGradientActiveCaption
        ReadOnly = True
        TabOrder = 5
        Visible = False
      end
    end
    object grClientes: TGroupBox
      Left = 1
      Top = 30
      Width = 623
      Height = 57
      TabOrder = 2
      object Label1: TLabel
        Left = 10
        Top = 4
        Width = 256
        Height = 15
        Caption = 'Digite Codigo de Cliente e rpessione <enter> :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCodCliente: TEdit
        Left = 10
        Top = 23
        Width = 64
        Height = 23
        TabOrder = 0
        OnChange = edtCodClienteChange
        OnKeyDown = edtCodClienteKeyDown
      end
      object edtNomeCliente: TEdit
        Left = 80
        Top = 23
        Width = 337
        Height = 23
        Color = clGradientInactiveCaption
        ReadOnly = True
        TabOrder = 1
      end
    end
    object grPedido: TGroupBox
      Left = 1
      Top = 0
      Width = 623
      Height = 32
      TabOrder = 3
      object Label6: TLabel
        Left = 10
        Top = 9
        Width = 68
        Height = 15
        Caption = 'Pedido Nro :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labNroPedido: TLabel
        Left = 98
        Top = 9
        Width = 111
        Height = 15
        AutoSize = False
        Color = clGradientInactiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
        WordWrap = True
      end
    end
  end
  object panBarraBotoes: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 65
    Align = alTop
    TabOrder = 1
    object btnGravar: TBitBtn
      Left = 1
      Top = 1
      Width = 120
      Height = 63
      Align = alLeft
      Caption = 'Gravar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      WordWrap = True
      OnClick = btnGravarClick
    end
    object btnCancelar: TBitBtn
      Left = 121
      Top = 1
      Width = 120
      Height = 63
      Align = alLeft
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelarClick
    end
    object btnFechar: TBitBtn
      Left = 361
      Top = 1
      Width = 120
      Height = 63
      Align = alLeft
      Caption = 'Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnFecharClick
    end
    object btnPedidos: TBitBtn
      Left = 241
      Top = 1
      Width = 120
      Height = 63
      Align = alLeft
      Caption = 'Pedidos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      WordWrap = True
      OnClick = btnPedidosClick
    end
  end
  object panTotal: TPanel
    Left = 0
    Top = 416
    Width = 624
    Height = 35
    Align = alBottom
    TabOrder = 2
    object labTotal: TLabel
      Left = 458
      Top = 10
      Width = 33
      Height = 15
      Caption = 'Total :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = -167
      Top = -127
      Width = 106
      Height = 17
      AutoSize = False
      Caption = 'Pedido Nro :'
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      WordWrap = True
    end
    object labTotalGeral: TLabel
      Left = 497
      Top = 9
      Width = 108
      Height = 15
      AutoSize = False
      Color = clGradientInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      WordWrap = True
    end
  end
  object FDMemPedidoProdutos: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'nro_pedido'
        DataType = ftInteger
      end
      item
        Name = 'cod_produto'
        DataType = ftInteger
      end
      item
        Name = 'quantidade'
        DataType = ftFloat
      end
      item
        Name = 'vlr_unitario'
        DataType = ftFloat
      end
      item
        Name = 'vlr_total'
        DataType = ftFloat
      end
      item
        Name = 'produto'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'id_produto'
        DataType = ftInteger
      end>
    IndexDefs = <>
    MasterFields = 
      'cod_produto;id;nro_pedido;produto;quantidade;vlr_total;vlr_unita' +
      'rio'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 448
    Top = 104
    object FDMemPedidoProdutosid: TIntegerField
      FieldName = 'id'
    end
    object FDMemPedidoProdutosnro_pedido: TIntegerField
      FieldName = 'nro_pedido'
    end
    object FDMemPedidoProdutoscod_produto: TIntegerField
      FieldName = 'cod_produto'
    end
    object FDMemPedidoProdutosquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object FDMemPedidoProdutosvlr_unitario: TFloatField
      FieldName = 'vlr_unitario'
    end
    object FDMemPedidoProdutosvlr_total: TFloatField
      FieldName = 'vlr_total'
    end
    object FDMemPedidoProdutosproduto: TStringField
      FieldName = 'produto'
      Size = 100
    end
    object FDMemPedidoProdutosid_produto: TIntegerField
      FieldName = 'id_produto'
    end
  end
  object DsMemPedidoProdutos: TDataSource
    DataSet = FDMemPedidoProdutos
    Left = 512
    Top = 112
  end
end
