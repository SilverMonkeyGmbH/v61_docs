Manual for library "Tools"
=============================================================

.. contents:: *In this article:*
  :local:
  :depth: 3


************************************************************************************
SIM.Tools CheckCondition
************************************************************************************

You can evaluate a string describing a condition into a boolean using an SIM.Tools.ICondition.
SIM.Tools.Condition class is its main implementation. It takes a string with the condition as an input parameter in the constructor. You can check the result of the condition using the property Result.

Check the next example:

.. literalinclude:: _static/CheckConditionSampleScript.ps1
  :language: powershell

This are the accepted operators:

#. <   => less than
#. >   => greater than
#. =   => equals
#. !   => not equals
#. AND => 'and' logical operator
#. OR  => 'or' logical operator
#. NOT => 'not' logical operator
#. ()  => Parentheses to modify operators preference

IMPORTANT: String literals must be enclosed by simple quotation marks: 'literal'

************************************************************************************
SIM.Tools ResolveName
************************************************************************************

You can replace "keys" in a string for its corresponding "values" using a SIM.Tools.IResolvedText and a SIM.Tools.IResolver.
SIM.Tools.ResolvedText class is the main implementation for IResolvedText. It takes the string with the keys and a IResolver as input parameters in the constructor. You can check the result using the property Text.
For IResolver there is an implementation for v6 and v61 taking 2 parameter:

1. An open connection with a SQL DB.
2. An SQL Query containing the columns that will be used as keys. The column name must match the key name. The column value will be the value we will use.

You can check the result of the replacement using the property Text.

Check the next example:

.. literalinclude:: _static/ResolveNameV6SampleScript.ps1
  :language: powershell

Error handling:

#. If braces do not match on the input text, a FormatException will be thrown.
#. If a key value is not found among the columns returned by the query, or no entries are returned, an ApplicationException will be thrown.
