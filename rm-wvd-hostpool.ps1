
<#
.SYNOPSIS
    Delete a WVD host pool and its resources.
.DESCRIPTION
    This script is intended to delete a windows virtual desktop host pool and its resources. 
    It is still being developed.
        -  Handle multiple subscriptions
        -  Create nested functions
.NOTES
    Test it before you trust it
    Author      : Daniel Zurkan
    Version     : .04
#>

function rm_wvd_hostpool {

    param([parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$hp, [parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$rg)


    # Log in to Azure
    Connect-AzAccount

    #subscription
    # handle multiple subscriptions

    # Check if resource group exists
    # Get resources groups and store the RGN in $listRG
    $listRg = Get-AzResourceGroup | select -exp ResourceGroupName
    
    # If $rg is in $listRg keep goin
    if ($listRg -like $rg){ }
    # If $rg does not exist in $listRg, exit with error
    else {
        $ErrorMessage = $_.Exception.message
        write-error ('Resource group does not exist. ' + $ErrorMessage)
        Exit 
    }

    # Check if host pool exists
    $hostPools = Get-AzWvdHostPool -ResourceGroupName $rg | select -exp Name  



    if ($hostPools -like $hp){ }
    # should this be a function?
    else {
        $ErrorMessage = $_.Exception.message
        Write-Error ('Host pool does not exist. ' + $ErrorMessage)
        Exit 
    }

    # Get confirmation before deleting the host pool
    $title = ""
    $message = "Do you really want to delete host pool $hp from resouce group $rg"
    $yn = '&Yes', '&No'
    $decision = $Host.UI.PromptForChoice($title, $message, $yn, 0) # default = (0) -> yes 

    # If user says yes, delete the host pool and resources
    if ($decision -eq 0) {

        # Delete Application Groups
        # Get application groups in $hp
        $appGrps = Get-AzWvdApplicationGroup -ResourceGroupName $rg |
            # Loop over each object in $appGrps
            ForEach-Object {
            # If the AppGroup's HostPoolArmPath property has the name of the host pool in it, delete that AppGroups
            if ($_.HostPoolArmPath -match $hp){
                # Delete each AppGroup in $hp
                foreach ($i in $_.Name){
                    Write-Host "Removing application group $i from $hp"
                    try {
                        # Delete the Application Group, RGN and Name are required
                        Remove-AzWvdApplicationGroup -ResourceGroupName $rg -Name $i
                    }
                    # Exit if an error occurs
                    catch {
                        $ErrorMessage = $_.Exception.message
                        Write-Error ("Error removing $i " + $ErrorMessage)
                    }
                }
            }
        }

        # Remove Session Hosts
        $sessionHosts = Get-AzWvdSessionHost -ResourceGroupName $rg -HostPoolName $hp |
            ForEach-Object {
                foreach ($i in $_.Name){
                    write-host "Removing session host $i from $hp"
                    try {
                        Remove-AzWvdSessionHost -ResourceGroupName $rg -HostPoolName $hp -Name $i
                    }
                    catch {
                        $ErrorMessage = $_.Exception.message
                        Write-Error ("Error removing $i " + $ErrorMessage)
                    }
                }
            }  

        # Delete the host pool
        Write-Host "Removing Host Pool $hp"
        try {
            Remove-AzWvdHostPool -ResourceGroupName $rg -Name $hp
        }
        catch {
            $ErrorMessage = $_.Exception.message
            Write-Error ("Error removing host pool $hp " + $ErrorMessage)
            Break
        }

    }
}