program ChangeAspectRatio;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.AnsiStrings, System.SysUtils;

const
  TV: TBytes = [$04, $38, $38, $E0, $07, $80, $90];
  PAD: TBytes = [$39, $20, $03, $56, $38, $60];

  TV_WIDE: TBytes = [$04, $38, $38, $E0, $05, $A0, $90];
  PAD_WIDE: TBytes = [$39, $20, $02, $80, $38, $60];

  NES_TV: TBytes = [$04, $38, $38, $E0, $09, $5F, $90];
  NES_PAD: TBytes = [$39, $20, $04, $29, $38, $60];

  SNES_TV: TBytes = [$04, $38, $38, $E0, $08, $C0, $90];
  SNES_PAD: TBytes = [$39, $20, $03, $E4, $38, $60];

function StringOf(const Bytes: TBytes): RawByteString;
var
  Len: Integer;
begin
  if Assigned(Bytes) then begin
    Len := Length(Bytes);
    SetLength(Result, Len);
    if Len > 0 then Move(Bytes[0], Result[1], Len);
  end
  else
    Result := '';
end;

function LastPosEx(SubStr, Str: RawByteString): Integer;
var
  I : Integer;
begin
  I := 0;
  repeat
    Result := I;
    I := PosEx(SubStr, Str, Result + 1);
  until I = 0;
end;

var
  FileName: string;
  FileHandle: THandle;
  FileLength: Integer;
  Buffer: RawByteString;
  TVPos, PADPos: Integer;
  AspectRatio: string;
begin
  try
    FileName := ParamStr(1);
    AspectRatio := ParamStr(2);
    FileHandle := FileOpen(FileName, fmOpenReadWrite);
    FileLength := FileSeek(FileHandle, 0, 2);
    FileSeek(FileHandle, 0, 0);
    SetLength(Buffer, FileLength);
    FileRead(FileHandle, Buffer[1], FileLength);
    TVPos := PosEx(StringOf(TV), Buffer);
    PADPos := LastPosEx(StringOf(PAD), Buffer);
    if (TVPos <> 0) and (PADPos <> 0) then begin
      if (AspectRatio = '/w') or (AspectRatio = '/W') or
         (AspectRatio = '-w') or (AspectRatio = '-W') then begin
        Writeln('Change to Wide Display.');
        Move(TV_WIDE[0], Buffer[TVPos], Length(TV_WIDE));
        Move(PAD_WIDE[0], Buffer[PADPos], Length(PAD_WIDE));
      end
      else if (Buffer[$711] = 'N') and (Buffer[$712] = 'E') and (Buffer[$713] = 'S') then begin
        Writeln('This is a NES VC file.');
        Move(NES_TV[0], Buffer[TVPos], Length(NES_TV));
        Move(NES_PAD[0], Buffer[PADPos], Length(NES_PAD));
      end
      else begin
        Writeln('This is a SNES VC file.');
        Move(SNES_TV[0], Buffer[TVPos], Length(SNES_TV));
        Move(SNES_PAD[0], Buffer[PADPos], Length(SNES_PAD));
      end;
      FileSeek(FileHandle, 0, 0);
      FileWrite(FileHandle, Buffer[1], FileLength);
    end;
    FileClose(FileHandle);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
