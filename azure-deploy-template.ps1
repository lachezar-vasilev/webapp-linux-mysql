
#Connect-AzAccount
#New-AzureRmResourceGroup RG-deploytest "West Europe"
#$pw = Read-Host "Enter Pass for VM" -AsSecureString
#New-AzureRmResourceGroupDeployment -ResourceGroupName $rg.ResourceGroupName -TemplateFile azure-testdeploy.json -TemplateParameterFile parameters.json -adminUsername admin123456 -adminPassword $pw



Clear-Host

###### LOGFILE
$logfile = "c:\windows\logs\azure-template-deploy-"+(Get-Date -Format 'ddMMyyyy-HHmm')+".log"

###### START CONSOLE RECORDING
Start-Transcript -Path $logfile -Append

###### SET EXECUTION POLICY 
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force

###### AZURE TENANT SIGN-IN
Write-Host
Write-Host
Write-Host
Write-Host "    ================ Sign-in Tenant ================"
Write-Host
Write-Host "          [1]: MENTORMATE"
Write-Host "          [2]: ORTHOLOGY"
Write-Host "          [3]: RAYEDIE"
Write-Host "                                  Press 'Q' to quit."
Write-Host "    ================================================"
Write-Host
$selection = Read-Host "Please make a selection"
	
switch ($selection)
 {
       '1' {
         Connect-AzAccount -Tenant 3eaf366b-e9a9-4eca-b7ab-e5fa337c1fc3
		   } 
	     '2' {
         Connect-AzAccount -Tenant 3a07883a-9a4f-4fa2-baa9-74333ce2926b
		   }
       '3' {
         Connect-AzAccount -Tenant 8bb36e0c-62be-4c06-a562-733ed2b41f71
           }
       'q' {
         return
           }
 }
 
Write-Host
Write-Host
 
Get-AzResourceGroup
 
Write-Host
Write-Host

Write-Host 'Press any key to be created new resource group' -ForegroundColor yellow
Write-Host -NoNewLine 'and to start template deployment...' -ForegroundColor yellow
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Write-Host

###### RESOURCE GROUP
$rg = "rgr-test-" + (Get-Random -Maximum 100000)
New-AzResourceGroup -Name $rg -Location centralus

###### URL TEMPLATE
#$templateUri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-webapp-linux-managed-mysql/azuredeploy.json"
#$paramUri    = ""
$templateUri1= "https://raw.githubusercontent.com/lachezar-vasilev/webapp-linux-mysql/master/2.test-template-vault.json"
$paramUri1   = "https://raw.githubusercontent.com/lachezar-vasilev/webapp-linux-mysql/master/2.test-parameters-vault.json"

###### DEPLOYMENT
#New-AzResourceGroupDeployment -ResourceGroupName $rg -TemplateUri $templateUri -DeploymentDebugLogLevel All

Write-Host -NoNewLine 'Press any key to deploy next template...' -ForegroundColor yellow
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Write-Host
Write-Host

New-AzResourceGroupDeployment -ResourceGroupName $rg -TemplateUri $templateUri1 -TemplateParameterUri $paramUri1 -DeploymentDebugLogLevel All


###### STOP CONSOLE RECORDING
Stop-Transcript








###### NOT USED
#New-AzResourceGroupDeployment -ResourceGroupName $rg -TemplateFile $template -TemplateParameterFile $param -DeploymentDebugLogLevel All
#-TemplateParameterUri $paramUri
#$template = "g:\My Drive\Azure\Code\azure-weblinux-mysql.json"
#$param     = "g:\My Drive\Azure\Code\"




























