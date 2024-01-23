#!/bin/bash
# A bash script to update a Cloudflare DNS A record with the external IP of the source machine
# Used to provide DDNS service for my home
# Needs the DNS record pre-creating on Cloudflare
# Modified after: https://gist.github.com/Tras2/cba88201b17d765ec065ccbedfb16d9a

## Cloudflare authentication details, keep these private!
cloudflare_auth_email=your@email.com
# Global Auth Key
cloudflare_auth_key=1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZX

# Cloudflare zone is the zone which holds the record
# Zone ID can be found in the Overview Tab
cloudflare_zoneid=1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZX

# Enable or Disable Cloudflare Proxified IP for the DNS Record
# In most cases you want this on false, because Cloudflare doesnt proxy all ports
proxy=false

# Proxy (Not Cloudflare Proxy) - uncomment and provide details if using a proxy
#export https_proxy=http://<proxyuser>:<proxypassword>@<proxyip>:<proxyport>

# ------------------------------------------------------------------------------

function printHelp {
  echo "Usage: script --domain <sub.domain.com> [OPTIONAL]"
  echo "  WHERE OPTIONAL CAN BE:"
  echo "    --proxy: Enable Proxy (if enabled, does not work for ssh)"
  echo "      abbreviated: -p"
  echo "    --target <ip>: Updates DNS-Record to this predetermined IP-Address"
  echo "      abbreviated: -t <ip>"
}

# ------------------------------------------------------------------------------

# Processing necessary arguments
if [ $# -lt 2 ] || ([ $1 != "--domain" ] && [ $1 != "-d" ]); then
  printHelp
  exit
fi
dnsrecord=$2; shift; shift

# ------------------------------------------------------------------------------

# Looping through optional arguments
while [ $# -gt 0 ]; do
  case "$1" in
    
    # Proxy Argument
    --proxy|-p)
      echo "Enabled Proxy for the Domain"
      proxy=true
    ;;
    
    # Target Argument, requires one additional value
    --target|-t)
      if [ $# -lt 2 ]; then
        echo "Error: Target requires one additional argument for the IP-Address"
	printHelp
	exit
      else
	ip=$2
	echo "Set Target IP to $ip"
	shift
      fi
    ;;
  esac
  shift
done

# ------------------------------------------------------------------------------

# Get the current external IP address
if [ -z "$ip" ]; then
  echo "Investigating current external IP Address"
  #ip=$(dig +short txt ch whoami.cloudflare @1.0.0.1 | tr -d '"')
  ip=$(curl https://ipinfo.io/ip)
  echo "Current IP is $ip"
  
  # Checking if Record already uses this IP to prevent useless cloudflare API Calls
  if host $dnsrecord 1.1.1.1 | grep "has address" | grep "$ip"; then
    echo "$dnsrecord is currently set to $ip; no changes needed"
    exit
  fi
fi

# ------------------------------------------------------------------------------
# if here, the dns record needs updating

# get the dns record id
dnsrecordid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$cloudflare_zoneid/dns_records?type=A&name=$dnsrecord" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "X-Auth-Key: $cloudflare_auth_key" \
  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')

echo "DNS Record ID for $dnsrecord is $dnsrecordid"

# update the record
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$cloudflare_zoneid/dns_records/$dnsrecordid" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "X-Auth-Key: $cloudflare_auth_key" \
  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"$dnsrecord\",\"content\":\"$ip\",\"ttl\":1,\"proxied\":$proxy}" | jq


# Possibile Integration with a Webhook here, not implemented yet
