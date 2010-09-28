[Setup]
AppName=Tempora
AppVerName=Tempora 1.01
DefaultDirName={pf}\Josip Medved\Tempora
OutputBaseFilename=tempora101
OutputDir=..\Releases
SourceDir=..\Binaries
AppId=JosipMedved_Tempora
AppPublisher=Josip Medved
AppPublisherURL=http://bitbucket.org/jmedved/tempora
UninstallDisplayIcon={app}\Tempora.exe
AlwaysShowComponentsList=no
ArchitecturesInstallIn64BitMode=x64
DisableProgramGroupPage=yes
MergeDuplicateFiles=yes
MinVersion=0,5.01
PrivilegesRequired=admin
ShowLanguageDialog=no
SolidCompression=yes

[Files]
Source: "Tempora.exe"; DestDir: "{app}"; Flags: ignoreversion;

[Registry]
Root: HKCU; Subkey: "Software\Josip Medved\Tempora"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Josip Medved"; Flags: uninsdeletekeyifempty

[Run]
Filename: "{app}\Tempora.exe"; Parameters: "/Install"; Flags: runascurrentuser waituntilterminated

[UninstallRun]
Filename: "{app}\Tempora.exe"; Parameters: "/Uninstall"; Flags: runascurrentuser waituntilterminated



[Code]

function PrepareToInstall(var NeedsRestart: Boolean): String;
var
    ResultCode: Integer;
begin
    Exec(ExpandConstant('{app}\Tempora.exe'), '/Uninstall', '', SW_SHOW, ewWaitUntilTerminated, ResultCode)
end;

