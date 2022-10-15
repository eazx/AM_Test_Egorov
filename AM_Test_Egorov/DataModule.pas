unit DataModule;

// Модуль доступа к БД

interface

uses
  SysUtils, Classes, DB, DBClient, MidasLib, Dialogs, StrUtils, CardValue;

type
  TCardDataEvent = procedure of object;

  TDM = class(TDataModule)
    dsCard: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    FFileName: string;
    FOnCardDataEvent: TCardDataEvent;
    procedure InitDB;
  public
    property OnCardDataEvent: TCardDataEvent read FOnCardDataEvent write FOnCardDataEvent;
    property FileName: string read FFileName;
    function SaveFileDB: boolean;
    procedure CardDataEventCall;
    function InsertCard(CardValue: TCardValue): boolean;
    function UpdateCard(CardValue: TCardValue): boolean;
    procedure DeleteCurrentCard;
    function GetCurrentCardValue: TCardValue;
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  sep: string;
  filePath: string;
begin
  filePath := ExtractFilePath(ParamStr(0));
  sep := '';
  if not AnsiEndsText('\', filePath) then
    sep := '\';
  FFileName := Format(filePath + '%s%s', [sep, 'db.cds']);

  dsCard.Close;
  dsCard.FileName := FFileName;
  if not FileExists(dsCard.FileName) then InitDB;
  dsCard.Open;
end;

procedure TDM.InitDB;
begin
  dsCard.CreateDataSet;
end;

function TDM.InsertCard(CardValue: TCardValue): boolean;
begin
  result := false;
  try
    dsCard.AppendRecord([
      CardValue.Fio,
      CardValue.Birthday,
      CardValue.Gender,
      CardValue.Phone,
      CardValue.WorkPlace]);
    result := true;
  except
    on e: Exception do
      ShowMessage(e.Message);
  end;
  CardDataEventCall;
end;

function TDM.UpdateCard(CardValue: TCardValue): boolean;
begin
  result := false;
  try
    if DM.dsCard.Locate('Id', CardValue.Id, []) then
    begin
      DM.dsCard.Edit;
      DM.dsCard.FieldByName('Fio').Value := CardValue.Fio;
      DM.dsCard.FieldByName('Birthday').Value := CardValue.Birthday;
      DM.dsCard.FieldByName('Gender').Value := CardValue.Gender;
      DM.dsCard.FieldByName('Phone').Value := CardValue.Phone;
      DM.dsCard.FieldByName('WorkPlace').Value := CardValue.WorkPlace;
      DM.dsCard.Post;
      result := true;
    end
    else
    begin
      raise Exception.Create('ID not found');
    end;
  except
    on e: Exception do
      ShowMessage(e.Message);
  end;
  CardDataEventCall;
end;

procedure TDM.DeleteCurrentCard;
begin
  dsCard.Delete;
  CardDataEventCall;
end;

function TDM.GetCurrentCardValue: TCardValue;
begin
  result.Id := DM.dsCard.FieldByName('Id').AsInteger;
  result.Fio := DM.dsCard.FieldByName('Fio').AsString;
  result.Birthday := DM.dsCard.FieldByName('Birthday').AsDateTime;
  result.Gender := DM.dsCard.FieldByName('Gender').AsString;
  result.Phone := DM.dsCard.FieldByName('Phone').AsString;
  result.WorkPlace := DM.dsCard.FieldByName('WorkPlace').AsString;
end;

procedure TDM.CardDataEventCall;
begin
  if Assigned(FOnCardDataEvent) then
    FOnCardDataEvent;
end;

function TDM.SaveFileDB: boolean;
begin
  result := false;
  try
    dsCard.SaveToFile(FFileName);
    result := true;
  except
    on e: Exception do
      ShowMessage(e.Message);
  end;
end;

end.
