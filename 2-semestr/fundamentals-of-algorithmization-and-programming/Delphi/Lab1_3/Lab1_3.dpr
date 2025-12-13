program Lab1_3;

uses
  Vcl.Forms,
  Unit1 in '..\Lab1_1\Unit1.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
