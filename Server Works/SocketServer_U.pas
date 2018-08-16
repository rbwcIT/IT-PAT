unit SocketServer_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, ExtCtrls, jpeg, DB, ADODB, Math;

type
  TForm1 = class(TForm)
    srvrsckt1: TServerSocket;
    lbl1: TLabel;
    procedure srvrsckt1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormShow(Sender: TObject);
    procedure srvrsckt1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Coordinates : array[0..1] of string;

implementation

{$R *.dfm}

procedure TForm1.srvrsckt1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  ClientReadText, con_num : string;
  a : Integer;
begin // clientreadtext: <connection number> # <direction(char)> <position>
  ClientReadText := Socket.ReceiveText;
  lbl1.Caption := ClientReadText; // <-- debugging

  // kry die ID van die client wat dit gesend het
  con_num := Copy(ClientReadText, 1, Pos('#', ClientReadText)-1);

  // relay die message v ammel
  for a := 0 to srvrsckt1.Socket.ActiveConnections-1 do
  begin
    if a = StrToInt(con_num) then // send nie v die ou wat dit gesend het nie
      Continue;

    srvrsckt1.Socket.Connections[a].SendText(ClientReadText);
  end; 
end;

procedure TForm1.FormShow(Sender: TObject);
var
  a : Integer;
begin
  srvrsckt1.Active := True ;

  for a := 0 to 1 do
  begin
    Coordinates[a] := IntToStr(RandomRange(0, 750)) + '|' + IntToStr(RandomRange(0, 750));
  end;

end;

procedure TForm1.srvrsckt1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  con_num : Integer;
begin
  con_num := srvrsckt1.Socket.ActiveConnections-1; // assign n ID an m nuwe connection

  srvrsckt1.Socket.Connections[con_num].SendText('!' + IntToStr(con_num) + '@' + Coordinates[0] + '-' + Coordinates[1]); // send dit v die client om te hou
end;

end.
