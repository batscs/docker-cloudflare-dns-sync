### Table of Contents  
[Introduction](#introduction)  
[Installation (With Docker)](#docker-installation)  
[Installation (Without Docker)](#installation)  
[Configuration (Crontab)](#configuration)  
[Script Usage](#script)  

<a name="introduction"/>

### Introduction
This is a bash script to continously update and refresh a cloudflare dns record with the public / external IP Address of the host system running the script (or a predetermined IP Address).

<a name="docker-installation"/>

### Installation (With Docker)
Deploy docker container
To use the installation script, simply run this command in your terminal of choice with root priveleges. The script will automatically build the image and deploy the container.
```
# If you dont have root priveleges run this first, otherwise you can skip this
sudo -i

# Command to run the installation script for docker
bash <(curl -s https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/docker.sh)
```
The docker container (named: cf-sync) has been deployed and should be running. If all went successfully you can now access it and configure your crontab.
```
# Enter bash shell for the docker container, if not already entered from deploy script
docker exec -it cf-sync bash

# Configure cloudflare credentials at the top of the script
nano ~/.cloudflare/cloudflare-dns-sync.sh

# Access crontab inside of docker container
crontab -e

# Exit docker container after modifying & saving crontab
cron
exit
```
if you need help configuring the cronjob for the script [click here](#configuration)  

<a name="installation"/>

### Installation (Without Docker)
Download the cloudflare-dns-sync.sh file to your desired  
  
Enter this into your terminal of choice to automatically deploy this script. Requires root privelege
Otherwise manually the cloudflare-dns-sync.sh file of this repository in a directory of your choice
```
# If you dont have root priveleges run this first, otherwise you can skip this
sudo -i

# Command to run the installation script
bash <(curl -s https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/deploy.sh)
```

With crontab you can automate the proccess of running this script
```
# Access crontab to automate running of script
crontab -e
```
if you need help configuring the cronjob for the script [click here](#configuration)  

<a name="configuration"/>

### Configuration

Configure your crontab in this format
```
*/10 * * * * ~/.cloudflare/cloudflare-dns-sync.sh --domain sub1.domain.com
*/10 * * * * ~/.cloudflare/cloudflare-dns-sync.sh --domain sub2.domain.com
```
This will update the cloudflare dns every 10 minutes to the ip of the host machine. 

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

