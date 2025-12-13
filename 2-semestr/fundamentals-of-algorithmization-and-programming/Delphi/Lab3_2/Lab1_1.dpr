program Lab1_1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {MainForm},
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
