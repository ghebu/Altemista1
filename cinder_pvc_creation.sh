#!/bin/bash
set -x


for i in {6..60}
do

#Define the name of the pvc
name=test$i



# Create the yaml config for the pvc creation 
echo "$(cat <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  namespace: default
  name: $name
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 15Gi
  storageClassName: standard
EOF
)" > test_pvc.yml



#Create the pvc from the previously created yaml config
oc create -f test_pvc.yml

#Sleep for the pvc to be created.
sleep 5


#If the pvc has been created return OK else exit the script
if [[ $(oc get pvc -n default | grep $name | awk '{print $2}' | grep -vi STATUS) == 'Bound' ]]
then
    echo "OK"
else
   exit 3
fi


done
