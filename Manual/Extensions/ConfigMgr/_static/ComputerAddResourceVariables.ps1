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
    $ConfigMgrComputersSettings.ResourceId = '16777221'
    #Define Target Computer by ComputerName
    $ConfigMgrComputersSettings.ComputerName = 'TestComputer478' 

    $MyVar1 = New-Object SIM.ConfigMgr.Parameter("MyVar1", "Value1") 
    $MyVar2 = New-Object SIM.ConfigMgr.Parameter("MyVar2", "Value2") 

    $ConfigMgrComputersSettings.Variables.Add($MyVar1)
    $ConfigMgrComputersSettings.Variables.Add($MyVar2)

    $res.ChildAdd($ConfigMgrComputersObject.AddResourceVariables($ConfigMgrComputersSettings))

}

$res.Dump()

