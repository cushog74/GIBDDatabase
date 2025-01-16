uses
  Forms,
  Controls,
  Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Инициализация компонентов
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageDlg('Вы уверены, что хотите выйти из программы?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    CanClose := True;
end;

uses
  Classes,
  DB,
  ADODB;

type
  TOwner = class
  private
    FID: Integer;
    FName: string;
    FLastName: string;
    FOrganizationName: string;
    FInn: string;
    FChief: string;
    FPhone: string;
    FAddress: string;
    FDistrict: string;
  public
    constructor Create(AID: Integer; AName: string; ALastName: string; AOrgName: string; AInn: string; AChief: string; APhone: string; AAddress: string; ADistrict: string);
    property ID: Integer read FID write FID;
    property Name: string read FName write FName;
    property LastName: string read FLastName write FLastName;
    property OrganizationName: string read FOrganizationName write FOrganizationName;
    property Inn: string read FInn write FInn;
    property Chief: string read FChief write FChief;
    property Phone: string read FPhone write FPhone;
    property Address: string read FAddress write FAddress;
    property District: string read FDistrict write FDistrict;
  end;

class function TOwner.GetList: TADOQuery;
begin
  Result := TADOQuery.Create(Self);
  Result.SQL.Text := 'SELECT * FROM Owners';
end;

class function TOwner.GetById(AId: Integer): TOwner;
begin
  Result := TADOQuery.Create(Self);
  Result.SQL.Text := 'SELECT * FROM Owners WHERE ID = :id';
  Result.Parameters.ParamByName('id').Value := AId;
  Result.Open;
  if not Result.EOF then begin
    Result.Free;
    Result := TOwner.Create(Result.FieldByName('ID').AsInteger,
      Result.FieldByName('Name').AsString,
      Result.FieldByName('LastName').AsString,
      Result.FieldByName('OrganizationName').AsString,
      Result.FieldByName('Inn').AsString,
      Result.FieldByName('Chief').AsString,
      Result.FieldByName('Phone').AsString,
      Result.FieldByName('Address').AsString,
      Result.FieldByName('District').AsString);
  end;
end;

procedure TForm1.AddOwnerClick(Sender: TObject);
var
  NewOwner: TOwner;
begin
  NewOwner := TOwner.Create;
  // Заполнение полей...
  OwnerDB.Insert(NewOwner);
  RefreshUI;
end;

procedure TForm1.RefreshUI;
begin
  // Обновление отображения данных в UI
end;
