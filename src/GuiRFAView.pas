(* ***** BEGIN LICENSE BLOCK *****
 * Version: GNU GPL 2.0
 *
 * The contents of this file are subject to the
 * GNU General Public License Version 2.0; you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 * http://www.gnu.org/licenses/gpl.html
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is GuiRFAView (http://code.google.com/p/bga)
 *
 * The Initial Developer of the Original Code is
 * Yann Papouin <yann.papouin at @ gmail.com>
 *
 * ***** END LICENSE BLOCK ***** *)

unit GuiRFAView;

interface

{$I BGA.inc}

uses
  JvGnuGetText, ShellAPI, GuiFormCommon, Comobj,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GuiRFACommon, ActnList, VirtualTrees, TB2Item, SpTBXItem, TB2Dock,
  TB2Toolbar, ExtCtrls, JvFormPlacement, JvAppStorage, JvAppRegistryStorage, Menus,
  JvComponentBase, JvAppInst, DragDrop, DropSource, DragDropFile, StdCtrls,
  SpTBXEditors, SpTBXControls, GuiUpdateManager, ActiveX, RFALib, JclFileUtils, ImgList,
  PngImageList, DropTarget, DropHandler, JvThread;

type

  TShiftWay =
  (
    shLeft,
    shRight
  );

  TEditResult =
  (
    edCancel,
    edOk,
    edInvalid
  );

  TDragDropStage =
  (
    dsNone,
    dsIdle,
    dsDrag,
    dsDragAsync,
    dsDragAsyncFailed,
    dsDrop,
    dsGetData,
    dsAbort,
    dsGetStream,
    dsDoneStream,
    dsDropComplete
  );

  TRFAViewForm = class;

  TSyncState =
  (
    ssWaiting,
    ssStopping,
    ssWorking
  );

  TSyncThread = class(TThread)
  private
    FGui : TRFAViewForm;
    FName: string;
    FSyncNode : PVirtualNode;
  protected
    procedure Execute; override;
    procedure Invalidate;
  public
    constructor Create(CreateSuspended:boolean; Gui: TRFAViewForm; Name: string);
    destructor Destroy; override;
  end;

  TRFAViewForm = class(TRFACommonForm)
    Open: TAction;
    Save: TAction;
    SaveAs: TAction;
    Quit: TAction;
    Recent: TAction;
    PackDirectory: TAction;
    ExtractModFolder: TAction;
    About: TAction;
    ApplicationRun: TAction;
    Settings: TAction;
    PreviewRAW: TAction;
    Defrag: TAction;
    New: TAction;
    NewVersionAvailable: TAction;
    Cancel: TAction;
    NewFolder: TAction;
    TopDock: TSpTBXDock;
    tbMenuBar: TSpTBXToolbar;
    mFile: TSpTBXSubmenuItem;
    SpTBXItem14: TSpTBXItem;
    SpTBXItem2: TSpTBXItem;
    RecentMenu: TSpTBXSubmenuItem;
    SpTBXItem4: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    SpTBXItem5: TSpTBXItem;
    SpTBXItem15: TSpTBXItem;
    SpTBXItem6: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    SpTBXItem7: TSpTBXItem;
    mEdit: TSpTBXSubmenuItem;
    SpTBXItem1: TSpTBXItem;
    SpTBXItem12: TSpTBXItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    SpTBXItem16: TSpTBXItem;
    SpTBXItem18: TSpTBXItem;
    SpTBXSubmenuItem1: TSpTBXSubmenuItem;
    SpTBXItem13: TSpTBXItem;
    SpTBXSubmenuItem3: TSpTBXSubmenuItem;
    SpTBXItem11: TSpTBXItem;
    SpTBXItem10: TSpTBXItem;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    SpTBXItem9: TSpTBXItem;
    SpTBXSubmenuItem2: TSpTBXSubmenuItem;
    SpTBXItem8: TSpTBXItem;
    mHelp: TSpTBXSubmenuItem;
    SpTBXItem3: TSpTBXItem;
    SpTBXItem17: TSpTBXItem;
    DropFileSource: TDropFileSource;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    AppInstances: TJvAppInstances;
    ViewerPopup: TSpTBXPopupMenu;
    SpTBXItem22: TSpTBXItem;
    EditWithMenuItem: TSpTBXSubmenuItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    SpTBXItem21: TSpTBXItem;
    SpTBXItem20: TSpTBXItem;
    SpTBXSeparatorItem6: TSpTBXSeparatorItem;
    SpTBXItem19: TSpTBXItem;
    AppStorage: TJvAppRegistryStorage;
    FormStorage: TJvFormStorage;
    StatusBar: TSpTBXStatusBar;
    ArchiveSize: TSpTBXLabelItem;
    SpTBXSeparatorItem7: TSpTBXSeparatorItem;
    Fragmentation: TSpTBXLabelItem;
    SpTBXSeparatorItem8: TSpTBXSeparatorItem;
    ArchiveFileCount: TSpTBXLabelItem;
    ProgressPanel: TSpTBXPanel;
    SubProgressBar: TSpTBXProgressBar;
    TotalProgressBar: TSpTBXProgressBar;
    TotalProgressLabel: TSpTBXLabel;
    SpTBXButton2: TSpTBXButton;
    ExtractAll: TAction;
    ExtractSelected: TAction;
    SpTBXItem23: TSpTBXItem;
    Filesystem: TAction;
    SpTBXSubmenuItem5: TSpTBXSubmenuItem;
    SkinGroup: TSpTBXSkinGroupItem;
    Theme: TSpTBXEdit;
    SpTBXSeparatorItem9: TSpTBXSeparatorItem;
    SpTBXSeparatorItem10: TSpTBXSeparatorItem;
    SelectionText: TSpTBXLabelItem;
    Revert: TAction;
    SpTBXItem24: TSpTBXItem;
    FileAssociation: TAction;
    SpTBXItem25: TSpTBXItem;
    SpTBXSeparatorItem11: TSpTBXSeparatorItem;
    SpTBXSubmenuItem6: TSpTBXSubmenuItem;
    EditWithOS: TAction;
    EditByExtension: TSpTBXItem;
    ExtensionImageList: TPngImageList;
    RecentList: TMemo;
    DropEmptySource: TDropEmptySource;
    DragDataFormatAdapter: TDataFormatAdapter;
    DebugItem: TSpTBXColorItem;
    SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AppInstancesCmdLineReceived(Sender: TObject; CmdLine: TStrings);
    procedure ApplicationRunExecute(Sender: TObject);
    procedure CancelExecute(Sender: TObject);
    procedure NewExecute(Sender: TObject);
    procedure NewFolderExecute(Sender: TObject);
    procedure OpenRecentClick(Sender: TObject);
    procedure OpenExecute(Sender: TObject);
    procedure QuitExecute(Sender: TObject);
    procedure SaveAsExecute(Sender: TObject);
    procedure SaveExecute(Sender: TObject);
    procedure DefragExecute(Sender: TObject);
    procedure AboutExecute(Sender: TObject);
    procedure RecentExecute(Sender: TObject);
    procedure RFAListDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure RFAListDblClick(Sender: TObject);
    procedure RFAListDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure DropFileSourceDrop(Sender: TObject; DragType: TDragType; var ContinueDrop: Boolean);
    procedure DropFileSourceAfterDrop(Sender: TObject; DragResult: TDragResult; Optimized: Boolean);
    procedure DropFileSourceGetData(Sender: TObject; const FormatEtc: tagFORMATETC; out Medium: tagSTGMEDIUM; var Handled: Boolean);
    procedure PreviewRAWExecute(Sender: TObject);
    procedure PackDirectoryExecute(Sender: TObject);
    procedure RFAListNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string);
    procedure RFAListEdited(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure RFAListNodeMoved(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure RFAListBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure RFAListStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure NewVersionAvailableExecute(Sender: TObject);
    procedure ExtractAllExecute(Sender: TObject);
    procedure ExtractSelectedExecute(Sender: TObject);
    procedure FilesystemExecute(Sender: TObject);
    procedure SkinGroupSkinChange(Sender: TObject);
    procedure RFAListKeyAction(Sender: TBaseVirtualTree; var CharCode: Word; var Shift: TShiftState; var DoDefault: Boolean);
    procedure RFAListStateChange(Sender: TBaseVirtualTree; Enter,
      Leave: TVirtualTreeStates);
    procedure RFAListDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RevertExecute(Sender: TObject);
    procedure FileAssociationExecute(Sender: TObject);
    procedure SettingsExecute(Sender: TObject);
    procedure SearchStartExecute(Sender: TObject);
    procedure PreviewExecute(Sender: TObject);
    procedure EditWithOSExecute(Sender: TObject);
    procedure EditByExtensionClick(Sender: TObject);
    procedure DropEmptySourceAfterDrop(Sender: TObject; DragResult: TDragResult;
      Optimized: Boolean);
    procedure DropEmptySourceDrop(Sender: TObject; DragType: TDragType;
      var ContinueDrop: Boolean);
    procedure DropEmptySourceGetData(Sender: TObject;
      const FormatEtc: tagFORMATETC; out Medium: tagSTGMEDIUM;
      var Handled: Boolean);
    procedure RFAListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RFAListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DropEmptySourceFeedback(Sender: TObject; Effect: Integer;
      var UseDefaultCursors: Boolean);
  private
    FEditResult : TEditResult;
    FThread : TSyncThread;
    FDragNodes : Array of PVirtualNode;
    FArchive : TRFAFile;
    FResetMutex : boolean;
    FStatus: TDragDropStage;
    procedure ReadEntry(Sender: TRFAFile; Name: AnsiString; Offset, ucSize: Int64; Compressed: boolean; cSize: integer);
    { Déclarations privées }
    procedure SubProgress(Sender : TRFAFile; Operation : TRFAOperation; Value : Integer = 0);
    procedure TotalProgress(Operation : TRFAOperation; Value : Integer; Max:integer);
    procedure Add(MainNode: PVirtualNode; List: TStringList; Path: string = '');
    function CheckStatus(Node: PVirtualNode): boolean;
    procedure DeleteSelection;
    procedure EditSelection;
    function EditInternal(ApplicationPath : string = '') : boolean;
    function LastOne(Offset: Int64): boolean;
    function LoadMap(Path: string): boolean;
    function QuickOpen: boolean;
    function QuickSave(Defragmentation: boolean): boolean;
    procedure RebuildRecentList;
    procedure AddToRecentList(Filename : string);
    procedure RemoveEmptyFolders;
    function Reset(Ask : boolean = false) : TModalResult;
    function SaveMap(Path: string; Defrag: boolean = false): boolean;
    procedure ExtractTo(Directory: string; RecreatePath : boolean; List: TStringList = nil);
    procedure ShiftData(ShiftData: TRFAResult; ShiftWay: TShiftWay; IgnoreNode: PVirtualNode = nil);
    procedure SyncAll;
    procedure ThreadCreate;
    procedure ThreadDestroy;
    procedure UpdateInfobar;
    procedure UpdateReply(Sender: TObject; Result: TUpdateResult);
    procedure RebuildEditWithMenu;
    procedure SetStatus(const Value: TDragDropStage);
    procedure PrepareDragList;
    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer; out AStream: IStream);
  protected
    procedure CancelChange;
    procedure NotifyChange;
  public
    { Déclarations publiques }
    property Status: TDragDropStage read FStatus write SetStatus;
  end;

var
  RFAViewForm: TRFAViewForm;

implementation

{$R *.dfm}

uses
  DbugIntf, VirtualTreeviewTheme, UAC, ShlObj, DragDropFormats,
  GuiRFASettings,
  GuiAbout, GuiMapView, GuiSMView, GuiBrowsePack, GuiSkinDialog, SpTBXSkins,
  Resources, Masks, Math, StringFunction, GuiBrowseExtract, CommonLib, AppLib, MD5Api;

const
  ASK_BEFORE_RESET = true;

procedure TRFAViewForm.ReadEntry(Sender : TRFAFile; Name: AnsiString; Offset, ucSize: Int64; Compressed : boolean; cSize : integer);
var
  Node: PVirtualNode;
  Data : pFse;
  W32Path : AnsiString;

begin
 // TotalProgress(roLoad, PG_AUTO, Sender.Count);
  W32Path := StringReplace(Name,'/','\',[rfReplaceAll]);

  Node := GetBuildPath(W32Path);
  Node := RFAList.AddChild(Node);

  Data := RFAList.GetNodeData(Node);
  Data.RFAFileHandle := Sender;
  Data.RFAFileName := Data.RFAFileHandle.Filepath;

  Data.EntryName := Name;
  Data.Offset := Offset;
  Data.Size := ucSize;
  Data.Compressed := Compressed;
  Data.CompSize := cSize;

  Data.W32Path := W32Path;
  Data.W32Name := ExtractFileName(W32Path);
  Data.W32Ext := ExtractFileExt(LowerCase(W32Path));
  Data.FileType := ExtensionToType(Data.W32Ext);
  Data.ExternalFilePath := EmptyStr;
end;



function TRFAViewForm.CheckStatus(Node: PVirtualNode): boolean;
var
  Data : pFse;
  PreviousStatus : TEntryStatus;
  FileDateTime: TDateTime;
  ConflictFound : boolean;
  Child : PVirtualNode;
  ChildData : pFse;
begin
  Result := False;
  if Node <> nil then
  begin
    Data := RFAList.GetNodeData(Node);
    PreviousStatus := Data.Status;
    if IsFile(Data.FileType) then
    begin
      if (Data.ExternalFilePath <> EmptyStr) and not (fsNew in Data.Status) or (fsExternal in Data.Status) then
      begin
        // Note : file age can change without data change
        if FileAge(Data.ExternalFilePath, FileDateTime) then
        begin
          if (FileDateTime <> Data.ExternalAge) then
          begin
            if MD5FromFile(Data.ExternalFilePath) <> Data.ExternalMD5 then
            begin
              Include(Data.Status, fsExternal);
              //NotifyChange;
            end
            else
              Exclude(Data.Status, fsExternal)
          end;
        end
          else
        begin
          Exclude(Data.Status, fsExternal);
          // Maybe the file has been deleted manually
          if not FileExists(Data.ExternalFilePath) then
            Data.ExternalFilePath := EmptyStr;
        end;
      end;

      if (fsEntry in Data.Status) and (Node.Parent <> nil) then
      begin
        ConflictFound := false;
        Child := Node.Parent.FirstChild;
        while Child <> nil do
        begin
          if Child <> Node then
          begin
            ChildData := RFAList.GetNodeData(Child);
            if not (fsDelete in ChildData.Status) then
              if (ChildData.W32Name = Data.W32Name) then
              begin
                Include(Data.Status, fsConflict);
                ConflictFound := true;
                Break;
              end;
          end;
          Child := RFAList.GetNextSibling(Child);
        end;
        if not ConflictFound then
          Exclude(Data.Status, fsConflict);
      end;
    end;

    Result := PreviousStatus <> Data.Status;
  end;
end;



procedure TRFAViewForm.Add(MainNode: PVirtualNode; List: TStringList; Path: string = '');
var
  i :integer;
  Node: PVirtualNode;
  Data : pFse;
  Sender: TBaseVirtualTree;

  function FindNode(Node: PVirtualNode; Filename : string) : PVirtualNode;
  var
    Data : pFse;
  begin
    Result := nil;
    Node := Node.FirstChild;
    while Node <> nil do
    begin
      Data := Sender.GetNodeData(Node);
      if UpperCase(Data.W32Name) = UpperCase(Filename) then
      begin
        Result := Node;
        Break;
      end;
      Node := Node.NextSibling;
    end;
  end;

  procedure AddFolder(Filename : string);
  var
    SubList: TStringList;
  begin
    if IsDirectory(Filename) then
    begin
      Node := FindNode(MainNode, ExtractFileName(Filename));
      if Node = nil then
      begin
        Node := Sender.AddChild(MainNode);
        Data := Sender.GetNodeData(Node);
        Data.W32Path := Filename;
        Data.W32Name := ExtractFileName(Filename);
        Data.FileType := ftFolder;
      end
        else
      begin
        Data := Sender.GetNodeData(Node);
      end;

      SubList := TStringList.Create;
      BuildFileList(IncludeTrailingPathDelimiter(Filename)+'*', faAnyFile - faHidden, SubList);
      Add(Node, SubList, Filename);
      SubList.Free;
    end;
  end;

  procedure AddFile(Filename : string);
  begin
    if not IsDirectory(Filename) then
    begin
      Node := FindNode(MainNode, ExtractFileName(Filename));
      if Node = nil then
      begin
        Node := Sender.AddChild(MainNode);
        Data := Sender.GetNodeData(Node);
        Data.W32Path := Filename;
        Data.W32Name := ExtractFileName(Filename);
        Data.ExternalFilePath := Data.W32Path;
        Data.Size := FileGetSize(Data.W32Path);
        Data.FileType := ftFile;
        Include(Data.Status, fsNew);
        Include(Data.Status, fsEntry);
      end
        else
      begin
        Data := Sender.GetNodeData(Node);
        Data.ExternalFilePath := Filename;
        Include(Data.Status, fsExternal);
        Exclude(Data.Status, fsDelete);
        Sender.FullyVisible[Node] := True;
      end;
    end;
  end;

begin
  BeginOperation;
  Sender := RFAList;
  NotifyChange;

  if MainNode = nil then
    MainNode := Sender.RootNode;

  if Assigned(List) then
  begin
    if Path <> EmptyStr then
      Path := IncludeTrailingPathDelimiter(Path);

    List.Sort;

    for i := 0 to List.Count - 1 do
      AddFolder(Path + List[i]);

    for i := 0 to List.Count - 1 do
      AddFile(Path + List[i]);
  end
    else
  begin
    AddFolder(Path);
    AddFile(Path);
  end;
  EndOperation;
end;



procedure TRFAViewForm.RemoveEmptyFolders;
var
  Node, NextNode: PVirtualNode;
  Data : pFse;
begin
  Node := RFAList.GetFirst;

  RFAList.BeginUpdate;
  while Node <> nil do
  begin
    NextNode := RFAList.GetNext(Node, true);
    Data := RFAList.GetNodeData(Node);

    if (Data.FileType = ftFolder) and (CountFilesByStatus(Node, [fsNew, fsEntry, fsExternal], true) = 0) then
    begin
      NextNode := RFAList.GetNextSibling(Node);
      RFAList.FullyVisible[Node] := false;
      Include(Data.Status, fsDelete);
    end;

    Node := NextNode;
  end;

  RFAList.EndUpdate;
end;



procedure TRFAViewForm.AppInstancesCmdLineReceived(Sender: TObject; CmdLine: TStrings);
begin
  if CmdLine.Count > 0 then
    if FileExists(CmdLine[0]) then
    begin
      OpenDialog.FileName := CmdLine[0];
      ThreadDestroy;
      try
        QuickOpen;
      finally
        ThreadCreate;
      end;
    end;
end;


procedure TRFAViewForm.ApplicationRunExecute(Sender: TObject);
var
  Node : PVirtualNode;
begin
  inherited;
  ApplicationRun.Enabled := false;
  FormStorage.RestoreFormPlacement;
  RebuildRecentList;

  if Theme.Text <> EmptyStr then
    SkinManager.SetSkin(Theme.Text);

  UpdateManagerForm.OnUpdateReply := UpdateReply;
  UpdateManagerForm.Check.Execute;

  RebuildEditWithMenu;
  Application.ProcessMessages;

  if ParamCount > 0 then
  begin
    SendDebug(ParamStr(1));
    OpenDialog.FileName := ParamStr(1);
    ThreadDestroy;
    try
      QuickOpen;
    finally
      ThreadCreate;
    end;

    if ParamCount > 1 then
    begin
      SendDebug(ParamStr(2));
      Node := FindFileByPath(ParamStr(2));
      if Node <> nil then
      begin
        RFAList.Selected[Node] := true;
        RFAList.FullyVisible[Node] := true;
        RFAList.ScrollIntoView(Node, true);
      end
        else
      begin
        SendDebugError('File not found');
      end;
    end;
  end
    else
  if RecentMenu.Enabled then
  begin
    if RFASettingsForm.OpenLast.Checked then
    begin
      RecentMenu.Items[0].Click
    end
      else
    begin
      New.Execute;
    end;
  end
  else
    OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);

  if not Assigned(ResourcesForm) then
    Application.CreateForm(TResourcesForm, ResourcesForm);
end;

function TRFAViewForm.Reset(Ask : boolean = false) : TModalResult;
begin
  Result := mrNone;

  if not FResetMutex and Ask and (Save.Enabled or (Assigned(FArchive) and (CountFilesByStatus(RFAList.RootNode, [fsNew], false) > 0) )) then
  begin
    FResetMutex := true;
    Result := ShowDialog('Confirmation', 'Save changes ?', mtInformation, mbYesNoCancel, mbCancel, 0);
    case Result of
      mrYes:
      begin
        SaveAs.Execute;
        FResetMutex := false;
      end;
      mrNo:
      begin
        FResetMutex := false;
      end;
      mrCancel:
      begin
        FResetMutex := false;
        Exit;
      end;
    end;
  end;

  ThreadDestroy;
  RFAList.Clear;
  Title := EmptyStr;

  if Assigned(FArchive) then
    FArchive.Free;

  FArchive := nil;
  Save.Enabled := false;
  Defrag.Enabled := false;
  SaveDialog.FileName := EmptyStr;
  UpdateInfobar;

  Result := mrOk;
end;





function TRFAViewForm.LoadMap(Path : string) :boolean;
var
  Node: PVirtualNode;
begin
  Result := false;
  RFAList.BeginUpdate;

  if Reset(ASK_BEFORE_RESET) = mrCancel then
  begin
    // Do nothing
  end
    else
  begin
    if Assigned(FArchive) then
      FArchive.Free;

    FArchive := TRFAFile.Create;
    FArchive.OnReadEntry := ReadEntry;
    //FArchive.OnProgress := SubProgress;

    TotalProgress(roBegin, 0, 0);

    try
      if FArchive.Open(Path) = orFailed then
      begin
        ShowError('Archive opening error', 'This file is already used by another application');
        FreeAndNil(FArchive);
      end
        else
      begin
        Result := true;
      end;

      Node := RFAList.GetFirst;
      while Node <> nil do
      begin
        RFAList.Expanded[Node] := true;

        if Node.ChildCount > 1 then
          Break;

        Node := RFAList.GetNext(Node);
      end;
      Sort;
    finally
      TotalProgress(roEnd, 0, 0);
    end;

    if Result then
    begin
      UpdateInfobar;
    end;
  end;

  RFAList.EndUpdate;
end;


procedure TRFAViewForm.ShiftData(ShiftData: TRFAResult; ShiftWay : TShiftWay; IgnoreNode : PVirtualNode = nil);
var
  Node : PVirtualNode;
  Data : pFse;
begin
  Node := RFAList.GetFirst;

  while Node <> nil do
  begin
    Data := RFAList.GetNodeData(Node);
    if (Node <> IgnoreNode) and IsFile(Data.FileType) and (Data.Offset > ShiftData.offset) then
    begin
      if (ShiftWay = shLeft) then
      begin
        SendDebugFmt('Shift %s from 0x%.8x to 0x%.8x',[Data.W32Name, Data.Offset, Data.Offset - ShiftData.size]);
        Data.Offset := Data.Offset - ShiftData.size;
      end;

      if (ShiftWay = shRight) then
      begin
        SendDebugFmt('Shift %s from 0x%.8x to 0x%.8x',[Data.W32Name, Data.Offset, Data.Offset + ShiftData.size]);
        Data.Offset := Data.Offset + ShiftData.size;
      end;

      Data.RFAFileHandle.UpdateEntry(Data.EntryName, Data.Offset, Data.Size, Data.CompSize);
      RFAList.InvalidateNode(Node);
    end;
    Node := RFAList.GetNext(Node);
  end;
end;


procedure TRFAViewForm.SkinGroupSkinChange(Sender: TObject);
var
  i :integer;
begin
  for i := 0 to RFAList.Header.Columns.Count - 1 do
    RFAList.Header.Invalidate(RFAList.Header.Columns[i]);
    //RFAList.Header.Columns[i].ParentColorChanged;

  RFAList.Invalidate;
end;

function TRFAViewForm.LastOne(Offset: Int64): boolean;
var
  Node : PVirtualNode;
  Data : pFse;
  MaxOffset : int64;
begin
  MaxOffset := 0;
  Node := RFAList.GetFirst;

  while Node <> nil do
  begin
    Data := RFAList.GetNodeData(Node);
    if IsFile(Data.FileType) then
    begin
      MaxOffset := Max(MaxOffset, Data.Offset);
      if MaxOffset > Offset then
        break;
    end;
    Node := RFAList.GetNext(Node);
  end;

  Result := (MaxOffset = Offset);
end;

function TRFAViewForm.SaveMap(Path: string; Defrag : boolean = false): boolean;
var
  NextNode, Node : PVirtualNode;
  Data : pFse;
  DeleteResult, InsertResult : TRFAResult;
  ExternalFile : TFileStream;
  InternalFile : TMemoryStream;
  Size : int64;
  NewResult : integer;
  TmpArchive : TRFAFile;
  TmpFilename : string;
  TmpUseCompression : boolean;

begin
  Result := false;
  RemoveEmptyFolders;
  SyncAll;

  if CountFilesByStatus(RFAList.RootNode, [fsConflict], false) > 0 then
  begin
    ShowError('Name conflict', 'Some files are in conflict, please solve this before');
  end
    else
  begin
    RFAList.BeginUpdate;
    Cancel.Enabled := true;

    if Assigned(FArchive) and (FArchive.Filepath = Path) and not Defrag then
    begin
      if FArchive.ReadOnly then
      begin
        ShowError('Archive saving error', 'This file is already used by another application. Use "Save as" instead');
      end
        else
      begin
        TotalProgress(roBegin, 0, RFAList.TotalCount*3);

        /// Step-1 : First delete entries
        Node := RFAList.GetFirst;
        while Node <> nil do
        begin
          if not Cancel.Enabled then
            Break;

          NextNode := RFAList.GetNext(Node);
          Data := RFAList.GetNodeData(Node);

          if (fsDelete in Data.Status) and IsFile(Data.FileType) then
          begin
            DeleteResult := Data.RFAFileHandle.DeleteEntry(Data.EntryName);
            //ShiftData(DeleteResult, shLeft);
            RFAList.DeleteNode(Node);
          end;

          TotalProgress(roSave, PG_AUTO, RFAList.TotalCount*3);
          Node := NextNode;
        end;


        /// Step-2 : Update edited files
        Node := RFAList.GetFirst;
        while Node <> nil do
        begin
          if not Cancel.Enabled then
            Break;

          NextNode := RFAList.GetNext(Node);
          Data := RFAList.GetNodeData(Node);

          if (fsExternal in Data.Status) and IsFile(Data.FileType) then
          begin

            // if the file is the last one then remove it first
            if LastOne(Data.Offset) then
            begin
              DeleteResult := Data.RFAFileHandle.DeleteFile(Data.Offset, Data.CompSize);
              ShiftData(DeleteResult, shLeft, Node);
            end;

            ExternalFile := TFileStream.Create(Data.ExternalFilePath, fmOpenRead or fmShareDenyNone);
            Size := ExternalFile.Size;
            InsertResult := Data.RFAFileHandle.InsertFile(ExternalFile, FArchive.Compressed);
            ShiftData(InsertResult, shRight, Node);
            ExternalFile.Free;

            Data.RFAFileHandle.UpdateEntry(Data.EntryName, InsertResult.offset, Size, InsertResult.size);

            Exclude(Data.Status, fsExternal);
            Data.Size := Size;
            Data.Offset := InsertResult.offset;
            Data.Compressed := FArchive.Compressed;
            Data.CompSize := InsertResult.size;
            Data.ExternalMD5 := MD5FromFile(Data.ExternalFilePath);
            RFAList.InvalidateNode(Node);
          end;

          TotalProgress(roSave, PG_AUTO, RFAList.TotalCount*3);
          Node := NextNode;
        end;

        /// Step-3 : Add new files
        Node := RFAList.GetFirst;
        while Node <> nil do
        begin
          if not Cancel.Enabled then
            Break;

          NextNode := RFAList.GetNext(Node);
          Data := RFAList.GetNodeData(Node);

          if (fsNew in Data.Status) and IsFile(Data.FileType) then
          begin
            ExternalFile := TFileStream.Create(Data.ExternalFilePath, fmOpenRead or fmShareDenyNone);
            Size := ExternalFile.Size;
            InsertResult := FArchive.InsertFile(ExternalFile, FArchive.Compressed);
            ShiftData(InsertResult, shRight, Node);
            ExternalFile.Free;

            Data.EntryName := BuildEntryNameFromTree(Node);
            Data.RFAFileHandle := FArchive;
            Data.RFAFileHandle.InsertEntry(Data.EntryName, InsertResult.offset, Size, InsertResult.size, 0);

            Exclude(Data.Status, fsNew);
            Exclude(Data.Status, fsEntry);
            Data.Size := Size;
            Data.Offset := InsertResult.offset;
            Data.Compressed := FArchive.Compressed;
            Data.CompSize := InsertResult.size;
            Data.ExternalFilePath := EmptyStr;
            Data.ExternalMD5 := EmptyStr;
            RFAList.InvalidateNode(Node);
          end;

          TotalProgress(roSave, PG_AUTO, RFAList.TotalCount*3);
          Node := NextNode;
        end;

        /// Step-4 : Update modified entries
        Node := RFAList.GetFirst;
        while Node <> nil do
        begin
          if not Cancel.Enabled then
            Break;

          NextNode := RFAList.GetNext(Node);
          Data := RFAList.GetNodeData(Node);

          if (fsEntry in Data.Status) and IsFile(Data.FileType) then
          begin
            Data.RFAFileHandle.DeleteEntry(Data.EntryName);
            Data.EntryName := BuildEntryNameFromTree(Node);
            Data.RFAFileHandle.InsertEntry(Data.EntryName, Data.offset, Data.Size, Data.CompSize, 0);
            Exclude(Data.Status, fsEntry);
            RFAList.InvalidateNode(Node);
          end;

          TotalProgress(roSave, PG_AUTO, RFAList.TotalCount*3);
          Node := NextNode;
        end;

        /// Step-5 : Reset folder status
        Node := RFAList.GetFirst;
        while Node <> nil do
        begin
          NextNode := RFAList.GetNext(Node);
          Data := RFAList.GetNodeData(Node);
          if Data.FileType = ftFolder then
          begin
            Data.Status := [];
            RFAList.InvalidateNode(Node);
          end;
          Node := NextNode;
        end;

        TotalProgress(roEnd, PG_NULL, PG_NULL);
        UpdateInfobar;
        Result := true;
      end;
    end
      else
    begin
      TmpArchive := TRFAFile.Create;
      TmpArchive.OnProgress := SubProgress;

      if Assigned(FArchive) and Defrag then
      begin
        repeat
          TmpFilename := ExtractFilePath(Path) + RandomString('333333') + '.tmp';
        until not FileExists(TmpFilename);


        TmpUseCompression := FArchive.Compressed;
        NewResult := TmpArchive.New(TmpFilename, TmpUseCompression);
      end
      else
      begin
        TmpUseCompression := RFASettingsForm.UseCompression.Checked;
        NewResult := TmpArchive.New(Path, TmpUseCompression);
      end;

      if NewResult < 0 then
      begin
         ShowError('Archive saving error', 'This file is already used by another application');
         FreeAndNil(TmpArchive);
      end
        else
      begin
        TotalProgress(roBegin, 0, RFAList.TotalCount*4);

        /// Step-0 : Immediatly update all needed entries
        Node := RFAList.GetFirst;
        while Node <> nil do
        begin
          if not Cancel.Enabled then
            Break;

          NextNode := RFAList.GetNext(Node);
          Data := RFAList.GetNodeData(Node);

          if (fsEntry in Data.Status) and IsFile(Data.FileType) then
          begin
            Data.EntryName := BuildEntryNameFromTree(Node);
            Exclude(Data.Status, fsEntry);
          end;

          TotalProgress(roSave, PG_AUTO, PG_SAME);
          Node := NextNode;
        end;

        /// Step-1 : Add same files without lost data
        Node := RFAList.GetFirst;
        while Node <> nil do
        begin
          if not Cancel.Enabled then
            Break;

          NextNode := RFAList.GetNext(Node);
          Data := RFAList.GetNodeData(Node);

          if (Data.Status = []) and IsFile(Data.FileType) then
          begin
            //SendDebugFmt('File %s exported',[Data.W32Name]);
            InternalFile := TMemoryStream.Create;
            ExportFile(Node, InternalFile);
            Size := InternalFile.Size;
            InsertResult := TmpArchive.InsertFile(InternalFile, Data.Compressed);
            InternalFile.Free;
            TmpArchive.InsertEntry(Data.EntryName, InsertResult.offset, Size, InsertResult.size, 0);
          end;

          TotalProgress(roSave, PG_AUTO, PG_SAME);
          Node := NextNode;
        end;

        /// Step-2 : Add edited files
        Node := RFAList.GetFirst;
        while Node <> nil do
        begin
          if not Cancel.Enabled then
            Break;

          NextNode := RFAList.GetNext(Node);
          Data := RFAList.GetNodeData(Node);

          if (fsExternal in Data.Status) and IsFile(Data.FileType) then
          begin
            ExternalFile := TFileStream.Create(Data.ExternalFilePath, fmOpenRead or fmShareDenyNone);
            Size := ExternalFile.Size;
            InsertResult := TmpArchive.InsertFile(ExternalFile, TmpUseCompression);
            ExternalFile.Free;
            TmpArchive.InsertEntry(Data.EntryName, InsertResult.offset, Size, InsertResult.size, 0);
          end;

          TotalProgress(roSave, PG_AUTO, PG_SAME);
          Node := NextNode;
        end;

        /// Step-3 : Add new files
        Node := RFAList.GetFirst;
        while Node <> nil do
        begin
          if not Cancel.Enabled then
            Break;

          NextNode := RFAList.GetNext(Node);
          Data := RFAList.GetNodeData(Node);

          if (fsNew in Data.Status) and IsFile(Data.FileType) then
          begin
            ExternalFile := TFileStream.Create(Data.ExternalFilePath, fmOpenRead or fmShareDenyNone);
            Size := ExternalFile.Size;
            InsertResult := TmpArchive.InsertFile(ExternalFile, TmpUseCompression);
            ExternalFile.Free;
            TmpArchive.InsertEntry(Data.EntryName, InsertResult.offset, Size, InsertResult.size, 0);
          end;

          TotalProgress(roSave, PG_AUTO, PG_SAME);
          Node := NextNode;
        end;

        TotalProgress(roEnd, PG_NULL, PG_NULL);
        TmpArchive.Free;

        if Assigned(FArchive) and Defrag then
        begin
          if not (FArchive.ReadOnly and (FArchive.Filepath = Path)) then
            Reset;

          if DeleteFile(Path) then
            Result := RenameFile(TmpFilename, Path)
          else
            DeleteFile(TmpFilename);
        end
          else
        begin
          Result := true;
        end;

        if Result then
        begin
          OpenDialog.FileName := Path;
          CancelChange;
          QuickOpen;
        end
          else
        begin
          ShowError('Archive saving error', 'This file is already used by another application');
        end;

      end;
    end;

    RFAList.EndUpdate;
  end;

end;

procedure TRFAViewForm.SearchStartExecute(Sender: TObject);
begin
  if not tbMenuBar.Enabled then
    Exit;

  inherited;
end;

procedure TRFAViewForm.SettingsExecute(Sender: TObject);
begin
  if not tbMenuBar.Enabled then
    Exit;

  if RFASettingsForm.Showmodal = mrOk then
    RebuildEditWithMenu;
end;

procedure TRFAViewForm.UpdateInfobar;
begin
  if Assigned(FArchive) then
  begin
    ArchiveSize.Visible := true;
    ArchiveSize.Caption := Format('Archive = %s',[SizeToStr(FArchive.DataSize)]);

    if FArchive.Compressed then
      ArchiveSize.Caption := ArchiveSize.Caption + ' (c)';


    Fragmentation.Visible := true;
    Fragmentation.Caption := Format('Fragmentation = %s',[SizeToStr(FArchive.Fragmentation)]);

    ArchiveFileCount.Visible := true;
    ArchiveFileCount.Caption := Format('%d file(s)',[FArchive.Count]);
  end
    else
  begin
    ArchiveSize.Visible := false;
    Fragmentation.Visible := false;
    ArchiveFileCount.Visible := false;
    SelectionText.Visible := false;
  end;
end;


function TRFAViewForm.QuickOpen: boolean;
var
  WindowCaption : string;
begin
  if DebugHook <> 0 then
    Assert(FThread = nil);

  Result := false;
  if FileExists(OpenDialog.FileName) then
  begin
    // Loading file
    if LoadMap(OpenDialog.FileName) then
    begin
      AddToRecentList(OpenDialog.FileName);
      RebuildRecentList;
      SaveDialog.FileName := OpenDialog.FileName;
      CancelChange;
      WindowCaption := OpenDialog.FileName;
      if FArchive.ReadOnly then
        WindowCaption := WindowCaption + ' (Read-only)';

      Title := WindowCaption;
      Result := true;
    end;
  end
    else
  begin
    ShowError('Open error', Format('File (%s) not found', [OpenDialog.FileName]));
  end;
end;

function TRFAViewForm.QuickSave(Defragmentation: boolean): boolean;
begin
  if DebugHook <> 0 then
    Assert(FThread = nil);

  Result := false;
  if SaveMap(SaveDialog.FileName, Defragmentation) then
  begin
    OpenDialog.FileName := SaveDialog.FileName;
    AddToRecentList(SaveDialog.FileName);
    RebuildRecentList;
    CancelChange;
    Result := true;
  end
    else
  begin
    SaveDialog.FileName := OpenDialog.FileName;
  end;
end;


procedure TRFAViewForm.RevertExecute(Sender: TObject);
var
  Node: PVirtualNode;
  Data: pFse;
begin
  Node := RFAList.GetFirstSelected;

  while Node <> nil do
  begin
    Data := RFAList.GetNodeData(Node);
    Data.ExternalFilePath := EmptyStr;
    Node := RFAList.GetNextSelected(Node, true);
  end;
end;



function TRFAViewForm.EditInternal(ApplicationPath: string = ''): boolean;
var
  Node: PVirtualNode;
  Filepath : string;
begin
  Result := false;
  Node := RFAList.GetFirstSelected;
  if Node <> nil then
  begin
    Filepath := ExtractTemporary(Node);

    if not FileExists(ApplicationPath) then
      ApplicationPath := RFASettingsForm.GetProgramByExt(ExtractFileExt(Filepath));

    if FileExists(ApplicationPath) then
    begin
      Result := true;
      if FileExists(Filepath) then
        ShellExecute(Handle,'open',PChar(ApplicationPath), PChar(Filepath),nil,SW_SHOW);
    end;
  end;
end;

procedure TRFAViewForm.EditSelection;
begin
  case RFASettingsForm.DoubleClickOption.ItemIndex of
    0,1:
    begin
      EditWithOS.Execute;
    end;
    2:
    begin
      if not EditInternal then
        EditWithOS.Execute;
    end;
  end;
end;

procedure TRFAViewForm.EditByExtensionClick(Sender: TObject);
var
  Path : string;
begin
  if (Sender is TSpTBXItem) then
  begin
    Path := (Sender as TSpTBXItem).Hint;
    EditInternal(Path);
  end;
end;


procedure TRFAViewForm.EditWithOSExecute(Sender: TObject);
var
  Node: PVirtualNode;
  Data : pFse;
  Filepath : string;
begin
  Node := RFAList.GetFirstSelected;
  if Node <> nil then
  begin
    Data := RFAList.GetNodeData(Node);
    if IsFile(Data.FileType) then
    begin
      Filepath := ExtractTemporary(Node);
      ShellExecute(Handle,'open',PChar(Filepath),nil,nil,SW_SHOW);
    end;
  end;
end;

procedure TRFAViewForm.ExtractAllExecute(Sender: TObject);
begin
  RFAList.SelectAll(false);
  ExtractSelected.Execute;
end;

procedure TRFAViewForm.ExtractSelectedExecute(Sender: TObject);
begin
  if not Assigned(BrowseExtractForm) then
    Application.CreateForm(TBrowseExtractForm, BrowseExtractForm);

  if (BrowseExtractForm.ShowModal = mrOk) then
  begin
    ExtractTo(BrowseExtractForm.Directory, BrowseExtractForm.RecreateFullPath.Checked);
  end;
end;


procedure TRFAViewForm.ExtractTo(Directory: string; RecreatePath : boolean; List : TStringList = nil);
var
  Data : pFse;
  Node: PVirtualNode;
  ExternalFilePath : string;
  ExternFile : TFileStream;
  W32Path : string;
begin
  Cancel.Enabled := true;

  if Assigned(List) then
    List.Clear;

  TotalProgress(roBegin, PG_NULL, RFAList.SelectedCount);
  Node := RFAList.GetFirstSelected;
  RFAList.BeginUpdate;
  while Node <> nil do
  begin
    if not Cancel.Enabled then
      Break;

    ExtendSelection(Node);
    Data := RFAList.GetNodeData(Node);

    if IsFile(Data.FileType) then
    begin
      if not (fsNew in Data.Status) and not (fsDelete in Data.Status) and not (fsConflict in Data.Status) then
      begin
        if RecreatePath then
          W32Path := Data.W32Path
        else
        begin
          W32Path := BuildEntryNameFromTree(Node, true);
          W32Path := StringReplace(W32Path,'/','\',[rfReplaceAll]);
        end;

        ExternalFilePath := IncludeTrailingBackslash(Directory) + W32Path;
        ForceDirectories(ExtractFilePath(ExternalFilePath));

        if Assigned(List) then
        begin
          //SendDebug(ExternalFilePath);
          List.Add(ExternalFilePath);
        end;

        ExternFile := TFileStream.Create(ExternalFilePath, fmOpenWrite or fmCreate);
        ExportFile(Node, ExternFile);
        ExternFile.Free;
      end;
    end;

    TotalProgress(roExport, PG_AUTO, RFAList.SelectedCount);
    Node := RFAList.GetNextSelected(Node);
  end;
  RFAList.EndUpdate;
  TotalProgress(roEnd, PG_NULL, PG_NULL);
end;

procedure TRFAViewForm.DeleteSelection;
var
  Node, ExtendNode, NextNode: PVirtualNode;
  Data : pFse;
begin
  RFAList.BeginUpdate;

  /// In a first time, we semi-delete all selected files
  Node := RFAList.GetFirstSelected;
  while Node <> Nil do
  begin
    ExtendNode := Node;
    ExtendSelection(ExtendNode);

    NextNode := RFAList.GetNextSelected(Node, true);
    Data := RFAList.GetNodeData(Node);

    if IsFile(Data.FileType) and (Data.Size > 0) then
    begin
      if (fsNew in Data.Status) then
      begin
        RFAList.DeleteNode(Node);
      end
        else
      if (Data.Status = []) or (fsEntry in Data.Status) or (fsExternal in Data.Status) then
      begin
        Exclude(Data.Status, fsEntry);
        Exclude(Data.Status, fsExternal);
        Include(Data.Status, fsDelete);
        RFAList.FullyVisible[Node] := false;
        NotifyChange;
      end
    end;

    Node := NextNode;
  end;

  /// In a second time, we semi-delete all selected empty folders
  Node := RFAList.GetFirstSelected;
  while Node <> Nil do
  begin
    ExtendNode := Node;
    ExtendSelection(ExtendNode);

    NextNode := RFAList.GetNextSelected(Node, true);
    Data := RFAList.GetNodeData(Node);

    if (Data.FileType = ftFolder) and (CountFilesByStatus(Node, [fsNew, fsEntry, fsExternal], true) = 0) then
    begin
      /// We can jumped all selected children now
      NextNode := RFAList.GetNextSelected(Node, false);
      Include(Data.Status, fsDelete);
      RFAList.FullyVisible[Node] := false;
      NotifyChange;
    end;

    Node := NextNode;
  end;

  RFAList.EndUpdate;
end;

procedure TRFAViewForm.SyncAll;
var
  Node : PVirtualNode;
begin
  Node := RFAList.GetFirst;
  while Node <> nil do
  begin
    CheckStatus(Node);
    Node := RFAList.GetNext(Node, true);
  end;
end;


procedure TRFAViewForm.RebuildEditWithMenu;
var
  MenuItem : TSpTBXItem;
  Separator : TSpTBXSeparatorItem;
  Node : PVirtualNode;
  Data : pExtData;

  Icon: TIcon;
  FileInfo: SHFILEINFO;
begin
  EditWithMenuItem.Clear;
  ExtensionImageList.Clear;

  Node := RFASettingsForm.ExtList.GetFirst;
  while Node <> nil do
  begin
    Data := RFASettingsForm.ExtList.GetNodeData(Node);

    if FileExists(Data.Path) then
    begin
      MenuItem := TSpTBXItem.Create(EditWithMenuItem);
      MenuItem.Hint := Data.Path;
      MenuItem.Caption := ExtractFileName(Data.Path);
      MenuItem.OnClick := EditByExtensionClick;
      EditWithMenuItem.Add(MenuItem);

      Icon := TIcon.Create;
      SHGetFileInfo(PChar(Data.Path), 0, FileInfo, SizeOf(FileInfo), SHGFI_ICON or SHGFI_SMALLICON or SHGFI_SYSICONINDEX);
      Icon.Handle := FileInfo.hIcon;

      MenuItem.Images := ExtensionImageList;
      MenuItem.ImageIndex := ExtensionImageList.AddIcon(Icon);
      Icon.Free;
    end;

    Node := Node.NextSibling;
  end;

  Separator := TSpTBXSeparatorItem.Create(EditWithMenuItem);
  EditWithMenuItem.Add(Separator);

  MenuItem := TSpTBXItem.Create(EditWithMenuItem);
  MenuItem.Action := EditWithOS;
  EditWithMenuItem.Add(MenuItem);
end;

procedure TRFAViewForm.RebuildRecentList;
var
  MenuItem : TSpTBXItem;
  i :Integer;
begin
  RecentMenu.Clear;
  for i := 0 to RecentList.Lines.Count - 1 do
  begin
    MenuItem := TSpTBXItem.Create(RecentMenu);
    MenuItem.OnClick := OpenRecentClick;
    MenuItem.Caption := RecentList.Lines[i];
    RecentMenu.Add(MenuItem);
  end;
  RecentMenu.Enabled := (RecentMenu.Count > 0);
end;

procedure TRFAViewForm.AddToRecentList(Filename : string);
var
  Idx : Integer;
begin
  Idx := RecentList.Lines.IndexOf(OpenDialog.FileName);
  if RecentList.Lines.IndexOf(OpenDialog.FileName) >= 0 then
    RecentList.Lines.Delete(Idx);

  RecentList.Lines.Insert(0, OpenDialog.FileName);

  while RecentList.Lines.Count > 20 do
    RecentList.Lines.Delete(RecentList.Lines.Count-1);
end;

// http://stackoverflow.com/questions/3770109/how-do-you-drag-and-drop-a-file-from-explorer-shell-into-a-virtualtreeview-contr
procedure GetFileListFromObj(const DataObj: IDataObject; FileList: TStringList);
var
  FmtEtc: TFormatEtc;                   // specifies required data format
  Medium: TStgMedium;                   // storage medium containing file list
  DroppedFileCount: Integer;            // number of dropped files
  I: Integer;                           // loops thru dropped files
  FileNameLength: Integer;              // length of a dropped file name
  FileName: string;                     // name of a dropped file
begin
  // Get required storage medium from data object
  FmtEtc.cfFormat := CF_HDROP;
  FmtEtc.ptd := nil;
  FmtEtc.dwAspect := DVASPECT_CONTENT;
  FmtEtc.lindex := -1;
  FmtEtc.tymed := TYMED_HGLOBAL;
  OleCheck(DataObj.GetData(FmtEtc, Medium));
  try
    try
      // Get count of files dropped
      DroppedFileCount := DragQueryFile(Medium.hGlobal, $FFFFFFFF, nil, 0);
      // Get name of each file dropped and process it
      for I := 0 to Pred(DroppedFileCount) do
        begin
          // get length of file name, then name itself
          FileNameLength := DragQueryFile(Medium.hGlobal, I, nil, 0);
          SetLength(FileName, FileNameLength);
          DragQueryFileW(Medium.hGlobal, I, PWideChar(FileName), FileNameLength + 1);
          // add file name to list
          FileList.Append(FileName);
        end;
    finally
      // Tidy up - release the drop handle
      // don't use DropH again after this
      DragFinish(Medium.hGlobal);
    end;
  finally
    ReleaseStgMedium(Medium);
  end;

end;

procedure TRFAViewForm.RFAListDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  DropData: TStgMedium;
  FileList : TStringList;
  HitNode: PVirtualNode;
  AttachMode: TVTNodeAttachMode;

  SourceNode : PVirtualNode;
  TargetNode : PVirtualNode;
  Data : pFse;
  i: integer;
begin
  Data := nil;
  if (Source = nil) and not (DropFileSource.DragInProgress) then
  begin
    for i := 0 to High(formats) - 1 do
    begin
      if (Formats[i] = CF_HDROP) and Assigned(DataObject) then
      begin
        FileList := TStringList.Create;
        try
          GetFileListFromObj(DataObject, FileList);

          HitNode := Sender.GetNodeAt(Pt.X, Pt.Y);

          if (HitNode <> nil) and (HitNode <> Sender.RootNode) then
          begin
            Data := Sender.GetNodeData(HitNode);

            while IsFile(Data.FileType) do
            begin
              HitNode := HitNode.Parent;

              if (HitNode = nil) or (HitNode = Sender.RootNode) then
                Break
              else
                Data := Sender.GetNodeData(HitNode);
            end;
          end;

          Add(HitNode, FileList);
        finally
          FileList.Free;
        end;
      end;
    end;
  end
    else
  begin
    SourceNode := Sender.GetFirstSelected;
    TargetNode := Sender.DropTargetNode;

    case DragMode of
      dmManual: ;
      dmAutomatic: ;
    end;

    AttachMode := amNoWhere;
    case Mode of
      dmAbove:
        AttachMode := amInsertBefore;
      dmOnNode:
        AttachMode := amAddChildLast;
      dmBelow:
        AttachMode := amInsertAfter;
    end;

    if TargetNode = nil then
      TargetNode := Sender.RootNode
    else
      Data := Sender.GetNodeData(TargetNode);

    if (TargetNode = Sender.RootNode) or (Data.FileType = ftFolder) then
    begin
      while SourceNode <> nil do
      begin
        if not Sender.HasAsParent(TargetNode, SourceNode) then
          Sender.MoveTo(SourceNode,TargetNode, AttachMode,false);

        Sender.Selected[SourceNode] := false;
        SourceNode :=  Sender.GetFirstSelected;
      end;
    end

  end;

  Sort;
end;


procedure TRFAViewForm.RFAListDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
var
  TargetNode, SourceNode : PVirtualNode;
  Data : pFse;
begin
  Accept := false;
  TargetNode := Sender.DropTargetNode;

  if (TargetNode <> nil) and (TargetNode <> Sender.RootNode) then
  begin
  (*
    if Sender.HasAsParent(TargetNode, Sender.GetFirstSelected) then
      Exit;
   *)
    Data := Sender.GetNodeData(TargetNode);
    if IsFile(Data.FileType) then
      Exit;

    SourceNode := Sender.GetFirstSelected;
    while SourceNode <> nil do
    begin
      if SourceNode = TargetNode then
        Exit;
      SourceNode := Sender.GetNextSelected(SourceNode, true);
    end;

  end;

  if DropEmptySource.PerformedDropEffect <> 0 then
    Exit;

  if (Source = nil) or (Source = Sender) then
    Accept := true;
end;


procedure TRFAViewForm.RFAListEdited(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  if FEditResult = edInvalid then

  else if FEditResult = edOk then
  begin
    NotifyChange;
    Sort;
  end;
end;

procedure TRFAViewForm.RFAListKeyAction(Sender: TBaseVirtualTree; var CharCode: Word; var Shift: TShiftState; var DoDefault: Boolean);
begin
  inherited;
  if CharCode = VK_DELETE then
  begin
    DeleteSelection;
  end;
end;

procedure TRFAViewForm.RFAListMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if (ssCtrl in Shift) then
  begin
    if DragDetectPlus(Handle, Point(X, Y)) then
    begin
      PrepareDragList;
    end;
  end;

end;

procedure TRFAViewForm.RFAListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if RFAList.DragMode <> dmAutomatic then
  begin
    RFAList.DragMode := dmAutomatic;
  end;
end;

procedure TRFAViewForm.RFAListNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: string);
var
  Data : pFse;
begin
  FEditResult := edCancel;
  Data := Sender.GetNodeData(Node);
  if (NewText <> Data.W32Name) then
  begin
    if ValidFilename(NewText, false) then
    begin
      Data.W32Name := NewText;
      FEditResult := edOk;

      if (Data.FileType = ftFolder) then
        PropagateStatus(Node, fsEntry)
      else
        Include(Data.Status, fsEntry);
    end
      else
    begin
      FEditResult := edInvalid;
      Beep;
    end;
  end;
end;

procedure TRFAViewForm.RFAListNodeMoved(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data : pFse;
begin
  Data := RFAList.GetNodeData(Node);
  Include(Data.Status, fsEntry);
  NotifyChange;
end;

procedure TRFAViewForm.RFAListStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  (Sender as TBaseVirtualTree).CancelEditNode;
end;

procedure TRFAViewForm.RFAListStateChange(Sender: TBaseVirtualTree; Enter,
  Leave: TVirtualTreeStates);
begin
  inherited;
  //SelectionText.Caption := FormatDateTime('hh:nn:zz',now);

  if tsChangePending in Leave then
  begin
    SelectionText.Visible := Sender.SelectedCount > 0;

    if SelectionText.Visible then
    begin
      if Sender.SelectedCount = 1 then
        SelectionText.Caption := BuildEntryNameFromTree(Sender.GetFirstSelected)
      else
        SelectionText.Caption := Format('%d items in selection',[Sender.SelectedCount]);
    end;
  end;
(*
  if tsOLEDragging in Enter then
  begin
    SendDebug('tsOLEDragging');
  end;
*)

end;

procedure TRFAViewForm.RFAListDblClick(Sender: TObject);
var
  PreviewResult : boolean;
begin
  PreviewResult := false;
  if RFASettingsForm.DoubleClickOption.ItemIndex = 0 then
    PreviewResult := PreviewSelection;

  if not PreviewResult then
    EditSelection;
end;


procedure TRFAViewForm.RFAListBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  Data : pFse;
begin
  Data := RFAList.GetNodeData(Node);

  with TargetCanvas do
  begin
    Pen.Style := psClear;
    InflateRect(CellRect,1,1);

    Brush.Color := clNone;

    if (fsExternal in Data.Status) or (fsEntry in Data.Status)  then
      Brush.Color := $0093DCFF;

    if fsNew in Data.Status then
      Brush.Color := $0080FF80;

    if fsConflict in Data.Status then
      Brush.Color := $008080FF;

    if Brush.Color <> clNone then
      Rectangle(CellRect);
  end;
end;

procedure TRFAViewForm.RFAListDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  Data : pFse;
begin
  Data := RFAList.GetNodeData(Node);

  if (fsExternal in Data.Status)
  or (fsNew in Data.Status)
  or (fsConflict in Data.Status) then
    TargetCanvas.Font.Color := clBlack;

end;


procedure TRFAViewForm.DropFileSourceDrop(Sender: TObject; DragType: TDragType; var ContinueDrop: Boolean);
var
  List : TStringList;
  ExternalPath : string;
  i :integer;
begin
  DropFileSource.Files.Clear;
  //if DropFileSource.InShellDragLoop then
  if true then
  begin
    repeat
      ExternalPath := GetMapTempDirectory + RandomString('333333')
    until not DirectoryExists(ExternalPath);

    ExtractTo(ExternalPath, False);

    List := TStringList.Create;
    BuildFileList(IncludeTrailingPathDelimiter(ExternalPath)+'*', faAnyFile - faHidden, List);

    for i := 0 to List.Count - 1 do
      DropFileSource.Files.Add(IncludeTrailingPathDelimiter(ExternalPath) + List[i]);

    List.Free;
  end
    else
  begin
    ContinueDrop := false;
  end;
end;

procedure TRFAViewForm.DropEmptySourceAfterDrop(Sender: TObject;
  DragResult: TDragResult; Optimized: Boolean);
begin
  Status := dsDropComplete;
end;

procedure TRFAViewForm.DropEmptySourceDrop(Sender: TObject; DragType: TDragType;
  var ContinueDrop: Boolean);
begin
  // Warning:
  // This event will be called in the context of the transfer thread during an
  // asynchronous transfer. See TFormMain.OnProgress for a comment on this.
  Status := dsDrop;
end;

procedure TRFAViewForm.DropEmptySourceFeedback(Sender: TObject; Effect: Integer;
  var UseDefaultCursors: Boolean);
begin
  inherited;
  //UseDefaultCursors := false;
  //Effect := 0;
end;

procedure TRFAViewForm.DropEmptySourceGetData(Sender: TObject;
  const FormatEtc: tagFORMATETC; out Medium: tagSTGMEDIUM;
  var Handled: Boolean);
begin
  // Warning:
  // This event will be called in the context of the transfer thread during an
  // asynchronous transfer. See TFormMain.OnProgress for a comment on this.
  Status := dsGetData;
end;

procedure TRFAViewForm.SetStatus(const Value: TDragDropStage);
begin
  FStatus := Value;
end;

procedure TRFAViewForm.PrepareDragList;
var
  i : integer;
  Node : PVirtualNode;
  Data : pFse;
  W32Path : string;
begin
  Status := dsIdle;

  if DragDataFormatAdapter.Enabled then
  begin
    RFAList.DragMode := dmManual;
    Status := dsDrag;
    with TVirtualFileStreamDataFormat(DragDataFormatAdapter.DataFormat) do
    begin
      FileNames.Clear;
      i := 0;
      Node := RFAList.GetFirstSelected;
      while Node <> nil do
      begin
        ExtendSelection(Node);
        Data := RFAList.GetNodeData(Node);

        if IsFile(Data.FileType) then
        begin
          W32Path := BuildEntryNameFromTree(Node, true);
          W32Path := StringReplace(W32Path,'/','\',[rfReplaceAll]);

          FileNames.Add(W32Path);
          SendDebugFmt('Adding %s',[W32Path]);

          // Set the size and timestamp attributes of the filename we just added.
          with PFileDescriptor(FileDescriptors[i])^ do
          begin
            GetSystemTimeAsFileTime(ftLastWriteTime);
            nFileSizeLow := Data.Size and $00000000FFFFFFFF;
            nFileSizeHigh := (Data.Size and $FFFFFFFF00000000) shr 32;
            dwFlags := FD_WRITESTIME or FD_FILESIZE or FD_PROGRESSUI;
          end;

          SetLength(FDragNodes, i+1);
          FDragNodes[i] := Node;
          Inc(i);
        end;

        Node := RFAList.GetNextSelected(Node, true);
      end;
    end;

    DropEmptySource.Execute;
    Status := dsIdle;
  end;

end;

procedure TRFAViewForm.OnGetStream( Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer; out AStream: IStream);
var
  Filename : string;
  InternFile : TMemoryStream;
  Data : pFse;
begin
  SendDebugFmt('OnGetStream %d',[Index]);
  // Warning:
  // This method will be called in the context of the transfer thread during an
  // asynchronous transfer. See TFormMain.OnProgress for a comment on this.

  // This event handler is called by TFileContentsStreamOnDemandClipboardFormat
  // when the drop target requests data from the drop source (that's us).
  Status := dsGetStream;

  if FDragNodes[Index] <> nil then
  begin
    Data := RFAList.GetNodeData(FDragNodes[Index]);
    if IsFile(Data.FileType) then
    begin
      Filename := TVirtualFileStreamDataFormat(DragDataFormatAdapter.DataFormat).FileNames[Index];
      SendDebugFmt('OnGetStream %s',[Filename]);
      InternFile := TMemoryStream.Create;
      ExportFile(FDragNodes[Index], InternFile);
      AStream := TFixedStreamAdapter.Create(InternFile, soOwned);
      //InternFile.Free; // DO NOT FREE
    end
     else
    begin
      SendDebugFmt('Not extracted %d',[Index]);
      AStream := nil;
    end;
  end;

end;



procedure TRFAViewForm.DropFileSourceAfterDrop(Sender: TObject; DragResult: TDragResult; Optimized: Boolean);
begin
  DropFileSource.Files.Clear;
end;

procedure TRFAViewForm.DropFileSourceGetData(Sender: TObject; const FormatEtc: tagFORMATETC; out Medium: tagSTGMEDIUM; var Handled: Boolean);
begin
  if (FormatEtc.cfFormat = CF_HDROP) then
  begin

  end;
end;


procedure TRFAViewForm.UpdateReply(Sender: TObject; Result: TUpdateResult);
begin
  NewVersionAvailable.Enabled := true;
  if Result = rs_UpdateFound then
  begin
    if not NewVersionAvailable.Visible then
    begin
      NewVersionAvailable.Visible := true;
      NewVersionAvailable.Execute;
    end
    else
      NewVersionAvailable.Visible := true;
  end
    else
  begin
    NewVersionAvailable.Visible := false;
  end;
end;



{ TRFAViewForm }


procedure TRFAViewForm.FormCreate(Sender: TObject);
begin
  inherited;
  // Setup event handler to let a drop target request data from our drop source.
  (DragDataFormatAdapter.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream;

  EnableSkinning(RFAList);
  Reset;

  ThreadCreate;
end;


procedure TRFAViewForm.FileAssociationExecute(Sender: TObject);
var
  Result : boolean;
begin
  inherited;
  Result :=  RunAsAdmin(Self.Handle, Application.ExeName, BGA_FILE_ASSOCIATION_REQUEST);
  if not Result then
    ShowError('File association', 'RFA files cannot be associated with BGA');
end;

procedure TRFAViewForm.FilesystemExecute(Sender: TObject);
begin
  //FSViewForm.Showmodal;  // Disabled
end;

procedure TRFAViewForm.FormActivate(Sender: TObject);
begin
  inherited;
  ActiveControl := RFAList;
  ApplicationRun.Execute;
end;

procedure TRFAViewForm.FormDestroy(Sender: TObject);
begin
  ThreadDestroy;

  if Assigned(FArchive) then
    FArchive.Free;

  inherited;
end;


procedure TRFAViewForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Result : TModalResult;
begin
  inherited;
  if Save.Enabled or (CountFilesByStatus(RFAList.RootNode, [fsNew], false) > 0) then
  begin
    Result := ShowDialog('Close', 'Save changes before exiting?', mtInformation, mbYesNoCancel, mbCancel, 0);
    case Result of
      mrYes : SaveAs.Execute;
      mrCancel: CanClose := false;
    end;
  end;

  if CanClose then
  begin
    Theme.Text := SkinManager.CurrentSkinName;
    FormStorage.SaveFormPlacement;

    if DirectoryExists(GetMapTempDirectory) then
      DeleteDirectory(GetMapTempDirectory, false);
  end;
end;

procedure TRFAViewForm.OpenRecentClick(Sender: TObject);
begin
  if (Sender is TSpTBXItem) then
  begin
    OpenDialog.FileName := (Sender as TSpTBXItem).Caption;
    ThreadDestroy;
    try
      QuickOpen;
    finally
      ThreadCreate;
    end;
  end;
end;


procedure TRFAViewForm.OpenExecute(Sender: TObject);
begin
  if not tbMenuBar.Enabled then
    Exit;

  if OpenDialog.FileName = EmptyStr then
    OpenDialog.FileName := ExtractFilePath(Application.ExeName);

  OpenDialog.InitialDir := ExtractFilePath(OpenDialog.FileName);
  OpenDialog.FileName := ExtractFileName(OpenDialog.FileName);
  if OpenDialog.Execute then
  begin
    ThreadDestroy;
    try
      QuickOpen;
    finally
      ThreadCreate;
    end;
  end;
end;

procedure TRFAViewForm.CancelChange;
begin
  Save.Enabled := false;
  if Assigned(FArchive) then
    Defrag.Enabled := FArchive.Fragmentation > 0
  else
    Defrag.Enabled := false;
end;

procedure TRFAViewForm.NotifyChange;
begin
  if Assigned(FArchive) then
  begin
    Save.Enabled := true; // and not FArchive.ReadOnly
    Defrag.Enabled := true;
  end;
end;

procedure TRFAViewForm.SaveAsExecute(Sender: TObject);
var
  UseDefrag : boolean;
begin
  UseDefrag := false;
  SaveDialog.InitialDir := ExtractFilePath(SaveDialog.FileName);
  SaveDialog.FileName := ExtractFileName(SaveDialog.FileName);

  ThreadDestroy;
  try
    if SaveDialog.Execute then
    begin
      if OpenDialog.FileName = SaveDialog.FileName then
        UseDefrag := true;

      if QuickSave(UseDefrag) then
      begin
        //Save.Enabled := false;
        //Defrag.Enabled := false;
      end;
    end;
  finally
    ThreadCreate;
  end;
end;

procedure TRFAViewForm.SaveExecute(Sender: TObject);
begin
  if not tbMenuBar.Enabled then
    Exit;

  ThreadDestroy;
  try
    QuickSave(false);
  finally
    ThreadCreate;
  end;
end;

procedure TRFAViewForm.DefragExecute(Sender: TObject);
begin
  if not tbMenuBar.Enabled then
    Exit;

  ThreadDestroy;
  try
    QuickSave(true);
  finally
    ThreadCreate;
  end;
end;

procedure TRFAViewForm.QuitExecute(Sender: TObject);
begin
  if not tbMenuBar.Enabled then
    Exit;

  //Application.Terminate;
  Close;
end;


procedure TRFAViewForm.CancelExecute(Sender: TObject);
begin
  Cancel.Enabled := false;
end;

procedure TRFAViewForm.NewExecute(Sender: TObject);
begin
  if not tbMenuBar.Enabled then
    Exit;

  Reset(true);
end;

procedure TRFAViewForm.NewFolderExecute(Sender: TObject);
var
  Node : pVirtualNode;
  Data : pFse;
begin

  Data := nil;
  Node := RFAList.GetFirstSelected;
  while Node <> nil do
  begin
    Data := RFAList.GetNodeData(Node);
    if not IsFile(Data.FileType) then
      Break;
    Node := RFAList.NodeParent[Node];
  end;

  if (Node = nil) or not IsFile(Data.FileType) then
  begin
    Node := RFAList.AddChild(Node);
    Data := RFAList.GetNodeData(Node);
    //Data.W32Path := Filename;
    //Data.W32Name := ExtractFileName(Filename);
    Data.W32Name := 'New folder';
    Data.FileType := ftFolder;
    Sort;
    RFAList.EditNode(Node,0);
  end;
end;

procedure TRFAViewForm.AboutExecute(Sender: TObject);
begin
  if not Assigned(AboutForm) then
    Application.CreateForm(TAboutForm, AboutForm);

  AboutForm.Showmodal;
end;


procedure TRFAViewForm.RecentExecute(Sender: TObject);
begin
//
end;


procedure TRFAViewForm.PackDirectoryExecute(Sender: TObject);
var
  FileDrive : string;
  BasePath : string;
  Node : PVirtualNode;
begin

  if not Assigned(BrowsePackForm) then
    Application.CreateForm(TBrowsePackForm, BrowsePackForm);

  if (BrowsePackForm.ShowModal = mrOk) then
    if DirectoryExists(BrowsePackForm.Directory) then
    begin

      if Reset(ASK_BEFORE_RESET) = mrCancel then
      begin
        Exit;
      end;

      Node := RFAList.RootNode;

      if BrowsePackForm.UseBasePath.Checked then
      begin
        BasePath := StringReplace(BrowsePackForm.Base.Text,'/','\',[rfReplaceAll]);
        BasePath := IncludeTrailingBackslash(BasePath);
        FileDrive := ExtractFileDrive(BasePath);

        if FileDrive <> EmptyStr then
          BasePath := SFRight(FileDrive, BasePath);

        if not ValidDirectoryname(BasePath) then
        begin
          ShowMessage('Base path error', Format('Base file path (%s) is invalid',[BasePath]));
          Exit;
        end;

        Node := GetBuildPath(BasePath);
      end;

      Add(Node, nil, BrowsePackForm.Directory);
    end;
end;



procedure TRFAViewForm.PreviewExecute(Sender: TObject);
begin
  if not tbMenuBar.Enabled then
    Exit;

  inherited;
end;

procedure TRFAViewForm.PreviewRAWExecute(Sender: TObject);
var
  TerrainNode : PVirtualNode;
  TerrainFile : string;
begin
  if not tbMenuBar.Enabled then
    Exit;

  (*
  ShowMessage('RAW Preview', 'Preview is disabled for this version, please wait for an update');
  Exit;
  *)

  TerrainNode := FindFileByName('Terrain.con');

  if (TerrainNode <> nil) then
  begin
    PreviewRAW.Enabled := false;
    TerrainFile := ExtractTemporary(TerrainNode);

    {$IfDef OPENGL_SUPPORT}
      if not Assigned(MapViewForm) then
        Application.CreateForm(TMapViewForm, MapViewForm);

      MapViewForm.GetFileByPath := GetFileByPath;
      MapViewForm.LoadTerrain(TerrainFile);
      MapViewForm.Show;
    {$Else}
      WarnAboutOpenGL;
    {$EndIf}
    PreviewRAW.Enabled := true;
  end
    else
      ShowWarning('RAW Preview', 'Terrain data not found in this archive');

end;



procedure TRFAViewForm.NewVersionAvailableExecute(Sender: TObject);
begin
  UpdateManagerForm.ShowModal;
end;



procedure TRFAViewForm.SubProgress(Sender: TRFAFile; Operation: TRFAOperation; Value: Integer);
begin
  if Operation = roBegin then
  begin
    SubProgressBar.Position := 0;
    SubProgressBar.Max := Value;
  end
else
  begin
    if Value = PG_AUTO then
      SubProgressBar.Position := SubProgressBar.Position+1
    else
      SubProgressBar.Position := Value;
  end;

  Application.ProcessMessages;
end;


procedure TRFAViewForm.ThreadCreate;
begin
  DebugItem.Color := clLime;
  if DebugHook <> 0 then
    Assert(FThread = nil);

  if not Assigned(FThread) then
    FThread := TSyncThread.Create(False, Self, 'SyncThread');
end;

procedure TRFAViewForm.ThreadDestroy;
var
  Diff: Cardinal;
begin
  DebugItem.Color := clRed;
  if Assigned(FThread) then
  begin
    Diff := GetTickCount;
    FThread.Terminate;
    if not FThread.Suspended then
    begin
      Assert(FThread.Terminated);
      FThread.WaitFor;
      FThread.Free;
    end;
    FThread := nil;
    SendDebugFmt('SyncThread destroyed in %dms',[GetTickCount-Diff]);
  end;
end;

procedure TRFAViewForm.TotalProgress(Operation: TRFAOperation; Value: Integer; Max:integer);
begin
  if TotalProgressLabel.Tag <> Ord(Operation) then
  begin
    case Operation of
      roLoad: TotalProgressLabel.Caption := 'Loading';
      roSave: TotalProgressLabel.Caption := 'Saving';
      roExport: TotalProgressLabel.Caption := 'Exporting';
        else
      TotalProgressLabel.Caption := EmptyStr;
    end;

    TotalProgressLabel.Tag := Ord(Operation);
  end;

  if Operation = roBegin then
  begin
    ProgressPanel.Show;
    tbMenuBar.Enabled := false;
    TotalProgressBar.Position := 0;
    TotalProgressBar.Max := Max;
    //SubProgressBar.Position := 0;
  end
    else
  if Operation = roEnd then
  begin
    ProgressPanel.Hide;
    tbMenuBar.Enabled := true;
  end
    else
  begin
    if Max <> PG_SAME then
      TotalProgressBar.Max := Max;

    if Value = PG_AUTO then
      TotalProgressBar.Position := TotalProgressBar.Position+1
    else
      TotalProgressBar.Position := Value;
  end;

  Application.ProcessMessages;
end;

{ TSyncThread }

constructor TSyncThread.Create(CreateSuspended: boolean; Gui: TRFAViewForm; Name: string);
begin
  inherited Create(CreateSuspended);

  FreeOnTerminate:=false;
  Priority:=tpNormal;
  FGui := Gui;
  FName := Name;
  FSyncNode := nil;
end;

destructor TSyncThread.Destroy;
begin

  inherited;
end;

procedure TSyncThread.Execute;
begin
  inherited;
  NameThreadForDebugging(FName);

  repeat
    if not FGui.OperationPending then
    begin
      Sleep(10);
      if Assigned(FGui.FArchive) then
      begin
        if (FSyncNode = nil) then
          FSyncNode := FGui.RFAList.GetFirst
        else
          FSyncNode := FGui.RFAList.GetNext(FSyncNode, true);

        if FGui.CheckStatus(FSyncNode) then
          Synchronize(Invalidate);
      end;
    end;
  until
    Terminated;

  FSyncNode := nil;
end;

procedure TSyncThread.Invalidate;
begin
  FGui.RFAList.InvalidateNode(FSyncNode);
  FGui.NotifyChange;
end;

end.
