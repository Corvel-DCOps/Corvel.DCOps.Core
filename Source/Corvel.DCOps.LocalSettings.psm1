# HashTable containing the default values if a saved value isn't found.
# Not all possible values are here.
$script:DefaultValues = @{
    dcopserver = 'https://dcops.corvel.com'
    dcopdbserver = 'hbdcdcops02'
    maxjsondatacacheage = '900'
 }
 $script:LocalSettingsFile = "$env:APPDATA\Corvel.DCOps\localsettings.json"

#region LoadScripts
. "$PSScriptRoot\loadfunctions.ps1"
Load-Function $MyInvocation.MyCommand.Path
#endregion
