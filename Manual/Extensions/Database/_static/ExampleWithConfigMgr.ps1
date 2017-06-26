$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\Base.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\EntityFramework.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\EntityFramework.SqlServer.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\System.Data.Common.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\System.Data.SqlClient.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\SIMv61Database.dll")
$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\ConfigMgr.dll")

$ctx = New-Object SIMv61Database.SIMv61Database("")

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
    # EXAMPLE with single row return:
    $row = $ctx.SQLQueryFirstRow("SELECT * FROM [v_CollectionRuleDirect] WHERE [ResourceType] = 5", $ConfigMgrConnection.SQLConnection)
    $row['RuleName']

    # **************************************
    # EXAMPLE with multiple rows (in a table) return:
    $table = $ctx.SQLQueryAll("SELECT * FROM [v_CollectionRuleDirect] WHERE [ResourceType] = 5", $ConfigMgrConnection.SQLConnection)

    if ($table.Rows.Count -gt 0)
    {
        Foreach ($Row in $table)
        {
           $Row['RuleName']
        }
    }

    # **************************************
    # EXAMPLE to fire a command:
    $intReturn = $ctx.SQLCommand("use testdb;  create table testtable(bla varchar(10));", $ConfigMgrConnection.SQLConnection)

    "Affected items: $intReturn"

}

$res.Dump()