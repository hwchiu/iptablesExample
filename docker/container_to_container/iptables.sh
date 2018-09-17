#!/bin/bash

insert() {
    iptables -t mangle -I PREROUTING -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/mangle-PREROUTE' --log-level debug
    iptables -t mangle -I POSTROUTING -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/mangle-POSTROUTE' --log-level debug
    iptables -t nat -I PREROUTING -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/nat-PREROUTE' --log-level debug
    iptables -t nat -I POSTROUTING -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/nat-POSTROUTE' --log-level debug
    iptables -t filter -I INPUT -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/filter-input' --log-level debug
    iptables -t filter -I OUTPUT -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/filter-output' --log-level debug
    iptables -t filter -I FORWARD -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/filter-forward' --log-level debug
}

delete() {
    iptables -t mangle -D PREROUTING -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/mangle-PREROUTE' --log-level debug
    iptables -t mangle -D POSTROUTING -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/mangle-POSTROUTE' --log-level debug
    iptables -t nat -D PREROUTING -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/nat-PREROUTE' --log-level debug
    iptables -t nat -D POSTROUTING -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/nat-POSTROUTE' --log-level debug
    iptables -t filter -D INPUT -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/filter-input' --log-level debug
    iptables -t filter -D OUTPUT -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/filter-output' --log-level debug
    iptables -t filter -D FORWARD -s 172.18.0.0/16 -d 172.18.0.0/16 -j LOG --log-prefix 'ctc/iptable/filter-forward' --log-level debug
}

check() {
    count=`iptables-save | grep ctc| wc -l`
    if [ "$count" == "0" ]; then
        echo "Delete Success"
    else
        echo "Delete Fail, Use the iptables-save to check what rules still exist"
    fi
}


if [ "$1" == "d" ]; then
delete
check
else
insert
fi
