program Lab5_1;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  ListLibraryInit in 'ListLibraryInit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
