unit uEarlyBirdsTracker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, Data.DB, Data.Win.ADODB;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    tsHandicap: TTabSheet;
    tsCompetition: TTabSheet;
    rgpHandicap: TRadioGroup;
    sedScore: TSpinEdit;
    btnEnter: TButton;
    redHandicap: TRichEdit;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Label1: TLabel;
    rgpCompetition: TRadioGroup;
    sedStablePoints: TSpinEdit;
    sedPutts: TSpinEdit;
    btnComp: TButton;
    redComp: TRichEdit;
    Label3: TLabel;
    Label4: TLabel;
    calComp: TMonthCalendar;
    calHandicap: TMonthCalendar;
    Label2: TLabel;
    Label5: TLabel;
    tsLeaderboard: TTabSheet;
    redLeaderboard: TRichEdit;
    btnPoints: TButton;
    btnPutts: TButton;
    procedure btnEnterClick(Sender: TObject);
    procedure rgpHandicapClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCompClick(Sender: TObject);
    procedure rgpCompetitionClick(Sender: TObject);
    procedure btnPointsClick(Sender: TObject);
    procedure btnPuttsClick(Sender: TObject);
  private
    { Private declarations }
    procedure fetchHandicapNames();
    procedure fetchCompNames();
    procedure fetchHandicapScores(member:string);
    procedure fetchCompScores(member:string);
    function calculateHandicap(member:string):integer;
    function getMemberID(member:string):integer;
    function getAvgPoints(member:string):real;
    function getAvgPutts(member:string):real;
    procedure printPointLeaderboard();
    procedure printPuttLeaderboard();
    function getHandicapMemberID(member:string):integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnCompClick(Sender: TObject);
var
 member : string;
 score,putts,id : integer;
 ddate : TDateTime;
begin
  if rgpCompetition.ItemIndex = -1 then
  begin
    showmessage('Please choose a member');
    Exit;
  end;//if

  if (sedStablePoints.Value=0) then
  begin
    ShowMessage('Please enter stableford points');
    exit;
  end;

  if (sedPutts.Value=0) then
  begin
    ShowMessage('Please enter the number of putts');
    exit;
  end;

  ddate := calComp.Date;
  member := rgpCompetition.Items[rgpCompetition.ItemIndex];
  score := sedStablePoints.Value;
  putts := sedPutts.Value;
  id := getMemberID(member);

  ADOQuery1.SQL.Text := 'INSERT INTO tblCompScores (Golf_date, Member, Score, Num_putts) ' +
                        'VALUES (:GolfDate, :MemberID, :Score, :Putts)';
  ADOQuery1.Parameters.ParamByName('GolfDate').Value := dDate;
  ADOQuery1.Parameters.ParamByName('MemberID').Value := ID;
  ADOQuery1.Parameters.ParamByName('Score').Value := Score;
  ADOQuery1.Parameters.ParamByName('Putts').Value := Putts;
  ADOQuery1.ExecSQL;

  redComp.Clear;
  redComp.Lines.Add(member + #9 + 'Avg points: '+FloatToStrF(getAvgPoints(member),ffFixed,15,2)+
  #9 + 'Avg putts: ' + FloatToStrF(getAvgPutts(member),ffFixed,15,2));
  redComp.Lines.Add('---------------------------------------------------------------------');
  redComp.Lines.Add('Date' + #9 + 'Stableford points' + #9 + 'Number of putts');
  fetchCompScores(member);

  sedStablePoints.Value := 0;
  sedPutts.Value := 0;
  rgpCompetition.ItemIndex := -1;
end;

procedure TForm1.btnEnterClick(Sender: TObject);
var
  member: string;
 score,id,handicap : integer;
 ddate : TDateTime;
begin
  if rgpHandicap.ItemIndex = -1 then
  begin
    showmessage('Please choose a member');
    Exit;
  end;//if

  if sedScore.Value = 0 then
  begin
    ShowMessage('Please enter score');
    Exit;
  end;//if

  member := rgpHandicap.Items[rgpHandicap.ItemIndex];
  score := sedScore.Value;
  ddate :=  calHandicap.Date;
  id := getHandicapMemberID(member);

  ADOQuery1.SQL.Text := 'INSERT INTO tblScores (Golf_date, Member, Score) ' +
                        'VALUES (:GolfDate, :MemberID, :Score)';
  ADOQuery1.Parameters.ParamByName('GolfDate').Value := dDate;
  ADOQuery1.Parameters.ParamByName('MemberID').Value := ID;
  ADOQuery1.Parameters.ParamByName('Score').Value := Score;
  ADOQuery1.ExecSQL;

  handicap := calculateHandicap(member);
  redHandicap.Clear;
  redHandicap.Lines.Add((member)+ #9 +'Handicap: '+ inttostr(handicap));
  redHandicap.Lines.Add('----------------------------------------------------------------');
  redHandicap.Lines.Add('Date' + #9 + 'Gross score');
  fetchHandicapScores(member);

  sedScore.Value := 0;
  rgpHandicap.ItemIndex := -1;
end;


procedure TForm1.btnPointsClick(Sender: TObject);
begin
  printPointLeaderboard();
end;

procedure TForm1.btnPuttsClick(Sender: TObject);
begin
  printPuttLeaderboard();
end;

function TForm1.calculateHandicap(member: string): integer;
const
  COURSE_RATING = 72;
var
  avg,handicap : real;
  id,total : integer;
  k: Integer;
begin
  id := getHandicapMemberID(member);
  total := 0;
   ADOQuery1.SQL.Text :=
      'SELECT TOP 8 Score ' +
      'FROM (SELECT TOP 20 Score, Golf_date ' +
      '  FROM tblScores ' +
      '  WHERE Member ='+inttostr(id) +
      '  ORDER BY Golf_date DESC) AS Last20 ' +
      'ORDER BY Score';

  ADOQuery1.Open;
  for k := 1 to 8 do
  begin
    total :=total + ADOQuery1.FieldByName('Score').asinteger;
    ADOQuery1.Next;
  end;//for k
  ADOQuery1.Close;
  avg := total/8;
  handicap := round(avg) - COURSE_RATING;
  result := TRUNC(handicap);
end;

procedure TForm1.fetchCompNames;
var
 member : string;
begin
   ADOQuery1.SQL.Text := 'Select [Member_name] from tblCompMembers';
  ADOQuery1.Open;

  rgpCompetition.Items.Clear;
  while not ADOQuery1.Eof do
  begin
    member := ADOQuery1.FieldByName('Member_name').AsString;
    rgpCompetition.Items.Add(member);
    ADOQuery1.Next;
  end;//while not

  ADOQuery1.Close;
end;

procedure TForm1.fetchCompScores(member: string);
var
 ddate : TDate;
 score,putts : integer;
begin
  ADOQuery1.SQL.Text := 'SELECT ts.Golf_date, ts.Score,ts.Num_putts ' +
    'FROM tblCompScores ts ' +
    'INNER JOIN tblCompMembers tm ON ts.Member = tm.ID ' +
    'WHERE tm.Member_name ="'+member +'"' +
    'ORDER BY ts.Golf_date DESC';

  ADOQuery1.Open;

  while not ADOQuery1.eof do
  begin
    ddate := ADOQuery1.FieldByName('Golf_date').AsDateTime;
    score := ADOQuery1.FieldByName('Score').AsInteger;
    putts := ADOQuery1.FieldByName('Num_putts').AsInteger;
    redComp.Lines.Add(DateToStr(ddate) + #9 + IntToStr(score)+ #9 + IntToStr(putts));
    ADOQuery1.Next;
  end;
  ADOQuery1.Close;
end;

procedure TForm1.fetchHandicapNames;
var
 member : string;
begin
  ADOQuery1.SQL.Text := 'Select [Member_name] from tblMembers';
  ADOQuery1.Open;

  rgpHandicap.Items.Clear;
  while not ADOQuery1.Eof do
  begin
    member := ADOQuery1.FieldByName('Member_name').AsString;
    rgpHandicap.Items.Add(member);
    ADOQuery1.Next;
  end;//while not

  ADOQuery1.Close;
end;

procedure TForm1.fetchHandicapScores(member:string);
var
  ddate : TDate;
  score,handicap: integer;
begin
   ADOQuery1.SQL.Text :=
    'SELECT TOP 20 ts.Golf_date, ts.Score ' +
    'FROM tblScores ts ' +
    'INNER JOIN tblMembers tm ON ts.Member = tm.ID ' +
    'WHERE tm.Member_name ="'+member +'"' +
    'ORDER BY ts.Golf_date DESC';
  ADOQuery1.Open;

  while not ADOQuery1.eof do
  begin
    ddate := ADOQuery1.FieldByName('Golf_date').AsDateTime;
    score := ADOQuery1.FieldByName('Score').AsInteger;
    redHandicap.Lines.Add(DateToStr(ddate) + #9 + IntToStr(score));
    ADOQuery1.Next;
  end;
  ADOQuery1.Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  redHandicap.Paragraph.TabCount := 2;
  redHandicap.Paragraph.Tab[0] := 0;
  redHandicap.Paragraph.Tab[1] := 150;

  redComp.Paragraph.TabCount := 3;
  redComp.Paragraph.Tab[0] := 0;
  redComp.Paragraph.Tab[1] := 150;
  redComp.Paragraph.Tab[2] := 300;

  redLeaderboard.Paragraph.TabCount := 4;
  redLeaderboard.Paragraph.Tab[0] := 0;
  redLeaderboard.Paragraph.Tab[1] := 100;
  redLeaderboard.Paragraph.Tab[2] := 200;
  redLeaderboard.Paragraph.Tab[3] := 350;

  calHandicap.Date := Date;
  calComp.Date := Date;
  fetchHandicapNames();
  fetchCompNames();
end;

function TForm1.getAvgPoints(member: string): real;
var
  id : integer;
  avg : real;
begin
  id := getMemberID(member);
  ADOQuery1.SQL.Text := 'Select AVG(Score) AS Average from tblCompScores Where '+
                        'member ='+inttostr(id);
  ADOQuery1.Open;
  avg := ADOQuery1.FieldByName('Average').AsFloat;
  ADOQuery1.Close;
  Result := avg;
end;

function TForm1.getAvgPutts(member: string): real;
var
  id : integer;
  avg : real;
begin
  id := getMemberID(member);
  ADOQuery1.SQL.Text := 'Select AVG(Num_putts) AS Average from tblCompScores Where '+
                        'member ='+inttostr(id);
  ADOQuery1.Open;
  avg := ADOQuery1.FieldByName('Average').AsFloat;
  ADOQuery1.Close;
  Result := avg;
end;

function TForm1.getHandicapMemberID(member: string): integer;
var
  id:integer;
begin
   ADOQuery1.SQL.Text := 'Select ID from tblMembers where [Member_name] ="'+member+'"';
  ADOQuery1.Open;
  id := ADOQuery1.FieldByName('ID').AsInteger;
  ADOQuery1.Close;
  result := id;
end;

function TForm1.getMemberID(member: string): integer;
var
  id:integer;
begin
   ADOQuery1.SQL.Text := 'Select ID from tblCompMembers where [Member_name] ="'+member+'"';
  ADOQuery1.Open;
  id := ADOQuery1.FieldByName('ID').AsInteger;
  ADOQuery1.Close;
  result := id;
end;

procedure TForm1.printPointLeaderboard;
var
  name,filename : string;
  avg  : real;
  iCount,games : integer;
  tfl : TextFile;
begin
  filename :='C:/Users/james/Desktop/Points.csv';
  AssignFile(tfl,filename);
  Rewrite(tfl);

  redLeaderboard.Clear;
  iCount := 1;
  ADOQuery1.SQL.Text :=
  'SELECT tblCompMembers.Member_name, AVG(tblCompScores.Score) AS AverageScore, COUNT(tblCompScores.Score) AS NumRecords ' +
  'FROM tblCompMembers ' +
  'INNER JOIN tblCompScores ON tblCompMembers.ID = tblCompScores.Member ' +
  'GROUP BY tblCompMembers.Member_name ' +
  'HAVING COUNT(tblCompScores.Score) > 0 ' +
  'ORDER BY AVG(tblCompScores.Score) DESC;';
  ADOQuery1.Open;

  redLeaderboard.Lines.Add('Position' +#9+ 'Name' +#9+ 'Average points'+#9+'No. of games');
  redLeaderboard.Lines.Add('-----------------------------------------------------------------------------');

  Writeln(tfl,'Position, Name, Average Points, No. of games');

  while not ADOQuery1.Eof do
  begin
    name := ADOQuery1.FieldByName('Member_name').AsString;
    avg := ADOQuery1.FieldByName('AverageScore').AsFloat;
    games := ADOQuery1.FieldByName('NumRecords').AsInteger;
    redLeaderboard.Lines.Add(IntToStr(iCount) + #9+name+ #9 + FloatToStrF(avg,ffFixed,15,2)+#9+inttostr(games));
    Writeln(tfl,IntToStr(iCount)+','+name+','+FloatToStrF(avg,ffFixed,15,2)+','+IntToStr(games));
    Inc(iCount);
    ADOQuery1.Next;
  end;//while

  ADOQuery1.Close;
  CloseFile(tfl);
end;

procedure TForm1.printPuttLeaderboard;
var
  name,filename : string;
  avg  : real;
  iCount,games : integer;
  tfl:textfile;
begin
  filename := 'C:/Users/james/Desktop/Putts.csv';
  AssignFile(tfl,filename);
  Rewrite(tfl);
  redLeaderboard.Clear;
  iCount := 1;
  ADOQuery1.SQL.Text :=
  'SELECT tblCompMembers.Member_name, AVG(tblCompScores.Num_putts) AS AveragePutts, COUNT(tblCompScores.Num_putts) AS NumRecords ' +
  'FROM tblCompMembers ' +
  'INNER JOIN tblCompScores ON tblCompMembers.ID = tblCompScores.Member ' +
  'GROUP BY tblCompMembers.Member_name ' +
  'HAVING COUNT(tblCompScores.Num_putts) > 0 ' +
  'ORDER BY AVG(tblCompScores.Num_putts) ASC;';

  ADOQuery1.Open;

  redLeaderboard.Lines.Add('Position' +#9+ 'Name' +#9+ 'Average putts'+#9+'No. of games');
  redLeaderboard.Lines.Add('-----------------------------------------------------------------------------');

  Writeln(tfl,'Position, Name, Average Putts, No. of games');

  while not ADOQuery1.Eof do
  begin
    name := ADOQuery1.FieldByName('Member_name').AsString;
    avg := ADOQuery1.FieldByName('AveragePutts').AsFloat;
    games := ADOQuery1.FieldByName('NumRecords').AsInteger;
    redLeaderboard.Lines.Add(IntToStr(iCount) + #9+name+ #9 + FloatToStrF(avg,ffFixed,15,2)+#9+IntToStr(games));
    Writeln(tfl,IntToStr(iCount)+','+name+','+FloatToStrF(avg,ffFixed,15,2)+','+IntToStr(games));
    Inc(iCount);
    ADOQuery1.Next;
  end;//while

  ADOQuery1.Close;
  CloseFile(tfl);
end;

procedure TForm1.rgpCompetitionClick(Sender: TObject);
var
 member: string;
begin
  redComp.clear;
  if rgpCompetition.ItemIndex = -1 then
    Exit;

  member := rgpCompetition.Items[rgpCompetition.ItemIndex];
  redComp.Clear;
  redComp.Lines.Add(member + #9 + 'Avg points: '+FloatToStrF(getAvgPoints(member),ffFixed,15,2)+
  #9 + 'Avg putts: ' + FloatToStrF(getAvgPutts(member),ffFixed,15,2));
  redComp.Lines.Add('---------------------------------------------------------------------');
  redComp.Lines.Add('Date' + #9 + 'Stableford points' + #9 + 'Number of putts');
  fetchCompScores(member);
end;

procedure TForm1.rgpHandicapClick(Sender: TObject);
var
  member : string;
  handicap : integer;
begin
  redHandicap.clear;
  if rgpHandicap.ItemIndex = -1 then
    Exit;

  member := rgpHandicap.Items[rgpHandicap.ItemIndex];
  handicap := calculateHandicap(member);

  redHandicap.Clear;
  redHandicap.Lines.Add((member)+ #9 +'Handicap: '+ inttostr(handicap));
  redHandicap.Lines.Add('----------------------------------------------------------------');
  redHandicap.Lines.Add('Date' + #9 + 'Gross score');
  fetchHandicapScores(member);
end;

end.
