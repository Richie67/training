#!/bin/bash

oc get route jaeger -n istio-system \
-o template --template '{{ "https://" }}{{ .spec.host }}'
