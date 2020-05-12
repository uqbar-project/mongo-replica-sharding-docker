Access mongo1 node and:

```
rs.initiate()
rs.add("mongo2:30002")
rs.add("mongo3:30001")
```

or

```
cfg={_id:"rsdev",members:[{host:"mongo1:30001"},{host:"mongo2:30002"},{host:"mongo3:30003"}]}
```

Connstring for connecting to replicaSet:
```
mongodb://mongo1:30001,mongo2:30002,mongo3:30003/murally?replicaSet=devrs&readPreference=secondary
```


# Adding network latency

Need to launch services with net admin capabilities:
```
-cap_add:
        - NET_ADMIN
```
Then install:
```
apt update
apt install iproute
```
and last:

```
tc qdisc add dev eth0 root netem delay 800ms
```

To undo:
```
qdisc pfifo_fast 0: dev eth0 root refcnt 2 bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1
```