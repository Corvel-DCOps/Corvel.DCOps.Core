#region LoadScripts
. "$PSScriptRoot\loadfunctions.ps1"
Load-Function $MyInvocation.MyCommand.Path
#endregion
Export-ModuleMember -Function 'ConvertTo-ByteArray'