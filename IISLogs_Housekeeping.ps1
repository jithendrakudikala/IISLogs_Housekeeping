<#
.synopsis
   <<synopsis goes here>>
.Description
  Server health check
.Notes
  ScriptName  : IISLogs_Housekeeping.PS1
  Requires    : Powershell Version 5.0
  Author      : Jithendra Kudikala
  EMAIL       : jithendra.kudikala@gmail.com
  Version     : 1.1 Script will connect to remote server and fetch healthcheck information 
.Parameter
   None
 .Example
   None
#>
Import-Module WebAdministration
$Maxage = "60"
$websites = get-website
foreach($website in $websites)
{
    $DeleteFIles = ($website.logFile.directory).replace("%systemDrives%", $env:SystemDrive) + "\w3svc" + $website.id | Get-ChildItem -File | Where-Object {$_.Lastwritetime -lt (Get-Date).AddDays((-1 * $Maxage))}
    $DeleteFIles | Remove-Item
}
