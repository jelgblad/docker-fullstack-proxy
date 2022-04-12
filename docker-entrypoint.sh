#!/bin/bash

set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
	shift # "haproxy"
	# if the user wants "haproxy", let's add a couple useful flags
	#   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
	#   -db -- disables background mode
	set -- haproxy -W -db "$@"
fi





# Generate haproxy config
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
  \n  http-request set-path \"%[path,regsub(^${path},${route})]\"\
  \n  http-request set-path \"%[path,regsub(^//,/)]\""

  conditions_output="$conditions_output\n  $condition"
  rules_output="$rules_output\n  $rule"
  backends_output="$backends_output\n$backend"
done

# Output to haproxy config file
sed -e "s|<<CONDITIONS>>|${conditions_output}|g" -e "s|<<RULES>>|${rules_output}|g" -e "s|<<BACKENDS>>|${backends_output}|g" haproxy_template.cfg > /var/lib/haproxy/haproxy.cfg






# Run Docker CMD
exec "$@"