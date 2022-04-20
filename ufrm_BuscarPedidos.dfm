object frm_BuscarPedidos: Tfrm_BuscarPedidos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'WK - Buscar Pedido'
  ClientHeight = 137
  ClientWidth = 269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 48
    Top = 18
    Width = 163
    Height = 15
    Caption = 'Forne'#231'ca N'#250'mero de Pedido :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtNroPedido: TEdit
    Left = 48
    Top = 39
    Width = 163
    Height = 23
    TabOrder = 0
    OnKeyPress = edtNroPedidoKeyPress
  end
  object btnBuscarPedido: TBitBtn
    Left = 88
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Buscar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnBuscarPedidoClick
  end
end
