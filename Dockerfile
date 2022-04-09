FROM haproxy:2.5

COPY haproxy_template.cfg .
COPY start.sh .
# COPY haproxy.cfg /usr/local/etc/haproxy/

USER root
CMD ["./start.sh"]
