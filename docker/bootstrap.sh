#!/bin/bash


su -c 'cd /home/ircnet/ircd && ./bin/ircd' - ircnet

echo [`date`] Bootstrap finished

tail -f /dev/null &
child=$!
wait "$child"
