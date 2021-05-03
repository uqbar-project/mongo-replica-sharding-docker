#!/bin/bash

watch -n 1 'mongo mongodb://mongo1:30001,mongo2:30002,mongo3:30003/?replicaSet=miReplicaSet --eval "rs.status()" | grep -A 5 stateStr'

