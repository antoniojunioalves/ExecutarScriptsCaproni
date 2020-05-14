program CopiarExecutarCaproni;

uses
  Vcl.Forms,
  CopiarExecutarScripts in 'CopiarExecutarScripts.pas' {FormExecutarScripts};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormExecutarScripts, FormExecutarScripts);
  Application.Run;
end.
