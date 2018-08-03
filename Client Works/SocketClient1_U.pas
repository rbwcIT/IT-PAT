unit SocketClient1_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    mmoAfvoer: TMemo;
    edtText: TEdit;
    btnSend: TButton;
    btnConnect: TButton;
    clntsckt1: TClientSocket;
    txtTyoe: TStaticText;
    lbledtName: TLabeledEdit;
    procedure btnConnectClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure clntsckt1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure clntsckt1Connecting(Sender: TObject;
      Socket: TCustomWinSocket);
  private
   sText : string ;
    { Private declarations }
  public
  Name : string ;

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnConnectClick(Sender: TObject);
begin

   Name := lbledtName.Text;
  clntsckt1.Host := '192.168.0.102' ; // Server IP
  //clntsckt1.Address := '192.168.1.1';//Default local ip
  clntsckt1.Port := 2015;
  clntsckt1.Active := True ;


end;

procedure TForm1.btnSendClick(Sender: TObject);
begin

  Name := lbledtName.Text;

  sText := edtText.Text ;

  mmoAfvoer.Lines.Add('['+Name+'] '+ sText );

  clntsckt1.Socket.SendText('['+Name+'] '+ sText);

  edtText.Clear;

end;

procedure TForm1.clntsckt1Read(Sender: TObject; Socket: TCustomWinSocket);
begin
  mmoAfvoer.Lines.Add('{S} '+Socket.ReceiveText);
  mmoAfvoer.Lines.Add('');
  end;

procedure TForm1.clntsckt1Connecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  mmoAfvoer.Lines.Add('[Connected to ServerHost]   '+'   ///Welcome ' + Name );
  mmoAfvoer.Lines.Add('');
end;

end.
