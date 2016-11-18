Manual for plugin "ConfigMgr"
=============================================================

.. contents:: *In this article:*
  :local:
  :depth: 3


.. warning:: This article is under construction! Please DO NOT use any of the instructions below, yet! You may cause damage to your system. This article will be finished soon.



.. tip:: Go to :doc:`/KnowledgeBase/KB00002_WebService-Test-Tool/index` to get help connecting to the web service. 

************************************************************************************
Connection
************************************************************************************
In the computers namespace all connection relevant parameters are stored.

Authentication Methods

a) Windows Auth: To use windows (or integrated authentication) leave the corresponding UserName attributes ``WMIUserName`` and ``SQLUserName`` empty.

Example:

.. literalinclude:: _static/Connection.ps1

b) Clear text: Currently, the only alternate option is clear text password authentication. 

Example:

c) Powershell Secure String: Will be supported in a later version.

************************************************************************************
Computers
************************************************************************************



===============
query
===============

Getting information from the web service.



==============================
queue
==============================

Adding a queue element for executing a powershell addon script