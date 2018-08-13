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
  //SERVER_IP : string = '192.168.0.102'; // by skool en network testing
  CONNECTION_PORT : Integer = 2015;     // makliker as ons later wil verander

implementation

{$R *.dfm}

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sMovement : string;   // format: <direction> <position>
  Direction : Char;
  sprite : TImage;
begin

  if MY_CONNECTION_NUMBER = '0' then                // kyk net watte image is wie sin mar ons gan later dynamic array werk
    sprite := imgClient1
  else
    sprite := imgClient2;

  case key of
  VK_UP:
    Sprite.Top := Sprite.Top - MOVEMENT_SPACE;

  VK_DOWN:
    Sprite.Top := Sprite.Top + MOVEMENT_SPACE;       // kort dit as deel van movement string

  VK_LEFT:
    Sprite.Left := Sprite.Left - MOVEMENT_SPACE;

  VK_RIGHT:
    Sprite.Left := Sprite.Left + MOVEMENT_SPACE;
  end;

 
  clntsckt1.Socket.SendText(MY_CONNECTION_NUMBER + '#' + IntToStr(sprite.Left) + '|' + IntToStr(sprite.Top));
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
begin
  Sprite.Left := StrToInt(Copy(instructions, 1, Pos('|', instructions)-1));
  Sprite.Top := StrToInt(Copy(instructions, Pos('|', instructions)+1, Length(instructions))) ;
end;

function TForm1.BuildInstruction(Sprite: TImage;  //  format: <connection_number>  # <x waarde> | <y waarde>
  cDirection: char): string;
var
  position : Integer;
begin
  Result := MY_CONNECTION_NUMBER + '#';


  case cDirection of
  'U':  Sprite.Top := Sprite.Top - MOVEMENT_SPACE;
  'D':  Sprite.Top := Sprite.Top + MOVEMENT_SPACE;
  'L':  Sprite.Left := Sprite.Left - MOVEMENT_SPACE;
  'R':  Sprite.Left := Sprite.Left + MOVEMENT_SPACE;
  end;

  Result := Result + IntToStr(Sprite.Left) + '|' + IntToStr(Sprite.Top);
  lbl2.Caption:= Result;   // <-- debugging  
end;

end.
