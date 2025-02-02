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
  OnCreate = FormCreate
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1193
    Height = 777
    ActivePage = tsHandicap
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object tsHandicap: TTabSheet
      Caption = 'Handicap'
      object Label1: TLabel
        Left = 355
        Top = 288
        Width = 172
        Height = 28
        Caption = '3) Enter Gross score'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 387
        Top = 6
        Width = 118
        Height = 28
        Caption = '2) Check date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object rgpHandicap: TRadioGroup
        Left = 3
        Top = 3
        Width = 305
        Height = 641
        Caption = '1) Choose member'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = rgpHandicapClick
      end
      object sedScore: TSpinEdit
        Left = 376
        Top = 322
        Width = 129
        Height = 38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 0
        MinValue = 0
        ParentFont = False
        TabOrder = 1
        Value = 0
      end
      object btnEnter: TButton
        Left = 366
        Top = 416
        Width = 161
        Height = 49
        Caption = '4) Enter'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnEnterClick
      end
      object redHandicap: TRichEdit
        Left = 605
        Top = 6
        Width = 537
        Height = 641
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 3
      end
      object calHandicap: TMonthCalendar
        Left = 323
        Top = 40
        Width = 260
        Height = 205
        Date = 45498.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
    object tsCompetition: TTabSheet
      Caption = 'Competition'
      ImageIndex = 1
      object Label3: TLabel
        Left = 302
        Top = 292
        Width = 225
        Height = 28
        Caption = '3) Enter stableford points:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 298
        Top = 394
        Width = 250
        Height = 28
        Caption = '4) Enter the number of putts:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 344
        Top = 24
        Width = 118
        Height = 28
        Caption = '2) Check date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object rgpCompetition: TRadioGroup
        Left = 7
        Top = 3
        Width = 249
        Height = 617
        Caption = '1) Choose member'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = rgpCompetitionClick
      end
      object sedStablePoints: TSpinEdit
        Left = 360
        Top = 326
        Width = 97
        Height = 38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 0
        MinValue = 0
        ParentFont = False
        TabOrder = 1
        Value = 0
      end
      object sedPutts: TSpinEdit
        Left = 360
        Top = 444
        Width = 97
        Height = 38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 0
        MinValue = 0
        ParentFont = False
        TabOrder = 2
        Value = 0
      end
      object btnComp: TButton
        Left = 336
        Top = 544
        Width = 145
        Height = 41
        Caption = '5) Enter'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btnCompClick
      end
      object redComp: TRichEdit
        Left = 581
        Top = 3
        Width = 601
        Height = 665
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 4
      end
      object calComp: TMonthCalendar
        Left = 288
        Top = 58
        Width = 260
        Height = 205
        Date = 45497.000000000000000000
        TabOrder = 5
      end
    end
    object tsLeaderboard: TTabSheet
      Caption = 'Leaderboard'
      ImageIndex = 2
      object redLeaderboard: TRichEdit
        Left = 323
        Top = 16
        Width = 646
        Height = 609
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object btnPoints: TButton
        Left = 16
        Top = 16
        Width = 217
        Height = 41
        Caption = 'View points leaderboard'
        TabOrder = 1
        OnClick = btnPointsClick
      end
      object btnPutts: TButton
        Left = 16
        Top = 80
        Width = 217
        Height = 41
        Caption = 'View putt leaderboard'
        TabOrder = 2
        OnClick = btnPuttsClick
      end
    end
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\james\OneD' +
      'rive\Projects\GolfTracker\earlyBirds.mdb;Persist Security Info=F' +
      'alse'
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 1160
    Top = 16
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 1164
    Top = 74
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 1168
    Top = 136
  end
end
