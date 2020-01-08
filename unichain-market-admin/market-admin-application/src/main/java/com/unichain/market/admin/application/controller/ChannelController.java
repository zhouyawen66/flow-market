package com.unichain.market.admin.application.controller;

import com.alibaba.fastjson.JSON;
import com.unichain.framework.mvc.annotation.Access;
import com.unichain.framework.mvc.controller.ResponseMessage;
import com.unichain.market.admin.application.Biz.ChannelBiz;
import com.unichain.market.model.req.ChannelDto;
import com.unichain.market.model.req.UserAccountDto;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static com.unichain.framework.mvc.controller.ResponseMessage.error;

@RestController
@RequestMapping("/channel")
public class ChannelController extends TokenController {

    Logger logger = LoggerFactory.getLogger(ChannelController.class);

    @Autowired
    ChannelBiz channelBiz;

    @ApiOperation(value = "获得注册数量和UV")
    @PostMapping("/get/regAndUV")
    @Access(ignoreToken = true)
    public ResponseMessage getRegAndUv(@RequestBody ChannelDto channelDto) throws Throwable {
        try {
            return ResponseMessage.ok(channelBiz.getChannelPvAndReg(channelDto));
        } catch (Exception e) {
            logger.error("getRegAndUv param:{}", JSON.toJSONString(channelDto), e);
            return error(e.getMessage());
        }
    }

    @ApiOperation(value = "获得渠道商趋势图")
    @PostMapping("/get/tendency")
    @Access(ignoreToken = true)
    public ResponseMessage getTendency(@RequestBody ChannelDto channelDto) throws Throwable {
        try {
            return ResponseMessage.ok(channelBiz.getTendency(channelDto));
        } catch (Exception e) {
            logger.error("getTendency param:{}", JSON.toJSONString(channelDto), e);
            return error(e.getMessage());
        }
    }

    @ApiOperation(value = "获取渠道商推送用户账户信息")
    @PostMapping("/get/account")
    @Access(ignoreToken = true)
    public ResponseMessage getUserRegInfo(@RequestBody UserAccountDto userAccountDto) throws Throwable {
        try {
            return ResponseMessage.ok(channelBiz.getUserRegInfo(userAccountDto));
        } catch (Exception e) {
            logger.error("getUserRegInfo param:{}", JSON.toJSONString(userAccountDto), e);
            return error(e.getMessage());
        }
    }

    @ApiOperation(value = "获取app推送用户账户信息")
    @PostMapping("/get/reg/account")
    @Access(ignoreToken = true)
    public ResponseMessage getUserRegApp(@RequestBody UserAccountDto userAccountDto) throws Throwable {
        try {
            return ResponseMessage.ok(channelBiz.getUserRegApp(userAccountDto));
        } catch (Exception e) {
            logger.error("getUserRegApp param:{}", JSON.toJSONString(userAccountDto), e);
            return error(e.getMessage());
        }
    }



}
