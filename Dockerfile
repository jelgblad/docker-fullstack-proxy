FROM haproxy:2.5

COPY haproxy_template.cfg .
COPY start.sh .

# haproxy:2.5 changes current user from "root" to "haproxy", so we need to switch back to "root" to run "start.sh".
# don't worry, "start.sh" starts haproxy as user "haproxy"!
USER root

CMD ["./start.sh"]
