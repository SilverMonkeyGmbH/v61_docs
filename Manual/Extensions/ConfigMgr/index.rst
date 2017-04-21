Manual for plugin "ConfigMgr"
=============================================================

.. contents:: *In this article:*
  :local:
  :depth: 3


.. warning:: This article is under construction! Please DO NOT use any of the instructions below, yet! You may cause damage to your system. This article will be finished soon.

General assumptions:

#. Actions with ``Workflow`` prefix combine multiple actions. Workflow actions exist to standardize frequent used action combos.
#. Every action

************************************************************************************
Connection
************************************************************************************
In the computers namespace all connection relevant parameters are stored.

Authentication Methods (or integrated authentication)

a) Windows Auth: Do not set the corresponding credentials attributes *UserName, *UserPassword.

Example:

  .. literalinclude:: _static/ConnectionWinAuth.ps1
    :language: powershell

b) Clear text: Set the corresponding credentials attributes *UserName, *UserPassword.

Example:

  .. literalinclude:: _static/ConnectionClearText.ps1
    :language: powershell

c) Powershell Secure String: Will be supported in a later version.

************************************************************************************
Computers
************************************************************************************
Everthing concering computer management is stored in the ``Computers`` namespace.

==============================
Action WorkflowCreate
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


==============================
AddCollectionMembership
==============================

Currently the following methods are supported by this action:

- RuleDirectUser
- RuleDirectComputer
- RuleInclude

Example for RuleDirectComputer:

.. literalinclude:: _static/ComputerAddCollectionMembershipRuleDirectComputer.ps1
  :language: powershell


Example for RuleInclude:

.. literalinclude:: _static/ComputerAddCollectionMembershipRuleInclude.ps1
  :language: powershell

==============================
AddResourceVariables
==============================

Adds variables to a specific computer system.

Example:

.. literalinclude:: _static/ComputerAddResourceVariables.ps1
  :language: powershell

==============================
ComputerExists
==============================

Checks wether a computer exists (by Name, MAC or SMBIOSGUID).

Found computers can be deleted directly via secondary function parameter ``DeleteSystem``.

Example:

.. literalinclude:: _static/ComputerComputerExists.ps1
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



