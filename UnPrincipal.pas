unit UnPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Styles, Vcl.themes;

type
  TopcVisual = class(TForm)
    Label1: TLabel;
    txtNum1: TEdit;
    Label2: TLabel;
    txtNum2: TEdit;
    BTsubtrair: TButton;
    BTmultiplicar: TButton;
    BTdividir: TButton;
    Label3: TLabel;
    txtResultado: TEdit;
    BTsomar: TButton;
    opcVisual: TRadioGroup;
    procedure BTsomarClick(Sender: TObject);
    procedure BTsubtrairClick(Sender: TObject);
    procedure BTmultiplicarClick(Sender: TObject);
    procedure BTdividirClick(Sender: TObject);
    procedure opcVisualClick(Sender: TObject);
    procedure txtNum1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }

      //  procedure calcularResultado(operacao: string);
      // diferen�a entre procedure e fun��o � que a fun��o sempre ter� um retorno de um valor de algum tipo

      function calcularResultado(num1, num2: Real; operacao: string): Real;
      function validarCampos(): Boolean;
      procedure habilitarBotoes(habilitado: Boolean);
      procedure registrarLog(acao: String);

      // coloca ponto e v�rgula para separar do outro parametro

  public
    { Public declarations }
  end;

var
  opcVisual: TopcVisual;

implementation

{$R *.dfm}


procedure TopcVisual.BTdividirClick(Sender: TObject);
begin
    if validarCampos then
      begin
          if txtNum2.Text = '0' then
            begin
                ShowMessage('Erro de divis�o por zero.');
            end
          else
              begin
                txtResultado.Text := FloatToStr(calcularResultado(StrToFloat(txtNum1.Text),StrToFloat(txtNum2.Text),'dividir'));
                registrarLog('Divis�o, num1= '+txtNum1.Text + ' num2 '+txtNum2.Text+', resultado= '+txtResultado.Text);
              end;
      end;
end;

procedure TopcVisual.BTmultiplicarClick(Sender: TObject);
begin
      if validarCampos then
        begin
          txtResultado.Text := FloatToStr(calcularResultado(StrToFloat(txtNum1.Text),StrToFloat(txtNum2.Text),'multiplicar'));
           registrarLog('Multiplica��o, num1 = '+txtNum1.Text + ', num2 =' +txtNum2.Text+', resultado = '+txtResultado.Text);
        end;
end;

procedure TopcVisual.BTsomarClick(Sender: TObject);
begin
      if validarCampos then
        begin
          txtResultado.Text := FloatToStr(calcularResultado(StrToFloat(txtNum1.Text),StrToFloat(txtNum2.Text),'somar'));
          registrarLog('Soma, num1 = '+txtNum1.Text + ', num2 = '+txtNum2.Text+', resultado = '+txtResultado.Text);
        end;

end;

procedure TopcVisual.BTsubtrairClick(Sender: TObject);
begin
      if validarCampos then
        begin
           txtResultado.Text := FloatToStr(calcularResultado(StrToFloat(txtNum1.Text),StrToFloat(txtNum2.Text),'subtrair'));
            registrarLog('Subtra��o, num1 = '+txtNum1.Text + ', num2 = '+txtNum2.Text+', resultado = '+txtResultado.Text);
        end;
end;

function TopcVisual.calcularResultado(num1, num2: Real; operacao: string): Real;
var
    resultado: Real;
begin
    resultado:= 0;

    if operacao = 'somar' then
    resultado := num1 + num2;

    if operacao = 'subtrair' then
    resultado := num1 - num2;

    if operacao = 'multiplicar' then
    resultado := num1 * num2;

    if operacao = 'dividir' then
    resultado := num1 / num2;

    result := resultado;

end;


procedure TopcVisual.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    registrarLog('Aplica��o Encerrada');
    registrarLog('---------------------------------------');
end;

procedure TopcVisual.FormCreate(Sender: TObject);
begin
    registrarLog('---------------------------------------');
    registrarLog('Aplica��o Iniciada');

end;

procedure TopcVisual.habilitarBotoes(habilitado: Boolean);
begin
      btSomar.Enabled := habilitado;
      btSubtrair.Enabled := habilitado;
      btMultiplicar.Enabled := habilitado;
      btDividir.Enabled := habilitado;
end;

procedure TopcVisual.opcVisualClick(Sender: TObject);
begin
     case opcVisual.ItemIndex of

        0:
          begin
            TStyleManager.SetStyle('Windows');
            registrarLog('Visual da aplica��o alterado para Windows');
         end;

        1:
          begin
            TStyleManager.SetStyle('Glow');
            registrarLog('Visual da aplica��o alterado para Glow');
         end;

        2:
          begin
            TStyleManager.SetStyle('Aqua Light Slate');
             registrarLog('Visual da aplica��o alterado para Aqua Light Slate');
           end;

     end;

end;

procedure TopcVisual.registrarLog(acao: String);
var
    arquivo: TextFile;
begin
    try
       AssignFile(arquivo, 'Logs.txt');    // se o arquivo Log.txt existir, chamamos a fun��o Append ela abre o
       if FileExists('Logs.txt') then       // arquivo.txt e colocando o ponteiro onde vai digitar esse conte�do
         Append(arquivo)                   // no final desse srquivo
       else
         Rewrite(arquivo);
                                                                    // Caso, a fun��o Append n�o ache o arquivo, ent�o ela ir� tentar criar
        Writeln(arquivo, '['+ DateTimeToStr(now())+'] -' + acao);   // Por�m, ao tentar criar e ele achar o arquivo, ele vau abrir esse arquivo
                                                                    // e vai sobreescrever todo conte�do que j� existia dentro dele.
    finally                                                         // A fun��o 'now' retorna a hora/min/seg
           CloseFile(arquivo);                                      // no finally ele vai simplismente fechar o arquivo
    end;
end;

// no bloco try/finally o c�digo vai ser executado independente de erro ou n�o dentro do try

procedure TopcVisual.txtNum1Change(Sender: TObject);
begin
      if validarCampos then
         habilitarBotoes(True)
      else
         habilitarBotoes(False);

// toda vez que o conte�do da caixa mudar � preciso fazer a valida��o
// caso a valida��o seja True, ent�o chamamos o 'habilitarBotoes'

end;

function TopcVisual.validarCampos: Boolean;
begin
    if (txtNum1.Text = '') or (txtNum2.Text = '') then
      Result := False
    else
       try
          StrToFloat(txtNum1.Text);
          StrToFloat(txtNum2.Text);

          Result := True;

       except
            on E: EConvertError do
              begin
                   Result := False;
              end;

// Ao acontecer um erro de convers�o, ele pega o erro e joga dentro da vari�vel E

       end;

// o comando de try/except vai tentar executar todo c�digo que estiver dentro do bloco try, caso ele encontre algum erro
// ele cai pra dentro do c�digo except e executa o c�digo que estiver dentro do c�digo except.

// Para evitar duplicidade de c�digo podemos referenciar um evento de outro componente

end;

end.


//O que � digitado em uma caixa de texto � considerado um texto e n�o um n�mero! Por mais que tenha um n�mero l�.
// por isso, tem que estar entre aspas

// caso tivesse duas linhas de comando seria obrigat�rio o uso do begin e do end.

