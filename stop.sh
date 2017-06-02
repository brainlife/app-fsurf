#!/bin/bash

#allows test execution
if [ -z $SERVICE_DIR ]; then export SERVICE_DIR=`pwd`; fi
if [ -z $TASK_DIR ]; then export TASK_DIR=`pwd`; fi

jobid=`cat jobid`
$SERVICE_DIR/fsurf remove --id $jobid
