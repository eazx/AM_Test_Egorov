program MedCard;

uses
  Forms,
  CardMain in 'CardMain.pas' {frmCardMain},
  CardDetail in 'CardDetail.pas' {CardDetail: TFrame},
  DataModule in 'DataModule.pas' {DM: TDataModule},
  PageCardDetail in 'PageCardDetail.pas',
  MCHelpers in 'MCHelpers.pas',
  CardValue in 'CardValue.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmCardMain, frmCardMain);
  Application.Run;
end.
