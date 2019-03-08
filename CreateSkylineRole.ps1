<#
    .NOTES
    Script Name: CreateSkylineRole.ps1
    Created on: 02/20/2019
    Author: Nick Fritsch, @nfritsch
    
    .DESCRIPTION
    Script to create vCenter Server role within vCenter Server with all privileges needed for Skyline Collector and Skyline Log Assist to function properly.
    
#>
$vCenterServer = "vCenter_Server_FQDN/IP_Address"
$SkylineRole = "Name of Skyline Role"
$RoleExists = Get-VIRole -Server $vCenterServer -Role $SkylineRole

Write-Host "Connecting to $vCenterServer"'n -ForeGroundColor Blue
Connect-VIServer $vCenterServer

Write-Host "Check Skyline Role Already Exists"'n -ForeGroundColor Blue
If ($RoleExists) {
    Write "Skyline Role Already Exists"
    Exit
}
Else {
    Write "Skyline Role Will Be Created"

Write-Host "Creating Skyline Role"'n -ForeGroundColor Blue
New-VIRole -Name $SkylineRole -Privilege (Get-VIPrivilege -Role Readonly)
$SkylinePrivleges = @(
  'Global.Licenses'
  'Global.Settings'
  'Global.Health'
  'Global.Diagnostics')
Set-VIRole -Name $SkylineRole -Privilege (Get-VIPrivilege -id $SkylinePrivleges) | Out-Null
#Set-VIRole -Role $SkylineRole -AddPrivilege (Get-VIPrivilege -id Global.Licenses)
#Set-VIRole -Role $SkylineRole -AddPrivilege (Get-VIPrivilege -id Global.Settings)
#Set-VIRole -Role $SkylineRole -AddPrivilege (Get-VIPrivilege -id Global.Health)
#Set-VIRole -Role $SkylineRole -AddPrivilege (Get-VIPrivilege -id Global.Diagnostics)

Write-Host "Disconnecting from $vCenterServer"'n -ForeGroundColor Blue
Disconnect-VIServer -Server $vCenterServer -Confirm:$false
