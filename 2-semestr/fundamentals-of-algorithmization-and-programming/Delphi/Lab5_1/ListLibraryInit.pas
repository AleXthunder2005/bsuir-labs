unit ListLibraryInit;

interface
type
    TElemPointer = ^TElem;
    TElem = record
        Value: Integer;
        Next: TElemPointer;
    end;

    procedure InsertElement(Head: TElemPointer; NewValue: Integer);stdcall;
    procedure InsertElementForMerge(var Curr: TElemPointer; NewValue: Integer); stdcall;
    function InitializeList(): TElemPointer; stdcall;
    function MergeLists(FirstHeader, SecondHeader: TElemPointer): TElemPointer; stdcall;
    procedure DisposeList (Header: TElemPointer);stdcall;
    procedure OutputListToTextFile (Header: TElemPointer; var FileOut: TextFile);stdcall;
implementation
    const
        ListLibrary = 'ListDLL.dll';
        procedure InsertElement; external ListLibrary;
        procedure InsertElementForMerge; external ListLibrary;
        function InitializeList; external ListLibrary;
        function MergeLists; external ListLibrary;
        procedure DisposeList; external ListLibrary;
        procedure OutputListToTextFile; external ListLibrary;
end.
