#!/bin/env bash
oc -n secure-mesh patch deployment history --type='json' -p='[{"op": "add", "path": "/spec/template/metadata/labels/ns-restricted", "value":"true"}]'

oc -n secure-mesh patch deployment currency --type='json' -p='[{"op": "add", "path": "/spec/template/metadata/labels/ns-restricted", "value":"true"}]'
