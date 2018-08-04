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
    lbl2: TLabel;
    procedure srvrsckt1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormShow(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure srvrsckt1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.srvrsckt1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  ClientReadText, sPosition : string;
begin
  ClientReadText := Socket.ReceiveText;
  lbl1.Caption := ClientReadText; //  <-- debugging

  //sPosition := Copy(ClientReadText, 2, Length(ClientReadText)-1); \\
  sPosition := Copy(ClientReadText, 2, 4);                          //   altwee die werk...die lyn sin sny af wanne dit by 10000 kom ma dis nie realisties nie so ons kan altwee gebruik

  lbl2.Caption := sPosition; // <-- debugging

  // onner doen presies dieselfde as dai lang case.. hierie ene lees net moeiliker :)

  if ((ClientReadText[1] = 'U') or (ClientReadText[1] = 'D')) then   // die kyk of dit n op en af change is en veranner in die op en af axis
  begin
    imgClient.Top := StrToInt(sPosition);
  end                                     
  else    // as dit nie op en af is nie is dit obviousely links of regs en veranner in die horisontal axis                                                   
    imgClient.Left := StrToInt(sPosition);
end; // omdat die client die exact position send hoef jy nie te specify in watte rigting hy move nie nie.. sal self regkom...ons kan dit later veranner as dit nodig is

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
