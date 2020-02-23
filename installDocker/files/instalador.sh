#!/bin/bash
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
echo "Adding Elasticsearch repository elastic.repo."
touch '/etc/yum.repos.d/elastic.repo'
echo "[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://packages.elastic.co/elasticsearch/7.x/centos
gpgcheck=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1" > '/etc/yum.repos.d/elastic.repo'

yum install -y java elasticsearch 

echo "reiniciando daemon"
systemctl daemon-reload
systemctl enable elasticsearch.service

echo "iniciando elastic search"
systemctl start elasticsearch.service
service  elasticsearch status