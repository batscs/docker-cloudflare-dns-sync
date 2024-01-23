### Table of Contents  
[Introduction](#introduction)  
[Installation (Without Docker)](#installation)  
[Installation (With Docker)](#docker-installation)  
[Script Usage](#script)  

<a name="introduction"/>

### Introduction
This is a bash script to continously update and refresh a cloudflare dns record with the public / external IP Address of the host system running the script (or a predetermined IP Address).

<a name="installation"/>

### Installation (Without Docker)
1. Download the cloudflare-dns-sync.sh file to your desired  
  
Enter this into your terminal of choice to automatically deploy this script. Otherwise manually the cloudflare-dns-sync.sh file of this repository in a directory of your choice
```
mkdir -p ~/.cloudflare; curl https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/cloudflare-dns-sync.sh > ~/.cloudflare/cloudflare-dns-sync.sh
```
2. Automate this script with a cronjob
  
Open the Crontab Editor with this command in your terminal
```
crontab -e
```
  

Configure your crontab in this format (assuming you used the directory of the automatically deployed script in step 1)
```
*/10 * * * * ~/.clouflare/cloudflare-dns-sync.sh --domain sub1.domain.com
*/10 * * * * ~/.clouflare/cloudflare-dns-sync.sh --domain sub2.domain.com
```
This will update the cloudflare dns every 10 minutes to the ip of the host machine. 


<a name="docker-installation"/>

### Installation (With Docker)
Dockerfile is not made yet :(

<a name="script"/>

### Script Usage
Update the dns record of the subdomain to the ip address of the host machine running the script.
```
# Update DNS-Record of Subdomain to IP of host machine running the 
script --domain sub.domain.com

# Turn on Proxy-DNS Feature of Cloudflare (not recommended in most cases)
script --domain sub.domain.com --proxy

# Use Target IP instead of IP of the host machine
script --domain sub.domain.com --target 127.0.0.1
``` 

