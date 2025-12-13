Program Lab1_4;
{$APPTYPE CONSOLE}
{$R *.res}
Uses
  System.SysUtils;
Var
    I, J: Integer;
    K : Real;
    Matrix : Array[ 0..1, 0..9 ] Of Real;
Begin;
    K := 0.5;
    Writeln( 'Данная программа вычислит радиус основания цилиндра единичного объёма для различных h.' );
    For I := 0 To 9 Do
    Begin
        Matrix [ 0, I ] := K;
        K := K + 0.5;
    End;
        For I := 0 To 9 Do
    Begin
        Matrix [ 1, I ] := Sqrt( 1 / ( PI * Matrix[ 0, I ] ) );
    End;
    Writeln( '   H       R ' );

    For I := 0 To 9 Do
    Begin
        Writeln( Matrix [ 0, I ]:5:2 , '  ', Matrix [ 1, I ]:7:4);
    End;

    Readln;
End.
