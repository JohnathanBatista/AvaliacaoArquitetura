unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Datasnap.DBClient;

type
  TfrmPrincipal = class(TForm)
    dbgrdNos: TDBGrid;
    btnConverter: TButton;
    tvArvore: TTreeView;
    cdsNos: TClientDataSet;
    dsNoz: TDataSource;
    cdsNosCODIGO_NO_PAI: TIntegerField;
    cdsNosCODIGO_PAI: TIntegerField;
    cdsNosDESCRICAO_NO: TStringField;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConverterClick(Sender: TObject);
  private
    procedure ConverterNodes(pTreeView: TTreeView);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnConverterClick(Sender: TObject);
begin
   try
      ConverterNodes(tvArvore);
   except
      on E: Exception do
      begin
         Application.MessageBox(pChar(('Erro ao converter. ' + E.Message)), 'ERRO', MB_OK + MB_ICONERROR);
      end;
   end
end;

procedure TfrmPrincipal.ConverterNodes(pTreeView: TTreeView);
var
   lNodePrincipal: TTreeNode;

   procedure CarregaNodesFilhos(var pNodePai: TTreeNode);
   var
      Marca: TBookMark; lNodeFilho: TTreeNode;
   begin
      Marca := cdsNos.GetBookMark;
      try
         while not cdsNos.EOF  do
         begin
            lNodeFilho := pTreeView.Items.AddChildObject(pNodePai, cdsNosDESCRICAO_NO.Value, Pointer(cdsNos.RecNo));
            lNodeFilho.SelectedIndex := lNodeFilho.ImageIndex;
            //CarregaNodesFilhos(lNodeFilho, cdsNosCODIGO_PAI.AsString);
            cdsNos.Next;
         end;
      finally
         cdsNos.GoToBookMark(Marca);
      end;
   end;

begin
   pTreeView.Items.BeginUpdate;
   pTreeView.Items.Clear;
   cdsNos.First;
   while not cdsNos.EOF do
   begin
      if (not cdsNosCODIGO_NO_PAI.IsNull) then
      begin
         lNodePrincipal := pTreeView.Items.AddObject(nil, cdsNosCODIGO_NO_PAI.AsString, Pointer(cdsNos.RecNo));
         lNodePrincipal.SelectedIndex := lNodePrincipal.ImageIndex;
         CarregaNodesFilhos(lNodePrincipal);
      end;

      cdsNos.Next;
   end;
   pTreeView.AlphaSort;
   pTreeView.Items.EndUpdate;
end;

procedure TfrmPrincipal.FormResize(Sender: TObject);
begin
   //Deixar a tela mais bem dividida, sempre com o bot�o no centro
   if IsZoomed(frmPrincipal.Handle) then
   begin
      dbgrdNos.Height := Trunc(Screen.WorkAreaHeight / 2) - btnConverter.Height;
   end
   else
   begin
      dbgrdNos.Height := Trunc(frmPrincipal.Height / 2) - btnConverter.Height;
   end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
   lInserir: Boolean;
   lNode: Integer;
begin
   lNode := 1;
   lInserir := True;
   while lInserir do
   begin
      cdsNos.Append;
      cdsNosCODIGO_PAI.AsInteger := lNode;
      cdsNos.Post;

      if cdsNos.RecNo = 10 then
      begin
         lInserir := False;
      end;
      inc(lNode);
   end;
   cdsNos.Edit;
end;

end.
