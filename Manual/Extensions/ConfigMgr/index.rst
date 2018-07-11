Manual for plugin "ConfigMgr"
=============================================================

.. contents:: *In this article:*
  :local:
  :depth: 3


General assumptions:

#. Actions with ``Workflow`` prefix combine multiple actions. Workflow actions exist to standardize frequent used action combos.
#. Every action returns ``Base.Result``. For more info go to Base.Result article.
#. Most of the functions accept parameters via a specific parameter class

************************************************************************************
Connection
************************************************************************************
In the Connection namespace all connection relevant parameters are stored.

Authentication Methods (or integrated authentication)

a) Windows Auth: Do not set the corresponding credentials attributes ``UserName``, ``UserPassword``.

Example:

.. literalinclude:: _static/ConnectionWinAuth.ps1
  :language: powershell

b) Clear text: Set the corresponding credentials attributes ``UserName``, ``UserPassword``.

Example:

.. literalinclude:: _static/ConnectionClearText.ps1
  :language: powershell

c) Powershell Secure String: Will be supported in a later version.

************************************************************************************
Examples
************************************************************************************

======================================================
Create collection, assign app, create membership
======================================================

.. literalinclude:: _static/Example_CreateCollectionAssignApp.ps1
  :language: powershell

=====================================
Example "reseting" existing computer
=====================================
This example shows how to

#. Check whether a computer is found by Hostname
#. Delete every direct collection membership
#. Reset cmputer variables
#. Add new variables
#. Reset PXE flags
#. Add to specific collection

.. literalinclude:: _static/Example_ResetingExistingComputer.ps1
  :language: powershell

************************************************************************************
Generic
************************************************************************************

==============================
GetWMIPredefinedClassProperty
==============================

Get for predefined WMI classes specific properties. Thise queries can either be used to lookup data or to determine of the object exists.

Definition:

.. literalinclude:: _static/GetWMIPredefinedClassProperty.cs
  :language: csharp

a) Get data

Example:

.. literalinclude:: _static/GetWMIPredefinedClassPropertyGetData.ps1
  :language: powershell

b) Check if object exists.

Example:

.. literalinclude:: _static/GetWMIPredefinedClassPropertyObjectExists.ps1
  :language: powershell


************************************************************************************
Computers
************************************************************************************
Everthing concering computer management is stored in the ``Computers`` namespace.







==============================
AddResourceVariables
==============================

Adds variables to a specific computer system.

Example:

.. literalinclude:: _static/ComputerAddResourceVariables.ps1
  :language: powershell

==============================
AdvertisementCreate
==============================

Creates an package advertisement for a specific collection

Example:

.. literalinclude:: _static/AdvertisementCreate.ps1
  :language: powershell

==============================
AssignmentCreate
==============================

Creates an application assignment for users or computers

Example:

.. literalinclude:: _static/AssignmentCreate.ps1
  :language: powershell

==============================
ClearPxeAdvertisementResource
==============================

Clears the PXE advertisements for a computer.

Example:

.. literalinclude:: _static/ComputerClearPxeAdvertisementResource.ps1
  :language: powershell


==============================
CollectionCreate
==============================

Create a collection.

Example:

.. literalinclude:: _static/CollectionCreate.ps1
  :language: powershell


==============================
CollectionMembershipAdd
==============================

Currently the following methods are supported by this action:

- RuleDirectUser
- RuleDirectComputer
- RuleInclude

Example for RuleDirectComputer:

.. literalinclude:: _static/ComputerCollectionMembershipAddRuleDirectComputer.ps1
  :language: powershell


Example for RuleInclude:

.. literalinclude:: _static/ComputerCollectionMembershipAddRuleInclude.ps1
  :language: powershell

========================================
CollectionMembershipRequestRefresh
========================================

Requests a refresh of the effective collection memberships. The request will be performed after the corresponding resource was found in the limiting collection.

Definition:

.. literalinclude:: _static/CollectionMembershipRequestRefresh_Definition.cs
  :language: csharp

Example:

.. literalinclude:: _static/CollectionMembershipRequestRefresh_Example.ps1
  :language: powershell

==============================
CollectionMembershipRemove
==============================

Currently the following methods are supported by this action:

- RuleDirectUser
- RuleDirectComputer

Example for RuleDirectComputer:

.. literalinclude:: _static/ComputerCollectionMembershipRemove.ps1
  :language: powershell

  

==============================
ComputerExists
==============================

Checks wether a computer exists (by Name, MAC or SMBIOSGUID).
Found computers can be deleted directly via secondary function parameter ``DeleteSystem``.

Example:

.. literalinclude:: _static/ComputerExists.ps1
  :language: powershell

==============================
Create
==============================

Creates a computer.

Example:

.. literalinclude:: _static/ComputerCreate.ps1
  :language: powershell

==============================
Delete
==============================

Deletes a computer. Can only be deleted with ResourceId. 
If deleting via Computername, MAC or SMBIOSGUID is needed, use ``ComputerExists`` function.

Example:

.. literalinclude:: _static/ComputerDelete.ps1
  :language: powershell

==============================
DeleteVariables
==============================

Deletes the variables on the corresponding system.

Example:

.. literalinclude:: _static/ComputerDeleteVariables.ps1
  :language: powershell

==============================
PrimaryUserAdd
==============================

Add a user to a computer as a PrimaryUser reference.

Example:

.. literalinclude:: _static/PrimaryUserAdd.ps1
  :language: powershell


==============================
WorkflowCreate
==============================

This worklow combines the following actions:

#. Check if computer exists (Delete if ``ComputerParameters.ComputerOverwriteExistingObject`` is true)
#. Create computer
#. Add variables to computer object
#. Add collection memberships to computer

Example (complete with connection):

.. literalinclude:: _static/ComputerWorkflowCreate.ps1
  :language: powershell

Expected output:

.. literalinclude:: _static/ComputerWorkflowCreate.log

************************************************************************************
Applications
************************************************************************************
Everthing concering application management is stored in the ``Application`` namespace.


==============================
CreateApplication
==============================

Creates an Application with a XML definition provided.

Example (complete with connection):

.. literalinclude:: _static/CreateApplication.ps1
  :language: powershell
