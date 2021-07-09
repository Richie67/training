#!/bin/bash

oc get route kiali -n istio-system \
-o template --template '{{ "https://" }}{{ .spec.host }}'
