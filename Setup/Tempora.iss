#define AppName        GetStringFileInfo('..\Binaries\Tempora.exe', 'ProductName')
#define AppVersion     GetStringFileInfo('..\Binaries\Tempora.exe', 'ProductVersion')
#define AppFileVersion GetStringFileInfo('..\Binaries\Tempora.exe', 'FileVersion')
#define AppCompany     GetStringFileInfo('..\Binaries\Tempora.exe', 'CompanyName')
#define AppCopyright   GetStringFileInfo('..\Binaries\Tempora.exe', 'LegalCopyright')
#define AppBase        LowerCase(StringChange(AppName, ' ', ''))
#define AppSetupFile   AppBase + StringChange(AppVersion, '.', '')

#define AppVersionEx   StringChange(AppVersion, '0.00', '')
#if "" != VersionHash
#  define AppVersionEx AppVersionEx + " (" + VersionHash + ")"
#endif


[Setup]
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppCompany}
AppPublisherURL=http://jmedved.com/{#AppBase}/
AppCopyright={#AppCopyright}
VersionInfoProductVersion={#AppVersion}
VersionInfoProductTextVersion={#AppVersionEx}
VersionInfoVersion={#AppFileVersion}
DefaultDirName={pf}\{#AppCompany}\{#AppName}
OutputBaseFilename={#AppSetupFile}
OutputDir=..\Releases
SourceDir=..\Binaries
AppId=JosipMedved_Tempora
CloseApplications="yes"
RestartApplications="no"
UninstallDisplayIcon={app}\Tempora.exe
AlwaysShowComponentsList=no
ArchitecturesInstallIn64BitMode=x64
DisableProgramGroupPage=yes
MergeDuplicateFiles=yes
MinVersion=0,6.01.7200
PrivilegesRequired=admin
ShowLanguageDialog=no
SolidCompression=yes
ChangesAssociations=yes
DisableWelcomePage=yes
LicenseFile=..\Setup\License.rtf

[Messages]
SetupAppTitle=Setup {#AppName} {#AppVersionEx}
SetupWindowTitle=Setup {#AppName} {#AppVersionEx}
BeveledLabel=jmedved.com

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

procedure InitializeWizard;
begin
  WizardForm.LicenseAcceptedRadio.Checked := True;
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
var
    ResultCode: Integer;
begin
    Exec(ExpandConstant('{app}\Tempora.exe'), '/Uninstall', '', SW_SHOW, ewWaitUntilTerminated, ResultCode)
    Result := Result;
end;
