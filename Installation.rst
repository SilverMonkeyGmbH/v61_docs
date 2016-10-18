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

Installation Setup
^^^^^^^^^^^^^^^^^^^^
Start the SQL Server installation setup.
Choose the "New SQL Server stand-alone installation..."-Option in the follwing Window:

  .. image:: _static/install/SQLServerInstallation_00.png

Throughout the installation, please choose the same features as shown below:

  .. image:: _static/install/SQLServerInstallation_01.png

Name the instance SIM or choose another name:

  .. image:: _static/install/SQLServerInstallation_02.png

Configurate the server as follows:

  .. image:: _static/install/SQLServerInstallation_03.png

Choose the Database Engine called 'SQL_Latin_General_CP1_CI_AS': 

  .. image:: _static/install/SQLServerInstallation_04.png

Select the 'mixed mode'-authentification and add your SQL service account as SQL Server administrator:

  .. image:: _static/install/SQLServerInstallation_05.png

You have completed the setup!


SQL Server TCP/IP Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Open the SQL Server Configuration Manager, choose 'SQL Server Network Configuration' and then 'Protocols for [Database Name]'. Change the  TCP/IP Status to *Enabled*:

  .. image:: _static/install/SQLServerInstallation_06.png

Right-click the TCP/IP line and choose 'Properties':

  .. image:: _static/install/SQLServerInstallation_07.png

Choose the tab "IP Adresses" and change the 'TCP Port'-entry to 1433:

  .. image:: _static/install/SQLServerInstallation_08.png

Afterwards, navigate to the SQL Server Services and restart the 'SQL Server ([Database Name]):

  .. image:: _static/install/SQLServerInstallation_09.png


SIM SQL DB Service Account
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Visit: :doc:`/KnowledgeBase/KB00020_SIM-SQL_DB-Rights/index` to see how to create the Silver Monkey service account necessary for the DB connection. 

You finished the basic SQL Server installation for Silver Monkey.



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