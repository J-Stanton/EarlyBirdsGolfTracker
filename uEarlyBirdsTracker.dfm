object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 750
  ClientWidth = 1192
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 1033
    Height = 769
    ActivePage = tsHandicap
    TabOrder = 0
    object tsHandicap: TTabSheet
      Caption = 'Handicap'
      object rgpMembers: TRadioGroup
        Left = 16
        Top = 8
        Width = 305
        Height = 721
        Caption = 'rgpMembers'
        TabOrder = 0
      end
      object sedScore: TSpinEdit
        Left = 344
        Top = 200
        Width = 129
        Height = 24
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object btnEnter: TButton
        Left = 344
        Top = 240
        Width = 129
        Height = 25
        Caption = 'btnEnter'
        TabOrder = 2
      end
      object redHandicap: TRichEdit
        Left = 512
        Top = 8
        Width = 641
        Height = 721
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'redHandicap')
        ParentFont = False
        TabOrder = 3
      end
    end
    object tsCompetition: TTabSheet
      Caption = 'Competition'
      ImageIndex = 1
    end
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\james\OneD' +
      'rive\Projects\GolfTracker\earlyBirds.mdb;Persist Security Info=F' +
      'alse'
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 1064
    Top = 128
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 1068
    Top = 226
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 1080
    Top = 312
  end
end
