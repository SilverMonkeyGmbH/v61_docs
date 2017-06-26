$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\Base.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\System.Data.SqlClient.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\Database.dll")
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
    
    # **************************************
    # Create new instance of Database with 
    # (A) an existing SQLConnection object
    # (B) with a path to the SIMV61 Config file: $SIM_DB = New-Object SIM.Tools.Database("C:\SilverMonkey\v61\Config.xml")  
    # **************************************
    $SIM_DB = New-Object SIM.Tools.Database($ConfigMgrConnection.SQLConnection)    

    
    # **************************************
    # EXAMPLE with single row return:
    # **************************************
    $row = $SIM_DB.SQLQueryFirstRow("SELECT * FROM [v_CollectionRuleDirect] WHERE [ResourceType] = 5")
    $row['RuleName']

    # **************************************
    # EXAMPLE with multiple rows (in a table) return:
    # **************************************
    $table = $SIM_DB.SQLQueryAll("SELECT * FROM [v_CollectionRuleDirect] WHERE [ResourceType] = 5")

    if ($table.Rows.Count -gt 0)
    {
        Foreach ($Row in $table)
        {
           $Row['RuleName']
        }
    }

    # **************************************
    # EXAMPLE to fire a command:
    # **************************************
    $intReturn = $SIM_DB.SQLCommand("use testdb;  create table testtable(bla varchar(10));")

    "Affected items: $intReturn"

}

$res.Dump()