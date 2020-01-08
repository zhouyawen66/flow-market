#!/usr/bin/env bash
echo '=====update coed from gitlab====='
git pull
echo '=====mvn install & docker:build====='
mvn -f ~/build/orderInfo-center/pom.xml clean install -U -DskipTests
mvn -f ~/build/orderInfo-center/lmt-mbsp-orderInfo-admin/orderInfo-admin/pom.xml docker:build
mvn -f ~/build/orderInfo-center/lmt-mbsp-orderInfo-user/orderInfo-user/pom.xml docker:build


