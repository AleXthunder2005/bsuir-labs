unit ManualUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TManualForm = class(TForm)
    ManualLabel: TLabel;
    BackButton: TButton;
    procedure BackButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ManualForm: TManualForm;

implementation

{$R *.dfm}

procedure TManualForm.BackButtonClick(Sender: TObject);
begin
    ManualForm.Close;
end;

procedure TManualForm.FormCreate(Sender: TObject);
begin
    with ManualLabel do
    begin
        Caption := 'Программа предоставляет возможность вести учет записей о комплектующих компьютера!' + #13#10#10 + '1)Для добавления записи нажмите кнопку "Добавить запись"' + #13#10 + '2)Для изменения записи нажмите на ячейку "..." в соответствующей строке' + #13#10 + '3)Для удаления записи нажмите на ячейку "Х" в соответствующей строке' + #13#10 + '4)Вы можете просмотреть записи о фирмах-изготовителях в отдельном окне' + #13#10#10;
        Caption := Caption + 'Вы можете использовать горячие клавиши:' + #13#10 + 'Ctrl + O - открыть файл' + #13#10 + 'Ctrl + S - сохранить файл' + #13#10 + 'F1 - инструкция';
    end;
end;

end.
