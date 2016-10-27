#!/bin/bash

echo "now config splunk ..."
set -e
export SPLUNK_HOME=/opt/splunk
echo "Start Splunk Now!"

if [ ! -e "/opt/splunk/etc/splunk.version" ];then
    echo "This is you first time install Splunk!"
	cp -r /app/etc/* /opt/splunk/etc/
fi

cd /opt/splunk/bin && ./splunk start --accept-license --answer-yes \
&& tail -f /opt/splunk/var/log/splunk/splunkd.log
