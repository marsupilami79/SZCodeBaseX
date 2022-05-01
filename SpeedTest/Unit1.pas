//For standard miliseconds count
//{$DEFINE MILISECONDS}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, SZCodeBaseX;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo2: TMemo;
    rbDataSize: TRadioGroup;
    rbLoops: TRadioGroup;
    cbShowOutput: TCheckBox;
    rgDataType: TRadioGroup;
    procedure BenchmarkAfter;
    procedure BenchmarkBefore;
    procedure Button1Click(Sender: TObject);
 private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  EncodingStringProc = function ( const s: string; MIMELine: integer = 0): string;
  DecodingStringProc = function ( const s: string): string;

  EncodingMemoryProc = function ( pIN, pOUT: PByte; Size: integer; MIMELine: integer = 0): integer;
  DecodingMemoryProc = function ( pIN, pOUT: PByte; Size: integer): integer;
  EncodingStreamProc = function ( sIN, sOUT: TStream; Size: integer=-1; MIMELine: integer = 0): integer;
  DecodingStreamProc = function ( sIN, sOUT: TStream): integer;

var
  Form1: TForm1;
  C : Integer;

implementation

uses SZTimer;

{$R *.dfm}


function DoEncodingString( const note: string; Encoding: EncodingStringProc; Decoding: DecodingStringProc; const Data:string; MIMELine: integer = 0): integer;
var
  i: integer;
  TMP,s : string;

//  vIn,vOut:  Pointer;

  RDTSC_Lower: Int64;
  T_Lower: Cardinal;

  T: TSZTimer;

begin

  // Clock cycles/Miliseconds

  t_Lower     := High(cardinal);
  RDTSC_Lower := High(Int64);

  for I :=1 to C do
  begin

//      Sleep(10);

    T.Start;

    TMP:=Encoding(Data, MIMELine);

    T.Stop;

    if RDTSC_Lower> T.ElapsedRDTSC then
       RDTSC_Lower:= T.ElapsedRDTSC;

    if T_Lower > T.ElapsedMS then
       T_Lower := T.ElapsedMS;
  end;

  SetLength(s, 0);
  s:=Decoding(TMP);

  if CompareStr(Data,s)=0 then
     Form1.memo2.Lines.Add(
     format('%s %10d clock cycles, %5d ms - PASS',[Note,RDTSC_Lower,T_Lower]))
  else
     Form1.memo2.Lines.Add(
     format('%s %10d clock cycles, %5d ms - FAIL!',[Note,RDTSC_Lower,T_Lower]));


  if Form1.cbShowOutput.checked then
  begin
    form1.memo2.Lines.Add(StringOfChar('-',80));
    form1.memo2.Lines.BeginUpdate;
    form1.memo2.Lines.Add(TMP);
    form1.memo2.Lines.EndUpdate;
    form1.memo2.Lines.Add(StringOfChar('-',80));
  end;

  result:=0
end;

function DoEncodingMemory( const note: string; Encoding: EncodingMemoryProc; Decoding: DecodingMemoryProc; const Data: string; MIMELine: integer = 0): integer;
var
  i: integer;

  TMP : string;

  vIn,vOut: pByte;
  pIn,pOut: pByte;

  size,TotalOut: Int64;
  len: integer;

  T_Lower: cardinal;
  RDTSC_Lower: Int64;

  T: TSZTimer;

begin

  Size:=Length(data);
  Len:=0;

  //TotalOut:=SZCalcRequireOutputMemory(Size, 6, 4, MIMELine);
  TotalOut:=SZCalcRequiredOutputMemoryForFullEncodeBase64(Size, MIMELine);

  SetLength(TMP, TotalOut);

  vIn:=@Data[1];
  vOut:=@TMP[1];

  FillChar(vOut^,TotalOut,0);

  // Clock cycles/Miliseconds
  t_Lower := High(cardinal);
  RDTSC_Lower:= High(Int64);
  for I :=1 to C do
  begin

//      Sleep(10);

    T.Start;

    len:=Encoding(vIn,vOut,Size, MIMELine);

    T.Stop;

    if RDTSC_Lower> T.ElapsedRDTSC then
       RDTSC_Lower:= T.ElapsedRDTSC;

    if T_Lower > T.ElapsedMS then
       T_Lower := T.ElapsedMS;
  end;


  pIn:=vOut;

  GetMem(pOut,len);

  len:=Decoding(pIn,pOut,len);

  pIn:=@Data[1];

  if CompareMem(pIn, pOut,len) then
     Form1.memo2.Lines.Add(
     format('%s %10d clock cycles, %5d ms - PASS',[Note,RDTSC_Lower,T_Lower]))
  else
     Form1.memo2.Lines.Add(
     format('%s %10d clock cycles, %5d ms - FAIL!',[Note,RDTSC_Lower,T_Lower]));

  if Form1.cbShowOutput.checked then
  begin
    form1.memo2.Lines.Add(StringOfChar('-',80));

    form1.memo2.Lines.BeginUpdate;
    form1.memo2.Lines.Add(TMP);
    form1.memo2.Lines.EndUpdate;

    form1.memo2.Lines.Add(StringOfChar('-',80));
  end;

  FreeMem(pOut);

  SetLength(TMP, TotalOut);

  result:=0
end;

function DoEncodingStream( const note: string; Encoding: EncodingStreamProc; Decoding: DecodingStreamProc; const Data: string; MIMELine: integer = 0): Integer;
var
  i: integer;

  size: Int64;

  adds: Tstrings;
  sin,sout: TMemoryStream;

  Len: integer;
  pIN{,pOUT}: pByte;

  T: TSZTimer;

  T_Lower: cardinal;
  RDTSC_Lower: Int64;

begin

  Size:=Length(data);

  sIn:= TMemoryStream.Create;
  sIn.Write(pointer(@Data[1])^,Size);
  sIn.Position:=0;

  sOut:=TMemoryStream.Create;


  // Clock cycles/Miliseconds

  t_Lower := High(cardinal);
  RDTSC_Lower:= High(Int64);
  for I :=1 to C do
  begin

    sIn.Position:=0;
    sOut.Position:=0;

//      Sleep(10);

    T.Start;

    Encoding(sIn,sOut,-1, MIMELine);

    T.Stop;

    if RDTSC_Lower> T.ElapsedRDTSC then
       RDTSC_Lower:= T.ElapsedRDTSC;

    if T_Lower > T.ElapsedMS then
       T_Lower := T.ElapsedMS;

  end;


  sIN.Position:=0;
  sOut.Position:=0;

  len:=Decoding(sOut, sIn);

  sIN.Position:=0;
  len:=sIN.Size;

  GetMem(pIN,len);

  sIN.Read(pIn^,len);

  if CompareMem(@Data[1], Pin,len) then
     Form1.memo2.Lines.Add(
     format('%s %10d clock cycles, %5d ms - PASS',[Note,RDTSC_Lower,T_Lower]))
  else
     Form1.memo2.Lines.Add(
     format('%s %10d clock cycles, %5d ms - FAIL!',[Note,RDTSC_Lower,T_Lower]));

  if Form1.cbShowOutput.checked then
  begin
    form1.memo2.Lines.Add(StringOfChar('-',80));

    sOut.Position:=0;

    adds:=TStringList.create;
    adds.LoadFromStream(sOut);

    form1.memo2.Lines.BeginUpdate;
    form1.memo2.Lines.AddStrings(adds);
    form1.memo2.Lines.EndUpdate;

    adds.Free;

    form1.memo2.Lines.Add(StringOfChar('-',80));
  end;

  sIn.Free;
  sOut.Free;

  FreeMem(pIN);

  Result:=0
end;

procedure TForm1.BenchmarkBefore;
var
  PerfEnd, PerfFreq, PerfStart, PerfTemp: Int64;
begin
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);

  // A quarter of a second for SpeedStep
  Win32Check(QueryPerformanceFrequency(PerfFreq));
  Win32Check(QueryPerformanceCounter(PerfStart));
  PerfEnd := PerfStart + (PerfFreq div 4);
  repeat
    Win32Check(QueryPerformanceCounter(PerfTemp));
  until PerfTemp >= PerfEnd;
end;

procedure TForm1.BenchmarkAfter;
begin
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL);
end;


procedure TForm1.Button1Click(Sender: TObject);
const
  CLEN = 1*1024*1024;
var
  i: integer;
  All_Chr: string;

  MIMELine: integer;
begin
  BenchmarkBefore;

  All_Chr:='';

  if rgDataType.ItemIndex=1 then
    randomize;

  // 256Bytes of data
  if rbDataSize.ItemIndex=0 then
  begin
    SetLength(All_Chr, 256);
    for i:=1 to 256 do
    if rgDataType.ItemIndex=0 then
      All_Chr[i]:= chr(i-1)
    else
      All_Chr[i]:=chr(random(256));

  end;

  // 1MB of data
  if rbDataSize.ItemIndex=1 then
  begin
    SetLength(All_Chr, CLEN);
    for i:=1 to CLEN do
    if rgDataType.ItemIndex=0 then
      All_Chr[i]:=chr(i-1)
    else
      All_Chr[i]:=chr(random(256));
  end;

  C:= StrToInt(Form1.rbLoops.Items[Form1.rbLoops.Itemindex]);

  //SetLength(All_Chr,0);
  //All_Chr:='Testing decode success!';

  memo2.Lines.Add(StringOfChar('-',30));
  memo2.Lines.Add('Encoding Base64 speed test.');
  memo2.Lines.Add(StringOfChar('-',30));
  memo2.Lines.Add('');
  memo2.Lines.Add('The fastest Loop of ' + IntToStr(C));
  memo2.Lines.Add(StringOfChar('-',80));

  DoEncodingString('SZCodeOnlyBase64 Ver 1.2     = ',
    SZFullEncodeOnlyBase64,
    SZDecodeBase64,
    All_chr);

  DoEncodingString('SZCodeOnlyBase64 6 Ver 1.2   = ',
    SZFullEncodeOnlyBase64_6,
    SZDecodeBase64,
    All_chr);

  memo2.Lines.Add('');

  MIMELine:=0;

  DoEncodingMemory(
    format('SZCodeBaseX Memory Ver 1.3.2 MIME %2d = ',[MIMELine]),
    SZFullEncodeBase64,
    SZDecodeBase64,
    All_chr);


  DoEncodingString(
    format('SZCodeBaseX String Ver 1.3.2 MIME %2d = ',[MIMELine]),
    SZFullEncodeBase64,
    SZDecodeBase64,
    All_chr);

  DoEncodingStream(
    format('SZCodeBaseX Stream Ver 1.3.2 MIME %2d = ',[MIMELine]),
    SZFullEncodeBase64,
    SZDecodeBase64,
    All_chr);

  memo2.Lines.Add('');

  // set MIMEline to 76 characters
  MIMELine := 76;

  DoEncodingMemory(
    format('SZCodeBaseX Memory Ver 1.3.2 MIME %2d = ',[MIMELine]),
    SZFullEncodeBase64,
    SZDecodeBase64,
    All_chr,
    MIMELine);

  DoEncodingString(
    format('SZCodeBaseX String Ver 1.3.2 MIME %2d = ',[MIMELine]),
    SZFullEncodeBase64,
    SZDecodeBase64,
    All_chr,
    MIMELine);

  DoEncodingStream(
    format('SZCodeBaseX Stream Ver 1.3.2 MIME %2d = ',[MIMELine]),
    SZFullEncodeBase64,
    SZDecodeBase64,
    All_chr,
    MIMELine);

  //-------------------------
  memo2.Lines.Add(StringOfChar('-',80));
  memo2.Lines.Add('');

  BenchmarkAfter;

end;

end.
