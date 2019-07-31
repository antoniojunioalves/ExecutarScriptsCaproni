unit CopiarExecutarScripts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellApi;

type
  TForm1 = class(TForm)
    edtOrigem: TEdit;
    lblOrigem: TLabel;
    btnCopiar: TButton;
    btnExecutar: TButton;
    mmoListaScripts: TMemo;
    procedure btnCopiarClick(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
    procedure CopiarScripts(psOrigem: string);
    procedure ExecutarScripts;
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}
const
  s_CAPRONI_BIN_DB2 = 'C:\CAPRONI_CMD\BIN_DB2\';
  s_CAPRONI_BIN_ORACLE = 'C:\CAPRONI_CMD\BIN_ORACLE\';
  s_CAPRONI_BIN_SQLSERVER = 'C:\CAPRONI_CMD\BIN_SQLSERVER\';

{ TForm1 }
procedure TForm1.btnCopiarClick(Sender: TObject);
begin
  CopiarScripts(edtOrigem.Text);
end;

procedure TForm1.btnExecutarClick(Sender: TObject);
begin
  ExecutarScripts;
end;

procedure TForm1.CopiarScripts(psOrigem: string);
var
  i: Integer;
  sScript: string;
  sListaDbChangeXML: TStringList;
  sOrigemDB2: string;
  sOrigemORACLE: string;
  sOrigemSQLSERVER: string;
  sDestinoDB2: string;
  sDestinoORACLE: string;
  sDestinoSQLSERVER: string;
begin
  if mmoListaScripts.Lines[0] = 'Informar o nome do script DH4' then
  begin
    ShowMessage('Informe os nomes dos scripts corretamente');
    Exit;
  end;

  psOrigem := Trim(psOrigem);

  if Copy(psOrigem, Length(psOrigem) - 2, Length(psOrigem)) <> PathDelim then
    psOrigem := psOrigem + PathDelim;

  sOrigemDB2 := psOrigem + 'DB2\';
  sOrigemORACLE := psOrigem + 'ORACLE\';
  sOrigemSQLSERVER := psOrigem + 'SQLSERVER\';

  sDestinoDB2 := s_CAPRONI_BIN_DB2 + 'INPUT\SG\';
  sDestinoORACLE := s_CAPRONI_BIN_ORACLE + 'INPUT\SG\';
  sDestinoSQLSERVER := s_CAPRONI_BIN_SQLSERVER + 'INPUT\SG\';

  sListaDbChangeXML := TStringList.Create;
  try
    sListaDbChangeXML.Add('<?xml version="1.0" encoding="UTF-8"?>');
    sListaDbChangeXML.Add('<havillan>');

    for i := 0 to mmoListaScripts.Lines.Count -1 do
    begin
      sScript := Trim(mmoListaScripts.Lines[i]);

      if sScript.IsEmpty then
        Continue;

      sListaDbChangeXML.Add('<script a_name="' + sScript + '" version="99.99.99" x_has_pos="false" z_description="Execucao automatica"/>');

      CopyFile(PWideChar(sOrigemDB2 + sScript), PWideChar(sDestinoDB2 + sScript), True);
      CopyFile(PWideChar(sOrigemORACLE + sScript), PWideChar(sDestinoORACLE + sScript), True);
      CopyFile(PWideChar(sOrigemSQLSERVER + sScript), PWideChar(sDestinoSQLSERVER + sScript), True);
    end;

    sListaDbChangeXML.Add('</havillan>');

    sListaDbChangeXML.SaveToFile(sDestinoDB2 + 'dbChange.xml');
    sListaDbChangeXML.SaveToFile(sDestinoORACLE + 'dbChange.xml');
    sListaDbChangeXML.SaveToFile(sDestinoSQLSERVER + 'dbChange.xml');
  finally
    FreeAndNil(sListaDbChangeXML);
  end;
end;

procedure TForm1.ExecutarScripts;
var
  sComando: string;
  sLista: TStringList;
  sNomeArquivoComando: string;
begin
  sLista := TStringList.Create;
  try
//    sNomeArquivoComando := ExtractFileDir(GetCurrentDir);
    sNomeArquivoComando := ExtractFilePath(Application.ExeName);

    sLista.Clear;
    sComando := s_CAPRONI_BIN_DB2 + 'capronica3.exe -is';
    sLista.Add(sComando);
    sLista.Add('pause');
    sLista.SaveToFile(sNomeArquivoComando + '\ComandoDB2.bat');

    sLista.Clear;
    sComando := s_CAPRONI_BIN_ORACLE + 'capronica3.exe -is';
    sLista.Add(sComando);
    sLista.Add('pause');
    sLista.SaveToFile(sNomeArquivoComando + '\ComandoORACLE.bat');

    sLista.Clear;
    sComando := s_CAPRONI_BIN_SQLSERVER + 'capronica3.exe -is';
    sLista.Add(sComando);
    sLista.Add('pause');
    sLista.SaveToFile(sNomeArquivoComando + '\ComandoSQLSERVER.bat');

    ShellExecute(handle, 'open', PChar(sNomeArquivoComando + '\ComandoDB2.bat'), '', '', SW_SHOWNORMAL);
    ShellExecute(handle, 'open', PChar(sNomeArquivoComando + '\ComandoORACLE.bat'), '', '', SW_SHOWNORMAL);
    ShellExecute(handle, 'open', PChar(sNomeArquivoComando + '\ComandoSQLSERVER.bat'), '', '', SW_SHOWNORMAL);
  finally
    FreeAndNil(sLista);
  end;
end;

end.
