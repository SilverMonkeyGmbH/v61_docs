Installation
=============

.. contents:: `In this article:`
    :depth: 2
    :local:
    

Requirements
----------------------------
For general information on system requirements see :doc:`/Requirements`.


IIS Features
----------------------------
Execute the following command to enable IIS features on the application server:

  .. literalinclude:: /_static/Install.cmd
    :language: batch

See :download:`Download Script </_static/Install.cmd>`.


Microsoft SQL Server
----------------------------
For information about supported SQL Server versions see :doc:`/SupportedConf`

The installation of the SQL Server will be described in the following steps.


Install the .NET Core Windows Server Hosting bundle
---------------------------------------------------

#. Install the `.NET Core Windows Server Hosting <https://go.microsoft.com/fwlink/?LinkID=827547>`__ bundle on the server. The bundle will install the .NET Core Runtime, .NET Core Library, and the ASP.NET Core Module. The module creates the reverse-proxy between IIS and the Kestrel server.
#. Restart the server or execute **net stop was /y** followed by **net start w3svc** from the command-line to pickup changes to the system PATH.


Create SilverMonkey folder
----------------------------

#. Create C:\SilverMonkey
#. Copy files from installation media


Create IIS App Pool
----------------------------

#. Go to IIS Manager and create the following App Pool:

.. image:: _static/install/AppPool.png