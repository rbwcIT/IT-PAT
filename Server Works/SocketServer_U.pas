unit SocketServer_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    mmoAfvoer: TMemo;
    edt1: TEdit;
    btnSend: TButton;
    btnStart: TButton;
    srvrsckt1: TServerSocket;
    lbledtName: TLabeledEdit;
    procedure btnStartClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure srvrsckt1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure srvrsckt1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
  private
  sText : string;
    { Private declarations }
  public
    Name : string ;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnStartClick(Sender: TObject);
begin

  name := lbledtName.Text;

  srvrsckt1.Active := True ;

  mmoAfvoer.Lines.Add('[Server has been created]   ' + '   ///Welcome ' + Name);
  mmoAfvoer.lines.Add('');

end;

procedure TForm1.btnSendClick(Sender: TObject);
var
  iCount : Integer;
begin
  name := lbledtName.Text;

  sText := edt1.Text;

  for iCount :=0 to srvrsckt1.Socket.ActiveConnections -1 do
  srvrsckt1.Socket.Connections[iCount].SendText('['+Name+'] ' + sText);

  mmoAfvoer.Lines.Add('['+Name+'] '+sText);

end;

procedure TForm1.srvrsckt1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Socket.SendText('[{Connected to ' + Name + '}]');
  Socket.SendText('');
  mmoAfvoer.Lines.Add('[{Client Connected}]');
  mmoAfvoer.Lines.Add('');
end;

procedure TForm1.srvrsckt1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 mmoAfvoer.Lines.Add('{C} '+ Socket.ReceiveText);
 mmoAfvoer.Lines.Add('');
 end;

end.
