unit MCHelpers;

// Модуль для рутинных функций

interface

uses
  cxGrid, cxGridTableView, StrUtils, Variants;

type
  TCDMode = (cdmAdd, cdmEdit);

// Функция выполняет текстовый поиск в cxGrid
function SearchInGrid(View: TcxGridTableView; Text: string; StartRowIndex: integer): boolean;

implementation

function SearchInGrid(View: TcxGridTableView; Text: string; StartRowIndex: integer): boolean;
var
  i, j: integer;
  function Compare(RowIndex, ColIndex: integer): boolean;
  begin
    Result := AnsiContainsText(VarToStr(View.ViewData.Rows[i].Values[j]), Text);
  end;
begin
  Result := false;
  View.DataController.ClearSelection;

  for i := StartRowIndex to View.ViewData.RowCount - 1 do
  begin
    for j := 0 to View.VisibleColumnCount - 1 do
    begin
      result := Compare(i, j);
      if result then break;
    end;
    if result then break;
  end;

  if result then
  begin
    View.ViewData.Rows[i].Focused := true;
  end;
end;

end.
