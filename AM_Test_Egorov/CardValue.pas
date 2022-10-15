unit CardValue;

interface

uses
  SysUtils;

type
  TCardValue = record
    Id: integer;
    Fio: string;
    Birthday: TDate;
    Gender: string;
    Phone: string;
    WorkPlace: string;
  public
    constructor Create(
      AId: integer;
      AFio: string;
      ABirthday: TDate;
      AGender: string;
      APhone: string;
      AWorkPlace: string);
  end;

implementation

{ TCardValue }

constructor TCardValue.Create(AId: integer; AFio: string; ABirthday: TDate;
  AGender, APhone, AWorkPlace: string);
begin
  Id := AId;
  Fio := AFio;
  Birthday := ABirthDay;
  Gender := AGender;
  Phone := APhone;
  WorkPlace := AWorkPlace;
end;

end.
