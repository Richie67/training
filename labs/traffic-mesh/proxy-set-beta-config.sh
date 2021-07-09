#!/bin/bash

proxyEndpoint=`oc get route ab-proxy -n traffic-mesh-proxy -o template --template '{{ "http://" }}{{ .spec.host }}'`

if curl -d '{"version":"beta"}' -H "Content-Type: application/json" -X POST ${proxyEndpoint}/headers
then
  echo "Updated proxy to send version:beta headers"
else
  echo "Error removing headers configuration"
fi
