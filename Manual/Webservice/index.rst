Manual for module "Webservice"
=============================================================

.. contents:: *In this article:*
  :local:
  :depth: 3


.. warning:: This article is under construction! Please DO NOT use any of the instructions below, yet! You may cause damage to your system. This article will be finished soon.



.. tip:: Go to :doc:`/KnowledgeBase/KB00002_WebService-Test-Tool/index` to get help connecting to the web service. 

************************************************************************************
Authentication
************************************************************************************
Depending on the setting of the IIS application there are two possible authentication methods

a) Windows Authentication (recommended)
b) Authentication via firewall exception in IP base

************************************************************************************
Available commands
************************************************************************************



===============
query
===============

Getting information from the web service.



==============================
queue
==============================

Adding a queue element for executing a powershell addon script


---------------------------------------
Creating Queue element via powershell
---------------------------------------

.. literalinclude:: _static/CreateQueueElement.ps1
  :language: powershell

.. code-block:: powershell
  .\CreateQueueElement.ps1 -definition "<Definition><Plugin>PLUGINNAME</Plugin><Data><Parameter1>Value</Parameter1></Data></Definition>"  -url "http://HOSTNAME/AppName" 