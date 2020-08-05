function Disable-SslCertificateValidation {
   [CmdletBinding()]
   param ()

   $TypeDefinition = @"
	using System.Net;
	using System.Security.Cryptography.X509Certificates;
	public class TrustAllCertsPolicy : ICertificatePolicy {
		 public bool CheckValidationResult(
			  ServicePoint srvPoint, X509Certificate certificate,
			  WebRequest request, int certificateProblem) {
			  return true;
		 }
	}
"@
   if (([System.Management.Automation.PSTypeName]'TrustAllCertsPolicy').Type -eq $Null) {
      try {
         Add-Type -TypeDefinition $TypeDefinition  -ErrorAction SilentlyContinue -Verbose:$false
      }
      catch {
         # Just suppressing any errors that may occur because the type already exists and we can't tell
      }
   }
   [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
}