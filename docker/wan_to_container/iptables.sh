#!/bin/bash

insert() {
    iptables -t mangle -I PREROUTING -p tcp -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-PREROUTE' --log-level debug
    iptables -t nat -I PREROUTING -p tcp  -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/nat-PREROUTE' --log-level debug
    iptables -t mangle -I PREROUTING -p tcp -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-PREROUTE' --log-level debug
    iptables -t nat -I PREROUTING -p tcp  -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/nat-PREROUTE' --log-level debug

    iptables -t filter -I FORWARD -p tcp  -m tcp  -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/filter-forward' --log-level debug
    iptables -t filter -I FORWARD -p tcp  -m tcp  -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/filter-forward' --log-level debug
    iptables -t mangle -I FORWARD -p tcp -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-FORWARD' --log-level debug
    iptables -t mangle -I FORWARD -p tcp -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-FORWARD' --log-level debug

    iptables -t mangle -I POSTROUTING -p tcp  -m tcp  -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-POSTROUTE' --log-level debug
    iptables -t mangle -I POSTROUTING -p tcp  -m tcp  -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-POSTROUTE' --log-level debug
    iptables -t nat -I POSTROUTING -p tcp  -m tcp  -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/nat-POSTROUTE' --log-level debug
    iptables -t nat -I POSTROUTING -p tcp  -m tcp  -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/nat-POSTROUTE' --log-level debug
 }

delete() {
    iptables -t mangle -D PREROUTING -p tcp -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-PREROUTE' --log-level debug
    iptables -t nat -D PREROUTING -p tcp  -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/nat-PREROUTE' --log-level debug
    iptables -t mangle -D PREROUTING -p tcp -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-PREROUTE' --log-level debug
    iptables -t nat -D PREROUTING -p tcp  -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/nat-PREROUTE' --log-level debug

    iptables -t filter -D FORWARD -p tcp  -m tcp  -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/filter-forward' --log-level debug
    iptables -t filter -D FORWARD -p tcp  -m tcp  -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/filter-forward' --log-level debug
    iptables -t mangle -D FORWARD -p tcp -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-FORWARD' --log-level debug
    iptables -t mangle -D FORWARD -p tcp -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-FORWARD' --log-level debug

    iptables -t mangle -D POSTROUTING -p tcp  -m tcp  -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-POSTROUTE' --log-level debug
    iptables -t mangle -D POSTROUTING -p tcp  -m tcp  -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/mangle-POSTROUTE' --log-level debug
    iptables -t nat -D POSTROUTING -p tcp  -m tcp  -d 172.18.0.0/16 -j LOG --log-prefix 'wtc/iptable/nat-POSTROUTE' --log-level debug
    iptables -t nat -D POSTROUTING -p tcp  -m tcp  -d 172.17.0.0/16 -j LOG --log-prefix 'wtc/iptable/nat-POSTROUTE' --log-level debug
}

check() {
    count=`iptables-save | grep wtc| wc -l`
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
