#!/bin/bash
apt-get install -y nginx  ebtables
systemctl start nginx
systemctl status nginx
