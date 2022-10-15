unit CardMain;

// Главная форма приложения

interface

uses
  Classes, Forms, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxBarBuiltInMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, StdCtrls, ToolWin,
  ActnMan, ActnCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  ExtCtrls, ImgList, Controls, ActnList, PlatformDefaultStyleActnCtrls, cxPC,
  Windows, Dialogs, SysUtils,
  PageCardDetail, DataModule, MCHelpers, CardValue;

type
  TfrmCardMain = class(TForm)
    pcCards: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    dsrCard: TDataSource;
    ActionManager1: TActionManager;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    Image1: TImage;
    ImageList1: TImageList;
    Panel1: TPanel;
    teSearch: TEdit;
    Label1: TLabel;
    gCardDBTableView1: TcxGridDBTableView;
    gCardLevel1: TcxGridLevel;
    gCard: TcxGrid;
    ActionToolBar1: TActionToolBar;
    btnFind: TButton;
    actFind: TAction;
    gCardDBTableView1fio: TcxGridDBColumn;
    gCardDBTableView1dt_birthday: TcxGridDBColumn;
    gCardDBTableView1gender: TcxGridDBColumn;
    gCardDBTableView1phone: TcxGridDBColumn;
    gCardDBTableView1work_place: TcxGridDBColumn;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure teSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    procedure CardDataEvent; // Обработчик события изменения данных БД
    procedure FormExposition; // Настройка отображения пользовательского интерфейса
    procedure CardDetailCreate(Mode: TCDMode); // Создание вкладки редактирования/добавления медкарты
  end;

var
  frmCardMain: TfrmCardMain;
  SearchText: string;

implementation

{$R *.dfm}

procedure TfrmCardMain.FormCreate(Sender: TObject);
begin
  inherited;
  FormExposition;
  DM.OnCardDataEvent := CardDataEvent;
  ReportMemoryLeaksOnShutdown := true;
end;

procedure TfrmCardMain.CardDataEvent;
begin
  DM.SaveFileDB;
  FormExposition;
end;

procedure TfrmCardMain.FormExposition;
var
  isEmptyData: boolean;
begin
  Self.Caption := Format('Медкарты - %s', [DM.FileName]);
  isEmptyData := gCardDBTableView1.ViewData.RowCount = 0;
  actEdit.Enabled := not isEmptyData;
  actDelete.Enabled := not isEmptyData;
end;


procedure TfrmCardMain.actAddExecute(Sender: TObject);
begin
  CardDetailCreate(cdmAdd);
end;

procedure TfrmCardMain.actEditExecute(Sender: TObject);
begin
  CardDetailCreate(cdmEdit);
end;

procedure TfrmCardMain.actDeleteExecute(Sender: TObject);
begin
  if MessageDlg('Удалить медкарту?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DM.DeleteCurrentCard;
  end;
end;


procedure TfrmCardMain.CardDetailCreate(Mode: TCDMode);
var
  pgCardOpened, pgCard: TPageCardDetail;
  i: integer;
begin
  pgCard := TPageCardDetail.CreatePageCardDetail(pcCards, Mode);

  if Mode = cdmEdit then
  begin
    for i := 0 to pcCards.PageCount - 1 do
    begin
      if pcCards.Pages[i] is TPageCardDetail then
      begin
        pgCardOpened := pcCards.Pages[i] as TPageCardDetail;
        if pgCardOpened.CardDetail.CardValue.Id = pgCard.CardDetail.CardValue.Id then
        begin
          pgCard := pgCardOpened; // Если эта медкарта уже открыта, перейти к ней
          break;
        end;
      end;
    end;
  end;

  if not Assigned(pgCard.PageControl) then
    pgCard.PageControl := pcCards;

  pcCards.ActivePage := pgCard;
end;


procedure TfrmCardMain.actFindExecute(Sender: TObject);
var
  StartRowIndex: integer;
begin
  if SearchText <> teSearch.Text then
    StartRowIndex := 0
  else
    StartRowIndex := gCardDBTableView1.Controller.FocusedRowIndex + 1;

  if MCHelpers.SearchInGrid(gCardDBTableView1, teSearch.Text, StartRowIndex) then
    SearchText := teSearch.Text
  else if StartRowIndex <> 0 then
  begin
    SearchText := '';
    actFindExecute(Sender);
  end;
end;

procedure TfrmCardMain.teSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    actFindExecute(Sender);
end;

end.
