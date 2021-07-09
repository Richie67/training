#!/bin/bash

oc login -u developer -p developer https://api.ocp4.example.com:6443
oc project adoptapup

mongo_pod=$(oc get pod -n adoptapup -l app=mongodb -o jsonpath='{.items[0].metadata.name}')

echo
echo 'Checking if animal data is loaded into MongoDB...'
echo
oc exec -i  ${mongo_pod} -c mongodb -- sh -c "mongo -u developer -p developer adopt-a-pup --quiet --eval 'db.animals.find()'"

echo
echo 'Checking if shelter data is loaded into MongoDB...'
echo
oc exec -i  ${mongo_pod} -c mongodb -- sh -c "mongo -u developer -p developer adopt-a-pup --quiet --eval 'db.shelters.find()'"
