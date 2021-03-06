object Form1: TForm1
  AlignWithMargins = True
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 10
  Padding.Top = 10
  Padding.Right = 10
  Padding.Bottom = 10
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 13
    Top = 13
    Width = 185
    Height = 274
    Align = alLeft
    BevelOuter = bvLowered
    Caption = ' '
    TabOrder = 0
    object SelectInteger: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 177
      Height = 30
      Align = alTop
      Caption = 'SelectInteger'
      TabOrder = 0
      OnClick = SelectIntegerClick
    end
    object SelectString: TButton
      AlignWithMargins = True
      Left = 4
      Top = 40
      Width = 177
      Height = 30
      Align = alTop
      Caption = 'SelectString'
      TabOrder = 1
      OnClick = SelectStringClick
    end
    object SelectWidestring: TButton
      AlignWithMargins = True
      Left = 4
      Top = 76
      Width = 177
      Height = 30
      Align = alTop
      Caption = 'SelectWidestring'
      TabOrder = 2
      OnClick = SelectWidestringClick
    end
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 204
    Top = 13
    Width = 418
    Height = 274
    Align = alClient
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object SqlitePassDatabase1: TSqlitePassDatabase
    DatabaseType = dbtUnknown
    DatatypeOptions.BooleanStorage = asInteger
    DatatypeOptions.DateFormat = 'YYYY-MM-DD'
    DatatypeOptions.DateStorage = asInteger
    DatatypeOptions.DateTimeFormat = 'YYYY-MM-DD hh:mm:ss.zzz'
    DatatypeOptions.DateTimeStorage = dtsDateTime
    DatatypeOptions.DecimalSeparator = '.'
    DatatypeOptions.DefaultFieldType = ftUnknown
    DatatypeOptions.DetectionMode = dmTypeName
    DatatypeOptions.LoadOptions = [loDefaultProperties, loCustomProperties, loTranslationRules, loCustomFieldDefs]
    DatatypeOptions.SaveOptions = [soCustomProperties, soTranslationRules, soCustomFieldDefs]
    DatatypeOptions.UnicodeEncoding = ueUTF16
    DatatypeOptions.TimeFormat = 'hh:mm:ss'
    DatatypeOptions.TimeStorage = asInteger
    DatatypeOptions.pCustomFieldDefs = ()
    DatatypeOptions.pTranslationsRules = ()
    Options.ApplyMode = [amOverwriteDatabaseFileSettings, amAutoVacuum, amCacheSize, amCaseSensitiveLike, amCountChanges, amDefaultCacheSize, amFullColumnNames, amForeignKeys, amJournalMode, amLockingMode, amRecursiveTriggers, amSecureDelete, amSynchronous, amTemporaryStorage]
    Options.AutoVacuum = avNone
    Options.CacheSize = 2000
    Options.CaseSensitiveLike = False
    Options.CountChanges = False
    Options.DefaultCacheSize = 2000
    Options.Encoding = UTF8
    Options.ForeignKeys = False
    Options.FullColumnNames = False
    Options.JournalMode = jmDelete
    Options.JournalSizeLimit = -1
    Options.LockingMode = lmNormal
    Options.LogErrors = True
    Options.MaxPageCount = 2147483647
    Options.PageSize = 1024
    Options.QuoteStyle = qsDoubleQuote
    Options.RecursiveTriggers = False
    Options.SecureDelete = False
    Options.Synchronous = syncNormal
    Options.TemporaryStorage = tsDefault
    QueryTimeout = 0
    ShowSystemObjects = False
    VersionInfo.Component = '0.55'
    VersionInfo.Schema = -1
    VersionInfo.Package = '0.55'
    VersionInfo.SqliteLibraryNumber = 0
    VersionInfo.UserTag = -1
    Left = 512
    Top = 24
  end
  object SqlitePassDataset1: TSqlitePassDataset
    CalcDisplayedRecordsOnly = False
    Database = SqlitePassDatabase1
    MasterSourceAutoActivate = True
    FilterMode = fmSQLDirect
    FilterRecordLowerLimit = 0
    FilterRecordUpperLimit = 0
    Indexed = True
    LocateSmartRefresh = False
    LookUpCache = False
    LookUpDisplayedRecordsOnly = False
    LookUpSmartRefresh = False
    Sorted = False
    RecordsCacheCapacity = 100
    DatabaseAutoActivate = True
    VersionInfo.Component = '0.55'
    VersionInfo.Package = '0.55'
    ParamCheck = False
    WriteMode = wmDirect
    Left = 544
    Top = 24
    pParams = ()
  end
  object DataSource1: TDataSource
    DataSet = SqlitePassDataset1
    Left = 576
    Top = 24
  end
end
