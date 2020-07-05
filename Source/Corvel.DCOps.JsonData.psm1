# Cache objects retrieved so we don't have to get them every time
# Age of objects in the cache controlled by LocalSetting maxjsondatacacheage
$script:DCOpsJsonDataCache = [System.Collections.Generic.List[object]]@()

#region LoadScripts
. "$PSScriptRoot\loadfunctions.ps1"
Load-Function $MyInvocation.MyCommand.Path
#endregion