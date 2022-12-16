#requries -Version 2.0
 
<#
       Requires Exchange Web Service Managed API 2.0 Installed
 
       https://www.microsoft.com/en-us/download/details.aspx?id=35371
       
       Requires Application impersonation role
 
       http://support.xink.io/support/solutions/articles/1000157751-how-to-assign-application-impersonation-in-admin-center-office-365-
#>
 
$Credential = Get-Credential
 
#User that Contacts will be exported for
$SmtpAddress = "test@test.com"
 
#Directory that csv will be outputed to
$FileSavedPath = "c:/temp"
 
Add-Type -AssemblyName System.Core
 
#Confirm the installation of EWS API
$webSvcInstallDirRegKey = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Exchange\Web Services\2.0" -PSProperty "Install Directory" -ErrorAction:SilentlyContinue
if ($webSvcInstallDirRegKey -ne $null) 
{
    $moduleFilePath = $webSvcInstallDirRegKey.'Install Directory' + 'Microsoft.Exchange.WebServices.dll'
    Import-Module $moduleFilePath
} 
else 
{
    $errorMsg = "Please install Exchange Web Service Managed API 2.0"
    throw $errorMsg
}
       
#Establish the connection to Exchange Web Service
 
$verboseMsg = $Messages.EstablishConnection
write-host "$verboseMsg"
$exService = New-Object Microsoft.Exchange.WebServices.Data.ExchangeService(`
                    [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::$ExchangeVersion)
                    
#Set network credential
$userName = $Credential.UserName
$exService.Credentials = $Credential.GetNetworkCredential()
            
 
Try
{
       #Set the URL by using Autodiscover
       $exService.AutodiscoverUrl($userName,{$true})
       $verboseMsg = $Messages.SaveExWebSvcVariable
       write-host "$verboseMsg"
       Set-Variable -Name exService -Value $exService -Scope Global -Force
}
Catch [Microsoft.Exchange.WebServices.Autodiscover.AutodiscoverRemoteException]
{
       write-host "$_"
}
Catch
{
       write-host "$_"
}
[regex]$reg = ".+(?=@)"
$FileSavedFullPath = $FileSavedPath + "\" + $($reg.Match($SmtpAddress)) + ".csv"
 
$exService.ImpersonatedUserId = new-object Microsoft.Exchange.WebServices.Data.ImpersonatedUserId([Microsoft.Exchange.WebServices.Data.ConnectingIdType]::SmtpAddress,$smtpAddress);
$ExportCollection = @()
Write-Host "Process Contacts"
$folderid= new-object Microsoft.Exchange.WebServices.Data.FolderId([Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::Contacts,$SmtpAddress)   
$Contacts = [Microsoft.Exchange.WebServices.Data.Folder]::Bind($exService,$folderid)
$psPropset = new-object Microsoft.Exchange.WebServices.Data.PropertySet([Microsoft.Exchange.WebServices.Data.BasePropertySet]::FirstClassProperties) 
 
#Define ItemView to retrive just 1000 Items    
$ivItemView =  New-Object Microsoft.Exchange.WebServices.Data.ItemView(1000)    
$fiItems = $null    
do{    
    $fiItems = $exservice.FindItems($Contacts.Id,$ivItemView) 
    [Void]$exservice.LoadPropertiesForItems($fiItems,$psPropset)  
    foreach($Item in $fiItems.Items)
    {     
             if($Item -is [Microsoft.Exchange.WebServices.Data.Contact])
        {
                    $expObj = "" | select DisplayName,GivenName,Surname,Email1DisplayName,Email1Type,Email1EmailAddress,BusinessPhone,MobilePhone,HomePhone,BusinessStreet,BusinessCity,BusinessState,HomeStreet,HomeCity,HomeState
                    $expObj.DisplayName = $Item.DisplayName
                    $expObj.GivenName = $Item.GivenName
                    $expObj.Surname = $Item.Surname
                    $BusinessPhone = $null
                    $MobilePhone = $null
                    $HomePhone = $null
                    if($Item.PhoneNumbers -ne $null){
                    if($Item.PhoneNumbers.TryGetValue([Microsoft.Exchange.WebServices.Data.PhoneNumberKey]::BusinessPhone,[ref]$BusinessPhone)){
                                $expObj.BusinessPhone = $BusinessPhone
                          }
                    if($Item.PhoneNumbers.TryGetValue([Microsoft.Exchange.WebServices.Data.PhoneNumberKey]::MobilePhone,[ref]$MobilePhone)){
                                $expObj.MobilePhone = $MobilePhone
                          }      
                    if($Item.PhoneNumbers.TryGetValue([Microsoft.Exchange.WebServices.Data.PhoneNumberKey]::HomePhone,[ref]$HomePhone)){
                                $expObj.HomePhone = $HomePhone
                          }      
                    }                   
             if($Item.EmailAddresses.Contains([Microsoft.Exchange.WebServices.Data.EmailAddressKey]::EmailAddress1)){                          
                          $expObj.Email1DisplayName = $Item.EmailAddresses[[Microsoft.Exchange.WebServices.Data.EmailAddressKey]::EmailAddress1].Name
                          $expObj.Email1Type = $Item.EmailAddresses[[Microsoft.Exchange.WebServices.Data.EmailAddressKey]::EmailAddress1].RoutingType
                          $expObj.Email1EmailAddress = $Item.EmailAddresses[[Microsoft.Exchange.WebServices.Data.EmailAddressKey]::EmailAddress1].Address
                    }
                    $HomeAddress = $null
                    $BusinessAddress = $null
                    if($item.PhysicalAddresses -ne $null){
                    if($item.PhysicalAddresses.TryGetValue([Microsoft.Exchange.WebServices.Data.PhysicalAddressKey]::Home,[ref]$HomeAddress)){
                                $expObj.HomeStreet = $HomeAddress.Street
                                 $expObj.HomeCity = $HomeAddress.City
                                 $expObj.HomeState = $HomeAddress.State
                          }
                    if($item.PhysicalAddresses.TryGetValue([Microsoft.Exchange.WebServices.Data.PhysicalAddressKey]::Business,[ref]$BusinessAddress)){
                                $expObj.BusinessStreet = $BusinessAddress.Street
                                 $expObj.BusinessCity = $BusinessAddress.City
                                 $expObj.BusinessState = $BusinessAddress.State
                          }
                    }
                    $ExportCollection += $expObj
             }
    }    
    $ivItemView.Offset += $fiItems.Items.Count    
}while($fiItems.MoreAvailable -eq $true) 
 
 
 
$ExportCollection | Export-Csv -NoTypeInformation $FileSavedFullPath
