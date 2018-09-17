#!/bin/bash
apt-get install -y nginx
systemctl start nginx
systemctl status nginx
