#!/bin/bash

oc get route grafana -n istio-system \
-o template --template '{{ "https://" }}{{ .spec.host }}'
