program Lab4_1;

uses
  Vcl.Forms,
  StartUnit in 'StartUnit.pas' {Form1},
  MainUnit in 'MainUnit.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  AddRecordUnit in 'AddRecordUnit.pas' {AddRecordForm},
  EditRecordUnit in 'EditRecordUnit.pas' {EditRecordForm},
  InformationUnit in 'InformationUnit.pas' {InformationForm},
  ManualUnit in 'ManualUnit.pas' {ManualForm},
  DishUnit in '..\..\Учебная практика\DishUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TStartForm, StartForm);
  Application.CreateForm(TAddRecordForm, AddRecordForm);
  Application.CreateForm(TEditRecordForm, EditRecordForm);
  Application.CreateForm(TInformationForm, InformationForm);
  Application.CreateForm(TManualForm, ManualForm);
  Application.CreateForm(TEditRecordForm, EditRecordForm);
  Application.CreateForm(TInformationForm, InformationForm);
  Application.CreateForm(TManualForm, ManualForm);
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
