# DCOpsHost
## about_DCOpsHost

# SHORT DESCRIPTION
The DCOps Host is a centrally accesible server used by the Datacenter team.

# LONG DESCRIPTION
The DCOps Host is a centrally accesible server used by the Datacenter team 
to provide a variety of services such as shared settings, credentials and a 
PowerShell repository. 

The server is (at this time) a Windows 2019 Server running IIS 7.5 to provide
https access to shared Json data files used for shared settings, shared credentials
and the 'DCOpsRepo' (the Datacenter team PowerShell repository). Additionally, the 
server also serves as the 'ScriptingServer' for running automation tasks.

In DNS, a cname record ('dcops.corvel.com') points to the actual Windows server with the 
shared services. 

Commands that rely on the DCOps Host have an optional parameter (DCOpsHost) to specify
the DCOps Server. If the parameter is not specified (which it usually doesn't need to be),
the local setting 'dcopshost' is used and, if that isn't present, the System Default 
(a hard coded value) is used. The Parameter primarily exists to aid the development efforts
for this and other modules. 

# SEE ALSO
- Online Version https://github.com/Corvel-DCOps/Corvel.DCOps.Core/blob/main/Source/docs/about_DCOPsHost.md
- Get-DCOpsLocalSetting
- Set-DCOpsLocalSetting
