#!/bin/bash

oc get route prometheus -n istio-system \
-o template --template '{{ "https://" }}{{ .spec.host }}'
