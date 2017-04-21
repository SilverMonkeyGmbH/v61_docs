Manual for library "Base"
=============================================================

.. contents:: *In this article:*
  :local:
  :depth: 3


************************************************************************************
Base.Result
************************************************************************************
The Base.Result class is used to nest every action result of your scripts to get strong and reliable error handling. 

Example:

.. literalinclude:: _static/BaseResultExample.ps1
  :language: powershell

Expected output:

.. literalinclude:: _static/BaseResultExample.log


--------------------------------------------
Powershell functions returning Base.Result
--------------------------------------------

To make sure, that self created powershell functions return a Base.Result object, please stick to the following structure:

.. literalinclude:: _static/PowershellFunctionsReturningBaseResult.ps1
  :language: powershell
