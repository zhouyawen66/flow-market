#!/usr/bin/env bash

network=pinpoint_pinpoint
vol_from=pinpoint-agent
#docker_registry=docker.lmt.com
docker_registry=192.168.1.162:5000

service_name=orderInfo-admin
service_port=8087
docker stop ${service_name}
docker rm ${service_name}
docker run -d --name=${service_name} -e "SPRING_PROFILES_ACTIVE=test" -p ${service_port}:${service_port} \
           -e TZ="Asia/Shanghai" -v /etc/localtime:/etc/localtime --restart=always --network=${network} --volumes-from=${vol_from} \
           ${docker_registry}/${service_name}



service_name=orderInfo-user
service_port=8088
docker stop ${service_name}
docker rm ${service_name}
docker run -d --name=${service_name} -e "SPRING_PROFILES_ACTIVE=test" -p ${service_port}:${service_port} \
           -e TZ="Asia/Shanghai" -v /etc/localtime:/etc/localtime --restart=always --network=${network} --volumes-from=${vol_from} \
           ${docker_registry}/${service_name}
