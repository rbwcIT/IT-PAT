object Form1: TForm1
  Left = 454
  Top = 147
  Width = 136
  Height = 177
  Caption = 'Server'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 44
    Top = 87
    Width = 16
    Height = 13
    Caption = 'lbl1'
  end
  object srvrsckt1: TServerSocket
    Active = False
    Port = 2015
    ServerType = stNonBlocking
    OnClientConnect = srvrsckt1ClientConnect
    OnClientRead = srvrsckt1ClientRead
    Left = 40
    Top = 24
  end
end
