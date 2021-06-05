# Makefile 里的push

`DOCKER_PASSWORD`、`DOCKER_USERNAME`、`DOCEER_REPO_PROVIDER` 分别按照实际情况填写。其他参数需要另外改动，也参照这样。

```
make push -e DOCKER_PASSWORD=123 DOCKER_USERNAME=myname DOCEER_REPO_PROVIDER=docker.io
```