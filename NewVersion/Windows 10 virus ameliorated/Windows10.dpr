program Windows10;

{$R 'Nouveau1.res' 'K:\Windows 10 virus\Nouveau1.rc'}
{$R 'Nouveau2.res' 'Nouveau2.rc'}

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Dark');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
