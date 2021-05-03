# Ejemplo de Sharding con docker-compose

### Componentes

- Config Server (replica set de 3 member): `config01`,`config02`,`config03`
- 3 Shards (cada uno es un replica set de 2 member ):
  - `shard01a`,`shard01b`
  - `shard02a`,`shard02b`
  - `shard03a`,`shard03b`
- 1 Router (mongos): `router`
- (TODO): Agregar persistencia local usando volúmenes

### Setup inicial

**Levantar todos los contenedores**

```
docker-compose up
```

**Inicializar los replica set, de config server y shards**

```
sh init.sh
```

**Para verificar el estado:**

```
docker-compose exec router mongo
mongos> sh.status()
--- Sharding Status ---
  sharding version: {
	"_id" : 1,
	"minCompatibleVersion" : 5,
	"currentVersion" : 6,
	"clusterId" : ObjectId("5981df064c97b126d0e5aa0e")
}
  shards:
	{  "_id" : "shard01",  "host" : "shard01/shard01a:27018,shard01b:27018",  "state" : 1 }
	{  "_id" : "shard02",  "host" : "shard02/shard02a:27019,shard02b:27019",  "state" : 1 }
	{  "_id" : "shard03",  "host" : "shard03/shard03a:27020,shard03b:27020",  "state" : 1 }
  active mongoses:
	"3.4.6" : 1
 autosplit:
	Currently enabled: yes
  balancer:
	Currently enabled:  yes
	Currently running:  no
		Balancer lock taken at Wed Aug 02 2017 14:17:42 GMT+0000 (UTC) by ConfigServer:Balancer
	Failed balancer rounds in last 5 attempts:  0
	Migration Results for the last 24 hours:
		No recent migrations
  databases:
```

### Startup normal

El cluster debe ser configurado sólo la primera vez, luego se puede iniciar con `docker-compose up` or `docker-compose up -d` para ejecutar en segundo plano.

### Acceder al Mongo Shell

Tan simple como:

```
docker-compose exec router mongo
```

### Resetear el cluster

Para eliminar toos los datos y poder re-inicializar el cluster, debés detener todos los contenedoes y:

```
docker-compose rm
```
