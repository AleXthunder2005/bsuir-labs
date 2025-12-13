program Lab7_1;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  IncidentListUnit in 'IncidentListUnit.pas',
  AddTopUnit in 'AddTopUnit.pas' {AddTopForm},
  MatrixUnit in 'MatrixUnit.pas' {MatrixForm},
  MatrixImplemetUnit in 'MatrixImplemetUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddTopForm, AddTopForm);
  Application.CreateForm(TMatrixForm, MatrixForm);
  Application.Run;
end.
