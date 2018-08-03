unit SocketServer_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, ExtCtrls, jpeg;

type
  TForm1 = class(TForm)
    srvrsckt1: TServerSocket;
    imgServer: TImage;
    imgClient: TImage;
    tmr1: TTimer;
    lbl1: TLabel;
    procedure srvrsckt1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormShow(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure srvrsckt1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
  sText : string;
    { Private declarations }
  public
    Name : string ;
    imgdClient : Integer ;
     ClientReadText : string;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.srvrsckt1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);

begin
   ClientReadText := Socket.ReceiveText;
      lbl1.Caption := Socket.ReceiveText;
 //if ClientReadText[1] = '^' then
// begin
  // imgClient.top := StrToInt(Copy(ClientReadText,2,Length(ClientReadText)-1));
 //end;
  imgClient.top := StrToInt(Socket.ReceiveText);
 end;


procedure TForm1.FormShow(Sender: TObject);
begin
 srvrsckt1.Active := True ;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
 // imgClient.Top := StrToInt(ClientReadText);
 // Form1.Update;
end;

procedure TForm1.srvrsckt1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  tmr1.Enabled := True;
end;

end.
