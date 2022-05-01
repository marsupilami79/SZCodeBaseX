unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    edToEncode: TEdit;
    btnTest: TButton;
    Label1: TLabel;
    btnEncode: TButton;
    btnDecode: TButton;
    ComboBox1: TComboBox;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    edToDecode: TEdit;
    Button4: TButton;
    OpenDialog2: TOpenDialog;
    Label4: TLabel;
    Edit1: TEdit;
    Button5: TButton;
    Button6: TButton;
    procedure btnTestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEncodeClick(Sender: TObject);
    procedure btnDecodeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  lastclock: int64=0;

implementation

uses SZCodeBaseX, Math;

{$R *.dfm}

function SZEncodeBase2(const S: string; MIMELines: integer=0): string;
{
 Example for binary Encoding
}
const
  Codes = '01';
  BITS = 1;
begin
  Result:=SZEncodeBaseXString(S, Codes, BITS, 0, MIMELines)
end;

function SZDecodeBase2(const S: string): string;
{
 Example for binary Decoding
}
const
  Codes = '01';
  BITS = 1;
begin
  Result:=SZDecodeBaseXString(S, Codes, BITS)
end;

procedure TForm1.btnTestClick(Sender: TObject);
var
  s,e,d: string;

  procedure PrintNote(const s, e, d: string);
  begin
    with Memo1.Lines do
    begin
      Add(s);
      Add('Encode: ' + e);
      Add('Decode: ' + d);
      Add('');
    end
  end;

begin
  Memo1.Clear;

  s:=Edit1.Text;

  with Memo1.Lines do
  begin
    Add('Text for testing: ' + s);
    Add('');

    e:=SZEncodeBase16(s); d:=SZDecodeBase16(e);
    PrintNote('Base16',e,d);

    e:=SZEncodeBase32(s); d:=SZDecodeBase32(e);
    PrintNote('Base32 - RFC 3548 incompatibility - no padding keys',e,d);

    e:=SZFullEncodeBase32(s); d:=SZDecodeBase32(e);
    PrintNote('Base32 - RFC 3548 full compatibility',e,d);

    e:=SZEncodeBase64(s); d:=SZDecodeBase64(e);
    PrintNote('Base64 - RFC 3548 incompatibility - no padding keys',e,d);

    e:=SZFullEncodeBase64(s); d:=SZDecodeBase64(e);
    PrintNote('Base64 - RFC 3548 full compatibility',e,d);

    e:=SZEncodeBase64URL(s); d:=SZDecodeBase64URL(e);
    PrintNote('Base64URL - RFC 3548 incompatibility - no padding keys',e,d);

    e:=SZFullEncodeBase64URL(s); d:=SZDecodeBase64URL(e);
    PrintNote('Base64URL - RFC 3548 full compatibility',e,d);

    e:=SZEncodeBase2(s); d:=SZDecodeBase2(e);
    PrintNote('Base2 - Example how to create your own base Encode/Decode functions',e,d);

   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  OpenDialog1.FileName:='.\';
end;

procedure TForm1.btnEncodeClick(Sender: TObject);
var
  e,d: string;
  Mime: integer;
begin

  d:=Memo1.Text;

  Mime:= StrToIntDef(Edit2.Text,0);
  if Mime<0 then
     Mime:=0;

  case ComboBox1.ItemIndex of
    0: e:=SZEncodeBase16(d,Mime);
    1: e:=SZEncodeBase32(d,Mime);
    2: e:=SZEncodeBase64(d,Mime);
    3: e:=SZEncodeBase64URL(d,Mime);
    4: e:=SZEncodeBase2(d,Mime);
    5: e:=SZFullEncodeBase32(d,Mime);
    6: e:=SZFullEncodeBase64(d,Mime);
    7: e:=SZFullEncodeBase64URL(d,Mime);
  end;
  //Edit2.Text:=e;
  memo1.text:=e
end;

procedure TForm1.btnDecodeClick(Sender: TObject);
var
  e,d: string;
  i: integer;
begin
  e:='';
  for i:=0 to memo1.Lines.count-1 do
    e:=e+memo1.Lines[i]+#13#10;


  case ComboBox1.ItemIndex of
    0: d:=SZDecodeBase16(e);
    1: d:=SZDecodeBase32(e);
    2: d:=SZDecodeBase64(e);
    3: d:=SZDecodeBase64URL(e);
    4: d:=SZDecodeBase2(e);
    5: d:=SZDecodeBase32(e);
    6: d:=SZDecodeBase64(e);
    7: d:=SZDecodeBase64URL(e);
  end;
//  Edit1.Text:=d;
  memo1.text:=d
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  sIn,sOut: TFileStream;
  fIn,fOut: String;
  size: integer;
begin

  fIn := edToEncode.Text;
  fOut:= edToDecode.Text;

{
  // Encoding directly by given filename
  sOut:=TFileStream.Create(fOut,fmCreate);
  size:=SZFullEncodeBase64(fIn, sOut);
  sOut.Free;
}

  // Stream to stream
  sIn :=TFileStream.Create(fIn, fmOpenRead or fmShareDenyNone);
  sOut:=TFileStream.Create(fOut, fmCreate);

  // Full Base64 encoding - with padding keys
//  size:=SZFullEncodeBase64(sIn, sOut, -1, StrToIntDef(Edit2.Text,0));

  case ComboBox1.ItemIndex of
    0: size:=SZEncodeBase16(sIn, sOut, -1, StrToIntDef(Edit2.Text,0));
    1: size:=SZEncodeBase32(sIn, sOut, -1, StrToIntDef(Edit2.Text,0));
    2: size:=SZEncodeBase64(sIn, sOut, -1, StrToIntDef(Edit2.Text,0));
    3: size:=SZEncodeBase64URL(sIn, sOut, -1, StrToIntDef(Edit2.Text,0));
    4:; //size:=SZEncodeBase2(sIn, sOut, -1, StrToIntDef(Edit2.Text,0));
    5: size:=SZFullEncodeBase32(sIn, sOut, -1, StrToIntDef(Edit2.Text,0));
    6: size:=SZFullEncodeBase64(sIn, sOut, -1, StrToIntDef(Edit2.Text,0));
    7: size:=SZFullEncodeBase64URL(sIn, sOut, -1, StrToIntDef(Edit2.Text,0));
  end;


  memo1.Lines.Add(
    format('Encoded "%s" (%d bytes) to "%s" (%d bytes) ',
      [fIn,sIn.Size,fOut,sOut.Size]));

  sIn.Free;
  sOut.Free;    
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  sIn,sOut: TFileStream;
  fIn,fOut: String;
  size: integer;
begin

  fIn := edToDecode.Text;
  fOut:= edToEncode.Text;

// Stream to stream
  sIn :=TFileStream.Create(fIn, fmOpenRead or fmShareDenyNone);
  sOut:=TFileStream.Create(fOut, fmCreate);

  // Decode Base64
  size:=SZDecodeBase64(sIn, sOut);

  case ComboBox1.ItemIndex of
    0: size:=SZDecodeBase16(sIn, sOut);
    1: size:=SZDecodeBase32(sIn, sOut);
    2: size:=SZDecodeBase64(sIn, sOut);
    3: size:=SZDecodeBase64URL(sIn, sOut);
    4: ;//size:=SZDecodeBase2(sIn, sOut);
    5: size:=SZDecodeBase32(sIn, sOut);
    6: size:=SZDecodeBase64(sIn, sOut);
    7: size:=SZDecodeBase64URL(sIn, sOut);
  end;


  memo1.Lines.Add(
    format('Decoded "%s" (%d bytes) to "%s" (%d bytes) ',
      [fIn,sIn.Size,fOut,sOut.Size]));

  sIn.Free;
  sOut.Free;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenDialog1.FileName:=edToEncode.Text;
  if OpenDialog1.Execute then
  begin
    edToEncode.Text:=OpenDialog1.FileName;
  end
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  OpenDialog2.FileName:=edToDecode.Text;
  if OpenDialog1.Execute then
  begin
    edToDecode.Text:=OpenDialog1.FileName;
  end

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile(edToEncode.Text);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile(edToDecode.Text);
end;

end.
