package com.unichain.market.admin.application;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;

/**
 * Auther: lait.zhang@gmail.com
 * Date: 7/10/2018 18:14
 * Description:
        */
@EnableDiscoveryClient
@EnableFeignClients(basePackages = {"com.unichain.market"})
@SpringBootApplication
@ComponentScan({"com.unichain.market"})
public class MarketAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(MarketAdminApplication.class, args);
    }
}
