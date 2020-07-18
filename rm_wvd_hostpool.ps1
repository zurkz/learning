<#
    .SYNOPSIS
        This script is intended to delete an Azure WVD host pool and its resources.

    .DESCRIPTION
        This script will take the user supplied host pool and delete any associated Remote Application groups,
        Desktop Application group, session hosts, and then the host pool.

    .EXAMPLE
        rm_wvd_hostpool -rg <resourcegroup> -hp <hostpool>

    .NOTES
        Only tested on a account with one subscription, zero session hosts, and zero applications.
        YMMV

        TODO:
            - Handle multiple subscriptions.
            - Look into nested functions.
            - Test with session hosts and applications.
            - Handle errors better.
            - Improve code.
        
        Version: .4.03
    #>

function rm_wvd_hostpool {

    # Inputs for the function. Both parameters are required and cannot be null
    param(
        [parameter(Mandatory=$true,HelpMessage="Enter a host pool name")]
        [ValidateNotNullOrEmpty()]
        [Alias("hp")][string]$hostpool, 

        [parameter(Mandatory=$true,HelpMessage="Enter a resource group")]
        [ValidateNotNullOrEmpty()]
        [Alias("rg")][string]$resourcegroup)

    # Log in to Azure
    if ($null -eq (Get-AzContext -ErrorAction SilentlyContinue)) {
        Write-Output "Log in to Azure with an account that has permissions to delete a host pool" -ForegroundColor Red
        Connect-AzAccount
    }
    
    #subscription
    # handle multiple subscriptions

    # Check if resource group exists
    # Get resources groups and store the RGN in $listRG
    $listRg = Get-AzResourceGroup | select -exp ResourceGroupName
    
    # If $rg is in $listRg keep goin
    if ($listRg -like $resourcegroup){ }
    # If $rg does not exist in $listRg, exit with error
    else {
        $ErrorMessage = $_.Exception.message
        Write-Error ('Resource group does not exist. ' + $ErrorMessage)
        Exit 
    }

    # Check if host pool exists
    $hostPools = Get-AzWvdHostPool -ResourceGroupName $resourcegroup | select -exp Name  

    if ($hostPools -like $hostpool){ }
    # should this be a function?
    else {
        $ErrorMessage = $_.Exception.message
        Write-Error ('Host pool does not exist. ' + $ErrorMessage)
        Exit 
    }

    # Get confirmation before deleting the host pool
    $title = ""
    $message = "Do you really want to delete host pool $hostpool from resouce group $resourcegroup"
    $yn = '&Yes', '&No'
    $decision = $Host.UI.PromptForChoice($title, $message, $yn, 0) # default = (0) -> yes 

    # If user says yes, delete the host pool and resources
    if ($decision -eq 0) {

        # Delete Application Groups
        # Get application groups in $hp
        $appGrps = Get-AzWvdApplicationGroup -ResourceGroupName $resourcegroup |
            # Loop over each object in $appGrps
            ForEach-Object {
            # If the AppGroup's HostPoolArmPath value has the name of the host pool in it, delete that AppGroup
            if ($_.HostPoolArmPath -match $hostpool){
                # Delete each AppGroup in $hp
                foreach ($i in $_.Name){
                    Write-Host "Removing application group $i from $hostpool"
                    try {
                        # Delete the Application Group, RGN and Name are required
                        Remove-AzWvdApplicationGroup -ResourceGroupName $resourcegroup -Name $i
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
        $sessionHosts = Get-AzWvdSessionHost -ResourceGroupName $resourcegroup -HostPoolName $hostpool |
            ForEach-Object {
                foreach ($i in $_.Name){
                    write-host "Removing session host $i from $hostpool"
                    try {
                        Remove-AzWvdSessionHost -ResourceGroupName $resourcegroup -HostPoolName $hostpool -Name $i
                    }
                    catch {
                        $ErrorMessage = $_.Exception.message
                        Write-Error ("Error removing $i " + $ErrorMessage)
                    }
                }
            }  

        # Delete the host pool
        Write-Host "Removing Host Pool $hostpool"
        try {
            Remove-AzWvdHostPool -ResourceGroupName $resourcegroup -Name $hostpool
        }
        catch {
            $ErrorMessage = $_.Exception.message
            Write-Error ("Error removing host pool $hostpool " + $ErrorMessage)
            Break
        }
    }
    else {
        Write-Host 'Host pool deletion cancelled'
        exit
    }
}