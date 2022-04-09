#!/bin/bash

# SERVICE1="/api:backend:3000:/api"
# SERVICE2="/api:backend:3000:/api"

for (( i=1; ; i++ )); do
  n="SERVICE${i}"           # the name of var
  declare -n p="$n"         # reference to the var
  [ "${p+x}" ] || break     # see if it exists

  echo "Generating config for $n..."

  # Split service values
  IFS=':' read -r -a values <<< "$p"

  # Assign more readable names
  path=${values[0]}
  host=${values[1]}
  port=${values[2]}
  route=${values[3]}

  # Service condition
  condition="acl url_service$i path_beg \"$path\""

  # Service rule
  rule="use_backend service$i if url_service$i"

  # Service backend
  backend="backend service$i\
  \n  server server$i \"${host}:${port}\"\
  \n  http-request set-path \"%[path,regsub(^${path}/,${route})]\"\
  \n  http-request set-path \"%[path,regsub(^${path},${route})]\""

  conditions_output="$conditions_output\n  $condition"
  rules_output="$rules_output\n  $rule"
  backends_output="$backends_output\n$backend"
done

sed -e "s|<<CONDITIONS>>|${conditions_output}|g" -e "s|<<RULES>>|${rules_output}|g" -e "s|<<BACKENDS>>|${backends_output}|g" haproxy_template.cfg > /usr/local/etc/haproxy/haproxy.cfg

# Start haproxy
su - haproxy
haproxy -f /usr/local/etc/haproxy/haproxy.cfg