#!/bin/bash

# This is the file where I performed the add dashboard experiments - might be useful to some.

GRAF_USER="admin"
GRAF_PASS="admin"

GRAF_API_BASE="localhost:3000"
GRAF_API_DATASOURCES="${GRAF_API_BASE}/api/datasources"

HOST_PROM="prometheus-local"

# set to 0 for delete
#delete_op=0
#delete_op=1
delete_op=2

echo -en "Datasources: \n$(curl --user ${GRAF_USER}:${GRAF_PASS} ${GRAF_API_DATASOURCES})\n\n"

req_status="$(curl -s --user ${GRAF_USER}:${GRAF_PASS} ${GRAF_API_DATASOURCES} | grep prometheus)"

echo -en "\nStatus is: ${req_status}\n\n"

if [[ "${delete_op}" -eq "0" ]]; then

req_status=$(curl -s --user ${GRAF_USER}:${GRAF_PASS} ${GRAF_API_DATASOURCES}/name/Prometheus/ \
-X DELETE -H 'Content-Type: application/json;charset=UTF-8')

  echo "Response was: {$req_status}"

elif [[ "${delete_op}" -eq "1" ]]; then

req_status=$(curl -s --user ${GRAF_USER}:${GRAF_PASS} ${GRAF_API_DATASOURCES}/ \
-X POST -H 'Content-Type: application/json;charset=UTF-8' \
--data-binary "{\"name\":\"Prometheus\", \"isDefault\":true , \"type\":\"prometheus\", \"url\":\"http://${HOST_PROM}:9090\", \"access\":\"proxy\", \"basicAuth\":false}")

  echo "Response was: {$req_status}"
fi
