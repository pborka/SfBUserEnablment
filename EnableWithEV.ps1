<# 
    Script to enable SfB users using an Excel spreadsheet.
    Syntax: C:\Scripts\EnableUsers.ps1 > output.txt or C:> .EnableUsers.ps1 | Tee-Object -FilePath C:output.txt (Unless using dynamic file path)

    Patrick Borka 
    V 1.0 
    08/29/2017
#>


 
$NewUsers = Import-csv 'C:\Scripts\NewUsers.csv'

Write-Host 'Enabling users...'

ForEach ($Row In $NewUsers) 

    {

     $EMail = $Row.SIPAddress
     $SipAddress = 'SIP:' + $Row.SIPAddress
      $SipAddress = $SipAddress.Trim()      
     $RegistrarPool = $Row.RegistrarPool

     
        Write-Host Enable-CsUser -Identity $Email -RegistrarPool $RegistrarPool -SipAddress $SipAddress -whatif
        
        #Error Check add -whatif
        
    <# To use Hard coded Pool instead of variable above: Enable-CsUser -Identity $Name -RegistrarPool atl-cs-001.litwareinc.com -SipAddress $SipAddress#>
    <# To use E-mail for SIP address instead of variable above: Enable-CsUser -Identity $Name -RegistrarPool atl-cs-001.litwareinc.com -SipAddressType EmailAddress#>

     } 

<#
      
    #Sleeping, so that the next command doesn't fail
    Write-Host 'Sleeping... Please wait...'

    Start-Sleep -s 4
 


    Write-Host 'Configuring users...'

    ForEach ($Row In $NewUsers) 


    {

        $SipAddress = 'SIP:' + $Row.SIPAddress
          $SipAddress = $SipAddress.Trim()    
            
        $RegistrarPool = $Row.RegistrarPool
		
        $ConfPolicy = $Row.ConfPolicy
	
        $LineURI = $Row.LineURI
        
        $DialPlan = $Row.DialPlan
        
        $VoicePol = $Row.VoicePolicy	
        

        #Setting the user as EnterpriseVoice enabled
        Set-CsUser -identity $SipAddress -EnterpriseVoiceEnabled $True
        
        #Setting dial plan
        Grant-CsDialPlan -Identity $SipAddress -PolicyName $DialPlan
        
        #Setting voice policy
        Grant-CsVoicePolicy -Identity $SipAddress -PolicyName $VoicePol
        
        #Setting conferenceing policy
        Grant-CsConferencingPolicy -identity $SipAddress -PolicyName $ConfPolicy
        
        #Set the Line URI
        Set-CsUser -identity $SipAddress -LineUri $LineURI


    } 

 
 #>


