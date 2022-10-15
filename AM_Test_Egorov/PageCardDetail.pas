unit PageCardDetail;

// ћодуль класса вклади дл€ добавлени€/редактировани€ медкарты

interface

uses
  Classes, cxPC, SysUtils, CardDetail, CardValue,
  MCHelpers, DataModule;

type

  TPageCardDetail = class (TcxTabSheet)
  private
    FCardDetail: TfCardDetail;
    FMode: TCDMode;
  public
    property CardDetail: TfCardDetail read FCardDetail write FCardDetail;
    property Mode: TCDMode read FMode;
    constructor CreatePageCardDetail(AOwner: TComponent; AMode: TCDMode);
    procedure CloseCard(Sender: TObject);
    procedure SaveAndCloseCard(Sender: TObject); virtual;
  end;

implementation

{ TPageCardDetail }

constructor TPageCardDetail.CreatePageCardDetail(AOwner: TComponent; AMode: TCDMode);
var
  cardValue: TCardValue;
begin
  inherited Create(AOwner);

  FMode := AMode;

  if AMode = cdmEdit then
  begin
    cardValue := DM.GetCurrentCardValue;
    Caption := cardValue.Fio;
  end
  else
  begin
    cardValue := TCardValue.Create(-1, '', Date, '', '', '');
    Caption := 'Ќова€ медкарта';
  end;

  FCardDetail := TfCardDetail.CreateCardDetail(self, cardValue);
  FCardDetail.Parent := self;
  FCardDetail.OnCancelClick := CloseCard;
  FCardDetail.OnSaveClick := SaveAndCloseCard;
end;

procedure TPageCardDetail.SaveAndCloseCard(Sender: TObject);
begin
  if FMode = cdmAdd then
    if not DM.InsertCard(FCardDetail.CardValue) then exit;

  if FMode = cdmEdit then
    if not DM.UpdateCard(FCardDetail.CardValue) then exit;

  CloseCard(Sender);
end;

procedure TPageCardDetail.CloseCard(Sender: TObject);
begin
  Free;
end;

end.
