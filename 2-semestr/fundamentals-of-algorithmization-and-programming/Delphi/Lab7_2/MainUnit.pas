unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus;

type
  TMainForm = class(TForm)
    UpPanel: TPanel;
    DownPanel: TPanel;
    ScrollBox: TScrollBox;
    TitleLabel: TLabel;
    ExitButton: TButton;
    BuildButton: TButton;
    TopCountEdit: TEdit;
    TopCountLabel: TLabel;
    MainImage: TImage;
    ElemPopupMenu: TPopupMenu;
    DeleteButton: TMenuItem;
    ConvertButton: TButton;
    MainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    OpenMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    ManualMenuItem: TMenuItem;
    AboutDeveloperMenuItem: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    CopyPastePopupMenu: TPopupMenu;
    CopyButton: TMenuItem;
    PasteButton: TMenuItem;
    CutButton: TMenuItem;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BuildButtonClick(Sender: TObject);
    procedure MainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MainImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ConvertButtonClick(Sender: TObject);
    procedure ScrollBoxMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ScrollBoxMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure OpenMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
    procedure TopCountEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TopCountEditKeyPress(Sender: TObject; var Key: Char);
    procedure TopCountEditChange(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure CopyPastePopupMenuPopup(Sender: TObject);
    procedure AboutDeveloperMenuItemClick(Sender: TObject);
    procedure ManualMenuItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
    IncidentListUnit, AddTopUnit, GraphUnit, Clipbrd;

const
    LEFT_PAD = 20;
    TOP_PAD = 20;
    W_ELEM = 60;
    W_HALF_ELEM = W_ELEM div 2;
    H_ELEM = 30;
    W_ADD_BUT = 30;
    CIRC_LEFT = W_ELEM div 6 * 4;
    CIRC_RIGHT = W_ELEM div 6 * 5;
    DIAMETR = W_ELEM div 6;
    T_LEFT = LEFT_PAD + W_ADD_BUT + 10;
    DISTANCE = 30;
    TEXT_PAD = 6;
    ELEM_LENGTH = W_ELEM + DISTANCE;

    kBACKSPACE = #8;
    kINSERT = 45;
    kESC = 27;
    MIN = 1;
    MAX = 99;

var
    IsListBuilded, IsHeightBigger: Boolean;
    MaxSecondaryTopCount: Word;
    SelectedBaseTop, SelectedTop: Word;

{$R *.dfm}

procedure EditImageWidth();
var
    ListWidth: Word;
begin
    ListWidth := MaxSecondaryTopCount * ELEM_LENGTH + T_LEFT + ELEM_LENGTH;

    with MainForm.MainImage do
    begin
        if ListWidth > ClientWidth then
        begin
            Align := alNone;
            Width := ListWidth + LEFT_PAD;
        end
        else
            if not IsHeightBigger then
                Align := alClient;
    end;
end;

procedure EditImageHeight();
var
    ListHeight: Word;
begin
    ListHeight := CommonBaseTopCount * H_ELEM + TOP_PAD;
    with MainForm.MainImage do
    begin
        if ListHeight > ClientHeight then
        begin
            Align := alNone;
            Height := ListHeight + TOP_PAD;
            IsHeightBigger := True;
        end
        else
        begin
            Align := alClient;
            IsHeightBigger := False;
        end;
    end;
end;

procedure DrawElem(X, Y: Word; Value: Word; HasNext, IsSelected: Boolean);
begin
      with MainForm.MainImage.Canvas do
      begin
            if IsSelected then
            begin
                Pen.Color := clNavy;
                Brush.Color := clHighlight;
            end
            else
            begin
                Pen.Color := clDefault;
                Brush.Color := clBtnHighlight;
            end;

            Rectangle(X, Y, X + W_HALF_ELEM, Y + H_ELEM);
            TextOut(X + TEXT_PAD, Y + TEXT_PAD, IntToStr(Value));

            Rectangle(X + W_HALF_ELEM, Y, X + W_ELEM, Y + H_ELEM);

            if HasNext then
            begin
                Ellipse(X + CIRC_LEFT, Y + DIAMETR, X + CIRC_RIGHT, Y + 2 * DIAMETR);
                MoveTo(X + CIRC_RIGHT, Y + H_ELEM div 2);
                LineTo(X + W_ELEM + DISTANCE, Y + H_ELEM div 2);
            end
            else
                TextOut(X + W_HALF_ELEM + TEXT_PAD, Y + TEXT_PAD, 'Nil');
      end;
end;

procedure DrawSecondaryList(CurrTop: PTop; X, Y: Word);
begin
    if CurrTop <> nil then
    begin
        with MainForm.MainImage.Canvas do
        begin
            DrawElem(X, Y, CurrTop^.Top, CurrTop^.NextTop <> nil, False);
            if CurrTop^.NextTop <> nil then
                DrawSecondaryList(CurrTop^.NextTop, X + W_ELEM + DISTANCE, Y);
        end;
    end;
end;

procedure DrawAddButton(Y: Word; IsSelected: Boolean);
var
    X: Word;
    CurrRect: TRect;
begin
    with MainForm.MainImage.Canvas do
    begin
        if IsSelected then
            Brush.Color := clHighLight
        else
            Brush.Color := TColor($0093DAFF);

        X := LEFT_PAD;
        CurrRect := Rect(X, Y, X + W_ADD_BUT, Y + H_ELEM);

        FillRect(CurrRect);
        Rectangle(CurrRect);
        TextOut(X + TEXT_PAD, Y + TEXT_PAD, '+');
    end;
end;

procedure DrawList();
var
    Curr: PBaseTop;
    X, Y: Word;
begin
    MainForm.MainImage.Picture := nil;
    with MainForm.MainImage.Canvas do
    begin
        Curr := BaseList^.Next;
        Y := TOP_PAD;
        Font.Name := 'System';

        while Curr <> nil do
        begin
            DrawAddButton(Y, False);

            X := T_LEFT;
            DrawElem(X, Y, Curr^.TopValue, Curr^.NextTop^.NextTop <> nil, False);
            if Curr^.NextTop <> nil then
                DrawSecondaryList(Curr^.NextTop^.NextTop, X + W_ELEM + DISTANCE, Y);

            Inc(Y, H_ELEM);
            Curr := Curr^.Next;
        end;
    end;
end;

procedure BuildBaseList(TopCount: Word);
begin
    with MainForm do
    begin
        DisposeList;

        IsHeightBigger := False;
        MainForm.MainImage.Align := alClient;

        MaxSecondaryTopCount := 0;
        BuildBaseTopList(TopCount);
        IsListBuilded := True;
        ConvertButton.Enabled := True;
        CommonBaseTopCount := TopCount;
        EditImageHeight();
        DrawList;
    end;
end;

procedure TMainForm.AboutDeveloperMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, 'Разработчик: Наривончик Александр Михайлович, гр. 351004', 'О разработчике', MB_OK Or MB_ICONINFORMATION);
end;

procedure TMainForm.BuildButtonClick(Sender: TObject);
begin
    BuildBaseList(StrToInt(TopCountEdit.Text));
end;

procedure TMainForm.ConvertButtonClick(Sender: TObject);
begin
    with GraphForm do
    begin
        ClientWidth := 800;
        ClientHeight := 600;
        Position := poDesktopCenter;
        ShowModal;
    end;
end;

procedure TMainForm.CopyButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CopyToClipboard;
end;

procedure TMainForm.CopyPastePopupMenuPopup(Sender: TObject);
var
    IValue: Integer;
    Buffer: String;
    IsCorrect: Boolean;
begin
    Buffer := Clipboard.AsText;
    IsCorrect := TryStrToInt(Buffer, IValue);
    PasteButton.Enabled := IsCorrect;
end;

procedure TMainForm.CutButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).CutToClipboard;
end;

procedure TMainForm.DeleteButtonClick(Sender: TObject);
begin
    DeleteSelectedElem(SelectedBaseTop, SelectedTop);
end;

procedure TMainForm.ExitButtonClick(Sender: TObject);
begin
    MainForm.Close;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := MessageBox(Handle, 'Вы действительно хотите выйти?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDYES;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    InitializeList;
    IsListBuilded := False;
end;



procedure AddTopToProject(DestTop, Top, WayLength: Word);
begin
    AddTop(DestTop, Top, WayLength);
    MaxSecondaryTopCount := GetSecondaryListTopMaxCount();
    EditImageWidth();
    DrawList();
end;

procedure TMainForm.MainImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    IsAddTopButton, IsSecondaryTop: Boolean;
    BaseTopNum, SecondaryTopNum, SecondaryListElemCount, DestTop, XRect, YRect: Word;
    Elem: PTop;
begin
    case Button of
        mbLeft:
            if IsListBuilded then
            begin
                IsAddTopButton := (X > LEFT_PAD) and (X < LEFT_PAD + W_ADD_BUT) and (Y > TOP_PAD) and (Y < CommonBaseTopCount * H_ELEM + TOP_PAD);
                if IsAddTopButton then
                begin
                    AddTopForm.Position := poDesktopCenter;
                    DestTop := (Y - TOP_PAD) div H_ELEM + 1;
                    AddTopForm.TitleLabel.Caption := 'Добавить вершину, связанную с вершиной ' + IntToStr(DestTop);
                    AddTopForm.ShowModal;
                    if AddTopForm.ModalResult = mrOK then
                        AddTopToProject(DestTop, StrToInt(AddTopForm.TopValueEdit.Text), StrToInt(AddTopForm.WayLengthEdit.Text));
                end;
            end;
        mbRight:
        begin
            BaseTopNum := (Y - TOP_PAD) Div H_ELEM + 1;
            SecondaryTopNum := (X - T_LEFT - 1*ELEM_LENGTH) div ELEM_LENGTH + 1;
            if(BaseTopNum > 0) and (BaseTopNum < CommonBaseTopCount+1) then
            begin
                SecondaryListElemCount := GetSecondaryListElemCount(BaseTopNum);
                IsSecondaryTop := (X > T_LEFT + 1*ELEM_LENGTH) and (SecondaryTopNum > 0) and (SecondaryTopNum < SecondaryListElemCount+1) and ((X - T_LEFT) Mod ELEM_LENGTH < W_ELEM);
                if IsSecondaryTop then
                begin
                    XRect := (X - T_LEFT) div ELEM_LENGTH * ELEM_LENGTH + T_LEFT;
                    YRect := ((Y - TOP_PAD) div H_ELEM) * H_ELEM + TOP_PAD;
                    Elem := GetTopByCoord(BaseTopNum, SecondaryTopNum);
                    DrawList();
                    DrawElem(XRect, YRect, Elem^.Top, Elem^.NextTop <> nil, True);

                    SelectedBaseTop := BaseTopNum;
                    SelectedTop := Elem^.Top;

                    X := X + Left + MainImage.Left + 10;
                    Y :=  Y + Top + MainImage.Top+60;
                    ElemPopupMenu.Popup(X, Y);
                end;
            end;
        end;
    end;

end;

procedure TMainForm.MainImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
    IsAddTopButton, IsSecondaryTop: Boolean;
    BaseTopNum, SecondaryTopNum, SecondaryListElemCount, XRect, YRect: Word;
    Elem: PTop;
begin
    if IsListBuilded then
    begin
        IsAddTopButton := (X > LEFT_PAD) and (X < LEFT_PAD + W_ADD_BUT) and (Y > TOP_PAD) and (Y < CommonBaseTopCount * H_ELEM + TOP_PAD);
        DrawList;
        if IsAddTopButton then
        begin
            with MainImage.Canvas do
            begin
                YRect := ((Y - TOP_PAD) div H_ELEM) * H_ELEM + TOP_PAD;
                DrawAddButton(YRect, True);
                Brush.Color := clMoneyGreen;
            end;
        end
        else
        begin
            BaseTopNum := (Y - TOP_PAD) Div H_ELEM + 1;
            SecondaryTopNum := (X - T_LEFT - 1*ELEM_LENGTH) div ELEM_LENGTH + 1;
            if(BaseTopNum > 0) and (BaseTopNum < CommonBaseTopCount+1) then
            begin
                SecondaryListElemCount := GetSecondaryListElemCount(BaseTopNum);
                IsSecondaryTop := (X > T_LEFT + 1*ELEM_LENGTH) and (SecondaryTopNum > 0) and (SecondaryTopNum < SecondaryListElemCount+1) and ((X - T_LEFT) Mod ELEM_LENGTH < W_ELEM);
                if IsSecondaryTop then
                begin
                    XRect := (X - T_LEFT) div ELEM_LENGTH * ELEM_LENGTH + T_LEFT;
                    YRect := ((Y - TOP_PAD) div H_ELEM) * H_ELEM + TOP_PAD;
                    Elem := GetTopByCoord(BaseTopNum, SecondaryTopNum);
                    DrawElem(XRect, YRect, Elem^.Top, Elem^.NextTop <> nil, True);
                end;
            end;
        end;
    end;
end;

procedure TMainForm.ManualMenuItemClick(Sender: TObject);
begin
    MessageBox(Handle, '1. Введите в соответствующее поле количество вершин графа (от 1 до 99) и нажмите "Построить".' + #13#10 + '2. Добавьте к каждой вершине графа все вершины, с которой она связана.' + #13#10 + '3. Нажмите кнопку "Построить граф".' + #13#10 + '4. После выбора пары городов, между которыми Вы хотите найти путь, программа вычислит длину кратчайшего пути!'+ #13#10 + '5. В случае ввода из файла убедитесь, что файл содержит количество вершин а затем в каждой новой строке все связанные вершины через пробел и расстояния между городами.', 'Инструкция', MB_OK Or MB_ICONINFORMATION);
end;

procedure TMainForm.ScrollBoxMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    VertScrollBar.Position := VertScrollBar.Position - 4;
end;

procedure TMainForm.ScrollBoxMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    VertScrollBar.Position := VertScrollBar.Position + 4;
end;

procedure EditButtonEnabled();
begin
    with MainForm do
        BuildButton.Enabled := TopCountEdit.Text <> '';
end;

procedure TMainForm.TopCountEditChange(Sender: TObject);
var
    TempStr:String;
    IValue, CursPos: Integer;
begin
    with Sender As TEdit do
    Begin
       if Text = '0' then
            Text := ''
        else
            if (Length(Text) > 0) then
            begin
                CursPos := SelStart;
                TempStr := Text;

                if not TryStrToInt(TempStr, IValue) then
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

procedure TMainForm.TopCountEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case Key of
        kINSERT: Key := 0;
        kENTER: if BuildButton.Enabled then BuildButton.Click;
        kESC: Close;
    end;
end;

procedure TMainForm.TopCountEditKeyPress(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9', kBACKSPACE]) then
        Key := #0;
end;

Function IsElemCorrect(Temp: String; NMin, NMax: Word): Boolean;
Var
    IsCorrect: Boolean;
    Num, Code: Integer;
Begin
    IsCorrect := True;
    Val(Temp, Num, Code);
    if (Code <> 0) or (Num < NMin) or (Num > NMax) then
    begin
        IsCorrect := False;
        MessageBox(MainForm.Handle, 'Некорректные данные в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
    end;

    IsElemCorrect := IsCorrect;
End;

function CheckSecondaryList(Temp: String; Min, Max: Word): Boolean;
var
    I, I0, Counter: Integer;
    TempSubstr: String;
    IsCorrect: Boolean;
begin
    Counter := 0;
    Temp := Temp + ' ';
    IsCorrect := True;
    I := Low(Temp);
    while (I < High(Temp)-1) and IsCorrect do
    begin
        while Temp[I] = ' ' do
            Inc(I);
        I0 := I;

        while Temp[I] <> ' ' do
            Inc(I);

        TempSubstr := Copy(Temp, I0, I-I0);
        IsCorrect := IsElemCorrect(TempSubstr, Min, Max);
        Inc(Counter);
    end;

    if IsCorrect then
        IsCorrect := Counter mod 2 = 0;

    CheckSecondaryList := IsCorrect;
end;

Function IsFileInPathCorrect(Var FileIn: TextFile): Boolean;
Var
    IsFileCorrect: Boolean;
    Path, Temp: String;
    N, Code, I: Integer;
Begin
    With MainForm Do
    Begin
        IsFileCorrect := True;
        Path := OpenDialog.FileName;
        AssignFile(FileIn, Path);
        Try
            Reset(FileIn);
        Except
            IsFileCorrect := False;
            MessageBox(MainForm.Handle, 'Не удалось открыть файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
        End;

        If IsFileCorrect Then
        Begin
            Readln(FileIn, Temp);
            Val(Temp, N, Code);
            if (Code <> 0) or (N < 1) or (N > 99) then
            begin
                IsFileCorrect := False;
                MessageBox(MainForm.Handle, 'Некорректные данные в файле!', 'Ошибка', MB_OK Or MB_ICONERROR);
            end;

            if IsFileCorrect then
            begin
                I := 0;
                while IsFileCorrect and (I < N) and not EoF(FileIn) do
                begin
                    Readln(FileIn, Temp);
                    if Temp <> '' then
                        IsFileCorrect := CheckSecondaryList(Temp, 1, N);
                    Inc(I);
                end;
            end;

            CloseFile(FileIn);
        End;
    End;

    IsFileInPathCorrect := IsFileCorrect;
End;

procedure TMainForm.OpenMenuItemClick(Sender: TObject);
Var
    Top,Weight, N: Word;
    FileIn: TextFile;
    I, J, J0, Code: Integer;
    Temp, TempSubstr: String;
Begin
    If OpenDialog.Execute And IsFileInPathCorrect(FileIn) Then
    Begin
        Reset(FileIn);
        Readln(FileIn, N);
        BuildBaseList(N);
        I := 1;
        While I <= N Do
        Begin
            Readln(FileIn, Temp);
            if Temp <> '' then
            begin
                Temp := Temp + ' ';
                J := Low(Temp);
                while (J < High(Temp)-1) do
                begin
                    while Temp[J] = ' ' do
                        Inc(J);
                    J0 := J;

                    while Temp[J] <> ' ' do
                        Inc(J);

                    TempSubstr := Copy(Temp, J0, J-J0);
                    Val(TempSubstr,Top,Code);

                    while Temp[J] = ' ' do
                        Inc(J);
                    J0 := J;

                    while Temp[J] <> ' ' do
                        Inc(J);

                    TempSubstr := Copy(Temp, J0, J-J0);
                    Val(TempSubstr, Weight, Code);
                    AddTopToProject(I, Top, Weight);
                end;
            end;
            Inc(I);
        End;
        CloseFile(FileIn);
    End;
End;

procedure TMainForm.PasteButtonClick(Sender: TObject);
begin
    TEdit(ActiveControl).PasteFromClipboard;
end;

Function IsSaveFilesPathCorrect(var SaveFile: TextFile): Boolean;
Var
    IsFileCorrect: Boolean;
    Path: String;
Begin
    With MainForm Do
    Begin
        IsFileCorrect := True;

        Path := SaveDialog.FileName;
        AssignFile(SaveFile, Path);

        If FileExists(Path) And (MessageBox(Handle, 'Вы действетельно хотите перезаписать файл?', 'Вы уверены?', MB_YESNO Or MB_ICONQUESTION) = IDNO) Then
            IsFileCorrect := False;

        If IsFileCorrect Then
            Try
                Rewrite(SaveFile);
            Except
                IsFileCorrect := False;
                MessageBox(Handle, 'Не удалось открыть файл!', 'Ошибка', MB_OK Or MB_ICONERROR);
            End;

        If IsFileCorrect Then
            CloseFile(SaveFile);
    End;

    IsSaveFilesPathCorrect := IsFileCorrect;
End;

procedure TMainForm.SaveMenuItemClick(Sender: TObject);
Var
    SaveFile: TextFile;
    Curr: PBaseTop;
    CurrTop: PTop;
begin
    If SaveDialog.Execute And IsSaveFilesPathCorrect(SaveFile) Then
    Begin
        Rewrite(SaveFile);
        Writeln(SaveFile, CommonBaseTopCount);
        Curr := BaseList^.Next;
        While (Curr <> Nil) Do
        Begin
            CurrTop := Curr^.NextTop^.NextTop;
            while CurrTop <> nil do
            begin
                Write(SaveFile, CurrTop^.Top, ' ', CurrTop^.WayLength, ' ');
                CurrTop := CurrTop^.NextTop;
            end;
            Writeln(SaveFile);
            Curr := Curr^.Next;
        End;
        CloseFile(SaveFile);
        MessageBox(Handle, 'Сохранено успешно!', 'Сохранение', MB_YESNO Or MB_ICONINFORMATION);
    End;
end;



end.
