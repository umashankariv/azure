param(
		$loginId,
		$plainpwd
	)

function getResourceList
{
	param(
		[String][Parameter(Mandatory=$false,ValueFromPipeline=$true)][ValidateSet(“Keyvault”,”VM”,”Storage”,"RedisCache","SQL")]
		$resType="VM"  
		)
}

function loginToSubscription
{
	param(
		$loginId,
		$plainpwd
	)
	try
	{
		$SecurePassword=ConvertTo-SecureString $plainpwd –asplaintext –force 
		$mycreds = New-Object System.Management.Automation.PSCredential ($loginId, $SecurePassword)
		Login-AzureRmAccount -Credential $mycreds
		# fetch subscription name alone using ".name"
		$subname = (Get-AzureRmSubscription | where {$_.Name -like "*SUBS*"}).name
		Write-Host "connecting to sub" $subname
		Select-AzureRmSubscription -SubscriptionName $subname
	}
	catch
	{
		$_.Exception
	}
}
loginToSubscription -loginId $loginId -plainpwd $plainpwd

# .\basics.ps1 -loginId "USERNAME" -plainpwd "PASSWORD"