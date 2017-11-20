#!/bin/bash

echo [`date`] Bootstrap finished

tail -f /dev/null &
child=$!
wait "$child"
