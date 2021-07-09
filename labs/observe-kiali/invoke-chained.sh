#!/bin/bash

GATEWAY_URL=$(oc get route istio-ingressgateway -n istio-system -o template --template '{{ "http://" }}{{ .spec.host }}')

while true;
 do curl ${GATEWAY_URL}/chained;
 sleep 3;
done
