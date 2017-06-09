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
    $objParameterCollection.Folder = New-Object SIM.ConfigMgr.ParameterFolder(16777217); #If FolderId is defined, the collection will be moved on creation
    $objParameterCollection.LimitingCollectionId = "SMS00001";

    $res.ChildAdd($ConfigMgrComputersObject.CollectionCreate($objParameterCollection))
   
}

$res.Dump()

