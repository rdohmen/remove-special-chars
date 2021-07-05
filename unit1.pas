unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ListBox1: TListBox;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function remove_special_chars(s, special_chars:string):string;
var i:integer;
    c : string;
    p:integer;
begin
  for i:= 1 to length(special_chars) do begin
    c:=copy(special_chars,i,1);
    p:=pos(c,s);
    if p>0 then begin
      s:=copy(s,1,p-1)+copy(s,p+1,length(s)-p);
      end;
    end;
  result:=s;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  searchResult : TSearchRec;
  NewFilename : string;
begin

  if SelectDirectoryDialog1.Execute Then Begin
    label2.caption:=SelectDirectoryDialog1.FileName;
    listbox1.clear;

    if findfirst(SelectDirectoryDialog1.FileName+'/'+'*', faAnyFile, searchResult) = 0 then
    begin
      repeat
        label5.caption:=searchResult.Name;
        NewFilename:=remove_special_chars(searchResult.Name,edit1.text);
        if NewFilename<>searchResult.Name Then Begin
          Listbox1.items.add(searchResult.Name);
          Listbox1.items.add(' -> '+ NewFilename);

          RenameFile(SelectDirectoryDialog1.FileName+'/'+searchResult.Name , SelectDirectoryDialog1.FileName+'/'+NewFilename);
          if fileexists(SelectDirectoryDialog1.FileName+'/'+searchResult.Name) then
            Listbox1.items.add('exists:'+SelectDirectoryDialog1.FileName+'/'+searchResult.Name);
          if fileexists(SelectDirectoryDialog1.FileName+'/'+NewFilename) then
            Listbox1.items.add('exists:'+SelectDirectoryDialog1.FileName+'/'+NewFilename);

          end
        else
          if not checkbox1.checked then
            Listbox1.items.add(searchResult.Name);

      until FindNext(searchResult) <> 0;


      FindClose(searchResult);
      end;
    end;
end;



begin

end.

