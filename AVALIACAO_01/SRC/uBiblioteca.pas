unit uBiblioteca;

interface

uses
   Windows, Messages, Forms, Types, StrUtils, Classes, SysUtils, GRids;

Const
   FUNC_1 = '03027504100;1988,85';
   FUNC_2 = '15496582166;5350,55';
   FUNC_3 = '98726415947;1650';
   FUNC_4 = '98726415853;1250,22';

   FUNC_NOME_1 = 'JOÃO DE OLIVEIRA FILHO';
   FUNC_NOME_2 = 'FRANCISO EDIVALDO BATISTA';
   FUNC_NOME_3 = 'ALBERTO DA SILVA NOGUEIRA';
   FUNC_NOME_4 = 'PEDRO SOUZA';


   MESES: Array[1..12] of String = (
               'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
               'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');

   MASCARA : String = '###,###,###,##0.00';

type
   TFuncionario = record
      fNome        : string;
      fCPF         : string;
      fSalarioBase : Double;
      fLinhaGrid   : Integer
   end;
   TFuncionarios = array of TFuncionario;

   TImpostos = (tiFGTSMensal, tiFGTSCompensatorio, tiCPEr, tiSeguroAcidente, tiINSS);

var
  LISTA_FUNC: TFuncionarios;

procedure Atencao(pMensagem: string);
procedure Erro(pMensagem: string);
procedure Split(const Delimiter: Char; Value: string; const Strings: TStrings);
procedure PreencheFuncionarios(pGrid: TStringGrid);
function ValidaMesAno(pMesAno: String): Boolean;
function MesExtenso(pMes: Integer; pMaiusculo: Boolean): String;
function LPad(S: string; Ch: Char; Len: Integer): string;
function RPad(S: string; Ch: Char; Len: Integer): string;
function GetAliquotaINSS(pSalarioBase: Double): Double;
function CalcularDescontos(pSalarioBase: Double; pImposto: TImpostos): Double;
function FormataCPF(pCPF: string): string;
function SoNumeros(pCampo : string): string;

implementation

procedure Atencao(pMensagem: string);
begin
   Application.MessageBox(pChar(pMensagem), 'Atenção', MB_OK + MB_ICONEXCLAMATION);
end;

procedure Erro(pMensagem: string);
begin
   Application.MessageBox(pChar(pMensagem), 'Erro', MB_OK + MB_ICONERROR);
end;

procedure Split(const Delimiter: Char; Value: string; const Strings: TStrings);
begin
   Assert(Assigned(Strings));
   Strings.Clear;
   Strings.Delimiter     := Delimiter;
   Strings.DelimitedText := Value;
end;

procedure PreencheFuncionarios(pGrid: TStringGrid);
var
   I, linha: Integer;
   lDado: TStringList;
begin
   lDado := TStringList.Create;
   try
      pGrid.Cells[0,0] := 'Nome';
      pGrid.Cells[1,0] := 'CPF';
      pGrid.Cells[2,0] := 'Salário Base';

      linha := pGrid.FixedRows;
      for I := 0 to 4 - 1 do         
      begin
         case I of
            0:
            begin
               Split(';', FUNC_1, lDado);
               pGrid.Cells[0, linha] := FUNC_NOME_1;
               pGrid.Cells[1, linha] := FormataCPF(lDado[0]);
               pGrid.Cells[2, linha] := FormatFloat(MASCARA, StrToFloat(lDado[1]));
            end;
            1:
            begin
               Split(';', FUNC_2, lDado);
               pGrid.Cells[0, linha] := FUNC_NOME_2;
               pGrid.Cells[1, linha] := FormataCPF(lDado[0]);
               pGrid.Cells[2, linha] := FormatFloat(MASCARA, StrToFloat(lDado[1]));

            end;
            2:
            begin
               Split(';', FUNC_3, lDado);
               pGrid.Cells[0, linha] := FUNC_NOME_3;
               pGrid.Cells[1, linha] := FormataCPF(lDado[0]);
               pGrid.Cells[2, linha] := FormatFloat(MASCARA, StrToFloat(lDado[1]));
            end;
            3:
            begin
               Split(';', FUNC_4, lDado);
               pGrid.Cells[0, linha] := FUNC_NOME_4;
               pGrid.Cells[1, linha] := FormataCPF(lDado[0]);
               pGrid.Cells[2, linha] := FormatFloat(MASCARA, StrToFloat(lDado[1]));
            end;
         end;
         Inc(linha)
      end;
      pGrid.RowCount := linha;
   finally
      FreeAndNil(lDado);
   end;
end;

function ValidaMesAno(pMesAno: String): Boolean;
var
   lMes, lAno: Integer;
begin
   lMes := StrToIntDef(Copy(pMesAno, 1, 2), 0);
   lAno := StrToIntDef(Copy(pMesAno, 4, 4), 0);
   Result := (lMes >= 1) and (lMes <= 12) and (lAno > 2000);
end;

function MesExtenso(pMes: Integer; pMaiusculo: Boolean): String;
begin
   Result := '';
   if (pMes >= 1) and (pMes <= 12) then
   begin
      Result := MESES[pMes];
      if pMaiusculo then
      begin
         Result := UpperCase(Result);
      end;
   end;
end;

function LPad(S: string; Ch: Char; Len: Integer): string;
var
   RestLen: Integer;
begin
   Result  := S;
   RestLen := Len - Length(s);
   if RestLen < 1 then
   begin
      Exit;
   end;
   Result := S + StringOfChar(Ch, RestLen);
end;

function RPad(S: string; Ch: Char; Len: Integer): string;
var
   RestLen: Integer;
begin
   Result  := S;
   RestLen := Len - Length(s);
   if RestLen < 1 then
   begin
      Exit;
   end;
   Result := StringOfChar(Ch, RestLen) + S;
end;

function GetAliquotaINSS(pSalarioBase: Double): Double;
begin
   if pSalarioBase <= 1693.72 then
   begin
      Result := 8;
      Exit;
   end;

   if (pSalarioBase >= 1693.73) and  (pSalarioBase <= 2822.90) then
   begin
      Result := 9;
      Exit;
   end;

   if (pSalarioBase >= 2822.91) and  (pSalarioBase <= 5645.80) then
   begin
      Result := 11;
      Exit;
   end;

   if (pSalarioBase > 5645.80) then
   begin
      Result := 11;
      Exit;
   end;  
end;

function CalcularDescontos(pSalarioBase: Double; pImposto: TImpostos): Double;
begin    
   {Realiza a cálculo do imposto de acordo com salário e tipo do imposto informado}
   case pImposto of
      tiFGTSMensal:
      begin
         Result := pSalarioBase * 8 / 100;
      end;

      tiFGTSCompensatorio:
      begin
         Result := pSalarioBase * 3.2 / 100;
      end;

      tiCPEr: //Contribuição Previdenciária do Empregador
      begin
         Result := pSalarioBase * 8 / 100;
      end;

      tiSeguroAcidente:
      begin
         Result := pSalarioBase * 0.8 / 100;
      end;

      tiINSS:
      begin
         Result := pSalarioBase * GetAliquotaINSS(pSalarioBase) / 100;
      end;
   end;
end;

function FormataCPF(pCPF: string): string;
begin
   Result := Copy(pCPF, 1, 3) + '.' + Copy(pCPF, 4, 3) + '.' + Copy(pCPF, 7, 3) + '-' + Copy(pCPF, 10, 2);
end;

function SoNumeros(pCampo : string): string;
var   
  I : Byte; 
begin   
   Result := '';
   for I := 1 To Length(pCampo) do
   begin
      if pCampo [I] In ['0'..'9'] Then
      begin
         Result := Result + pCampo[I];
      end;
   end;
end;

end.
