function Disable-SslCertificateValidation {
   [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingEmptyCatchBlock', '', Scope = 'Function', Target = '*')]
   [CmdletBinding()]
   param ()
   if ($PSVersionTable.PSEdition -eq 'Desktop') {
      $TypeDefinition = @'
	using System.Net;
	using System.Security.Cryptography.X509Certificates;
	public class TrustAllCertsPolicy : ICertificatePolicy {
		 public bool CheckValidationResult(
			  ServicePoint srvPoint, X509Certificate certificate,
			  WebRequest request, int certificateProblem) {
			  return true;
		 }
	}
'@
      if ($null -eq ([System.Management.Automation.PSTypeName]'TrustAllCertsPolicy').Type) {
         try {
            Add-Type -TypeDefinition $TypeDefinition -ErrorAction SilentlyContinue -Verbose:$false
         }
         catch {
            # Just suppressing any errors that may occur because the type already exists and we can't tell
         }
      }
      [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
   } else {
      Write-Warning 'Disable-SslCertificateValidation is not supported on PowerShell Core.'
      throw [System.PlatformNotSupportedException]
   }
}