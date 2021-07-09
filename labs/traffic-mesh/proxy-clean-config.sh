#!/bin/bash

proxyEndpoint=`oc get route ab-proxy -n traffic-mesh-proxy -o template --template '{{ "http://" }}{{ .spec.host }}'`

if curl -X DELETE ${proxyEndpoint}/headers
then
  echo "Removed headers configuration"
else
  echo "Error removing headers configuration"
fi
