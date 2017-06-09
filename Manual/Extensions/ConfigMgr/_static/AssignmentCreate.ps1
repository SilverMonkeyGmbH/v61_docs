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

    $objParameterCollection = New-Object SIM.ConfigMgr.ParameterCollection;
    $objParameterCollection.CollectionName = "Test Collection 1";
    $objParameterCollection.CollectionType = [SIM.ConfigMgr.ParameterCollectionTypes]::Device

    $objParameterAssignment = New-Object SIM.ConfigMgr.ParameterAssignment;
    $objParameterAssignment.Collection = $objParameterCollection;
    $objParameterAssignment.Application = New-Object SIM.ConfigMgr.ParameterApplication("Test App 1");
    $objParameterAssignment.AssignmentType = [SIM.ConfigMgr.ParameterAssignment+AssignmentTypes]::Install
    $objParameterAssignment.OfferType = [SIM.ConfigMgr.ParameterAssignment+OfferTypes]::Optional

    $res.ChildAdd($ConfigMgrComputersObject.AssignmentCreate($objParameterAssignment))
   
}

$res.Dump()

