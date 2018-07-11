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

    $ConfigMgrComputersObject = New-Object SIM.ConfigMgr.Computers.Computer($ConfigMgrConnection)

    $objParameterCollection = New-Object SIM.ConfigMgr.ParameterCollection;
    $objParameterCollection.CollectionName = "TestCollection";
    $objParameterCollection.CollectionType = [SIM.ConfigMgr.ParameterCollectionTypes]::Device

    $objParameterAdvertisement = New-Object SIM.ConfigMgr.ParameterAdvertisement;
    $objParameterAdvertisement.Collection = $objParameterCollection;
    $objParameterAdvertisement.Package = New-Object SIM.ConfigMgr.ParameterPackage("P0100050");
    $objParameterAdvertisement.Package.ProgramName = "Install"
    $objParameterAdvertisement.OfferType = [SIM.ConfigMgr.ParameterAssignment+OfferTypes]::Optional

    $res.ChildAdd($ConfigMgrComputersObject.AdvertisementCreate($objParameterAdvertisement))
   
}

$res.Dump()