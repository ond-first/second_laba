unit second_laba;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    btnNumber: TButton;
    EdCount1: TEdit;
    edDPI1: TEdit;
    Ednumber: TEdit;
    EdName1: TEdit;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EdName: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    EdCount: TEdit;
    edDPI: TEdit;
    edPath: TEdit;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ListBox1: TListBox;
    procedure btnNumberClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
type
  mouse= record
    name : string[20];
    count: integer;
    dpi: integer;
  end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  f: file of mouse;
  m:mouse;
begin
  {Проверки здесь если не заполнена графа выдать ошибку}
   assignfile (f,edPath.text);
   if (FileExists (edPath.text)) then
   begin
     reset(f);
     seek(f,filesize(f)); {в конец файла}
    end
   else
    rewrite (f);

   m.name:= edName.Text;
   m.count:= strtoint (edcount.text);
   m.dpi:= strtoint (eddpi.text);

   write (f,m);
   closefile (f);
end;

procedure TForm1.btnNumberClick(Sender: TObject);
var
  f:file of mouse;
  m : mouse;
  id: integer;
begin
   id:= strtoint(edNumber.text);
   {проверка}
   assignfile (f,edpath.text);
   reset(f);

   if (id> filesize(f)) then
    begin
    MessageDlg('Мыши с таким номером нет!', mtError,mbYesNoCancel,0);
    exit;
    end;
   seek (f, id - 1);
   read (f,m);
   edName1.Text := m.Name;
   edCount1.Text := inttostr(m.count);
   eddpi.text := inttostr(m.dpi);
   closefile(f);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  f:file of mouse;
  m : mouse;
begin
    listBox1.Items.Clear;// очищаем листбокс
     {Проверки здесь если не заполнена графа выдать ошибку}
   assignfile (f,edPath.Text);
   if (not fileexists(edpath.text)) then
    begin
    MessageDlg('Файла не существует', mtError,mbYesNoCancel,0);
    closefile(f);
    exit;
    end;

   reset(f);

   while (not EOF (f)) do
    begin
       read(f,m);
       listBox1.Items.add(m.name+' '+inttostr(m.count)+' '+inttostr(m.dpi));
    end;
 closefile(f);
end;

procedure TForm1.Label3Click(Sender: TObject);
begin


end;

end.

