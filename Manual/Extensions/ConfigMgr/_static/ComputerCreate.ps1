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
    $ConfigMgrComputersSettings.MACAddress = "00-00-00-00-00-11"
	
    $resCreate = $ConfigMgrComputersObject.Create($ConfigMgrComputersSettings)
    [string]$ResourceId = $resCreate.ReturnObj
    $res.ChildAdd($resCreate)

    if ($res.Successful -eq $true -And $ResourceId -ne $null)		
	{
        "Computer was created with ResourceId: $ResourceId"
    }

}

$res.Dump()

