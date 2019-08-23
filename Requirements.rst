Requirements
============

Application Server (IIS)
----------------------------
-	Microsoft Windows Server 2016 or higher
-	Internet Information Server
-	Microsoft .NET Core 2.x

To Check if .Net Core is installed, run the following cmd command and check the output.

.. literalinclude:: /_static/install/Test-dotnet_Core1.0.1.cmd
  :language: batch



Install the .NET Core Windows Server Hosting bundle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Install the `.NET Core Windows Server Hosting <https://go.microsoft.com/fwlink/?linkid=844461>`__ bundle on the server. The bundle will install the .NET Core Runtime, .NET Core Library, and the ASP.NET Core Module. The module creates the reverse-proxy between IIS and the Kestrel server.
#. Restart the server or execute **net stop was /y** followed by **net start w3svc** from the command-line to pickup changes to the system PATH.

.. important:: Make sure that module is available in IIS/Modules: 
  
  .. image:: _static/install/AspNetCoreModule.png


Database Server (SQL)
----------------------------
-	For Application: Microsoft SQL Server 2017 or higher 
-	Or Microsoft SQL Server Express with **Advanced Services**
- For SCCM Database: Microsoft SQL Server 2017 (a lower version causes limited functions)


Server Hardware Requirements (IIS+SQL)
--------------------------------------------------------
The system requirements for processors, RAM and hard disk space depend on the size of the correspondig ConfigMgr environment and the number of users working at the same time. Anyway, there is always the option to easily move the application to a more powerful machine or to distribute it across several servers with load balancing.

In addition to the requirements of the operating system, the following conditions arise:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
- 2 CPUs 2GHz+
- RAM	4GB
- Database size	500MB
- Website/Application files	150MB

(Valid for up to 10,000 systems and 20 concurrent users on the Web Application)


Workplace Systems
----------------------------
-	Microsoft Internet Explorer (not supported but works)
- Microsoft Edge
-	Mozilla FireFox
-	Google Chrome

