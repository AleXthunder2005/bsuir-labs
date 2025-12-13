unit AddTopUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TAddTopForm = class(TForm)
    TitleLabel: TLabel;
    TopValueEdit: TEdit;
    TopValueLabel: TLabel;
    CloseButton: TButton;
    ConfirmButton: TButton;
    CopyPastePopupMenu: TPopupMenu;
    CopyButton: TMenuItem;
    PasteButton: TMenuItem;
    CutButton: TMenuItem;
    procedure CloseButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure TopValueEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TopValueEditKeyPress(Sender: TObject; var Key: Char);
    procedure TopValueEditChange(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    AddTopForm: TAddTopForm;
    MaxTopCount: Word;

const
    kBACKSPACE = #8;
    kINSERT = 45;
    kENTER = 13;

implementation
    uses
        Clipbrd;

{$R *.dfm}

procedure TAddTopForm.CloseButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TAddTopForm.ConfirmButtonClick(Sender: TObject);
begin
    ModalResult := mrOK;
end;

procedure TAddTopForm.CopyButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CopyToClipboard;
end;

procedure TAddTopForm.CopyPastePopupMenuPopup(Sender: TObject);
var
    IValue: Integer;
    Buffer: String;
    IsCorrect: Boolean;
begin
    Buffer := Clipboard.AsText;
    IsCorrect := TryStrToInt(Buffer, IValue);
    PasteButton.Enabled := IsCorrect;
end;

procedure TAddTopForm.CutButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CutToClipboard;
end;

procedure TAddTopForm.FormShow(Sender: TObject);
begin
    TopValueEdit.Text := '';
end;

procedure TAddTopForm.PasteButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).PasteFromClipboard;
end;

procedure EditButtonEnabled();
begin
    with AddTopForm do
        ConfirmButton.Enabled := TopValueEdit.Text <> '';
end;

procedure TAddTopForm.TopValueEditChange(Sender: TObject);
var
    TempStr:String;
    IValue, CursPos: Integer;
begin
    with Sender As TEdit do
    Begin
        TempStr := Text;
        CursPos := SelStart;

       if Text = '0' then
            Text := ''
        else
            if (Length(Text) > 0) then
            begin
                CursPos := SelStart;
                TempStr := Text;

                if not TryStrToInt(TempStr, IValue) or (IValue < 1) or (IValue > MaxTopCount) then
                begin
                    Delete (TempStr, SelStart, 1);
                    Text := TempStr;
                    SelStart := CursPos-1;
                end
                else
                begin
                    Text := IntToStr(IValue);
                    SelStart := CursPos;
                end;
            end;
        EditButtonEnabled;
    End;
end;

procedure TAddTopForm.TopValueEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case Key of
        kINSERT: Key := 0;
        kENTER: ConfirmButton.Click;
    end;


end;

procedure TAddTopForm.TopValueEditKeyPress(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9', kBACKSPACE]) then
        Key := #0;
end;

end.
