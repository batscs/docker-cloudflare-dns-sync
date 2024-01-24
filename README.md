<table>
  <tr>
    <td> <img src="https://github.com/batscs/cloudflare-dns-sync/assets/31670615/58296fbd-9a48-4263-a491-308e49035aba" alt="image" width="130" height="auto"> </td>
    <td><h1>bats' Cloudflare-DNS-Sync</h1></td>
  </tr>
</table>

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

If you need help or run into problems feel free to open an issue for this repository.

#### Features:
- Automatic deployment to a docker container
- Automatic synchronization for Cloudflare DNS-Record with IP Address of Host Machine
- Automatic docker container start with crontab running
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

The docker container (named: cf-sync) has been deployed and should be running. If all went successfully you can now access it and configure your crontab. When using the install script the crontab editor should open by itself, otherwise you can edit the crontab schedule like this:
```bash
docker exec -it cf-sync crontab -e
```

At last you just need to configure the script to work with your Cloudflare API Gateway. Edit the variables here at the top. Only change the script if you really understand what you are doing.
```bash
docker exec -it cf-sync nano /opt/bin/cloudflare/cloudflare-dns-sync.sh
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
*/10 * * * * /opt/bin/cloudflare/cloudflare-dns-sync.sh --domain sub1.domain.com
*/10 * * * * /opt/bin/cloudflare/cloudflare-dns-sync.sh --domain sub2.domain.com
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
