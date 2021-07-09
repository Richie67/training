#!/bin/bash

oc patch servicemeshmemberroll/default \
-n istio-system --type=merge \
-p '{"spec": {"members": ["tracing"]}}'
