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
    $ConfigMgrComputersSettings.ComputerName = "SIMTestPC"					
    $ConfigMgrComputersSettings.MACAddress = "00-00-00-00-00-12"

    $DeleteSystem = $true

    [Base.Result]$existsResult = $ConfigMgrComputersObject.ComputerExists($ConfigMgrComputersSettings,$DeleteSystem)
    [string]$ResourceId = $existsResult.ReturnObj
    $res.ChildAdd($existsResult)

    if ($existsResult.ExitCode.Code -eq 'ElementFound') 
    {

        Write-Host "Computer was found and has following ResourceId: $ResourceId"

    }

}

$res.Dump()

