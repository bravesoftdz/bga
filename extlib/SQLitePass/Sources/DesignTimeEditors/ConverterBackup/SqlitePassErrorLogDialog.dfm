object SqlitePassErrorLogDlg: TSqlitePassErrorLogDlg
  Left = 25
  Top = 207
  Width = 995
  Height = 457
  Caption = 'Errors Log Dialog'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object PanelIndexesToolBar: TPanel
    Left = 0
    Top = 0
    Width = 987
    Height = 381
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanelIndexesToolBar'
    Color = 14869218
    TabOrder = 0
    object PanelErrorLogTitle: TPanel
      Left = 0
      Top = 0
      Width = 987
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      Color = 16772833
      TabOrder = 0
      object LabelErrorLogTitle: TLabel
        Left = 38
        Top = 10
        Width = 88
        Height = 14
        Caption = 'Logged Error(s)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Image4: TImage
        Left = 16
        Top = 9
        Width = 16
        Height = 16
        AutoSize = True
        Center = True
        Picture.Data = {
          07544269746D617036040000424D360400000000000036000000280000001000
          0000100000000100200000000000000400000000000000000000000000000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF002FAAE2A22DA7E0FF2BA4DFFF29A1DDFF279EDCFF259BDAFF2398D9FF2093
          D6FF1B8CD3FF1685CFFF117ECCFF0D77C9FF0971C6FF066CC3FF0368C1FF0064
          BFA231ADE3E3BEE3F5FFF4FCFEFFEFFBFEFFEEFBFEFFEEFBFEFFEFFCFEFFEFFC
          FEFFEFFBFEFFEEFBFEFFEDFBFEFFEDFBFEFFECFBFEFFF2FCFEFFABCEEBFF0368
          C1D834B0E54B62BFE8FFF4FCFEFFB5EFFAFF58DAF5FF58DAF5FF57D8F3FF58D7
          F2FF58D6F2FF57D9F4FF51D8F5FF4ED7F4FF62DAF6FFEAFBFEFF4493D2FF066D
          C34BFFFFFF0034B0E5CA9DD7F1FFE7F9FDFF8BE5F8FF5ADBF6FF5BDAF4FF3DA1
          D5FF3DA1D5FF54D6F2FF52D8F5FF50D6F4FFD8F6FCFF88BFE5FF0E79C9B4FFFF
          FF00FFFFFF0036B3E62434B1E5FBF3FBFEFFC3F2FBFF5CDCF6FF5CDAF4FF64DF
          F6FF57CBEBFF55D6F2FF54D9F5FF94E7F8FFE3F4FBFF1787D0F91380CD24FFFF
          FF00FFFFFF00FFFFFF0036B3E6AA8CD2F0FFEAFBFEFF94E6F8FF5CDAF4FF47B1
          DDFF3DA1D5FF56D7F2FF5CDBF5FFDEF8FDFF7DC0E7FF1D8ED487FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0038B6E80C36B4E6ECC8EAF7FFE6FAFDFF5DDAF4FF3DA1
          D5FF3DA1D5FF57D7F2FFC7F3FCFFC0E3F4FF2499D9E42296D80CFFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0038B6E85A71C8EDFFF9FEFFFF5EDCF4FF3EA2
          D5FF3EA2D5FF5CD9F4FFEDFBFEFF68BBE5FF269CDB5AFFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0038B7E8D4A9DFF4FFEDF9FDFF3EA3
          D6FF3EA3D6FFD4F5FCFFA2D7F1FF2BA3DEC3FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003AB9E93038B7E8FDF9FDFFFF94E9
          F9FF9EEBFAFFECFAFEFF2FA9E1FC2DA6E030FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003AB9E9B494D8F2FFF3FC
          FEFFE7FAFEFF8FD3F0FF31ACE396FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003CBCEB123ABAE9F2F1FA
          FDFFD5EFFAFF35B2E6ED33AFE412FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003CBCEB9585D4
          F1FF82D1F0FF37B5E769FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003DBFEC033CBC
          EBD43ABAEAC339B8E803FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00
        }
        Transparent = True
      end
    end
    object MemoErrorLog: TMemo
      Left = 0
      Top = 32
      Width = 987
      Height = 349
      Align = alClient
      BorderStyle = bsNone
      Color = cl3DLight
      Lines.Strings = (
        ''
      )
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object PanelButtons: TPanel
    Left = 0
    Top = 381
    Width = 987
    Height = 42
    Align = alBottom
    Anchors = [akRight]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object SbOk: TSpeedButton
      Left = 897
      Top = 10
      Width = 73
      Height = 22
      Anchors = [akRight]
      Caption = 'Ok'
      Flat = True
      OnClick = SbOkClick
    end
    object SbClear: TSpeedButton
      Left = 817
      Top = 10
      Width = 73
      Height = 22
      Anchors = [akRight]
      Caption = 'Clear'
      Flat = True
      OnClick = SbClearClick
    end
    object SbSaveToFile: TSpeedButton
      Left = 737
      Top = 10
      Width = 73
      Height = 22
      Anchors = [akRight]
      Caption = 'Save to file'
      Flat = True
      OnClick = SbSaveToFileClick
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    Left = 696
    Top = 389
  end
end
