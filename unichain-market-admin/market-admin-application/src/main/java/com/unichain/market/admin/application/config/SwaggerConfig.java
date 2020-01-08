package com.unichain.market.admin.application.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.request.async.DeferredResult;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.ParameterBuilder;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.service.Parameter;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.ArrayList;
import java.util.List;

//@Configuration
//@EnableSwagger2
public class SwaggerConfig {


    @Bean
    public Docket swaggerSpringMvcPlugin() {
        //添加head参数
        ParameterBuilder ticketPar = new ParameterBuilder();
        List<Parameter> pars = new ArrayList<>();
        ticketPar.name("Token").description("user token").modelRef(new ModelRef("string")).parameterType("header").required(false).build();
        pars.add(ticketPar.build());

        return new Docket(DocumentationType.SWAGGER_2)
                .groupName("cms-admin-api")
                .apiInfo(apiInfo())
                .genericModelSubstitutes(DeferredResult.class)
                .useDefaultResponseMessages(false)
                .forCodeGeneration(true)
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.unichain.market.admin.application.controller"))
//                .paths(PathSelectors.any())
                .build()
                .globalOperationParameters(pars)
                .ignoredParameterTypes();
    }


    private ApiInfo apiInfo() {
        //Api的一些描述信息
        ApiInfo apiInfo = new ApiInfoBuilder()
                .title("market-admin接口")
                .description("market-admin接口")
                .contact(new Contact("lait", "http://wiki.lmt.com", "lait.zhang@gmial.com"))
                .version("1.0.0")
                .build();
        return apiInfo;
    }

}
