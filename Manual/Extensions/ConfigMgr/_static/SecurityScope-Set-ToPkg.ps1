$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\Base.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\Database.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\ConfigMgr.dll")

$ConfigMgrConnectionSettings = New-Object SIM.ConfigMgr.ConnectionSettings
$ConfigMgrConnectionSettings.WMIHostName = 'localhost'
$ConfigMgrConnectionSettings.SiteCode = 'P01'
$ConfigMgrConnectionSettings.SQLHostname = $ConfigMgrConnectionSettings.WMIHostName;

$ConfigMgrConnection = New-Object SIM.ConfigMgr.Connection($ConfigMgrConnectionSettings)

$res = New-Object Base.Result("Starting ConfigMgr script...")

$res.ChildAdd($ConfigMgrConnection.Connect())

if ($res.Successful -eq $true)
{

    $SecurityScopeManagement = New-Object SIM.ConfigMgr.Security.SecurityScopeManagement($ConfigMgrConnection);

    $securityScopeList = New-Object SIM.ConfigMgr.Security.SecurityScopeList
    $securityScopeList.SecurityScopes.Add( (New-Object SIM.ConfigMgr.Security.SecurityScope ("","GERMANY Scope","") ));

    $res.ChildAdd( ($SecurityScopeManagement.SecurityScopeAdd($securityScopeList, "P0100052", [SIM.ConfigMgr.ObjectTypeID]::SMS_Package) ));
   
}

$res.Dump()