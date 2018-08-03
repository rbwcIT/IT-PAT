unit SocketServer_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, ExtCtrls, DB, ADODB, StrUtils;

type
  TForm1 = class(TForm)
    mmoAfvoer: TMemo;
    edt1: TEdit;
    btnSend: TButton;
    btnStart: TButton;
    srvrsckt1: TServerSocket;
    lbledtName: TLabeledEdit;
    con1: TADOConnection;
    tbl1: TADOTable;
    ds1: TDataSource;
    procedure btnStartClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure srvrsckt1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure srvrsckt1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure LogClient(cname : string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  sText : string;
    { Private declarations }                          // '!'   - name identifier
  public                                              // '$'   - connection established
    Name : string ;                                   // '#'   - destination (client to client)
    { Public declarations }                           // '-s'  - server visibility
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
  Socket.SendText('$[{Connected to ' + Name + '}]');
  Socket.SendText('');   
end;

procedure TForm1.srvrsckt1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  sInput, sDestination: string;
begin
  sInput := Socket.ReceiveText ;

  if sInput[1] = '!' then
  begin
    LogClient(Copy(sInput, 2, Length(sInput)));
    Exit;
  end;

 sDestination := Copy(sInput,1, Pos('#', sInput)-1);

 Delete(sInput, 1, Pos('#', sInput));

 if AnsiContainsText(sDestination, '-s') then //flag in destination is
 begin
  mmoAfvoer.Lines.Add(sInput);
 end;
 tbl1.Open;
 tbl1.Locate('client_name', sDestination, []);                    // select to connect to whom
 srvrsckt1.Socket.connections[tbl1['con_num']].SendText(sInput);  //send text to selected connection
 tbl1.Close;
end;

procedure TForm1.LogClient(cname: string);
begin
  tbl1.Open;
  tbl1.Insert;
  tbl1['con_num'] := srvrsckt1.Socket.ActiveConnections-1;
  tbl1['client_name'] := cname;
  //tbl1['client_addr'] := srvrsckt1.Socket.Connections[tbl1['con_num']].RemoteAddress;
  tbl1.Post;
  tbl1.Close;
  mmoAfvoer.Lines.Add('['+cname+' Connected]');
  mmoAfvoer.Lines.Add('');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tbl1.Open;
 
  tbl1.First;

  while not tbl1.Eof do
  begin
    tbl1.Delete;
    tbl1.Next;
  end;

  tbl1.Close; 
end;

end.
