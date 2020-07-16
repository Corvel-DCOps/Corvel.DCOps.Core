function Copy-PreferenceVariables {
   [CmdletBinding()]
   [OutputType([System.Void])]
   param (
      [Parameter(Mandatory=$true)]
      [ValidateScript({$_.GetType().FullName -eq 'System.Management.Automation.PSScriptCmdlet' })]
      [object]$Cmdlet,
      [Parameter(Mandatory=$true)]
      [System.Management.Automation.SessionState]$SessionState
   )

   # Preference Variables and their Common Parameter
   $PreferenceVariables = @{
      'ErrorActionPreference' = 'ErrorAction'
      'DebugPreference' = 'Debug'
      'ConfirmPreference' = 'Confirm'
      'WhatIfPreference' = 'WhatIf'
      'VerbosePreference' = 'Verbose'
      'WarningPreference' = 'WarningAction'
      'InformationPreference' = 'InformationAction'
   }
   
   foreach ($PrefVar in $PreferenceVariables.GetEnumerator()) {
      if (-not $Cmdlet.MyInvocation.BoundParameters.ContainsKey($PrefVar.Value)) {
         if ($CallerVariable = $Cmdlet.SessionState.PSVariable.Get($PrefVar.Key)) {
            if ($SessionState -eq $ExecutionContext.SessionState) {
               Set-Variable -Scope 1 -Name $CallerVariable.Name -Value $CallerVariable.Value -Force -Confirm:$false -WhatIf:$false
            } else {
               $SessionState.PSVariable.Set($CallerVariable.Name, $CallerVariable.Value)
            }
         }
      }
   }
}