object Form1: TForm1
  Left = 371
  Top = 136
  Width = 533
  Height = 586
  Caption = 'Server'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object mmoAfvoer: TMemo
    Left = 16
    Top = 72
    Width = 497
    Height = 465
    TabOrder = 0
  end
  object edt1: TEdit
    Left = 8
    Top = 40
    Width = 417
    Height = 21
    TabOrder = 1
  end
  object btnSend: TButton
    Left = 432
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 2
    OnClick = btnSendClick
  end
  object btnStart: TButton
    Left = 432
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 3
    OnClick = btnStartClick
  end
  object lbledtName: TLabeledEdit
    Left = 40
    Top = 8
    Width = 121
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Name'
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object srvrsckt1: TServerSocket
    Active = False
    Port = 2015
    ServerType = stNonBlocking
    OnClientConnect = srvrsckt1ClientConnect
    OnClientRead = srvrsckt1ClientRead
    Left = 392
  end
  object con1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\WILLIAMCR' +
      'ONJE\Desktop\Chat Official NEw\Server Works\clients.mdb;Persist ' +
      'Security Info=False'
    Mode = cmShareDenyNone
    Provider = 'Microsoft.ACE.OLEDB.12.0'
    Left = 200
    Top = 8
  end
  object tbl1: TADOTable
    Connection = con1
    CursorType = ctStatic
    TableName = 'Table1'
    Left = 248
    Top = 8
  end
  object ds1: TDataSource
    DataSet = tbl1
    Left = 288
    Top = 8
  end
end
