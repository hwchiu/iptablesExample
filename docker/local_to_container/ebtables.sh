#!/bin/bash

insert() {
    ebtables -t broute -I BROUTING --log --log-prefix 'ctc/ebtable/broute-BROUTING' --log-level debug
    ebtables -t nat -I PREROUTING --log --log-prefix 'ctc/ebtable/nat-PREROUTE' --log-level debug
    ebtables -t nat -I POSTROUTING --log --log-prefix 'ctc/ebtable/nat-POSTROUTE' --log-level debug
    ebtables -t filter -I INPUT --log --log-prefix 'ctc/ebtable/filter-input' --log-level debug
    ebtables -t filter -I OUTPUT --log --log-prefix 'ctc/ebtable/filter-output' --log-level debug
    ebtables -t filter -I FORWARD --log --log-prefix 'ctc/ebtable/filter-forward' --log-level debug
}

delete() {
    ebtables -t broute -D BROUTING --log --log-prefix 'ctc/ebtable/broute-BROUTING' --log-level debug
    ebtables -t nat -D PREROUTING --log --log-prefix 'ctc/ebtable/nat-PREROUTE' --log-level debug
    ebtables -t nat -D POSTROUTING --log --log-prefix 'ctc/ebtable/nat-POSTROUTE' --log-level debug
    ebtables -t filter -D INPUT --log --log-prefix 'ctc/ebtable/filter-input' --log-level debug
    ebtables -t filter -D OUTPUT --log --log-prefix 'ctc/ebtable/filter-output' --log-level debug
    ebtables -t filter -D FORWARD --log --log-prefix 'ctc/ebtable/filter-forward' --log-level debug
}

check() {
    count=`ebtables-save | grep ctc| wc -l`
    if [ "$count" == "0" ]; then
        echo "Delete Success"
    else
        echo "Delete Fail, Use the ebtables-save to check what rules still exist"
    fi
}


if [ "$1" == "d" ]; then
delete
check
else
insert
fi
