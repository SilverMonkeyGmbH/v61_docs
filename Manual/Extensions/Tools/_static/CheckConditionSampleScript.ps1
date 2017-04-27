Add-Type -Path ("$PSScriptRoot\bin\debug\CheckCondition.dll")

#Here are 2 examples of use of the class SIM.Tools.Condition, with different inputs.

#Given some inputs (be sure to use simple qutations for string literals: 'text'):
$numInput = "3 * (2 + 1) = 9"
$stringInput = "'M' ! 'R'"

#We create the Condition:
$numCondition = New-Object SIM.Tools.Condition($numInput)
$stringCondition = New-Object SIM.Tools.Condition($stringInput)

#And so we can access the condition result:
$numCondition.get_Result()
$stringCondition.get_Result()

#We could also check the original condition from input:
#$numCondition.Condition
#$stringCondition.Condition
