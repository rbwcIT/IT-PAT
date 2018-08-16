unit SocketClient1_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, ExtCtrls, Buttons, jpeg;

type
  TForm1 = class(TForm)
    clntsckt1: TClientSocket;
    imgClient2: TImage;
    imgClient1: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure clntsckt1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure clntsckt1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure MoveSprite(Sprite : TImage; instructions : char);        //eie function (move image)
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  Coordinates : array[0..1] of string;

  MY_CONNECTION_NUMBER : String;  // kry van server (dynamically assign)

const
  MOVEMENT_SPACE : Integer = 10;
  //SERVER_IP : string = '127.0.0.1';     // by huis en basic testing
  SERVER_IP : string = '192.168.0.101'; // by skool en network testing
  CONNECTION_PORT : Integer = 2015;     // makliker as ons later wil verander

implementation

{$R *.dfm}

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sMovement : string;   // format: <con_num> # <direction>
  Direction : Char;
  sprite : TImage;
begin
  if MY_CONNECTION_NUMBER = '0' then                // kyk net watte image is wie sin mar ons gan later dynamic array werk
  begin
    sMovement := '0#';
    sprite := imgClient1;
  end
  else
  begin
    sMovement := '1#';
    sprite := imgClient2;
  end;

  case key of
  VK_UP:
    begin
      Direction := 'U';
    end;

  VK_DOWN:
    begin
      Direction := 'D';
    end;       // kort dit as deel van movement string

  VK_LEFT:
    begin
      Direction := 'L';
    end;

  VK_RIGHT:
    begin
      Direction := 'R';
    end;
  end;

  MoveSprite(sprite, Direction);
  sMovement := sMovement + Direction;

  clntsckt1.Socket.SendText(sMovement);
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

procedure TForm1.clntsckt1Read(Sender: TObject; Socket: TCustomWinSocket);
var
  sText, moving_connection : string;  // sText: <connection_num>#<instructions>
  sprite : TImage;
  a : Integer;
begin
  sText := Socket.ReceiveText;

  if sText[1] = '!' then    //  message van server wat ID gee
  begin
    Delete(sText, 1, 1);
    MY_CONNECTION_NUMBER := sText[1];
    Delete(sText, 1, 2);

    Coordinates[0] := Copy(sText, 1, Pos('-', Coordinates[0])-1);
    Coordinates[1] := sText;

    imgClient1.Left := StrToInt(Copy(Coordinates[0], 1, Pos('|', Coordinates[0])-1));
    imgClient1.Top := StrToInt(Copy(Coordinates[0], Pos('|', Coordinates[0])+1, Length(Coordinates[0])));
    imgClient2.Left := StrToInt(Copy(Coordinates[1], 1, Pos('|', Coordinates[1])-1));
    imgClient2.Top := StrToInt(Copy(Coordinates[1], Pos('|', Coordinates[1])+1, Length(Coordinates[1])));

    Exit;
  end;

//  ons gan later n dynamic array gebruik om al die connectons te log en die images daaran te koppel
  moving_connection := Copy(sText, 1, Pos('#', sText)-1);
  Delete(sText, 1, Pos('#', sText));

  if moving_connection = '0' then  // temporary image assignment
    MoveSprite(imgClient1, sText[1])
  else
    MoveSprite(imgClient2, sText[1]);
end;

procedure TForm1.MoveSprite(Sprite: TImage; instructions: char);   // skuif image wat jy se na sekere plek toe
begin
  case instructions of
  'U':
      sprite.Top := sprite.Top - MOVEMENT_SPACE; 
  'D':
      sprite.Top := sprite.Top + MOVEMENT_SPACE;
  'L':
      sprite.Left := sprite.Left - MOVEMENT_SPACE;
  'R':
      sprite.Left := sprite.Left + MOVEMENT_SPACE;
  end;
end;

end.
