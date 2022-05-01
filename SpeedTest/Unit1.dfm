object Form1: TForm1
  Left = 7
  Top = 106
  Width = 795
  Height = 463
  Caption = 'Base64 Speed Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    787
    436)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 56
    Width = 105
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo2: TMemo
    Left = 16
    Top = 88
    Width = 759
    Height = 332
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object rbDataSize: TRadioGroup
    Left = 312
    Top = 8
    Width = 105
    Height = 33
    Caption = 'Data size'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      '256B'
      '1MB')
    TabOrder = 2
  end
  object rbLoops: TRadioGroup
    Left = 24
    Top = 8
    Width = 273
    Height = 33
    Caption = 'The fasted loop of N attempts'
    Columns = 6
    ItemIndex = 3
    Items.Strings = (
      '1'
      '5'
      '10'
      '50'
      '100'
      '500')
    TabOrder = 3
  end
  object cbShowOutput: TCheckBox
    Left = 176
    Top = 56
    Width = 97
    Height = 17
    Caption = 'Show output'
    TabOrder = 4
  end
  object rgDataType: TRadioGroup
    Left = 312
    Top = 48
    Width = 169
    Height = 33
    Caption = 'Data type'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Sequencial'
      'Random')
    TabOrder = 5
  end
end
