unit GLFileSM;

interface


uses
  Classes, SysUtils, GLVectorFileObjects, ApplicationFileIO, FileSM, TypesSM;

type
   // TGLSMVectorFile
   //
   {: The SM vector file (Refractor2 standard mesh).<p>
      }
  TGLSMVectorFile = class(TVectorFile)
  public
     { Public Declarations }
     class function Capabilities : TDataFileCapabilities; override;
     procedure LoadFromStream(aStream : TStream); override;
  end;

  TSMMeshType =
  (
    mtNone,
    mtCollision,
    mtLod
  );

  TGLSMMeshObject = class (TMeshObject)
  private
    function GetMeshType: TSMMeshType;
  public
    property MeshType : TSMMeshType read GetMeshType;
  end;


  TGLSMColMeshObject = class(TGLSMMeshObject)
  private

  public

  end;

  TGLSMLodMeshObject = class(TGLSMMeshObject)
  private
    FTexturePath: string;
    FParentMeshID: integer;

  public
    property TexturePath : string read FTexturePath;
    property ParentMeshID : integer read FParentMeshID;
  end;

implementation

uses
  Dbugintf, VectorTypes;


// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------
{ TGLSMVectorFile }

class function TGLSMVectorFile.Capabilities: TDataFileCapabilities;
begin
   Result:=[dfcRead];
end;

procedure TGLSMVectorFile.LoadFromStream(aStream: TStream);
var
   i, j, k : Integer;
   SMFile : TFileSM;
   ColMesh : TGLSMColMeshObject;
   LodMesh : TGLSMLodMeshObject;
   Mat : TMatrix3f;
begin
  inherited;
  SMFile:=TFileSM.Create;
  SMFile.LoadFromStream(aStream);

  try

    if SMFile.CollMeshCount > 0 then
    begin
      // retrieve ColMesh data
      for i := 0 to SMFile.CollMeshCount - 1 do
      begin
        ColMesh := TGLSMColMeshObject.CreateOwned(Owner.MeshObjects);

        for j:=0 to SMFile.CollMeshes[i].FaceCount-1 do
        begin
          Mat := SMFile.CollVertexFromFaceId(i, j);

          ColMesh.Vertices.Add(Mat[0]);
          ColMesh.Vertices.Add(Mat[1]);
          ColMesh.Vertices.Add(Mat[2]);
        end;

        //SendDebugFmt('Current Mesh.Vertices.Capacity is %d',[ColMesh.Vertices.Capacity]);
        //SendDebugFmt('Current Mesh.TriangleCount is %d',[ColMesh.TriangleCount]);
      end;
    end;

    if SMFile.MeshCount > 0 then
    begin
      // retrieve LodMesh data
      for i := 0 to SMFile.MeshCount - 1 do
      begin
        for j:=0 to SMFile.Meshes[i].LodMeshCount-1 do
        begin
          LodMesh := TGLSMLodMeshObject.CreateOwned(Owner.MeshObjects);
          LodMesh.FTexturePath := SMFile.Meshes[i].LodMeshes[j].Material.Name;
          LodMesh.FParentMeshID := i;

          for k:=0 to SMFile.Meshes[i].LodMeshes[j].MeshData.FaceCount-1 do
          begin
            Mat := SMFile.MeshVertexFromLodFaceId(i, j, k);

            LodMesh.Vertices.Add(Mat[0]);
            LodMesh.Vertices.Add(Mat[1]);
            LodMesh.Vertices.Add(Mat[2]);
          end;

          //SendDebugFmt('Current Mesh.Vertices.Capacity is %d',[LodMesh.Vertices.Capacity]);
          //SendDebugFmt('Current Mesh.TriangleCount is %d',[LodMesh.TriangleCount]);
        end;
      end;
    end;

  finally
    SMFile.Free;
  end;
end;



{ TGLSMMeshObject }

function TGLSMMeshObject.GetMeshType: TSMMeshType;
begin
  if Self is TGLSMColMeshObject then
    result := mtCollision
  else
  if Self is TGLSMLodMeshObject then
    result := mtLod
  else
    result := mtNone
end;

initialization
// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------

  RegisterVectorFileFormat('sm', 'Battlefield 1942 standardmesh files', TGLSMVectorFile);

end.
