#!/bin/env sh

GATEWAY_URL=`oc get route istio-ingressgateway -n istio-system -o template --template '{{ "http://" }}{{ .spec.host }}'`

echo "Executing 10 requests:"
echo ""

for i in {1..10}; do
  curl "${GATEWAY_URL}/resilience-retry"
done

echo ""
echo "Done"
