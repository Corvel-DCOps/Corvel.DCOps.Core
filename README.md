# **Corvel.DCOps.Core**
A collection of generic commands useful for the other DCOps PowerShell Modules.
This is the module in what will be serveral modules as I work on splitting out the
Corvel.DCOps module into smaller, more manageable modules that are more task specific.

This module will expand somewhat moving forward but, hopefully, not too much. 

This module relies heavily on the 'DCOps Host'. The DCOps Host is a web server that is
the central/shared server for the Datacenter Operations team. Primarily, it provides access 
to the various Json data files used by many of the scripts and modules used for automating tasks
and processes. Additionally, the server also hosts the 'DCOpsRepo' PowerShell Repository  and 
is the server where most of the scheduled scripts are ran from.

# Corvel.DCOps.JsonData
This module handles retrieving and saving Json data files to the DCOps Host. Included, is a simple caching system 
so that data files do not have to be retrieved from the server with every call. 

# Corvel.DCOps.LocalSettings
This module handles local/user specific settings, such as the location of the DCOps host.
The local settings file is located at %APPDATA%\Corvel.DCOps\localsettings.json.
Built in defaults (as of version 1.0.0) are:
* dcopshost: http://dcops.corvel.com
* dcopdbserver: hbdcdcops02
* maxjsondatacacheage: 900

# Corvel.DCOps.SharedSettings
This module handles the shared/global settings maintained on the DCOps Host. 
