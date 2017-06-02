#!/bin/bash

#allows test execution
if [ -z $SERVICE_DIR ]; then export SERVICE_DIR=`pwd`; fi
if [ -z $TASK_DIR ]; then export TASK_DIR=`pwd`; fi

#return code 0 = running
#return code 1 = finished successfully
#return code 2 = failed

if [ -f finished ]; then
    code=`cat finished`
    if [ $code -eq 0 ]; then
        echo "finished successfully"
        exit 1 #success!
    else
        echo "finished with code:$code"
        exit 2 #failed
    fi
fi

if [ -f jobid ]; then
    jobid=`cat jobid`
    $SERVICE_DIR/fsurf status --id $jobid > .status
    jobstate=`cat .status | grep Status | cut -d " " -f 2`
    echo $jobstate
    if [ -z $jobstate ]; then
        exit 2 #removed?
    fi
    if [ $jobstate == "QUEUED" ]; then
        exit 0
    fi
    if [ $jobstate == "RUNNING" ]; then
	tail -1 .status
        exit 0
    fi
    if [ $jobstate == "DELETE PENDING" ]; then
        exit 2
    fi
    if [ $jobstate == "DELETED" ]; then
        exit 2
    fi
    if [ $jobstate == "COMPLETED" ]; then
        #need to download result as part of status call.. (
	#TODO should I spawn a separate process to do that?)
	$SERVICE_DIR/fsurf output --id $jobid
	if [ -s subject_output.tar.bz2 ]; then
		tar -jxvf subject_output.tar.bz2
		$SERVICE_DIR/fsurf remove --id $jobid
	       	echo 1 > finished
		exit 1
	else
		echo "failed to download output file"
		echo 2 > finished
		exit 2
	fi
    fi

    #assume failed for all other state
    #'ERROR'
    #'FAILED',
    exit 2
fi

echo "can't determine the status!"
exit 3
