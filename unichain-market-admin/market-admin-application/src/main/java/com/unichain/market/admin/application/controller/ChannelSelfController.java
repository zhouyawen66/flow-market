package com.unichain.market.admin.application.controller;

import com.alibaba.fastjson.JSON;
import com.unichain.framework.mvc.annotation.Access;
import com.unichain.framework.mvc.controller.ResponseMessage;
import com.unichain.framework.mvc.exception.BusinessException;
import com.unichain.market.admin.application.Biz.ChannelSelfBiz;
import com.unichain.market.model.req.ChannelDto;
import com.unichain.market.model.req.ChannelSelfDto;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static com.unichain.framework.mvc.controller.ResponseMessage.error;
import static com.unichain.framework.mvc.controller.ResponseMessage.ok;

@RestController
@RequestMapping("/channelSelf")
public class ChannelSelfController extends TokenController{

    Logger logger = LoggerFactory.getLogger(ChannelController.class);

    @Autowired
    private ChannelSelfBiz channelSelfBiz;

   /* @ApiOperation(value = "获得统计的pv和uv")
    @PostMapping("/get/getPvAndUv")
    @Access(ignoreToken = true)
    public ResponseMessage getPvAndUv(@RequestBody ChannelSelfDto channelSelfDto) throws Throwable {
        try {
            return ResponseMessage.ok(channelSelfBiz.selectPvAndUv(channelSelfDto));
        } catch (Exception e) {
            logger.error("getPvAndUv param:{}", JSON.toJSONString(channelSelfDto), e);
            return error(e.getMessage());
        }
    }*/
    @ApiOperation(value = "获得一段时间内的pv和uv")
    @PostMapping("/get/getPvAndUvByCtime")
    @Access(ignoreToken = true)
    public ResponseMessage getPvAndUvByCtime(@RequestBody ChannelSelfDto channelSelfDto) throws Throwable {
        try {
            return ResponseMessage.ok(channelSelfBiz.selectPvAndUvByCtime(channelSelfDto));
        } catch (Exception e) {
            logger.error("getPvAndUv param:{}", JSON.toJSONString(channelSelfDto), e);
            return error(e.getMessage());
        }
    }

    @ApiOperation("获得趋势图")
    @PostMapping("/getUvAndPvAbscissa")
    @Access(ignoreToken = true)
    public ResponseMessage queryUvAndPvAbscissa(@RequestBody ChannelSelfDto channelSelfDto) {
        try {
            return ok(channelSelfBiz.queryUvAndPvAbscissa(channelSelfDto));
        } catch (BusinessException e) {
            ResponseMessage responseMessage = ResponseMessage.error(e.getMessage());
            responseMessage.code(e.getErrorCode());
            return responseMessage;
        }
    }
}
