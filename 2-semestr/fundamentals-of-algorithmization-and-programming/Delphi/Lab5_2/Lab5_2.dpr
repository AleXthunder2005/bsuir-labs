program Lab5_2;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  BinaryTreeUnit in 'BinaryTreeUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
