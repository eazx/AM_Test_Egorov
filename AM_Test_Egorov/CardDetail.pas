unit CardDetail;

// Модуль класса фрейма медкарты

interface

uses Mask, Controls, StdCtrls, ComCtrls, Classes, Forms, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  dxCore, cxDateUtils, cxCalendar, SysUtils, CardValue;

type
  TCancelClickEvent = procedure(Sender: TObject) of object;
  TSaveClickEvent = procedure(Sender: TObject) of object;

  TfCardDetail = class(TFrame)
    btnSave: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    teFio: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    tePhone: TMaskEdit;
    Label3: TLabel;
    teWorkPlace: TEdit;
    cbGender: TcxComboBox;
    dtBirthday: TcxDateEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    FOnCancelClick: TCancelClickEvent;
    FOnSaveClick: TSaveClickEvent;
    FCardValue: TCardValue;
    procedure DataBind; // Разместить данные на форме
    function DataCollect: TCardValue; // Собрать данные с формы
  public
    constructor CreateCardDetail(AOwner: TComponent; ACardValue: TCardValue);
    property OnCancelClick: TCancelClickEvent read FOnCancelClick write FOnCancelClick; // Событие нажатия кнопки Отмена
    property OnSaveClick: TSaveClickEvent read FOnSaveClick write FOnSaveClick; // Событие нажатия кнопки Сохранить
    property CardValue: TCardValue read DataCollect;
  end;


implementation

{$R *.dfm}

constructor TfCardDetail.CreateCardDetail(AOwner: TComponent; ACardValue: TCardValue);
begin
  inherited Create(AOwner);
  FCardValue := ACardValue;
  DataBind;
end;

procedure TfCardDetail.DataBind;
begin
  teFio.Text := FCardValue.Fio;
  dtBirthday.Date := FCardValue.Birthday;
  cbGender.Text := FCardValue.Gender;
  tePhone.Text := FCardValue.Phone;
  teWorkPlace.Text := FCardValue.WorkPlace;
end;

function TfCardDetail.DataCollect: TCardValue;
begin
  FCardValue.Fio := teFio.Text;
  FCardValue.Birthday := dtBirthday.Date;
  FCardValue.Gender := cbGender.Text;
  FCardValue.Phone := tePhone.Text;
  FCardValue.WorkPlace := teWorkPlace.Text;

  result := FCardValue;
end;

procedure TfCardDetail.btnCancelClick(Sender: TObject);
begin
  if Assigned(FOnCancelClick) then
    FOnCancelClick(Sender);
end;

procedure TfCardDetail.btnSaveClick(Sender: TObject);
begin
  if Assigned(FOnSaveClick) then
    FOnSaveClick(Sender);
end;

end.
