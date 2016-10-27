FROM ubuntu:14.04

MAINTAINER lichao <lichao@goodrain.com>
RUN echo "Asia/Shanghai" > /etc/timezone;dpkg-reconfigure -f noninteractive tzdata

COPY script /app/script
RUN chmod +x /app/script/run.sh && \
    chmod +x /app/script/docker-entrypoint.sh

COPY splunklight.tgz /app/splunklight.tgz

RUN tar xvzf /app/splunklight.tgz -C /app/ \
    && cp -r /app/splunk/etc /app/ \
    && echo OPTIMISTIC_ABOUT_FILE_LOCKING = 1 >> /app/etc/splunk-launch.conf \
    && rm -r /app/splunk/etc \
    && cp -r /app/splunk  /opt/ \
    && rm /app/splunklight.tgz \
    && rm -r /app/splunk \
    && mkdir -p /opt/splunk/var \
    && chmod -R 710 /opt/splunk/var

VOLUME ["/opt/splunk/etc","/opt/splunk/var"]
EXPOSE 5000
ENTRYPOINT ["/app/script/docker-entrypoint.sh"]
#ENTRYPOINT ["/app/script/run.sh"]