# Docker Cassandra K8s

Apache Cassandra docker image based on ubuntu-slim that is optimized to run on Kubernetes.

Note that this image is unstable and under development.

```
docker build --build-arg "CASSANDRA_VERSION=3.9" -t local/cassandra .
```
