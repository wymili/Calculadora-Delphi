program calculadora;

uses
  Vcl.Forms,
  UnPrincipal in 'UnPrincipal.pas' {opcVisual},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TopcVisual, opcVisual);
  Application.Run;
end.
