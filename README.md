### Table of Contents  
[Introduction](#introduction)  
[Installation (with Docker)](#docker-installation)  
[Installation (without Docker)](#installation)  
[Configuration (Crontab)](#configuration)  
[Script Usage](#script)  

<a name="introduction"/>

## Introduction
This is a bash script to continously update and refresh a Cloudflare DNS-Record with the public / external IP Address of the host system running the script (or a predetermined IP Address).
Runs inside a Ubuntu 20.04 Docker Container.

This is intentend to be as lightweight as possible. All written in bash instead of python, and the docker container has just installed the minimum of neccessary software.

#### Features:
- Automatic deployment to a docker container
- Automatic synchronization for Cloudflare DNS-Record with IP Address of Host Machine
- (Optional) Support for Cloudflare DNS-Proxy (Not recommended in most cases)
- (Optional) Support for Specifization of Target IP instead of Host Machine

#### Requirements:
- Docker

<a name="docker-installation"/>

## Installation (with Docker)
Deploy docker container
To use the installation script, simply run this command in your terminal of choice with root priveleges. The script will automatically build the image and deploy the container.

Root priveleges are required to run the installation script. If you can not execute the command from the next step run this:
```bash
sudo -i
```

This runs the installation script on the Host Machine to build the Docker Image from this Repository and deploy a Docker Container with it.
```bash
bash <(curl -s https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/docker.sh)
```

The docker container (named: cf-sync) has been deployed and should be running. If all went successfully you can now access it and configure your crontab.
From the installation script you should already be connected to the container in your shell. However if this is not the case, you can enter the container like this:
```bash
docker exec -it cf-sync bash
```

From here you first need to setup your Cloudflare-DNS-Sync Script by entering your API Token and Specifics about the DNS.
```bash
nano ~/.cloudflare/cloudflare-dns-sync.sh
```

Modify the crontab schedule to periodically update the DNS Record, if an IP Change for the host machine occurs.
If you need help configuring the cronjob for the script [click here](#configuration) for examples.
```bash
crontab -e
```

At last you need to start your Cron Service, which is responsible for the scheduled command execution in the previous step.
No output from the command is expected, if it tells you an APPID is already reserved, it means Cron is already running.
```bash
cron
```

<a name="installation"/>  

## Installation (without Docker, not recommended)

It is recommended to use the installation with docker. This script is pretty much what is being installed inside the docker container, alongside the required software. If you know what you are doing and why you want this to be on your host machine and not in a container, follow these instructions. Support for this might drop in the future.
  
Enter this into your terminal of choice to automatically deploy this script. Requires root privelege.
Otherwise manually download the cloudflare-dns-sync.sh file of this repository in a directory of your choice and skip the next two steps.
Only do this if you really know what and why you are doing this.

Root priveleges are required to run the installations script. If you can not execute the command from the next step run this:
```bash
sudo -i
```

Run the installation script in your terminal with the following command.
```bash
bash <(curl -s https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/deploy.sh)
```

Now you need to configure the crontab schedule for the automatic execution of your scripts, you can edit the schedule with this command:
```bash
crontab -e
```
if you need help configuring the cronjob for the script [click here](#configuration) for examples.

<a name="configuration"/>

## Configuration

Configure your crontab in this format
```
*/10 * * * * ~/.cloudflare/cloudflare-dns-sync.sh --domain sub1.domain.com
*/10 * * * * ~/.cloudflare/cloudflare-dns-sync.sh --domain sub2.domain.com
```
This will update the Cloudflare DNS-Record for sub1 and sub2 every 10 minutes to the ip of the host machine.
For more about cronjobs [read this](https://ostechnix.com/a-beginners-guide-to-cron-jobs/).

<a name="script"/>

## Script Usage
```bash
# Update DNS-Record of Subdomain to IP of host machine running the 
script --domain sub.domain.com

# Turn on Proxy-DNS Feature of Cloudflare (not recommended in most cases)
script --domain sub.domain.com --proxy

# Use Target IP instead of IP of the host machine
script --domain sub.domain.com --target 127.0.0.1

# Use Target IP instead of IP of the host machine AND use Cloudflare Proxy
script --domain sub.domain.com --target 127.0.0.1 --proxy
``` 

## To-Do
If docker container restarts, you need to manually start cron again. Would be really convenient if this could be automated. This would probably also fix cron not being started on first boot, even though its defined in the Dockerfile.
```
cron
```
