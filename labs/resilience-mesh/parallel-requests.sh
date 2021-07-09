#!/bin/bash

requests="${1:-20}"

GATEWAY_URL=`oc get route istio-ingressgateway -n istio-system -o template --template '{{ "http://" }}{{ .spec.host }}'`

for i in $(seq 1 ${requests})
do
  curl  -s -o /dev/null \
    -w 'HTTP code: %{http_code}\n' \
    "${GATEWAY_URL}/frontend" &
done

wait
