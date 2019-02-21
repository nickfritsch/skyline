<#
    .NOTES
    Script Name: CreateSkylineRole.ps1
    Created on: 02/20/2019
    Author: Nick Fritsch, @nfritsch
    
    .DESCRIPTION
    Script to create vCenter Server role within vCenter Server with all privileges needed for Skyline Collector and Skyline Log Assist to function properly.
    
#>
New-VIRole -Name Skyline -Privilege (Get-VIPrivilege -Role Readonly)
Set-VIRole -Role Skyline -AddPrivilege (Get-VIPrivilege -id Global.Licenses)
Set-VIRole -Role Skyline -AddPrivilege (Get-VIPrivilege -id Global.Settings)
Set-VIRole -Role Skyline -AddPrivilege (Get-VIPrivilege -id Global.Health)
Set-VIRole -Role Skyline -AddPrivilege (Get-VIPrivilege -id Global.Diagnostics)
 
Get-VIPrivilege -Role Skyline
