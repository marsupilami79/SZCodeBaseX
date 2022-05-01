program Demo;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  SZCodeBaseX in '..\SZCodeBaseX.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
