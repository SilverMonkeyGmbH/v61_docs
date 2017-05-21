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

    $ConfigMgrComputersSettings = New-Object SIM.ConfigMgr.Computers.ComputerParameters
    
    #Define Target Computer by Name
    $ConfigMgrComputersSettings.ComputerName = 'TestComputer1'

    $res.ChildAdd($ConfigMgrComputersSettings.TryResolve($ConfigMgrConnection))

    $ResourceId = $ConfigMgrComputersSettings.ResourceId

    If ($ResourceId)
    {

    
        # REMOVE FROM COLLECTIONS

        $Command = New-Object System.Data.SQLClient.SQLCommand
        $Command.Connection = $ConfigMgrConnection.SQLConnection
        $Command.CommandText = "SELECT [CollectionID] FROM [v_CollectionRuleDirect] WHERE [ResourceID] = '$ResourceId' AND [ResourceType] = 5"

        $DataAdapter = new-object System.Data.SqlClient.SqlDataAdapter $Command
        $Dataset = new-object System.Data.Dataset

        $DataAdapter.Fill($Dataset)
    
        $QueryResultCount = $Dataset.Tables[0].Rows.ToString()

        if ($QueryResultCount -gt 0)
        {

            Foreach ($Row in $Dataset.Tables[0])
 
            {
 
                $ConfigMgrComputersObject = New-Object SIM.ConfigMgr.Computers.Computer($ConfigMgrConnection)
                $objParametersCollectionMembership = New-Object SIM.ConfigMgr.ParametersCollectionMembership;

                $objParametersCollectionMembership.CollectionMembershipType = [SIM.ConfigMgr.ParametersCollectionMembership+CollectionMembershipTypes]::RuleDirectComputer;
                $objParametersCollectionMembership.CollectionId = $Row["CollectionID"]
                $objParametersCollectionMembership.ResourceId = $ResourceId

                $res.ChildAdd($ConfigMgrComputersObject.CollectionMembershipRemove($objParametersCollectionMembership));
 
            }

        }

        # ADD RES VARS

        $res.ChildAdd($ConfigMgrComputersObject.DeleteVariables($ConfigMgrComputersSettings))

        $MyVar1 = New-Object SIM.ConfigMgr.Parameter("MyVar1", "Value1") 
        $MyVar2 = New-Object SIM.ConfigMgr.Parameter("MyVar2", "Value2") 

        $ConfigMgrComputersSettings.Variables.Add($MyVar1)
        $ConfigMgrComputersSettings.Variables.Add($MyVar2)

        $res.ChildAdd($ConfigMgrComputersObject.AddResourceVariables($ConfigMgrComputersSettings))

        # ClearPxeAdvertisementResource

        $res.ChildAdd($ConfigMgrComputersObject.ClearPxeAdvertisementResource($ConfigMgrComputersSettings))

        # ADD TO COLL

        $objParametersCollectionMembership = New-Object SIM.ConfigMgr.ParametersCollectionMembership;

        $objParametersCollectionMembership.CollectionMembershipType = [SIM.ConfigMgr.ParametersCollectionMembership+CollectionMembershipTypes]::RuleDirectComputer;
        $objParametersCollectionMembership.CollectionName = "DeployColl";
        $objParametersCollectionMembership.ResourceName = $ConfigMgrComputersSettings.ComputerName

        $res.ChildAdd($ConfigMgrComputersObject.CollectionMembershipAdd($objParametersCollectionMembership));

        

    }

}

$res.Dump()

