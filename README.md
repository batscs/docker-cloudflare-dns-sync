<table>
  <tr>
    <td> <img src="https://github.com/batscs/cloudflare-dns-sync/assets/31670615/58296fbd-9a48-4263-a491-308e49035aba" alt="image" width="130" height="auto"> </td>
    <td><h1>bats' Cloudflare-DNS-Sync</h1></td>
  </tr>
</table>

### Table of Contents  
[Introduction](#introduction)  
[Installation (with Docker-Compose)](#compose-installation)  
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


<a name="compose-installation"/>

## Recommended Installation (with Docker-Compose)
This is the recommended way to set up this docker container, as it allows for easily backing up and modifying the cronjobs.

Choose a directory of your choice to house the docker-compose.yml file. You will need this directory to start, stop or restart the docker container. This will also be the directory of the stored cronjobs.
```bash
curl https://raw.githubusercontent.com/batscs/cloudflare-dns-sync/main/docker-compose.yml -o docker-compose.yml
```

Configure the environment variables in the `docker-compose.yml` to your cloudflare credentials. The auth_key is the Cloudflare Global API Key.
```yml
environment:
  - cloudflare_email=your@email.com
  - cloudflare_auth_key=123456789012345678901234567890
  - cloudflare_zoneid=123456789012345678901234567890
```

Now you can start the docker container with this docker compose command. The "-d" flag starts the container in the background and keeps it running.
```bash
docker-compose up -d
```

Create a file named `app.cron` inside the newly created `data` Directory. Your app.cron File will be storing all your cronjobs. You can configure them as [as explained here](#configuration). This file is only being loaded from the container on startup, so you need to restart it with the following command:
```bash
docker-compose restart
```

<a name="configuration"/>

## Configuration

Configure your crontab in this format, this is also an example of how your app.cron file shoud look if you are using docker-compose.
```
*/10 * * * * /app/cloudflare-dns-sync.sh --domain sub1.domain.com
*/10 * * * * /app/cloudflare-dns-sync.sh --domain sub2.domain.com
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
Flags can also be abbreviated like this
```bash
script -d sub.domain.com
script -d sub.domain.com -p
script -d sub.domain.com -t 127.0.0.1
script -d sub.domain.com -t 127.0.0.1 -p 
```
