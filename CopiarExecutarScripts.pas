unit CopiarExecutarScripts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellApi,
  IniFiles;

type
  TForm1 = class(TForm)
    edtOrigem: TEdit;
    lblOrigem: TLabel;
    btnCopiar: TButton;
    btnExecutar: TButton;
    mmoListaScripts: TMemo;
    procedure btnCopiarClick(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
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
  s_CAPRONI_BIN_POSTGRESQL = 'C:\CAPRONI_CMD\BIN_POSTGRESQL\';
  s_INI_TELA = 'TELA';
  s_INI_ORIGEM_SCRIPT = 'ORIGEM_SCRIPT';

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
  oListaDbChangeXML: TStringList;
  sOrigemDB2: string;
  sOrigemORACLE: string;
  sOrigemSQLSERVER: string;
  sOrigemPOSTGRESQL: string;
  sDestinoDB2: string;
  sDestinoORACLE: string;
  sDestinoSQLSERVER: string;
  sDestinoPOSTGRESQL: string;
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
  sOrigemPOSTGRESQL := psOrigem + 'POSTGRESQL\';

  sDestinoDB2 := s_CAPRONI_BIN_DB2 + 'INPUT\SG\';
  sDestinoORACLE := s_CAPRONI_BIN_ORACLE + 'INPUT\SG\';
  sDestinoSQLSERVER := s_CAPRONI_BIN_SQLSERVER + 'INPUT\SG\';
  sDestinoPOSTGRESQL := s_CAPRONI_BIN_POSTGRESQL + 'INPUT\SG\';

  oListaDbChangeXML := TStringList.Create;
  try
    oListaDbChangeXML.Add('<?xml version="1.0" encoding="UTF-8"?>');
    oListaDbChangeXML.Add('<havillan>');

    for i := 0 to mmoListaScripts.Lines.Count - 1 do
    begin
      sScript := Trim(mmoListaScripts.Lines[i]);

      if sScript.IsEmpty then
        Continue;

      oListaDbChangeXML.Add('<script a_name="' + sScript + '" version="99.99.99" x_has_pos="false" z_description="Execucao automatica"/>');

      CopyFile(PWideChar(sOrigemDB2 + sScript), PWideChar(sDestinoDB2 + sScript), True);
      CopyFile(PWideChar(sOrigemORACLE + sScript), PWideChar(sDestinoORACLE + sScript), True);
      CopyFile(PWideChar(sOrigemSQLSERVER + sScript), PWideChar(sDestinoSQLSERVER + sScript), True);
      CopyFile(PWideChar(sOrigemPOSTGRESQL + sScript), PWideChar(sDestinoPOSTGRESQL + sScript), True);
    end;

    oListaDbChangeXML.Add('</havillan>');

    oListaDbChangeXML.SaveToFile(sDestinoDB2 + 'dbChange.xml');
    oListaDbChangeXML.SaveToFile(sDestinoORACLE + 'dbChange.xml');
    oListaDbChangeXML.SaveToFile(sDestinoSQLSERVER + 'dbChange.xml');
    oListaDbChangeXML.SaveToFile(sDestinoPOSTGRESQL + 'dbChange.xml');
  finally
    FreeAndNil(oListaDbChangeXML);
  end;
end;

procedure TForm1.ExecutarScripts;
var
  sComando: string;
  sNomeArquivoComando: string;

  procedure SalvarArquivoBAT(psComando: string; sbancoDados: string);
  var
    oLista: TStringList;
  begin
    oLista := TStringList.Create;
    try
      oLista.Clear;
      oLista.Add(psComando);
      oLista.Add('pause');
      oLista.SaveToFile(sNomeArquivoComando + '\Comando' + sbancoDados + '.bat');
    finally
      FreeAndNil(oLista)
    end;
  end;
begin
  sNomeArquivoComando := ExtractFilePath(Application.ExeName);

  sComando := s_CAPRONI_BIN_DB2 + 'capronica3.exe -is';
  SalvarArquivoBAT(sComando, 'DB2');

  sComando := s_CAPRONI_BIN_ORACLE + 'capronica3.exe -is';
  SalvarArquivoBAT(sComando, 'ORACLE');

  sComando := s_CAPRONI_BIN_SQLSERVER + 'capronica3.exe -is';
  SalvarArquivoBAT(sComando, 'SQLSERVER');

  sComando := s_CAPRONI_BIN_POSTGRESQL + 'capronica3.exe -is';
  SalvarArquivoBAT(sComando, 'POSTGRESQL');

  ShellExecute(handle, 'open', PChar(sNomeArquivoComando + '\ComandoDB2.bat'), '', '', SW_SHOWNORMAL);
  ShellExecute(handle, 'open', PChar(sNomeArquivoComando + '\ComandoORACLE.bat'), '', '', SW_SHOWNORMAL);
  ShellExecute(handle, 'open', PChar(sNomeArquivoComando + '\ComandoSQLSERVER.bat'), '', '', SW_SHOWNORMAL);
  ShellExecute(handle, 'open', PChar(sNomeArquivoComando + '\ComandoPOSTGRESQL.bat'), '', '', SW_SHOWNORMAL);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    Ini.WriteString(s_INI_TELA, s_INI_ORIGEM_SCRIPT, edtOrigem.Text);
  finally
    Ini.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
const
  s_CAMINHO_DEFAULT = 'C:\RTC\PIPELINE_SG5_RUSSIA_CONTINUO\PIPELINE_SG5_RUSSIA_CONTINUO\dbscript\SG';
var
  Ini: TIniFile;
  sCaminhoPadrao: string;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    sCaminhoPadrao := Trim(Ini.ReadString(s_INI_TELA, s_INI_ORIGEM_SCRIPT, s_CAMINHO_DEFAULT));

    if sCaminhoPadrao = '' then
      sCaminhoPadrao := s_CAMINHO_DEFAULT;

    edtOrigem.Text := sCaminhoPadrao;
  finally
    Ini.Free;
  end;
end;

end.

