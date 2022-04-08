# docker-fullstack-proxy

## How to use

### Configuration
Configure services with environment variables. `SERVICE1`, `SERVICE2`, `SERVICE3`, `SERVICE...`.

| Environment variable | Format                         | Example               |
| -------------------- | ------------------------------ | --------------------- |
| `SERVICE1`           | `{path}:{host}:{port}:{route}` | `/api:backend:3000:/` |

| Service definition part | Description           | Example   |
| ----------------------- | --------------------- | --------- |
| `path`                  | Path on reverse proxy | `/api`    |
| `host`                  | Service hostname      | `backend` |
| `port`                  | Service port          | `3000`    |
| `route`                 | Base route on service | `/`       |

## haproxy config

```sh
frontend http
  acl url_service1 path_beg "/api"
  use_backend service1 if url_service1

backend service1
  server server1 "backend:3000"
  http-request set-path "%[path,regsub(^/api,/)]"
```

## Push to hub.docker.com

`docker build -t jelgblad/fullstack-proxy .`
`docker push jelgblad/fullstack-proxy`