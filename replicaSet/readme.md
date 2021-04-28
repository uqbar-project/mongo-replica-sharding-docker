# Ejemplo de Replica Set con docker-compose

Acceder al nodo mongo1 y:

```
rs.initiate()
rs.add("mongo2:30002")
rs.add("mongo3:30003")
```

o de otra forma, acceder a cualquier nodo y:

```
cfg={_id:"rsdev",members:[{_id: 1, host:"mongo1:30001"},{_id: 2, host:"mongo2:30002"},{_id: 3, host:"mongo3:30003"}]}
```

Connection string para conectarse al replica Set:

```
mongodb://mongo1:30001,mongo2:30002,mongo3:30003/?replicaSet=devrs
```

# Agregar latencia a la red para hacer pruebas

Es necesario que los servicios se lancen con privilegios de net admin:

```
-cap_add:
        - NET_ADMIN
```

Además instalar:

```
apt update
apt install iproute
```

Y por último correr el siguiente comando (ejemplo para 800ms de delay)

```
tc qdisc add dev eth0 root netem delay 800ms
```

Para deshacer:

```
qdisc pfifo_fast 0: dev eth0 root refcnt 2 bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1
```
