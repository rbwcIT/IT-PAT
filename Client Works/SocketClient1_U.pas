unit SocketClient1_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, ExtCtrls, Buttons, jpeg;

type
  TForm1 = class(TForm)
    clntsckt1: TClientSocket;
    imgServer: TImage;
    imgClient: TImage;
    lbl1: TLabel;
    tmr1: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure clntsckt1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  MOVEMENT_SPACE : Integer = 10;
  SERVER_IP : string = '127.0.0.1';     // by huis en basic testing
  //SERVER_IP : string = '192.168.0.1'; // by skool en network testing
  CONNECTION_PORT : Integer = 2015;     // makliker as ons later wil verander

implementation

{$R *.dfm}

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sMovement : string;   // format: <direction> <position>
begin
  case  key of
  VK_UP:                              // constant om dit makliker maak om te verander...minner tikwerk :)
    begin                             //     |
      imgClient.Top := imgClient.top - MOVEMENT_SPACE;
      sMovement := 'U' + inttostr(imgClient.Top);
    end;

  VK_DOWN:
    begin
      imgClient.Top := imgClient.top + MOVEMENT_SPACE;
      sMovement := 'D' + inttostr(imgClient.Top);
    end;

  VK_LEFT:
    begin
      imgClient.Left := imgClient.Left - MOVEMENT_SPACE;
      sMovement := 'L' + inttostr(imgClient.Left);
    end;

  VK_RIGHT:
    begin
      imgClient.Left := imgClient.Left + MOVEMENT_SPACE;
      sMovement := 'R' + inttostr(imgClient.Left);
    end;
  end;

  clntsckt1.Socket.SendText(sMovement); // die format v al die positions is dieselle so ons kan ma 1 var gebruik
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  clntsckt1.Host := SERVER_IP ;   // verander die constant bo 
  clntsckt1.Port := CONNECTION_PORT;
  clntsckt1.Active := True ; 
end;

procedure TForm1.clntsckt1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  lbl1.Caption := 'Connected';
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
 

  // clntsckt1.Socket.SendText(upmovement);
end;

end.
