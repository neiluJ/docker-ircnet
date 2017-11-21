#!/bin/bash


su -c 'cd /home/ircnet/ircd && ./bin/ircd' - ircnet
su -c 'cd /home/ircnet/newserv-master && ./newserv > /dev/null 2>&1' - ircnet

echo [`date`] Bootstrap finished

tail -f /dev/null &
child=$!
wait "$child"
