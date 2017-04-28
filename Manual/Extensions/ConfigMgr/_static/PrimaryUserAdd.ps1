$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\Base.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\ConfigMgr.dll")

$ConfigMgrConnectionSettings = New-Object SIM.ConfigMgr.ConnectionSettings
$ConfigMgrConnectionSettings.WMIHostName = 'localhost'
$ConfigMgrConnectionSettings.SiteCode = 'SIM'
$ConfigMgrConnectionSettings.SQLHostname = $ConfigMgrConnectionSettings.WMIHostName;

$ConfigMgrConnection = New-Object SIM.ConfigMgr.Connection($ConfigMgrConnectionSettings)

$res = New-Object Base.Result("Starting ConfigMgr script...")

$res.ChildAdd($ConfigMgrConnection.Connect())

if ($res.Successful -eq $true)
            
{

    $ConfigMgrComputersObject = New-Object SIM.ConfigMgr.Computers.Computer($ConfigMgrConnection)

    $ConfigMgrComputersSettings = New-Object SIM.ConfigMgr.Computers.ComputerParameters
    
    #Define Target Computer by ResourceId
    $ConfigMgrComputersSettings.ResourceId = '16777222'

    $UserParameters = New-Object SIM.ConfigMgr.Users.UserParameters($ConfigMgrConnection)
    $UserParameters.ResourceId = "2063597568"

    $ParameterPrimaryUser = New-Object SIM.ConfigMgr.ParameterPrimaryUser($ConfigMgrComputersSettings, $UserParameters)

    $res.ChildAdd($ConfigMgrComputersObject.PrimaryUserAdd($ParameterPrimaryUser))

}

$res.Dump()

