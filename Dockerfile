FROM haproxy:2.5

COPY haproxy_template.cfg .
COPY docker-entrypoint.sh /usr/local/bin/

CMD ["haproxy", "-f", "/var/lib/haproxy/haproxy.cfg"]
