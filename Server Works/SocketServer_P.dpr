program SocketServer_P;

uses
  Forms,
  SocketServer_U in 'SocketServer_U.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
