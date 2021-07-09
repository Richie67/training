#!/bin/env sh

oc patch smmr default -n istio-system --type='json' -p='[{"op": "add", "path": "/spec/members/0", "value":"curl"}]'
