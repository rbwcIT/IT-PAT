program SocketClient1_P;

uses
  Forms,
  SocketClient1_U in 'SocketClient1_U.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
