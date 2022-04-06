FROM haproxy

COPY haproxy.cfg /usr/local/etc/haproxy/

ENV SERVICE1_PATH=/api
ENV SERVICE1_HOST=backend
ENV SERVICE1_PORT=80

ENV SERVICE2_PATH=/
ENV SERVICE2_HOST=frontend
ENV SERVICE2_PORT=80
