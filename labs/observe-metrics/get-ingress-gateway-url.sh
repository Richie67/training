#!/bin/bash

oc get route istio-ingressgateway -n istio-system \
-o template --template '{{ "http://" }}{{ .spec.host }}'
