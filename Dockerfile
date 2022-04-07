FROM haproxy:2.5

COPY haproxy.cfg /usr/local/etc/haproxy/

ENV SERVICE1_PATH=/
# ENV SERVICE1_ROUTE=/
ENV SERVICE1_HOST=frontend
ENV SERVICE1_PORT=3000
