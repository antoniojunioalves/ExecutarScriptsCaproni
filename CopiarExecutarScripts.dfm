object FormExecutarScripts: TFormExecutarScripts
  Left = 0
  Top = 0
  Caption = 'Executar Scripts Caproni'
  ClientHeight = 220
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblOrigem: TLabel
    Left = 16
    Top = 3
    Width = 88
    Height = 13
    Caption = 'Origem dos scripts'
  end
  object edtOrigem: TEdit
    Left = 16
    Top = 18
    Width = 471
    Height = 21
    TabOrder = 0
    Text = 
      'C:\RTC\PIPELINE_SG5_RUSSIA_CONTINUO\PIPELINE_SG5_RUSSIA_CONTINUO' +
      '\dbscript\SG'
  end
  object btnCopiar: TButton
    Left = 16
    Top = 49
    Width = 88
    Height = 25
    Caption = 'Copiar Scripts'
    TabOrder = 1
    OnClick = btnCopiarClick
  end
  object btnExecutar: TButton
    Left = 116
    Top = 49
    Width = 88
    Height = 25
    Caption = 'Executar Scripts'
    TabOrder = 2
    OnClick = btnExecutarClick
  end
  object mmoListaScripts: TMemo
    Left = 562
    Top = 3
    Width = 267
    Height = 210
    Lines.Strings = (
      'Informar o nome do script DH4'
      'um por linha Ex.:'
      'SG011660.DH4'
      'SG011661.DH4'
      ''
      'N'#195'O TEM TRATAMENTO PARA SCRIPT COM POS'
      '')
    TabOrder = 3
  end
  object rgPGouSG: TRadioGroup
    Left = 14
    Top = 88
    Width = 185
    Height = 61
    Caption = 'Sistema a rodar o script: '
    ItemIndex = 1
    Items.Strings = (
      'PG'
      'SG')
    TabOrder = 4
  end
end
