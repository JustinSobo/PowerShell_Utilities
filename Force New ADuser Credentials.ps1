Set-ADAccountPassword -Identity 'CN=Mike Pruett,OU=SBSUsers,OU=Users,OU=MyBusiness,DC=bhdefense,DC=local' -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "BHD_2018!!" -Force)
