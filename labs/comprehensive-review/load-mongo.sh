#!/bin/bash

oc login -u developer -p developer https://api.ocp4.example.com:6443
oc project adoptapup

mongo_pod=$(oc get pod -n adoptapup -l app=mongodb -o jsonpath='{.items[0].metadata.name}')

echo
echo 'Populating animals in MongoDB database...'
echo
if oc exec -i "${mongo_pod}" -c mongodb -- sh -c 'mongoimport --username=developer --password=developer --collection=animals --db=adopt-a-pup --drop' < /home/student/DO328/labs/comprehensive-review/mongo-data/animals.mongo; then
  echo 'Animal data successfully loaded!'
else
  echo 'Animal data loading failed!'
fi

echo
echo 'Populating shelters in MongoDB database...'
echo
if oc exec -i "${mongo_pod}" -c mongodb -- sh -c 'mongoimport --username=developer --password=developer --collection=shelters --db=adopt-a-pup --drop' < /home/student/DO328/labs/comprehensive-review/mongo-data/shelters.mongo; then
  echo 'Shelter data successfully loaded!'
else
  echo 'Shelter data loading failed!'
fi

