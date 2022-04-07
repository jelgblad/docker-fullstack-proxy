# docker-fullstack-proxy

## How to use

### Environment variables

| Variable      | Description                   | Default  |
| ------------- | ----------------------------- | -------- |
| SERVICE1_PATH | Service1 proxy path           | /        |
| SERVICE1_ROUTE| Service1 base route on server | /        |
| SERVICE1_HOST | Service1 hostname             | frontend |
| SERVICE1_PORT | Service1 port                 | 3000     |

| Variable      | Description                   | Default  |
| ------------- | ----------------------------- | -------- |
| SERVICE2_PATH | Service2 proxy path           |          |
| SERVICE2_ROUTE| Service2 base route on server | /        |
| SERVICE2_HOST | Service2 hostname             |          |
| SERVICE2_PORT | Service2 port                 |          |

| Variable      | Description                   | Default  |
| ------------- | ----------------------------- | -------- |
| SERVICE3_PATH | Service3 proxy path           |          |
| SERVICE3_ROUTE| Service3 base route on server | /        |
| SERVICE3_HOST | Service3 hostname             |          |
| SERVICE3_PORT | Service3 port                 |          |

## Push to hub.docker.com

`docker build -t jelgblad/fullstack-proxy .`
`docker push jelgblad/fullstack-proxy`