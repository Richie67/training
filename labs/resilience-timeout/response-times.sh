#!/bin/bash

GATEWAY_URL=`oc get route istio-ingressgateway -n istio-system -o template --template '{{ "http://" }}{{ .spec.host }}'`

curl  -s \
  -w 'HTTP code: %{http_code}\nTime: %{time_total}s\n' \
  "${GATEWAY_URL}/resilience-timeout"
