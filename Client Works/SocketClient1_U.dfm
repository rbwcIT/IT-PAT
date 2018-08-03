object Form1: TForm1
  Left = 190
  Top = 172
  Width = 404
  Height = 540
  Caption = 'Client'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mmoAfvoer: TMemo
    Left = 8
    Top = 136
    Width = 369
    Height = 169
    TabOrder = 0
  end
  object edtText: TEdit
    Left = 8
    Top = 48
    Width = 289
    Height = 21
    TabOrder = 1
  end
  object btnSend: TButton
    Left = 304
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 2
    OnClick = btnSendClick
  end
  object btnConnect: TButton
    Left = 280
    Top = 8
    Width = 99
    Height = 25
    Caption = 'Connect to server'
    TabOrder = 3
    OnClick = btnConnectClick
  end
  object txtTyoe: TStaticText
    Left = 8
    Top = 32
    Width = 99
    Height = 17
    Caption = 'Type Message Here'
    TabOrder = 4
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
    TabOrder = 5
  end
  object lbledtClientname: TLabeledEdit
    Left = 8
    Top = 88
    Width = 289
    Height = 21
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = 'Clientname'
    TabOrder = 6
  end
  object chkServerAlso: TCheckBox
    Left = 80
    Top = 360
    Width = 97
    Height = 17
    Caption = 'chkServerAlso'
    TabOrder = 7
  end
  object clntsckt1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnecting = clntsckt1Connecting
    OnRead = clntsckt1Read
    Left = 352
    Top = 8
  end
end
