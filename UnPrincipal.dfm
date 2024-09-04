object opcVisual: TopcVisual
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Calculadora'
  ClientHeight = 410
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 53
    Height = 15
    Caption = 'N'#250'mero 1'
  end
  object Label2: TLabel
    Left = 16
    Top = 80
    Width = 53
    Height = 15
    Caption = 'N'#250'mero 2'
  end
  object Label3: TLabel
    Left = 16
    Top = 192
    Width = 52
    Height = 15
    Caption = 'Resultado'
  end
  object txtNum1: TEdit
    Left = 16
    Top = 37
    Width = 185
    Height = 23
    TabOrder = 0
    OnChange = txtNum1Change
  end
  object txtNum2: TEdit
    Left = 16
    Top = 101
    Width = 185
    Height = 23
    TabOrder = 1
    OnChange = txtNum1Change
  end
  object BTsubtrair: TButton
    Left = 63
    Top = 138
    Width = 42
    Height = 25
    Caption = '-'
    Enabled = False
    TabOrder = 2
    OnClick = BTsubtrairClick
  end
  object BTmultiplicar: TButton
    Left = 111
    Top = 138
    Width = 42
    Height = 25
    Caption = '*'
    Enabled = False
    TabOrder = 3
    OnClick = BTmultiplicarClick
  end
  object BTdividir: TButton
    Left = 159
    Top = 138
    Width = 42
    Height = 25
    Caption = '/'
    Enabled = False
    TabOrder = 4
    OnClick = BTdividirClick
  end
  object txtResultado: TEdit
    Left = 16
    Top = 213
    Width = 185
    Height = 23
    ReadOnly = True
    TabOrder = 5
  end
  object BTsomar: TButton
    Left = 16
    Top = 138
    Width = 41
    Height = 25
    Caption = '+'
    Enabled = False
    TabOrder = 6
    OnClick = btSomarClick
  end
  object opcVisual: TRadioGroup
    Left = 16
    Top = 264
    Width = 185
    Height = 130
    Caption = 'Alterar visual da calculadora'
    ItemIndex = 1
    Items.Strings = (
      'Classic Windows'
      'Glow'
      'Aqua Light Slate')
    TabOrder = 7
    OnClick = opcVisualClick
  end
end
