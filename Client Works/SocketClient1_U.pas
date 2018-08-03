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
   sText : string ;
    { Private declarations }
  public
  upmovement : string;
  Name : string ;

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case  key of
  VK_UP:
  begin
  imgClient.Top := imgClient.top - 10;
    upMovement :=inttostr(imgClient.Top);
    clntsckt1.Socket.SendText(upmovement);
  end;
  end;




end;

procedure TForm1.FormShow(Sender: TObject);
begin
    clntsckt1.Host := '192.168.0.102' ; // Server IP
  //clntsckt1.Address := '192.168.1.1';//Default local ip
  clntsckt1.Port := 2015;
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
