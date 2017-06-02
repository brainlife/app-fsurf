#!/bin/bash

#allows test execution
if [ -z $SERVICE_DIR ]; then export SERVICE_DIR=`pwd`; fi
if [ -z $TASK_DIR ]; then export TASK_DIR=`pwd`; fi

T1=`$SERVICE_DIR/jq -r '.t1' config.json`

$SERVICE_DIR/fsurf submit --subject='subject' --input=$T1 --defaced --deidentified | tee submit.log
id=$(cat submit.log | grep Workflow | cut -d " " -f 2)
echo $id > jobid
