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
    $ApplicationName = "Test App 1"
    $CollectionName = "Test Collection 1"
    $ComputerName = "TestComputer1"


    $ConfigMgrComputersObject = New-Object SIM.ConfigMgr.Computers.Computer($ConfigMgrConnection)
    
    $objParameterCollection = New-Object SIM.ConfigMgr.ParameterCollection;
    $objParameterCollection.CollectionName = $CollectionName;
    $objParameterCollection.CollectionType = [SIM.ConfigMgr.ParameterCollectionTypes]::Device
    $objParameterCollection.Folder = New-Object SIM.ConfigMgr.ParameterFolder(16777217);

    #Check if collection exists

    [Base.Result] $resFindColletion = $ConfigMgrComputersObject.GetWMIPredefinedClassProperty([SIM.ConfigMgr.SuperClass+ConfigMgrQueries]::CollectionId_By_CollectionName,$objParameterCollection.CollectionName)

    if ($resFindColletion.ExitCode.Code -eq [Base.ResultSuperClass+ExitCodeType]::ElementFound)
    {
        $objParameterCollection.CollectionId = $resFindColletion.ReturnObj;
    }
    else
    {
        
        #If not exists, create collection
        
        $res.ChildAdd($ConfigMgrComputersObject.CollectionCreate($objParameterCollection))

        if ($res.Successful -eq $true)
            
        {

            #Create assignment to application, if application does not exist, the action will fail with corresponding message
            
            $objParameterAssignment = New-Object SIM.ConfigMgr.ParameterAssignment;
            $objParameterAssignment.Collection = $objParameterCollection;
            $objParameterAssignment.Application = New-Object SIM.ConfigMgr.ParameterApplication($ApplicationName);
            $objParameterAssignment.AssignmentType = [SIM.ConfigMgr.ParameterAssignment+AssignmentTypes]::Install
            $objParameterAssignment.OfferType = [SIM.ConfigMgr.ParameterAssignment+OfferTypes]::Optional

            $res.ChildAdd($ConfigMgrComputersObject.AssignmentCreate($objParameterAssignment))

        }
    }

    #If everthing before was executed without any errors, a collection membership is created

    if ($res.Successful -eq $true)  
    {
            

        $objParametersCollectionMembership = New-Object SIM.ConfigMgr.ParametersCollectionMembership;

        $objParametersCollectionMembership.CollectionMembershipType = [SIM.ConfigMgr.ParametersCollectionMembership+CollectionMembershipTypes]::RuleDirectComputer;
        $objParametersCollectionMembership.Collection = $objParameterCollection
        $objParametersCollectionMembership.ResourceName = $ComputerName;

        $res.ChildAdd($ConfigMgrComputersObject.CollectionMembershipAdd($objParametersCollectionMembership));

        $res.ChildAdd($ConfigMgrComputersObject.CollectionMembershipRequestRefresh($objParametersCollectionMembership,10,20000,20000));


    }

    
   
}

$res.Dump()

