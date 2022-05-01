object Form1: TForm1
  Left = 42
  Top = 46
  Width = 740
  Height = 517
  Caption = 'Demo for SZCodeBaseX unit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    732
    490)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 48
    Width = 53
    Height = 13
    Caption = 'To Encode'
  end
  object Label3: TLabel
    Left = 32
    Top = 72
    Width = 54
    Height = 13
    Caption = 'To Decode'
  end
  object Label4: TLabel
    Left = 8
    Top = 96
    Width = 77
    Height = 13
    Caption = 'Text For Testing'
  end
  object Label2: TLabel
    Left = 481
    Top = 8
    Width = 52
    Height = 13
    Anchors = [akRight]
    Caption = 'MIME lines'
  end
  object Memo1: TMemo
    Left = 8
    Top = 128
    Width = 709
    Height = 352
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object edToEncode: TEdit
    Left = 96
    Top = 40
    Width = 377
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'Encode.tmp'
  end
  object btnTest: TButton
    Left = 480
    Top = 94
    Width = 75
    Height = 26
    Anchors = [akTop, akRight]
    Caption = 'Test'
    Default = True
    TabOrder = 2
    OnClick = btnTestClick
  end
  object btnEncode: TButton
    Left = 560
    Top = 96
    Width = 77
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Memo Encode'
    TabOrder = 3
    OnClick = btnEncodeClick
  end
  object btnDecode: TButton
    Left = 640
    Top = 96
    Width = 73
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Memo Decode'
    TabOrder = 4
    OnClick = btnDecodeClick
  end
  object ComboBox1: TComboBox
    Left = 576
    Top = 6
    Width = 137
    Height = 21
    Anchors = [akRight]
    ItemHeight = 13
    ItemIndex = 6
    TabOrder = 5
    Text = 'Full Base 64'
    Items.Strings = (
      'Base 16'
      'Base 32'
      'Base 64'
      'Base 64 URL'
      'Base 2'
      'Full Base 32'
      'Full Base 64'
      'Full Base 64 URL')
  end
  object Button1: TButton
    Left = 480
    Top = 40
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    Caption = 'Load'
    ParentBiDiMode = False
    TabOrder = 7
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 640
    Top = 39
    Width = 75
    Height = 26
    Anchors = [akTop, akRight]
    Caption = 'Encode file'
    TabOrder = 8
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 640
    Top = 64
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Decode file'
    TabOrder = 9
    OnClick = Button3Click
  end
  object Edit2: TEdit
    Left = 538
    Top = 5
    Width = 31
    Height = 21
    Anchors = [akRight]
    TabOrder = 6
    Text = '76'
  end
  object edToDecode: TEdit
    Left = 96
    Top = 64
    Width = 377
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Text = 'Decode.tmp'
  end
  object Button4: TButton
    Left = 480
    Top = 64
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    Caption = 'Load'
    ParentBiDiMode = False
    TabOrder = 11
    OnClick = Button4Click
  end
  object Edit1: TEdit
    Left = 96
    Top = 96
    Width = 377
    Height = 21
    TabOrder = 12
    Text = 'Testing encoding typed text'
  end
  object Button5: TButton
    Left = 560
    Top = 40
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'To Memo'
    TabOrder = 13
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 560
    Top = 64
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'To Memo'
    TabOrder = 14
    OnClick = Button6Click
  end
  object OpenDialog1: TOpenDialog
    InitialDir = '.'
    Left = 248
    Top = 40
  end
  object OpenDialog2: TOpenDialog
    InitialDir = '.'
    Left = 248
    Top = 72
  end
end
