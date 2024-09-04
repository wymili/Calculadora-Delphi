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
      // diferença entre procedure e função é que a função sempre terá um retorno de um valor de algum tipo

      function calcularResultado(num1, num2: Real; operacao: string): Real;
      function validarCampos(): Boolean;
      procedure habilitarBotoes(habilitado: Boolean);
      procedure registrarLog(acao: String);

      // coloca ponto e vírgula para separar do outro parametro

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
                ShowMessage('Erro de divisão por zero.');
            end
          else
              begin
                txtResultado.Text := FloatToStr(calcularResultado(StrToFloat(txtNum1.Text),StrToFloat(txtNum2.Text),'dividir'));
                registrarLog('Divisão, num1= '+txtNum1.Text + ' num2 '+txtNum2.Text+', resultado= '+txtResultado.Text);
              end;
      end;
end;

procedure TopcVisual.BTmultiplicarClick(Sender: TObject);
begin
      if validarCampos then
        begin
          txtResultado.Text := FloatToStr(calcularResultado(StrToFloat(txtNum1.Text),StrToFloat(txtNum2.Text),'multiplicar'));
           registrarLog('Multiplicação, num1 = '+txtNum1.Text + ', num2 =' +txtNum2.Text+', resultado = '+txtResultado.Text);
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
            registrarLog('Subtração, num1 = '+txtNum1.Text + ', num2 = '+txtNum2.Text+', resultado = '+txtResultado.Text);
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
    registrarLog('Aplicação Encerrada');
    registrarLog('---------------------------------------');
end;

procedure TopcVisual.FormCreate(Sender: TObject);
begin
    registrarLog('---------------------------------------');
    registrarLog('Aplicação Iniciada');

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
            registrarLog('Visual da aplicação alterado para Windows');
         end;

        1:
          begin
            TStyleManager.SetStyle('Glow');
            registrarLog('Visual da aplicação alterado para Glow');
         end;

        2:
          begin
            TStyleManager.SetStyle('Aqua Light Slate');
             registrarLog('Visual da aplicação alterado para Aqua Light Slate');
           end;

     end;

end;

procedure TopcVisual.registrarLog(acao: String);
var
    arquivo: TextFile;
begin
    try
       AssignFile(arquivo, 'Logs.txt');    // se o arquivo Log.txt existir, chamamos a função Append ela abre o
       if FileExists('Logs.txt') then       // arquivo.txt e colocando o ponteiro onde vai digitar esse conteúdo
         Append(arquivo)                   // no final desse srquivo
       else
         Rewrite(arquivo);
                                                                    // Caso, a função Append não ache o arquivo, então ela irá tentar criar
        Writeln(arquivo, '['+ DateTimeToStr(now())+'] -' + acao);   // Porém, ao tentar criar e ele achar o arquivo, ele vau abrir esse arquivo
                                                                    // e vai sobreescrever todo conteúdo que já existia dentro dele.
    finally                                                         // A função 'now' retorna a hora/min/seg
           CloseFile(arquivo);                                      // no finally ele vai simplismente fechar o arquivo
    end;
end;

// no bloco try/finally o código vai ser executado independente de erro ou não dentro do try

procedure TopcVisual.txtNum1Change(Sender: TObject);
begin
      if validarCampos then
         habilitarBotoes(True)
      else
         habilitarBotoes(False);

// toda vez que o conteúdo da caixa mudar é preciso fazer a validação
// caso a validação seja True, então chamamos o 'habilitarBotoes'

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

// Ao acontecer um erro de conversão, ele pega o erro e joga dentro da variável E

       end;

// o comando de try/except vai tentar executar todo código que estiver dentro do bloco try, caso ele encontre algum erro
// ele cai pra dentro do código except e executa o código que estiver dentro do código except.

// Para evitar duplicidade de código podemos referenciar um evento de outro componente

end;

end.


//O que é digitado em uma caixa de texto é considerado um texto e não um número! Por mais que tenha um número lá.
// por isso, tem que estar entre aspas

// caso tivesse duas linhas de comando seria obrigatório o uso do begin e do end.

