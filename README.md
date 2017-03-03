# Cassandra K8s

This project provides a container optimized to run Apache Cassandra on Kubernetes.  This project provides both a 
production grade container, and a developer container for using cqlsh.

## Build Status

[![Docker Repository on Quay](https://quay.io/repository/vorstella/cassandra-k8s/status "Docker Repository on Quay")](https://quay.io/repository/vorstella/cassandra-k8s)

This container is hosted on Docker Repository on Quay.  Visit the [repository](https://quay.io/repository/vorstella/cassandra-k8s?tab=tags) 
for the most update to date container.  We do not recommend running using "lastest", as breaking changes may break your production environment.

## Building via Makefile

The projects Makefile contains various targets for building and pushing both the production container
and the development container.

### Production Container

Use the default target. The example below also sets the docker repository name and the Cassandra version.
See the top of the Makefile for other variables that can be set.

```console
make CASSANDRA_VERSION=3.9 PROJECT=quay.io/vorstella/cassandra-k8s
```

### Development Container

The following command builds the development container, which includes a working version of `cqlsh`.

```console
make build-dev
```
