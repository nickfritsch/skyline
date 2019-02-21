<#
    .NOTES
    Script Name: CreateSkylineRole.ps1
    Created on: 02/20/2019
    Author: Nick Fritsch, @nfritsch
    
    .DESCRIPTION
    Script to create vCenter Server role within vCenter Server with all privileges needed for Skyline Collector and Skyline Log Assist to function properly.
    
#>
$vCenterServer = "vCenter_Server_FQDN/IP_Address"

$RoleExists = Get-VIRole -Server $vCenterServer -Role Skyline

If ($RoleExists) {
    Write "Skyline Role Already Exists"
    Exit
}
Else {
    Write "Skyline Role Will Be Created"

New-VIRole -Name Skyline -Privilege (Get-VIPrivilege -Role Readonly)
Set-VIRole -Role Skyline -AddPrivilege (Get-VIPrivilege -id Global.Licenses)
Set-VIRole -Role Skyline -AddPrivilege (Get-VIPrivilege -id Global.Settings)
Set-VIRole -Role Skyline -AddPrivilege (Get-VIPrivilege -id Global.Health)
Set-VIRole -Role Skyline -AddPrivilege (Get-VIPrivilege -id Global.Diagnostics)
 
Get-VIPrivilege -Role Skyline
