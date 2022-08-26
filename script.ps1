function testFunction {
#if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
      Clear
       Write-Host "The Program is still not yet tested for Mass Usage please use it at your own risk." -ForegroundColor red -BackgroundColor white
       pause
#$exist = if ($(Get-NetFirewallRule -DisplayName "Asia Blocked Port" ) -eq ''){"false"} Else {"true"}
$exist = $(Get-NetFirewallRule -DisplayName "Asia Blocked Port" -erroraction 'silentlycontinue')
$empty=[string]::IsNullOrEmpty($exist) #empty = no connectgion
#-erroraction 'silentlycontinue'
#pause
$FileName  = "$($env:LOCALAPPDATA)\dhananjay\script.ps1"
if($empty) {

Write-Host "No Connection Block Found" -ForegroundColor DarkMagenta -BackgroundColor DarkYellow
   $User = Read-Host -Prompt 'Do you Want to Block HongKong Server Connection ?' 
if( $User.toUpper() -eq 'Y'){
New-NetFirewallRule -DisplayName "Asia Blocked Port" -Direction Outbound -Enabled True -Group "Dhananjay" -Program "Any" -Action Block -RemoteAddress 65.52.164.0-65.52.164.255 > $null
 Write-Host "Execution Successful."
 if (Test-Path $FileName = True) {
  Remove-Item $FileName
}
exit
}elseif ($User.toUpper() -eq 'N'){
exit
}else{
Write-Host "Not a Valid Input"
pause 
exit
}
}else {
    Write-Host "Found a Blocked Connection" -ForegroundColor DarkMagenta -BackgroundColor DarkYellow
   $remove = Read-Host -Prompt ' do you want to remove it ? Y/N' 
   if($remove.ToUpper() -eq 'Y'){
   Remove-NetFirewallRule -DisplayName "Asia Blocked Port" > $null
   Write-Host "Restored Connection , Please Restart your pc if you continue facing issue"
   }else {
   Write-Host "CODE CREATED BY DHANANJAY." -ForegroundColor red -BackgroundColor white 
   pause
   if (Test-Path $FileName = True) {
  Remove-Item $FileName
}
   exit
   }
}
#}
}
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
     Write-Host "Admin Permission Not Found Trying to Elevate" -ForegroundColor DarkBlue -BackgroundColor White 
     pause
        Start-Process powershell.exe -Verb RunAs -ArgumentList ("-noexit  -ExecutionPolicy Bypass -file  `"$($env:LOCALAPPDATA)\dhananjay\script.ps1`" ")
    }
    exit
}
'Acquired Needed Priviledge'
Start-Sleep -Seconds 1
testFunction