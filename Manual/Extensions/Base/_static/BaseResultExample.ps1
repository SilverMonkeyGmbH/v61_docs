$Assembly = [Reflection.Assembly]::LoadFile("$PSScriptRoot\Base.dll")

$res = New-Object Base.Result("My first script with error handling.")

#------ First part will work ------#

Try
{
    $DevisionByTwo = 1 / 2
    "Result ByTwo: $DevisionByTwo"

    $resTemp = New-Object Base.Result("Result of DevisionByTwo: $DevisionByTwo")
    $res.ChildAdd($resTemp)

}
Catch
{
    
    $ErrorMessage = $_.Exception.Message 
    $ExitCodeClass = New-Object Base.ResultSuperClass+ExitCodeClass([Base.ResultSuperClass+ExitCodeCategory]::Error,[Base.ResultSuperClass+ExitCodeType]::SystemException)
    $resError = New-Object Base.Result("Exception thrown: $ErrorMessage",$ExitCodeClass)

    $res.ChildAdd($resError)
   
}


#------ Check if everything went good so far ------#
if ($res.Successful -eq $true) 
            
{

    #------ Second part will not work ------#

    Try
    {
        $DevisionByZero = 1 / 0
        "Result ByZero: $DevisionByZero"
    
        $resTemp = New-Object Base.Result("Result of DevisionByZero: $DevisionByZero")
        $res.ChildAdd($resTemp)

    }
    Catch
    {
    
        $ErrorMessage = $_.Exception.Message 
        $res.ChildAdd((New-Object Base.Result("Exception thrown: $ErrorMessage", (New-Object Base.ResultSuperClass+ExitCodeClass([Base.ResultSuperClass+ExitCodeCategory]::Error,[Base.ResultSuperClass+ExitCodeType]::SystemException)))))
   
    }
}


$res.Dump()