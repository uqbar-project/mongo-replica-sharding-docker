# Ejemplo de Replica Set con docker-compose

### 1. Iniciar los contenedores utilizando docker-compose:

```
docker-compose up
```

### 2. Iniciar el replicaSet entre los nodos, hay dos formas:

a.

Conectarse a través de un cliente de mongo a un nodo y correr lo siguiente (ejemplo accediendo al nodo1):

```
rs.initiate()
rs.add("mongo2:30002")
rs.add("mongo3:30003")
```

b.

Otra forma, sería acceder a cualquier nodo e iniciar el replicaSet con un objeto de configuración:

```
cfg={_id:"miReplicaSet",members:[{_id: 1, host:"mongo1:30001"},{_id: 2, host:"mongo2:30002"},{_id: 3, host:"mongo3:30003"}]}
rs.initiate(cfg)
```

### 3. Ya podés conectarte al replicaSet con el siguiente connection string:

```
mongodb://mongo1:30001,mongo2:30002,mongo3:30003/?replicaSet=miReplicaSet
```

## Opcional

### Agregar latencia a la red para hacer pruebas

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
