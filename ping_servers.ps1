$servers = @('')

$up_servers = @()
$down_servers = @()
$losing_packets = @()
$not_resolving_servers = @()

foreach ($server in $servers)
{

    $ping = ping $server
    $queue_separator = "Lost = (\d)"
    $regex = [string]$ping -match $queue_separator
    $lost_packets = $Matches[1]

    if([int]$lost_packets -eq 4){
        write-host "$server is down"
        $down_servers += $server
      }

    elseif([int]$lost_packets -gt 0 -and [int]$lost_packets -lt 4){
        write-host "$server not completely down. Packets lost $lost_packets out of 4"
        $losing_packets += $server
      }

    elseif([int]$lost_packets -eq 0){
        write-host "$server is up"
        $up_servers += $server
      }

    else {
        write-host "unable to ping $server, fqdn may not be resolving"
        $not_resolving_servers += $server
        }

  }


write-host "`n########## SERVERS UP ##########`n"
$up_servers

write-host "`n########## SERVERS LOSING PACKETS ##########`n"
$losing_packets

write-host "`n########## SERVERS NOT RESOLVING FQDN ##########`n"
$not_resolving_servers

write-host "`n########## DOWN SERVERS ##########`n"
$down_servers

