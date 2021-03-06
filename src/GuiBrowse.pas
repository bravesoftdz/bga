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
 * The Original Code is GuiBrowse (http://code.google.com/p/bga)
 *
 * The Initial Developer of the Original Code is
 * Yann Papouin <yann.papouin at @ gmail.com>
 *
 * ***** END LICENSE BLOCK ***** *)

unit GuiBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvBaseDlg, JvBrowseFolder, StdCtrls, SpTBXEditors, JvComponentBase, JvFormPlacement, ActnList, SpTBXItem, SpTBXControls, ExtCtrls,
  TB2Item, SpTBXTabs;

type
  TBrowseForm = class(TForm)
    Browse: TJvBrowseForFolderDialog;
    Folder: TSpTBXButtonEdit;
    Recents: TSpTBXListBox;
    FormStorage: TJvFormStorage;
    Actions: TActionList;
    Ok: TAction;
    Cancel: TAction;
    ButtonOk: TSpTBXButton;
    ButtonCancel: TSpTBXButton;
    Footer: TPanel;
    SpTBXLabel1: TSpTBXLabel;
    SpTBXLabel2: TSpTBXLabel;
    Background: TSpTBXPanel;
    procedure OkExecute(Sender: TObject);
    procedure CancelExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditFolder(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FolderChange(Sender: TObject);
    procedure RecentsClick(Sender: TObject);
    procedure RecentsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function GetDirectory: string;
    procedure SetDirectory(const Value: string);
    { Déclarations privées }
  public
    { Déclarations publiques }
    property Directory : string read GetDirectory write SetDirectory;
  end;

var
  BrowseForm: TBrowseForm;

implementation

{$R *.dfm}

uses
  GuiRFAView, Resources;


procedure TBrowseForm.FormActivate(Sender: TObject);
begin
  ActiveControl := ButtonOk;
end;

procedure TBrowseForm.FormShow(Sender: TObject);
begin
  if Recents.Items.Count > 0 then
  begin
    Folder.Text := Recents.Items[0];
  end;
end;


procedure TBrowseForm.CancelExecute(Sender: TObject);
begin
  FormStorage.RestoreFormPlacement;
  ModalResult := mrCancel;
  //Close;
end;

procedure TBrowseForm.OkExecute(Sender: TObject);
begin
  if Recents.Items.IndexOf(Folder.Text) < 0 then
    Recents.Items.Insert(0, Folder.Text);

  FormStorage.SaveFormPlacement;
  ModalResult := mrOk;
  //Close;
end;

procedure TBrowseForm.FolderChange(Sender: TObject);
begin
  //Change color if directory valid
  if DirectoryExists(Folder.Text) then
  begin
    //Folder.Font.Color := clBlack;
    Folder.ParentFont := true;
  end
  else
    Folder.Font.Color := clRed;
end;

procedure TBrowseForm.EditFolder(Sender: TObject);
begin
  Browse.Directory := ((Sender as TControl).Parent as TSpTBXButtonEdit).Text;
  if Browse.Execute then
  begin
    ((Sender as TControl).Parent as TSpTBXButtonEdit).Text := Browse.Directory;
  end;
end;

procedure TBrowseForm.RecentsClick(Sender: TObject);
var
  i :integer;
begin
  for i := 0 to Recents.Count - 1 do
  if Recents.Selected[i] then
  begin
    Folder.Text := Recents.Items[i];
    Break;
  end;
end;


procedure TBrowseForm.RecentsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i :integer;
begin
  if key = VK_DELETE then

  for i := Recents.Count-1 downto  0 do
  if Recents.Selected[i] then
  begin
    Recents.Items.Delete(i);
  end;
end;

function TBrowseForm.GetDirectory: string;
begin
  Result := Folder.Text;
end;

procedure TBrowseForm.SetDirectory(const Value: string);
begin
  Folder.Text := Value;
end;

end.
