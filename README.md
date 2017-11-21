# Docker IRC Test Network

This utility provides a simple way to run a local test IRC network.

Features:
* ircu2.10.12.18
* QuakeNet's Newserv Services (Q / N)

Requirements:
* Docker + docker-compose
* Git
* sqlite3

It's obvious that this project is intended for local/development usage and you may NOT use it in production.

## Install and Run

Install by cloning this repository:
```
git clone git@github.com:neiluJ/docker-ircnet.git
```

Run the IRC network:
```
./docker-compose up -d
```

Enjoy IRC! on ```/server localhost``` (port 6667 / 4400 for servers).
Be an IRC Operator: ```/oper julien operpass```.

## Custom Configuration

* Edit ```config/ircd.conf``` to fit your needs.
* Edit MOTD ```config/ircd.motd```
* Edit Newserv Config ```config/newserv.conf```

### Create Q/N Account

You'll have to create the first account on Q/N services before getting started using it.
*This have to be done ONLY ONCE!*

Say HELLO and Quit IRC:
```
/Q HELLO you@example.com you@example.com
/quit
```

Now kill newserv, update your flags/password and restart it:
```
docker exec -ti irc su - ircnet
cd newserv-master/
kill -9 `ps -ef | grep "newserv" | grep -v grep | awk '{print $2}'`
sqlite3
.open chanserv.db
update users set flags=17388,password='yourpassword' where id=1;
.quit
./newserv > /dev/null 2>&1
```

Reconnect to IRC, Oper up and AUTH yourself. You're now a super-administrator!
```
/oper julien operpass
/Q AUTH nickname yourpassword
/N HELLO
```
