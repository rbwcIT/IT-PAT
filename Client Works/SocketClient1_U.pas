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
    lbledtClientname: TLabeledEdit;
    chkServerAlso: TCheckBox;
    procedure btnConnectClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure clntsckt1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure clntsckt1Connecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure SendIDmsg();
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
  clntsckt1.Host := '127.0.0.1';
  clntsckt1.Port := 2015;
  clntsckt1.Active := True ;

end;

procedure TForm1.btnSendClick(Sender: TObject);
var
  sDestination : string;     // format: " <clientname> #"
begin

  Name := lbledtName.Text;

  sText := edtText.Text ;

  mmoAfvoer.Lines.Add('['+Name+'] '+ sText );

  sDestination := lbledtClientname.Text;

  if chkServerAlso.Checked then
   sDestination := sDestination + ' -s ';   //Flag to only client on client or + server

  sDestination := sDestination + '#';       // special character to Seperate

  clntsckt1.Socket.SendText(sDestination + '['+Name+'] '+ sText);

  edtText.Clear;

end;

procedure TForm1.clntsckt1Read(Sender: TObject; Socket: TCustomWinSocket);
var
  sInput : string;
begin
  sInput := Socket.ReceiveText;
  if sInput[1] = '$' then
  begin
    SendIDmsg;
    Delete(sInput, 1, 1);
  end;  

  mmoAfvoer.Lines.Add(sInput);
  mmoAfvoer.Lines.Add('');
end;

procedure TForm1.clntsckt1Connecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  mmoAfvoer.Lines.Add('[Connected to ServerHost]   '+'   ///Welcome ' + Name );
  mmoAfvoer.Lines.Add('');
end;

procedure TForm1.SendIDmsg;
begin
  clntsckt1.Socket.SendText('!' + name);

end;

end.
