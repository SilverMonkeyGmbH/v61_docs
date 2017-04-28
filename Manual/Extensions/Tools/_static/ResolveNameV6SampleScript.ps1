Add-Type -Path ("$PSScriptRoot\bin\debug\ResolveName.dll")
Add-Type -Path ("$PSScriptRoot\..\SIMv61Database\bin\Debug\SIMv61Database.dll")

#Given a sample input
$input = '"<br>The software package: "{PackagingPackageName}" has been hand over to packaging factory. 
<br>Manufacturer: <b>{RequestManufacturerName}</b>
<br>Product:<b>{RequestProductName}</b>
<br>Version: <b>{RequestProductVersion}</b>
<br>Architecture: <b>{HC_Architecture}</b>"'

#We obtain a connection with the corresponding table:
$connV61 = (New-Object SIMv61Database.SIMv61Database).Database.Connection
$connV61.Open()
$connV61.ChangeDatabase("SIM_HC_R003")

#We create the Resolved Text, using either connection.
#We can use different Resolvers. Here we use v6 resolver:
$inputResolvedText = New-Object SIM.Tools.ResolvedText(
    $input,
    (New-Object SIM.Tools.V6SqlDbResolver(
        $connV61, 
        "SELECT * FROM PackagingJob WHERE Id=101"
    ))
)

#And so we can access its resolved text (use of property accessor method to expose exceptions in PS):
$inputResolvedText.get_Text()

#We could also check the original text before resolving:
#$inputResolvedText.OriginText
