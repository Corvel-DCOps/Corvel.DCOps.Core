function Set-DynamicParameter {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Scope = 'Function', Target = '*')]
    [CmdletBinding()]
    [OutputType([System.Management.Automation.RuntimeDefinedParameterDictionary])]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ParameterName,
        [Parameter(Mandatory = $true)]
        [string[]]$Values,
        [int]$Position = 0,
        [switch]$IsArray,
        [switch]$IsMandatory,
        [string]$ParameterSetName,
        [System.Management.Automation.RuntimeDefinedParameterDictionary]$RuntimeParameterDictionary
    )
    if ($IsArray) {
        $ParameterType = [array]
    }
    else {
        $ParameterType = [string]
    }
    if (! $RuntimeParameterDictionary) {
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
    }
    $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
    $ParameterAttribute.Mandatory = $IsMandatory
    $ParameterAttribute.Position = $Position
    if ($PSBoundParameters.ContainsKey('ParameterSetName')) {
        $ParameterAttribute.ParameterSetName = $ParameterSetName
    }
    $AttributeCollection.Add($ParameterAttribute)
    $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($Values)
    $AttributeCollection.Add($ValidateSetAttribute)
    $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, $ParameterType, $AttributeCollection)
    $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
    Return $RuntimeParameterDictionary
}
