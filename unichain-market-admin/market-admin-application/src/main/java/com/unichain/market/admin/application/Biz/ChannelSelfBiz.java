package com.unichain.market.admin.application.Biz;

import com.unichain.market.model.req.ChannelDto;
import com.unichain.market.model.req.ChannelSelfDto;
import com.unichain.market.model.resp.ChannelSelfVo;
import com.unichain.market.model.resp.XYPhoto;

import java.util.List;
import java.util.Map;

public interface ChannelSelfBiz {

   /* *//**
     * 获取统计的pv和uv总和
     * @param channelDto
     * @return
     *//*
    ChannelSelfVo selectPvAndUv(ChannelSelfDto channelDto);*/

    /**
     * 获取一段时间内的pv和uv
     * @param channelSelfDto
     * @return
     */
    Map<String, Object> selectPvAndUvByCtime(ChannelSelfDto channelSelfDto);

    /**
     * 获取pv和uv的趋势图
     * @param channelSelfDto
     * @return
     */
    List<XYPhoto> queryUvAndPvAbscissa(ChannelSelfDto channelSelfDto);
}
