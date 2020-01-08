#!/usr/bin/env bash

network=pinpoint_pinpoint
vol_from=pinpoint-agent
docker_registry=docker.lmt.com

service_name=orderInfo-admin
docker_name=${service_name}-dev
service_port=58087
docker stop ${docker_name}
docker rm ${docker_name}
docker run -d --name=${docker_name} -e "SPRING_PROFILES_ACTIVE=dev" -p ${service_port}:${service_port} \
           -e TZ="Asia/Shanghai" -v /etc/localtime:/etc/localtime --restart=always --network=${network} --volumes-from=${vol_from} \
           ${docker_registry}/${service_name}

service_name=orderInfo-user
docker_name=${service_name}-dev
service_port=58088
docker stop ${docker_name}
docker rm ${docker_name}
docker run -d --name=${docker_name} -e "SPRING_PROFILES_ACTIVE=dev" -p ${service_port}:${service_port} \
           -e TZ="Asia/Shanghai" -v /etc/localtime:/etc/localtime --restart=always --network=${network} --volumes-from=${vol_from} \
           ${docker_registry}/${service_name}
