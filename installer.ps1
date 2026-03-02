Write-Host "Creating portable version of Visual Studio Code..."
Write-Host "Creating vscode-porteable directory and downloading the latest stable version of Visual Studio Code for Windows 64-bit as a zip archive..."
mkdir vscode-porteable
curl -o vscode-porteable/vscode-porteable.zip 'https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-archive'

Write-Host "Moving to vscode-porteable directory and extracting the downloaded zip archive..."
Set-Location vscode-porteable
7z x -y  vscode-porteable.zip

Write-Host "Extracted the zip archive to $PWD."

Write-Host "Do you want to delete the downloaded zip archive? (y/n)"
$deleteZip = Read-Host
if ($deleteZip -eq 'y') {
    try {
    Remove-Item vscode-porteable.zip
    }
    catch {
        <#Do this if a terminating exception happens#>
        Write-Error "An error occurred while trying to delete the zip archive: $_"
    }
}
else {
    Write-Host "Keeping the downloaded zip archive."
}

Write-Host "Portable version of Visual Studio Code has been created successfully in the vscode-porteable directory."

Write-Host "Thx for using this installer script! If you have any feedback or suggestions, please let me know."
Write-Host "https://github.com/involvex/vscode-porteable-installer"

Write-Host "Consider starring the repository if you find this project useful! It helps a lot and is greatly appreciated!"
Write-Host "Sponspor this project on GitHub: https://github.com/sponsors/involvex"
Write-Host "or buy me a coffee: https://www.buymeacoffee.com/involvex"
Write-Host "PayPal: https://paypal.me/involvex"
Write-Host "or just use the Ref link for Bing Rewards https://rewards.bing.com/welcome?rh=14525F68&ref=rafsrchae&form=ML2XE3&OCID=ML2XE3&PUBL=RewardsDO&CREA=ML2XE3"