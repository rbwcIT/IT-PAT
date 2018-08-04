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
    procedure MoveSprite(Sprite : TImage; instructions : string);        //eie function (move image)
    function BuildInstruction(Sprite : TImage; cDirection : char) : string;   //eie function (bou die string wat gesend gan word oor netword)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  MY_CONNECTION_NUMBER : String;  // kry van server (dynamically assign)

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
  Direction : Char;
begin
  case key of
  VK_UP:
    Direction := 'U';

  VK_DOWN:
    Direction := 'D';       // kort dit as deel van movement string

  VK_LEFT:
    Direction := 'L';

  VK_RIGHT:
    Direction := 'R';
  end;

  if MY_CONNECTION_NUMBER = '0' then                // kyk net watte image is wie sin mar ons gan later dynamic array werk
    sMovement := BuildInstruction(imgClient1, Direction)
  else
    sMovement := BuildInstruction(imgClient2, Direction);

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
begin
  sText := Socket.ReceiveText;

  if sText[1] = '!' then    //  message van server wat ID gee
  begin
    Delete(sText, 1, 1);
    MY_CONNECTION_NUMBER := sText;
    Exit;
  end;
  
//  ons gan later n dynamic array gebruik om al die connectons te log en die images daaran te koppel
  moving_connection := Copy(sText, 1, Pos('#', sText)-1);
  Delete(sText, 1, Pos('#', sText));

  if moving_connection = '0' then  // temporary image assignment
    MoveSprite(imgClient1, sText)
  else
    MoveSprite(imgClient2, sText);    
end;

procedure TForm1.MoveSprite(Sprite: TImage; instructions: string);   // skuif image wat jy se na sekere plek toe
var
  sDirection : string;
begin
  sDirection := instructions[1];
  Delete(instructions, 1, 1);

  if ((sDirection='U') or (sDirection='D')) then
    Sprite.Top := StrToInt(instructions)
  else
    Sprite.Left := StrToInt(instructions);
end;

function TForm1.BuildInstruction(Sprite: TImage;  //  format: <connection_number>  # <direction(char)> <position>
  cDirection: char): string;
var
  position : Integer;
begin
  Result := MY_CONNECTION_NUMBER + '#' + cDirection;

  case cDirection of
  'U':
    begin
      Sprite.Top := Sprite.Top - MOVEMENT_SPACE;
      position := Sprite.Top;
    end;
  'D':
    begin                                                  // skuif image en record position na geskuif is
      Sprite.Top := Sprite.Top + MOVEMENT_SPACE;
      position := Sprite.Top;
    end;
  'L':
    begin
      Sprite.Left := Sprite.Left - MOVEMENT_SPACE;
      position := Sprite.Left;
    end;
  'R':
    begin
      Sprite.Left := Sprite.Left + MOVEMENT_SPACE;
      position := Sprite.Left;
    end;
  end;

  Result := Result + IntToStr(position);
  lbl2.Caption:= Result;   // <-- debugging
  

end;

end.
