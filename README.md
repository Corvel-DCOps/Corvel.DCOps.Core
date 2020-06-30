# Corvel.DCOps.Core
This module handles the management of settings, both local and shared/global settings for the other Corvel.DCOps modules.
Currently, there is only one local setting:
* The URL of the Shared DCOps Server where the global settings are kept. This defaults to 'https://dcops.corvel.com'.

This module (will) replace the modules in the main Corvel.DCOps module.
* Corvel.DCOps.Settings (and the Corvel.DCOps.Settings.xml)
* Corvel.DCOps.Common (used for retrieving the JSON files stored on the DCOps server)

This is the first module in efforts to split Corvel.DCOps into smaller modules.
